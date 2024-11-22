FROM node:20
#FROM  docker.io/anapsix/alpine-java 
# Update package list
#RUN apk update && apk add --no-cache nodejs
    
# Create and set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

###RUN apt-get update && apt-get install -y nodejs npm
RUN which node
RUN which npm
RUN echo "Node: " && node -v
RUN echo "NPM: " && npm -v

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
