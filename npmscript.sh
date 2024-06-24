# Use a base image with Node.js pre-installed
FROM node:latest

# Install curl and other dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Source nvm in this shell (since RUN commands start a new shell)
RUN /bin/bash -c "source ~/.bashrc"

# Install npm globally
RUN npm install -g npm@latest

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to work directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Install next.js and other dependencies
RUN npm install next --save

# Copy the rest of the application code
COPY . .

# Expose the port that the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
