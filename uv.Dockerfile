# based on the documentation: https://docs.astral.sh/uv/guides/integration/docker/
FROM python:3.12-slim-trixie
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# optimizations
# ENV UV_COMPILE_BYTECODE=1
# or
# RUN uv sync --locked --compile-bytecode

ADD . /app
WORKDIR /app
RUN uv sync --locked

EXPOSE 8080
CMD ["uv", "run", "app"]
