# Use an official Node.js image as the base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Clone the repository into the container
RUN git clone https://github.com/rampatra/wedding-website.git .

# Install the required dependencies
RUN npm install

# Install gulp globally
RUN npm install -g gulp-cli

# Run gulp to compile sass and minify JS
RUN gulp

# Expose the port that the web server will run on
EXPOSE 80

# Command to open the app (using a lightweight server to serve the HTML)
CMD ["npx", "http-server", "."]
