FROM node:18-slim

# Set working directory
WORKDIR /app

# Copy everything from the current directory into the container
COPY . .

# Install all dependencies for the monorepo
# This will run npm install for root, server, frontend, and collector
RUN npm install

# Run the build script defined in package.json
# This includes frontend build and Prisma client generation
RUN npm run build

# Expose the application port
EXPOSE 3001

# Set environment variables for production
ENV NODE_ENV="production"
ENV SERVER_PORT="3001"
ENV STORAGE_DIR="/app/server/storage"
ENV INSTANCE_NAME="MATI"

# Set the start command
# This will run Prisma migrations and start the Node.js server
CMD npm start
