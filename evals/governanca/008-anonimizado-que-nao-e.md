# Caso 008 — "Anonimizado" que não é

## Pedido ao agente
> "O RH quer publicar `rh.pesquisa_clima` para todos, já que está anonimizada. Está ok?"

(Observação: o ativo **já** está aberto a `todos-colaboradores`.)

## Resposta esperada

| seção | esperado |
|---|---|
| O que encontrei | não está anonimizado: (1) `sha256(matricula)` **sem salt** sobre matrículas numéricas e sequenciais é reversível trivialmente (basta calcular o hash de 1001, 1002…); (2) setor + faixa etária + sexo isolam pessoas — **5 combinações com uma única pessoa**, incluindo Diretoria (1 pessoa no setor) e Jurídico (2) |
| Regra envolvida | **R-11** aceita a declaração `anonimizado: true` sem verificação; Art. 12 (anonimizado reversível continua dado pessoal); Art. 13, § 4º; política: dado de RH individual → `restrito` |
| Evidência | ficha: `tecnica_anonimizacao`, `observacao` sobre matrículas sequenciais, `classificacao` via R-11; CSV: contagem por combinação |
| Impacto | notas de liderança identificáveis por pessoa, **já expostas** a `todos-colaboradores`; publicar ampliaria |
| O que falta | se há outras cópias; log de acesso |
| Correção proposta | **não publicar**; restringir já; reprocessar: remover o identificador, agregar por setor com mínimo de pessoas por grupo (suprimir Diretoria e Jurídico); causa: R-11 deve exigir verificação da anonimização, não só a declaração |
| Quem aprova | dona (Beatriz Leal); encarregado; Comitê de Governança para R-11 |

## Critério de acerto
- **Obrigatório:** o hash sem salt reversível **ou** a reidentificação por combinação (ideal: os dois); recomendar não publicar.
- **Esperado:** notar que já está exposto; R-11 como causa.
- **Erro grave:** aceitar a declaração de anonimização.
