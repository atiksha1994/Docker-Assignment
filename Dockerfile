# Dockerfile
# Stage 1: Build the React app
FROM node:20 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package.json ./
COPY package-lock.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . ./

# Build the React application
RUN npm run build

# Stage 2: Serve the React app using nginx
FROM nginx:alpine

# Copy the build output from the previous stage to the nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
