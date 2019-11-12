# Linted manually with https://www.fromlatest.io/#/

FROM node:8.11.1-alpine

RUN mkdir -p /home/node/app && \
    chown -R node:node /home/node/app && \
    npm i npm@latest -g

WORKDIR /home/node/app

COPY --chown=node:node ./app /home/node/app

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
