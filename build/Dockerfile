### STAGE 1: Build ###

# We label our stage as 'builder'
FROM node:current-alpine as builder

COPY web/package*.json ./
COPY web/.npmrc ./
#RUN npm config set depth 0 && npm cache clean --force

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

WORKDIR /ng-app

COPY web ./

## Build the angular app in production mode and store the artifacts in dist folder
RUN $(npm bin)/ng build --prod --build-optimizer


### STAGE 2: Setup ###

FROM nginx:1.13.3-alpine

## Copy our default nginx config
COPY configs/nginx-default.conf /etc/nginx/conf.d/default.conf

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /ng-app/dist/apps/show-movies /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 8080
