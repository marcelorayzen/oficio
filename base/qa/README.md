# Aurora Varejo — ambiente de QA (fictício)

A mesma empresa fictícia de `base/`, vista pelo time de produto e engenharia. Nenhum dado é real.

| arquivo | conteúdo |
|---|---|
| `perfil-empresa.md` | stack, ferramentas e formatos do time — tudo que o profissional sugere parte daqui |
| `api/pedidos-openapi.yaml` | contrato da API de pedidos do e-commerce |
| `historias/` | histórias de usuário do backlog, como chegam do PO |
| `evidencias/` | o que o analista recebeu de um defeito: descrição de print, log, relato |

A API de pedidos grava em `vendas.pedidos` (ver `base/catalogo/vendas.pedidos.yaml`), e o cadastro
em `clientes.cadastro` — as duas trilhas olham os mesmos ativos por lados diferentes.

> **Prints entram como texto nesta fase.** `evidencias/` descreve a tela em vez de trazer a
> imagem, para o caso rodar sem modelo de visão. Um caso com imagem de verdade entra quando o
> runtime existir.
