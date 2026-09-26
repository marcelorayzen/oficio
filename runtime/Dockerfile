# Ofício — runtime (Hermes) da Fase 1.
#
# Mesma receita do Hermes que já roda no Rayzen, com as lições de lá (medidas, não lidas na doc):
# - não existe imagem oficial; a instalação é o `install.sh` do projeto, aqui dentro de um
#   container para ficar declarada, descartável e mensurável;
# - `build-essential` é necessário, ao contrário do que a doc diz (módulos nativos do Node);
# - Node na imagem, fora de `$HERMES_HOME`, senão o volume de estado congela a versão;
# - `--commit` fixa a versão (princípio 7: upstream que muda sem avisar é pinado);
# - `--dir` separa código de estado, para o volume guardar só o estado.
#
# Sem dependência do Rayzen: nenhuma rede, token ou arquivo de lá. Só a receita foi reaproveitada.
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      git curl xz-utils ca-certificates build-essential \
    && rm -rf /var/lib/apt/lists/*

ARG NODE_VERSION=26.8.2
RUN curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" \
      | tar -xJ -C /opt && mv "/opt/node-v${NODE_VERSION}-linux-x64" /opt/node
ENV PATH="/opt/node/bin:${PATH}"

RUN useradd -m -s /bin/bash oficio \
    && mkdir -p /opt/hermes && chown oficio:oficio /opt/hermes

USER oficio
WORKDIR /home/oficio

# Mesmo commit que o Rayzen usa em produção — a versão cujo schema de config (44) já foi migrado
# e conferido. Para atualizar: troque o SHA, rebuild, rode `hermes config check`.
ARG HERMES_COMMIT=422bc9bde9d212ab3741fbc45a871a3938436d59
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- \
      --commit "${HERMES_COMMIT}" --dir /opt/hermes/agent

ENV PATH="/home/oficio/.local/bin:${PATH}"

# O volume de estado monta aqui. Criar o diretório na imagem, como `oficio`, faz o volume nascer
# com esse dono — senão ele nasce de root e o Hermes não consegue escrever o próprio estado.
RUN mkdir -p /home/oficio/.hermes

# A UI web (`hermes dashboard`) fica para depois da Fase 1: aqui os casos rodam por CLI.

COPY --chmod=0755 entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["sleep", "infinity"]
