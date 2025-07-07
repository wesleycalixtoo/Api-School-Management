FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Isso aproveita o cache de camadas do Docker. A instalação de dependências só será executada novamente se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que o app será executado
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar
# Use 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8081", "--reload"]