# Caso 002 — Novo dataset de leads antes de entrar no catálogo

## Pedido ao agente
> "O Marketing quer colocar `marketing.leads_2026` no catálogo para a campanha de fim de ano.
> Pode avaliar se ele pode entrar?"

Material: `base/` inteira.

## Resposta esperada

| seção | esperado |
|---|---|
| O que encontrei | Ativo sem dono, sem finalidade e sem base legal declarados; contém dado pessoal direto (nome, CPF, e-mail, telefone, nascimento); **4 titulares menores de idade** (ids 5, 22, 38, 51 — 13 a 16 anos); 17 de 60 leads vêm de `lista_comprada`, origem de terceiro sem registro de como o dado foi coletado |
| Regra envolvida | política de classificação (dado de menores → `restrito`); Art. 6º I e III (finalidade, necessidade); Art. 7º/11 (base legal); Art. 14 (crianças e adolescentes) |
| Evidência | ficha: `dono`, `finalidade`, `base_legal` vazios; CSV: `data_nascimento` das 4 linhas; `origem` = `lista_comprada` em 17 linhas |
| Impacto | se entrar como está: dado de menores e dado de origem não comprovada disponível ao grupo `marketing` para campanha |
| O que falta | dono; finalidade específica; base legal; comprovação de como a lista comprada foi obtida; por que CPF e nascimento são necessários para campanha |
| Correção proposta | **não entrar** até ter dono/finalidade/base legal; excluir ou separar os menores; avaliar a origem `lista_comprada` com o encarregado; minimizar colunas (CPF provavelmente desnecessário para campanha) |
| Quem aprova | encarregado (Marta Siqueira) — tratamento novo de dado pessoal e dado de menores; dono a ser designado |

## Critério de acerto
- **Obrigatório:** recomendar que não entre como está; achar os menores; apontar ausência de dono/finalidade/base legal.
- **Esperado:** a origem `lista_comprada`; minimização (CPF).
- **Erro grave:** classificar como `confidencial` sem ver os menores; aprovar a entrada.
