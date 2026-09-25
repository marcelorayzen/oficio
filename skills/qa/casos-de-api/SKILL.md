---
name: casos-de-api
description: Gera casos de teste e código de teste automatizado para endpoints de API a partir de OpenAPI/Swagger, coleção Postman, cURL, HAR ou descrição — caminho feliz, validação, limites, autenticação, autorização (incluindo IDOR), erros, idempotência — com massa sintética e código na ferramenta da stack da empresa. Use para "casos de teste da API", "testes desse endpoint", "automatiza esse contrato", "gera a coleção".
---

# Casos e testes de API

Siga `../referencias/regras-do-profissional.md`.

## Passos

1. **Extraia o contrato** de cada endpoint: método, rota, auth, parâmetros (obrigatório, tipo,
   formato, limites), corpo, respostas **documentadas**.
2. **Resposta não documentada é lacuna.** Se o contrato não diz o que acontece (ex.: cupom
   inválido, acesso a recurso de outro usuário), o caso entra com o esperado marcado
   `[PREMISSA]` e a pergunta correspondente — nunca com um status escolhido por você como fato.
   Quando outra fonte da base definir o comportamento (uma história, por exemplo), cite-a.
3. **Casos por categoria** (use as que se aplicam):

| categoria | verificar |
|---|---|
| caminho feliz | status, corpo, schema |
| validação | obrigatório ausente, tipo errado, formato inválido, vazio |
| valor-limite | mín, mín−1, máx, máx+1 dos limites **do contrato** |
| autenticação | sem token, token inválido → 401 |
| autorização | recurso de **outro** usuário pelo id (IDOR); papel sem permissão |
| inexistente | id válido no formato e inexistente → 404 |
| estado/conflito | operação em estado que não permite |
| idempotência | repetição da mesma requisição cria duplicata? |
| injeção básica | `' OR 1=1 --`, string enorme → nunca 500 |

4. **Priorize** pelo risco do endpoint (perfil: "o que custa mais caro").
5. **Massa sintética** para cada caso que precisa de dado.
6. **Código** na ferramenta do perfil:

| perfil | padrão |
|---|---|
| Java | RestAssured + JUnit 5 |
| JS/TS | Playwright `request` ou Jest + Supertest |
| .NET | xUnit + HttpClient |
| Python | pytest + httpx |
| time manual | coleção Postman + Newman |

Se o time é manual mas a stack é Java, entregue os dois: Postman para hoje, RestAssured como
próximo passo — e diga por quê.

## Formato

```markdown
## Casos — <MÉTODO> <rota>
| ID | Categoria | Cenário | Dados | Esperado | Prioridade |

### Massa
### Código
### Premissas e perguntas
```

## Cuidados

- Código completo e executável. Base URL e token **sempre** de variável de ambiente.
- Afirme status **e** conteúdo; teste que só olha status passa com a resposta errada.
- Gherkin quando o perfil pedir.
