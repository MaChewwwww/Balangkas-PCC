FROM python:3.11-slim
WORKDIR /toolchain
RUN apt-get update && apt-get install -y --no-install-recommends libgomp1 libgl1 libglib2.0-0 && rm -rf /var/lib/apt/lists/*
COPY backend/requirements-ocr.lock ./requirements.lock
RUN pip install --no-cache-dir --require-hashes -r requirements.lock && pip check
CMD ["python", "--version"]
