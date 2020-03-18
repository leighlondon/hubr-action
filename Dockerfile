FROM alpine:3.11 AS base
COPY get.sh /get.sh
RUN apk add --no-cache bash git curl jq \
    && /get.sh MYOB-Technology hubr hubr-linux.zip v0.6.6 \
    && mv hubr /bin/

FROM alpine:3.11 AS action
RUN apk add --no-cache bash
COPY --from=base /bin/hubr /bin/hubr
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
