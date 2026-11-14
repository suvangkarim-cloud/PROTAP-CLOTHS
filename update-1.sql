-- Run once in Supabase > SQL Editor (after supabase-setup.sql).
-- Hidden products (Edit > untick "Visible in shop") will no longer be readable by the public.
drop policy if exists "anyone reads products" on products;
create policy "read visible products" on products for select using (active or is_admin());
