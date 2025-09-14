# base image
FROM python:3.10-slim-bookworm

# Install curl
RUN apt-get update && apt-get install -y curl

# add a work directory
WORKDIR /backend

# env
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONBUFFERED=1

# install system dependencies
RUN apt-get update \
  # && apt-get -y install gcc postgresql \
  # netcat 
  && apt-get clean

# install python dependencies
COPY ./requirements.txt /backend
RUN pip install --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

# copy files to the container folder
COPY . /backend

# start the server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--log-level", "debug"]