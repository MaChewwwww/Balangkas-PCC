FROM python:3.11-slim@sha256:9534e5a8e315485d4061ed659af0fd78a284c015f9b73661b41d6bab25604534
WORKDIR /toolchain
ENV PIP_EXTRA_INDEX_URL=https://download.pytorch.org/whl/cpu
RUN apt-get update && apt-get install -y --no-install-recommends libgomp1 libgl1 libglib2.0-0 && rm -rf /var/lib/apt/lists/*
COPY backend/requirements-ocr.lock ./requirements.lock
RUN pip install --no-cache-dir --require-hashes -r requirements.lock && pip check
CMD ["python", "--version"]
