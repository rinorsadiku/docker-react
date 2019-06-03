# First Phase: Building the app
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build --> The folder where the built project is located

# Second Phase: Wiring up the server with the built project
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx has a default command that will start the nginx server automatically