FROM adriancampos/nginx

ENV USUARIO="AdrianCV"
ENV PASSWORD="adriancv"
ENV GITHUB="https://github.com/AdrianRCV/PokeAPINext.git"
ARG TZ
ARG CONTEXT
ARG PROYECTO
USER root

RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y curl gnupg software-properties-common

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get install -y nodejs

USER root
RUN mkdir /root/admin/next
COPY ./dockerfiles/js/next /root/admin/next
RUN chmod +x /root/admin/next/admin/start.sh

WORKDIR /var/www/html

EXPOSE 3000

WORKDIR /root/admin/next
ENTRYPOINT ["./admin/start.sh"]