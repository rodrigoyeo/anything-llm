FROM mintplexlabs/anythingllm:latest

# Set environment variables
ENV NODE_ENV=production
ENV JWT_SECRET=ohLqK6kKpIAt
ENV SIG_KEY=02A4UFhR3oXCVYFQ4b5tCh6hVq4e2ALX
ENV SIG_SALT=PD7ZpSbskNaEUY9h3yctGi77ivqluPRj
ENV LLM_PROVIDER=openai
ENV OPEN_MODEL_PREF=gpt-4o
ENV VECTOR_DB=pgvector
ENV INSTANCE_NAME=MATI

# Copy our customized files directly to the server's public directory
COPY ./frontend/public/Favicon_arkode.png /app/server/public/favicon.png
COPY ./frontend/public/Logo_Arkode_LLM.png /app/server/public/logo.png

# Copy the modified index.html file
COPY ./frontend/index.html /app/server/public/index.html
