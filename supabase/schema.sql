create table if not exists public.champion_predictions (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null,
  session_id uuid not null,
  champion text not null,
  bracket jsonb,
  created_at timestamptz not null default now()
);

alter table public.champion_predictions enable row level security;

create unique index if not exists champion_predictions_client_session_idx
on public.champion_predictions (client_id, session_id);

drop policy if exists "allow anonymous prediction inserts" on public.champion_predictions;
create policy "allow anonymous prediction inserts"
on public.champion_predictions
for insert
to anon
with check (champion is not null and client_id is not null and session_id is not null);

create or replace function public.get_champion_stats(champion_id text)
returns table(total bigint, count bigint, percent integer)
language sql
security definer
set search_path = public
as $$
  with stats as (
    select
      count(*)::bigint as total,
      count(*) filter (where champion = champion_id)::bigint as count
    from public.champion_predictions
  )
  select
    total,
    count,
    case when total = 0 then 0 else round(count * 100.0 / total)::integer end as percent
  from stats;
$$;

grant execute on function public.get_champion_stats(text) to anon;
