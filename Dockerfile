FROM alpine:3.11
COPY main.sh /usr/bin/
RUN apk add --no-cache bash
RUN ln -s /usr/bin/main.sh
ENTRYPOINT ["main.sh"]