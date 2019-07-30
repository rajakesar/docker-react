# Choose a base image for node to create a build (named builder)
FROM node:alpine as builder
# Set the directory inside the image to work from
WORKDIR /app
# Copy the package.json file to this directory
COPY package.json .
# Run npm install to install dependencies
RUN npm install
# Copy the remaining files
COPY . .
# Start the node server with npm start (npm is the command, start is the argument)
RUN npm run build

# Let's move on to the nginx hosting phase
FROM nginx
# Copy a folder from the builder phase to the default Nginx hosting folder
COPY --from=builder /app/build /usr/share/nginx/html