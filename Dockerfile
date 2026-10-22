FROM python:3.11-slim
WORKDIR /app

# PyTorch bản CPU cho nhẹ
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY webui/requirements.txt webui/requirements.txt
RUN pip install --no-cache-dir -r webui/requirements.txt gunicorn

COPY . .
WORKDIR /app/webui
ENV PYTHONPATH=/app
ENV HF_HOME=/data/hf

CMD gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 4 --timeout 300 wsgi:app
