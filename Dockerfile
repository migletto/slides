FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Same Claude Code CLI version already running on the host, so the
# agent_backend.py loopback channel (`claude -p`) behaves identically.
RUN npm install -g @anthropic-ai/claude-code@2.1.215

WORKDIR /app
COPY . .

EXPOSE 3030

CMD ["python3", "tools/vela-dev/scripts/serve.py", "decks", \
     "--host", "0.0.0.0", "--port", "3030", \
     "--ai", "--channel-port", "8787", "--no-auth"]
