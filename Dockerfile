FROM nginx:1.19.2-alpine

RUN chown -HR 1000:1000 /var/run && \
  chown -R 1000:1000 /var/cache/nginx && \
  sed -i '/^user/d' /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY dist /usr/share/nginx/html
