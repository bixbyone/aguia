# Dockerfile criado por: zeh & tutoC
# Data: 10-03-2024
# Versão: 1.0.1

ARG BUILDER_IMAGE="ubuntu:22.04"

FROM ${BUILDER_IMAGE} as builder

# Instalação das dependências de compilação
RUN apt-get update && apt-get -y --no-install-recommends install \
    build-essential \
    # Compilador Clang
    clang-15 \
    # Biblioteca de parsing JSON
    libcjson-dev \
    # Biblioteca MicroHTTP
    libmicrohttpd-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Especifica os caminhos de inclusão para a biblioteca JSON e MicroHTTP
ENV C_INCLUDE_PATH="/usr/include/cjson:/usr/include/microhttpd"

WORKDIR /app

# Copia o código-fonte principal da aplicação
COPY main.c .

# Compila a aplicação
RUN clang-15 -O2 -o main main.c -lcjson -lmicrohttpd

# Instrução Docker para executar o contêiner
CMD ["/app/main"]
