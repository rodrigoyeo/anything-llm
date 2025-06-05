FROM node:18-slim

# Set working directory
WORKDIR /app

# Copy root package.json and install root dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Copy sub-project package.json files and install their dependencies
COPY server/package.json ./server/
COPY server/package-lock.json ./server/
COPY frontend/package.json ./frontend/
COPY frontend/package-lock.json ./frontend/
COPY collector/package.json ./collector/
COPY collector/package-lock.json ./collector/

# Install dependencies for each sub-project
RUN npm install --prefix server --legacy-peer-deps
RUN npm install --prefix frontend --legacy-peer-deps
RUN npm install --prefix collector --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Build the frontend and copy to server/public
WORKDIR /app/frontend
RUN npm run build
RUN mkdir -p ../server/public && cp -r dist/* ../server/public/

# Generate Prisma client
WORKDIR /app/server
RUN npx prisma generate

# Expose the application port
EXPOSE 3001

# Set environment variables for production
ENV NODE_ENV="production"
ENV SERVER_PORT="3001"
ENV STORAGE_DIR="/app/server/storage"
ENV INSTANCE_NAME="MATI"

# Set the start command
WORKDIR /app/server
CMD npx prisma migrate deploy && node index.js