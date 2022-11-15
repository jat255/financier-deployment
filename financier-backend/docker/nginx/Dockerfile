FROM nginx:1.17-alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# copy fmobile code into /var/www/static
COPY ./dist /var/www/static

RUN chown nginx:nginx /var/www/static


EXPOSE 8080
