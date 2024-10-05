#Stage 1: Build the application
FROM node:lts AS build
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Stage 2: Create the development image
FROM node:lts-alpine
WORKDIR /app

# Copy all files from the build stage
COPY --from=build /app .
CMD ["npm", "start"]
# Expose port 3000 for development purposes
EXPOSE 18000
