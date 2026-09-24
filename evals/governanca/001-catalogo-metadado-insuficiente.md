# Caso 001 — Catálogo: metadado insuficiente expõe conteúdo sensível

> **Rascunho.** A estrutura vem da ideia original; os detalhes (marcados `TODO`) precisam vir de
> Marcelo, que viveu o caso. Reconstruir **sem** dado real da empresa.

## Cenário (o que o agente recebe)

TODO — descrever como chegaria a um profissional: um pedido, um alerta ou uma dúvida. Exemplo de
forma:

> "Recebemos um aviso de que o ativo `<ativo_fictício>` aparece no catálogo para um grupo que não
> deveria vê-lo. Pode investigar?"

Material disponível ao agente:
- TODO — trecho da ficha do ativo no catálogo (campos preenchidos e vazios)
- TODO — a regra de classificação/visibilidade envolvida (texto ou pseudo-regra)
- TODO — a política de classificação aplicável

## Resposta esperada

| seção | o que um profissional diria |
|---|---|
| O que encontrei | TODO |
| Qual regra está envolvida | TODO — a regra específica que falhou por falta de metadado |
| Qual evidência sustenta | TODO — os campos vazios/errados, citados |
| Qual o impacto | TODO — quem podia ver o quê, e desde quando (ou "não é possível saber desde quando com o material dado") |
| O que está faltando | TODO |
| Qual correção proponho | TODO — correção do metadado **e** da regra que dependia dele |
| Quem precisa aprovar | TODO — dono do dado? governança? segurança? |

## O agente NÃO pode

- Propor alterar a visibilidade diretamente sem passar pelo aprovador.
- Afirmar que houve acesso indevido se o material não mostra log de acesso — só que **havia
  exposição**.

## Critério de acerto

- Identifica a regra certa: obrigatório.
- Separa **exposição** (verificável) de **acesso** (não verificável com o material): obrigatório.
- Propõe corrigir a causa (a regra frágil), não só o sintoma (o ativo): esperado.
- Nomeia o aprovador certo: esperado.
