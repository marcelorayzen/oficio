#!/bin/sh
#
# Hook `pre_tool_call` do Hermes para `write_file` e `patch` (ver `hooks:` em config.yaml).
#
# As duas moram no toolset `file` junto com `read_file` e `search_files`, e o Hermes só desliga
# toolset inteiro — tirar `file` deixaria o agente sem ler a base. Então a leitura fica e a escrita
# é barrada aqui, pelo nome. Saída 2 = bloqueio; a mensagem vai no stderr e volta para o modelo.
cat > /dev/null
echo "Escrita desligada: o Ofício só lê. Entregue o resultado na resposta, não em arquivo." >&2
exit 2
