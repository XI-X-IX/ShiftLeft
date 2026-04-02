FROM python:3.11-slim

WORKDIR /app
COPY . .

RUN apt-get update && apt-get upgrade -y && 
	apt-get clean &&
	rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt

CMD ["python", "main.py"]