# base image
FROM python:3.10-slim-bookworm

# Install curl
RUN apt-get update && apt-get install -y curl

# add a work directory
WORKDIR /003

# env
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONBUFFERED=1

# install system dependencies
RUN apt-get update \
  && apt-get clean

# install python dependencies
COPY ./requirements.txt /003
RUN pip install --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

# copy files to the container folder
COPY . /003

EXPOSE 8000

# start the server
CMD ["uvicorn", "main:app", "--reload", "--port", "8000", "--log-level", "debug"]