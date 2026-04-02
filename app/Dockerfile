FROM python:3.11-slim AS builder

WORKDIR /app
COPY . .

# Install only runtime dependencies, remove build tools and cache
RUN apt-get update && \
	apt-get upgrade -y && \
	pip install --upgrade pip && \
	pip install --prefix=/install -r requirements.txt && \
	apt-get purge -y --auto-remove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /app /app
COPY --from=builder /install /usr/local

CMD ["python", "main.py"]