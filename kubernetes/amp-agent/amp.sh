#!/bin/bash

# Verifica se o número de argumentos é 2
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <URL do Prometheus> <query>"
    exit 1
fi

# Atribui os argumentos a variáveis
PROMETHEUS_URL=$1
QUERY=$2

# Codifica a query para ser usada na URL
ENCODED_QUERY=$(echo "$QUERY" | jq -s -R -r @uri)

# Realiza a chamada de API ao Prometheus
RESPONSE=$(curl -s -H 'host: aps-workspaces.us-east-1.amazonaws.com' "${PROMETHEUS_URL}/workspaces/ws-dc65a0ca-61f6-4d2e-a5ef-9418a5f1a6fa/api/v1/query?query=${ENCODED_QUERY}")

# Verifica se a resposta está vazia
if [ -z "$RESPONSE" ]; then
    echo "Erro: Não foi possível obter resposta da API do Prometheus."
    exit 1
fi

# Exibe a resposta da API
echo "$RESPONSE"