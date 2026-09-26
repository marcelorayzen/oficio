# HU-103 — Exportar clientes para campanha

**Épico:** Marketing · **PO:** Rafael Tavares · **Sprint:** 43

**Como** analista de marketing
**quero** exportar a lista completa de clientes em CSV
**para** subir na ferramenta de disparo e fazer a campanha de fim de ano.

## Regras
1. Botão "Exportar clientes" na área de marketing.
2. O CSV traz todas as colunas de `clientes.cadastro`: nome, CPF, e-mail, telefone, data de
   nascimento e cidade.
3. Qualquer usuário logado na área administrativa pode exportar.
4. O arquivo é gerado na hora e baixado pelo navegador.

## Critérios de aceite
- O CSV contém todos os clientes da base.
- O CSV abre corretamente no Excel.
- Para testar, usar uma cópia da base de produção em `homolog`, para ter volume real.
