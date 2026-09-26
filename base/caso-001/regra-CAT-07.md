# Regra de visibilidade do catálogo

Configuração atual do catálogo:

```text
REGRA CAT-07 — Visibilidade por classificação

IF ativo.classificacao = "PUBLICO"
    THEN visibilidade = "Todos"

IF ativo.classificacao = "INTERNO"
    THEN visibilidade = "Colaboradores"

IF ativo.classificacao = "RESTRITO"
    THEN visibilidade = "Colaboradores autorizados"

IF ativo.classificacao IS NULL
    THEN visibilidade = "Todos os usuários do catálogo"
```

**Observação:** a regra controla a visibilidade do ativo **no catálogo**. Ela não representa, por
si só, autorização de acesso aos dados armazenados no sistema de origem.
