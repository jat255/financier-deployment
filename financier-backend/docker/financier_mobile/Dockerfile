FROM node:10-alpine

RUN apk add --update \
  python3 \
  alpine-sdk

#COPY ./fmobile /fmobile
WORKDIR /tmp
RUN git clone https://gitlab.com/asromzek/fmobile.git
WORKDIR /tmp/fmobile

# RUN rm package-lock.json
# RUN yarn add sortablejs@1.7.0 
RUN yarn import
RUN yarn add patch-package@5.1.1
RUN yarn install
RUN yarn run build

CMD ["cp", "-r", "dist", "/fmobile/"]

# Run using docker build -t fmobile .
#
