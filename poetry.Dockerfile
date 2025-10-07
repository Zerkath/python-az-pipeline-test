FROM python:3.12-slim-trixie

RUN pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir poetry

ENV POETRY_NO_INTERACTION=1 \
  POETRY_VENV_IN_PROJECT=1 \
  POETRY_CACHE_DIR=/opt/.cache \
  POETRY_VERSION=1.2.0

ADD . /app
WORKDIR /app
RUN poetry install

USER appuser
EXPOSE 8080
CMD [ "poetry", "run", "python", "-m", "src.server" ]
