FROM node:8-alpine

ENV TZ Asia/Shanghai

ENV PATH /root/.yarn/bin:$PATH

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

RUN apk update \
  && apk add yarn

RUN yarn global add shadowsocks-manager \
    && echo $TZ > /etc/timezone \
    && rm /etc/localtime

COPY ss.yml ss.yml

CMD exec ssmgr -c /ss.yml