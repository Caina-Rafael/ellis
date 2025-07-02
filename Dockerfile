# 1. Usar uma imagem base oficial do Python.
# A versão 'slim' oferece um bom equilíbrio entre tamanho e compatibilidade.
# O README menciona Python 3.10+, então 3.11 é uma escolha segura e moderna.
FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho no contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências.
# Isso é feito em um passo separado para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# 4. Instalar as dependências.
# A flag --no-cache-dir reduz o tamanho da imagem final.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação.
COPY . .

# 6. Expor a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Definir o comando para iniciar a aplicação.
# Usamos --host 0.0.0.0 para que o servidor seja acessível de fora do contêiner.
# A flag --reload foi removida, pois é para desenvolvimento, não para produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]