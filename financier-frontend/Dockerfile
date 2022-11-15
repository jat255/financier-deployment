FROM node:18

ARG GIT_REF
ARG GIT_BRANCH

RUN git clone ${GIT_REF} financier
WORKDIR /financier
RUN git checkout ${GIT_BRANCH}

RUN yarn install --frozen-lockfile
RUN yarn test
RUN yarn run build
RUN yarn run docs

WORKDIR /financier/api

EXPOSE 8080

CMD node ./index.js
