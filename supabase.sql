-- Execute no SQL Editor do Supabase para habilitar as salas online.
-- ATENÇÃO: POLÍTICAS DE DEMONSTRAÇÃO. NÃO use com dados pessoais sensíveis.
create table if not exists public.domino_rooms (
  code text primary key check (code ~ '^[A-Z2-9]{6}$'),
  version integer not null default 0,
  max_players integer not null check (max_players between 2 and 4),
  host text not null,
  players jsonb not null default '[]'::jsonb,
  game jsonb,
  created_at timestamptz not null default now()
);
create index if not exists domino_rooms_created_at_idx on public.domino_rooms(created_at);
alter table public.domino_rooms enable row level security;
-- Para um protótipo educacional, acesso anônimo somente a esta tabela.
-- As mãos e respostas não são protegidas contra inspeção/alteração maliciosa.
drop policy if exists "domino_demo_read" on public.domino_rooms;
drop policy if exists "domino_demo_insert" on public.domino_rooms;
drop policy if exists "domino_demo_update" on public.domino_rooms;
create policy "domino_demo_read" on public.domino_rooms for select to anon using (true);
create policy "domino_demo_insert" on public.domino_rooms for insert to anon with check (true);
create policy "domino_demo_update" on public.domino_rooms for update to anon using (true) with check (true);
-- Realtime: habilitar a publicação das alterações (executar uma única vez).
do $$ begin
  alter publication supabase_realtime add table public.domino_rooms;
exception when duplicate_object then null;
end $$;
-- Opcional: remova salas antigas periodicamente pelo painel SQL:
-- delete from public.domino_rooms where created_at < now() - interval '7 days';
