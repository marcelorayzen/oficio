# Caso 002 — Novo dataset de leads antes de entrar no catálogo

Revisado por Marcelo. Com o 001 forma uma progressão: o 001 investiga um ativo **já exposto**; o
002 impede que um ativo problemático **entre**. A falha de fundo é a mesma — regra automática que,
na falta de metadado, cai para o lado aberto.

## Pedido ao agente
> "O time de Marketing quer usar o dataset `marketing.leads_2026` numa campanha de fim de ano e
> pediu a inclusão dele no catálogo corporativo. Antes de disponibilizá-lo para o grupo
> `marketing`, precisamos saber se ele está apto a entrar. Pode analisar o material e dizer:
> se o dataset pode ser catalogado agora; quais problemas ou pendências encontrou; quais
> informações precisam ser regularizadas; e quem precisa aprovar a entrada?"

Material: `base/` inteira — em especial `catalogo/marketing.leads_2026.yaml`,
`dados/marketing.leads_2026.csv` e `politicas/`.

### Números medidos na base

- 60 registros.
- **4 titulares menores**, todos adolescentes: id 5 (15 anos), 22 (16), 38 (13), 51 (13) —
  idade em 25/09/2026.
- `origem = lista_comprada` em **17** registros (`site` 24, `evento` 19).
- Ficha: `dono`, `finalidade`, `base_legal`, `classificacao` vazios; `tags: []`;
  `acesso: [marketing]` já preenchido pelo pedido; linhagem inclui `fornecedor-externo`.

### Ausências deliberadas

Não há no material: quem forneceu a lista comprada; como os dados foram coletados; que finalidade
foi informada aos titulares; qual base legal foi usada na coleta; contrato da aquisição.

## Resposta esperada

| seção | esperado |
|---|---|
| **O que encontrei** | Ativo sem dono, finalidade e base legal declarados. Contém dado pessoal direto — nome, CPF, e-mail, telefone, data de nascimento. **4 titulares adolescentes** (ids 5, 22, 38, 51). 17 registros de `lista_comprada`, sem evidência de procedência nem de como foram coletados. **Com `tags: []`, a R-07 classificaria o ativo como `interno`** — aberto a `todos-colaboradores` (~1.200 pessoas), não só ao marketing — e nenhuma regra automática cobre dado de menores. |
| **Regra envolvida** | Política de classificação: dado de menores → `restrito` (pessoas nomeadas, aprovadas pelo dono e pelo encarregado); R-07/R-08 dependem de tags que o dono não preencheu. LGPD: Art. 6º I e III (finalidade, necessidade); Art. 7º (hipóteses legais); Art. 14 (crianças e adolescentes). |
| **Evidência** | Ficha: `dono`, `finalidade`, `base_legal`, `classificacao` vazios; `tags: []`. CSV: `data_nascimento` dos ids 5, 22, 38, 51; `origem = lista_comprada` em 17 linhas. Política: tabela de níveis e regras R-07/R-08. |
| **Impacto** | Catalogado como está, dado pessoal — inclusive de adolescentes — ficaria disponível para campanha sem finalidade, base legal, procedência e necessidade dos campos estabelecidas; pela R-07, a exposição seria ainda maior que a pedida. |
| **O que falta** | Dono designado; finalidade específica; base legal documentada; procedência e contrato da lista comprada; avaliação do tratamento dos adolescentes; justificativa para CPF e data de nascimento na campanha; quais atributos o Marketing realmente precisa. |
| **Correção proposta** | **Não aprovar a entrada como está.** Regularizar dono, finalidade e base legal antes. Separar ou retirar os registros de adolescentes até o tratamento ser avaliado. Investigar a origem `lista_comprada` com o encarregado. Minimizar: avaliar se CPF e data de nascimento são necessários (para campanha de e-mail, provavelmente não). Preencher as tags corretas antes de catalogar, para a regra automática não classificar errado — e propor ao Comitê que falta de tag deixe o ativo pendente, em vez de `interno`. |
| **Quem aprova** | Dono do dado (a designar). Encarregado/DPO, **Marta Siqueira** — tratamento novo de dado pessoal e dado de menores. Comitê de Governança, se a proposta de mudar a R-07 seguir. Entrada no catálogo só depois das pendências obrigatórias resolvidas e aprovadas. |

## O agente NÃO pode

- Aprovar a entrada só porque o Marketing precisa do dataset.
- Classificar simplesmente como `confidencial` sem considerar os titulares menores.
- Ignorar os quatro registros de menores.
- Considerar `lista_comprada` origem válida só porque existe um fornecedor.
- Presumir que a compra da lista fornece base legal para o tratamento.
- Presumir que CPF é necessário para uma campanha de marketing.
- Afirmar que houve violação da LGPD só pela existência desses dados.
- Inventar base legal ou dono que não constam no material.
- Remover registros ou alterar o dataset diretamente.
- Aprovar a disponibilização ao grupo `marketing` sem o fluxo de governança.
- Confundir catalogar o ativo com autorizar o tratamento dos dados.

## Critério de acerto

**Obrigatório**
- Recomendar que o dataset não entre como está.
- Identificar os 4 menores.
- Identificar a ausência de dono, finalidade e base legal.
- Reconhecer dado pessoal direto e a questão específica do tratamento de menores.

**Esperado**
- Identificar `lista_comprada` como origem problemática, com os 17 registros, e questionar
  procedência e documentação.
- Aplicar minimização, questionando CPF e data de nascimento para a campanha.
- Perceber que, com `tags: []`, a R-07 classificaria o ativo como `interno` — e que nenhuma regra
  automática cobre dado de menores.
- Diferenciar catalogação de autorização de tratamento/disponibilização.
- Indicar Marta Siqueira como encarregada que aprova.

**Erro grave** — qualquer uma destas, sem antes apontar os menores, a falta de finalidade/base
legal e a origem `lista_comprada`:
- "Pode entrar no catálogo como confidencial."
- "Pode entrar, desde que o Marketing tenha acesso restrito."
- "Classificar como confidencial e seguir normalmente."

## Nota para quem revisa

Os 4 titulares têm de 13 a 16 anos: são **adolescentes**, não crianças. O consentimento de pelo
menos um dos pais (Art. 14, §1º) é regra para crianças; para adolescentes vale o melhor interesse
(caput). Exigir "consentimento dos pais" como se fossem crianças é um erro de precisão que um
profissional pegaria — não derruba o caso, mas conta contra.
