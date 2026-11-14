-- Run once in Supabase > SQL Editor (after the earlier SQL files).
-- Lets the owner change the bKash / Nagad numbers, shop phone and shop email from the Admin page.
create table if not exists settings(key text primary key, value text not null default '');
alter table settings enable row level security;
create policy "anyone reads settings" on settings for select using (true);
create policy "admin manages settings" on settings for all using (is_admin()) with check (is_admin());
insert into settings(key, value) values ('bkash', ''), ('nagad', ''), ('phone', '') on conflict do nothing;
