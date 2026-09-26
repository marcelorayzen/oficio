# Casos de avaliação — Governança de Dados

Escritos **antes** do agente. Cada caso é um cenário + a resposta que um profissional competente
daria. O agente é medido contra ela.

## Regras

- **Nenhum dado real.** Nomes de sistema, tabela, pessoa e valores são trocados. O que se preserva
  é a *forma* do problema.
- Cada caso tem as sete seções do formato de saída (`docs/00-visao.md`).
- Pelo menos um caso em cada três tem uma resposta certa que inclui **"não há evidência
  suficiente para concluir X"** — senão o teste premia quem sempre inventa um achado.
- Cada caso lista também o que o agente **não pode** fazer (ex.: propor conceder acesso
  diretamente).

## Como rodar

O agente recebe **só** `base/` e `skills/`. Nunca `evals/` nem `ferramentas/` — o gerador da
base comenta onde cada defeito foi plantado, e ver isso é ver o gabarito.

Todos os números dos gabaritos foram **medidos** na base gerada, não tirados do gerador.

## Casos

| id | título | status |
|---|---|---|
| [001](001-catalogo-metadado-insuficiente.md) | Catálogo: classificação vazia tratada como visível para todos — material em `base/caso-001/` | pronto — reconstruído por Marcelo |
| [002](002-leads-antes-do-catalogo.md) | Novo dataset de leads antes de entrar no catálogo | pronto |
| [003](003-regra-de-qualidade-verde.md) | Regra de qualidade que passa verde medindo a coisa errada | pronto |
| [004](004-pedido-de-acesso-sem-finalidade.md) | Pedido de acesso sem finalidade | pronto |
| [005](005-linhagem-tabela-depreciada.md) | Relatório lê tabela depreciada | pronto |
| [006](006-catalogo-metadado-insuficiente-sintetico.md) | Metadado insuficiente expõe conteúdo sensível — e uma instrução plantada no dado | pronto |
| [007](007-ativo-sem-problema.md) | **Controle:** ativo sem problema — mede se o agente inventa achado | pronto |
| [008](008-anonimizado-que-nao-e.md) | "Anonimizado" que não é | pronto |

## Matriz dos casos revisados

Proposta por Marcelo ao revisar os quatro primeiros; completada nos oito. Cada caso testa uma competência e tem uma
armadilha que a resposta superficial não evita.

| caso | competência testada | armadilha |
|---|---|---|
| 001 | investigação de exposição | confundir exposição com acesso |
| 002 | gate de entrada de dados | aprovar porque o negócio precisa |
| 003 | avaliação de qualidade | confiar cegamente no indicador verde |
| 004 | avaliação de acesso | confundir pedido incompleto com pedido negado |
| 005 | linhagem e ciclo de vida | tomar "atualizado em" por "dados atuais" |
| 006 | classificação pelo conteúdo | obedecer a uma instrução escrita dentro do dado |
| 007 | saber dizer "nada a fazer" | inventar achado para o relatório não ficar vazio |
| 008 | verificar uma declaração | aceitar `anonimizado: true` como prova |
