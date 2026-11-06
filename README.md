# Dominó do Alzheimer: Conhecer para Cuidar

Protótipo educacional de dominó digital, com modo individual contra o computador e salas online para 2–4 participantes. Construído em HTML, CSS e JavaScript, com GitHub Pages e Supabase.

## Arquivos

- `index.html`: jogo completo, incluindo interface e regras.
- `supabase.sql`: tabela, permissões de demonstração e atualização em tempo real.

## 1. Testar o modo individual

1. Baixe e extraia o ZIP.
2. Abra `index.html` no Chrome, Edge ou Firefox (com internet para carregar a biblioteca Supabase, embora o modo individual não use o banco).
3. Digite seu nome, selecione 2, 3 ou 4 jogadores e clique em **Iniciar partida individual**.
4. Escolha uma peça compatível com uma ponta da sequência, responda à questão e acompanhe os turnos.
5. Se não tiver uma peça compatível, use **Comprar peça**. Se não houver peças no monte, use **Passar a vez**.

## 2. Configurar o Supabase para salas online

1. Acesse https://supabase.com/dashboard e crie um projeto gratuito (ou use um projeto de testes separado).
2. Abra **SQL Editor** > **New query**. Cole todo o conteúdo de `supabase.sql` e execute.
3. No painel, abra **Project Settings** > **API** (ou **Connect**, conforme a interface) e copie a **Project URL** e a **publishable/anon key**.
4. Abra `index.html` num editor de texto e substitua:

   ```js
   const SUPABASE_URL = 'COLE_AQUI_A_URL_DO_SUPABASE';
   const SUPABASE_ANON_KEY = 'COLE_AQUI_A_CHAVE_PUBLICAVEL';
   ```

   Exemplo ilustrativo: `https://seu-projeto.supabase.co` e a chave pública do seu projeto.
5. Salve o arquivo. **Nunca coloque a chave `service_role` ou uma chave secreta no HTML.**
6. Para testar online, abra o site em dois navegadores/dispositivos. Crie uma sala, copie o convite e entre com outro nome. O criador inicia a partida com 2 ou mais jogadores.

## 3. Publicar no GitHub Pages

1. Entre em https://github.com e crie um repositório público, por exemplo `domino-do-alzheimer`.
2. Faça upload de `index.html` para a raiz do repositório (e opcionalmente `README.md`). **Não é necessário publicar `supabase.sql`**, embora ele não contenha senhas.
3. Em **Settings > Pages**, selecione **Deploy from a branch**, branch `main` e pasta `/ (root)`; salve.
4. Aguarde a publicação. O link será semelhante a `https://SEU-USUARIO.github.io/domino-do-alzheimer/`.
5. Teste primeiro o modo individual e depois o online em duas janelas ou dispositivos.

## 4. Como o jogo funciona

- A partida usa 24 peças, cada uma contendo um par de conceitos.
- Uma peça central inicia a sequência; os participantes recebem 5 peças cada e o restante fica no monte.
- É possível encaixar uma peça quando uma de suas extremidades é **idêntica** à ponta esquerda ou direita do tabuleiro.
- A associação correta com resposta correta à pergunta rende **2 pontos** (1 pela associação e 1 pela justificativa). Resposta incorreta: perde a vez, sem colocar a peça.
- Se não houver peça compatível, compre do monte; se o monte estiver vazio, passe a vez.
- Vence quem descartar todas as peças. Em bloqueio, vence quem tiver menos peças; empate é decidido pela pontuação.
- Bots escolhem jogadas compatíveis e têm uma probabilidade simulada de acertar as questões. Não são inteligência artificial clínica.

## 5. Limitações importantes desta primeira versão

**As salas online são um protótipo funcional para demonstração, não uma infraestrutura segura para partidas públicas competitivas.** O banco permite acesso anônimo à tabela de salas e guarda todo o estado da partida em JSON. Usuários tecnicamente experientes podem inspecionar ou alterar o estado, inclusive as mãos e a pontuação. Não armazene dados pessoais sensíveis e não use como sistema de avaliação oficial.

O sincronismo usa eventos do Supabase Realtime e atualização por versão para reduzir conflitos. Em caso de concorrência, pode ser necessário tentar novamente; se o Realtime falhar, atualize a página (o retorno automático à sala depende do mesmo navegador/sessão). O jogo não tem reconexão robusta, autenticação, proteção anti-trapaça, limpeza automática de salas nem validação de respostas no servidor. Uma versão para uso público deverá migrar as jogadas para funções SQL/RPC com autenticação e validação autoritativa.

As questões são explicações educativas simplificadas. A dinâmica do documento original foi adaptada para permitir conferência automática: a compatibilidade usa igualdade de termos e a explicação é validada por múltipla escolha, não por fala livre. As peças podem não ser todas jogadas numa partida. O conteúdo deve ser revisado pelo grupo/professor antes de aplicação formal.

## 6. Solução de problemas

- **Botão criar sala mostra aviso de configuração:** verifique URL e chave pública no início do `<script>`.
- **Erro de tabela não encontrada:** execute `supabase.sql` no projeto correto.
- **A outra tela não atualiza:** confira se a tabela está incluída na publicação `supabase_realtime`, recarregue e entre novamente.
- **Erro de permissão:** confira as políticas RLS no SQL Editor.
- **Página 404 no GitHub:** confirme o nome `index.html`, branch `main`, pasta `/ (root)` e aguarde a publicação.

## 7. Referência pedagógica

Baseado no roteiro fornecido pelo grupo: **Dominó do Alzheimer: Conhecer para Cuidar**, com objetivo de relacionar sinais, sintomas, funcionalidade, segurança, fatores modificáveis e assistência de Enfermagem. Não substitui orientações de profissionais de saúde.
