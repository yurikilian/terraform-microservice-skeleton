FROM node:14.9.0-alpine
WORKDIR /opt
COPY dist app
COPY node_modules node_modules
EXPOSE 3000
CMD ["node", "app/app.js"]