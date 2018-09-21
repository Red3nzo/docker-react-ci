# Setting image and setting builder phase
FROM node:alpine as builder

# Copying code and setting WORKDIR
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# Building app for production // compressed files for serving
RUN npm run build

# Setting up NGINX server from builder image // nginx starts automatically
FROM nginx

# Copying files from builder // takes snapshots
COPY --from=builder /app/build /usr/share/nginx/html
