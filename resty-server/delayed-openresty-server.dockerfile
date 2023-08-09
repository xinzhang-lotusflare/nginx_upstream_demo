FROM ecr.lotusflare.info/openresty-unified:20230620-1835

ENV ALLOW_UNSAFE_UUID="true"
# TODO: do we need $service_name path?
ENV LUA_PATH_EXTRA="/mnt/lua/?.lua;/opt/lua/?.lua;/mnt/lua/libs/?.lua;/mnt/lua/$SERVICE_NAME/?.lua"

COPY entrypoint.sh /

RUN apt-get update \
    && apt-get -y install gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /mnt/lua \
    && rm -rf /etc/nginx \
    && chmod +x /entrypoint.sh

COPY openresty.conf /etc/nginx/nginx.conf

EXPOSE 80 443 9909
CMD ["/entrypoint.sh"]
