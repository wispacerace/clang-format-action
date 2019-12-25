FROM alpine:3.10

RUN apk update && apk add clang git

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
