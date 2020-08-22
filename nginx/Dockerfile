FROM nginx:1.19.2-alpine

RUN rm -f /etc/nginx/conf.d/*

COPY nginx.conf /etc/nginx/conf.d/thanks.conf

CMD ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
