# Step 1: Use a Node.js image to install dependencies and build the project
FROM node:18 as builder

# Set the working directory inside the container
WORKDIR /app

# Clone the project into the container (this will be done in the build phase)
RUN git clone https://github.com/rampatra/wedding-website.git .

# Install dependencies
RUN npm install

# Run gulp to compile Sass, minify JS, etc.
RUN npm run gulp

# Step 2: Use Nginx to serve the built static files
FROM nginx:alpine

# Copy the built project from the builder stage to Nginx's default directory
COPY --from=builder /app /usr/share/nginx/html

# Expose port 80 (HTTP)
EXPOSE 80

# Use Nginx's default config, which binds to 0.0.0.0 by default (accessible externally)
CMD ["nginx", "-g", "daemon off;"]
