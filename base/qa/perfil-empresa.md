# Perfil da empresa — Aurora Varejo (fictício)

## Produto
- **Domínio:** varejo, e-commerce B2C
- **O que custa mais caro se quebrar:** checkout e pagamento; dados pessoais de clientes (LGPD)
- **Usuários:** cliente, atendente, analista de marketing, administrador

## Stack
- **Backend:** Java 21 + Spring Boot 3
- **Frontend:** React
- **Banco:** PostgreSQL (plataforma de dados, schemas `vendas`, `clientes`, …)
- **APIs:** REST (OpenAPI 3); eventos de pedido em Kafka
- **Auth:** OAuth2 / JWT (Bearer). Papéis: `cliente`, `atendente`, `admin`

## Teste hoje
- **Ferramentas em uso:** Postman (manual, coleções soltas); JUnit 5 só nos devs
- **Automação de QA:** nenhuma
- **CI:** GitHub Actions
- **Gestão:** Jira + Xray
- **Ambientes:** `dev`, `qa`, `homolog`
- **Time de QA:** 2 analistas, manuais

## Formatos
- **Caso de teste:** Gherkin, em pt-BR
- **IDs de caso:** `<MODULO>-<NNN>` (ex.: `PED-001`)
- **Severidade:** bloqueante / crítica / alta / média / baixa
- **Campos obrigatórios do bug no Jira:** componente, versão, ambiente, severidade, passos,
  esperado, obtido, evidência
