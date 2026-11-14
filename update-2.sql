-- Run once in Supabase > SQL Editor (after supabase-setup.sql and update-1.sql).
-- Delivery fee: 60 inside Barisal, 100 everywhere else. Change the numbers/district here AND in index.html (SHIP, SHIP_LOCAL, LOCAL_DISTRICT).

alter table orders add column if not exists note text;
alter table orders add column if not exists ship int;

create or replace function ship_fee(d text) returns int language sql immutable as
$$ select case when lower(trim(coalesce(d, ''))) = 'barisal' then 60 else 100 end $$;

create or replace function set_order_total() returns trigger language plpgsql security definer set search_path = public as $$
declare s int; c int;
begin
  select coalesce(sum(p.price * (i->>'q')::int), 0), count(*) into s, c
  from jsonb_array_elements(new.items) i join products p on p.id = (i->>'id')::bigint and p.active;
  if c = 0 or c <> jsonb_array_length(new.items) then raise exception 'Some items are no longer available'; end if;
  if exists (select 1 from jsonb_array_elements(new.items) i where (i->>'q')::int not between 1 and 20) then raise exception 'Invalid quantity'; end if;
  new.ship := ship_fee(new.district);
  new.total := s + new.ship;
  new.status := 'Pending';
  return new;
end $$;

-- lets a customer cancel their own order, only while it is still Pending
create or replace function cancel_my_order(oid bigint) returns void language sql security definer set search_path = public as
$$ update orders set status = 'Cancelled' where id = oid and user_id = auth.uid() and status = 'Pending' $$;
