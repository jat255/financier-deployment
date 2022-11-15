# This script builds the fmobile application and moves the resulting
# dist files to the nginx container.
docker build -t fmobile ./financier-backend/docker/financier_mobile
docker run --rm -it -v `pwd`/financier-backend/docker/financier_mobile/fmobile:/fmobile fmobile
cp -R ./financier-backend/docker/financier_mobile/fmobile/dist ./financier-backend/docker/nginx
