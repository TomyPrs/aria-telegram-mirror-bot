#Base Image
FROM ghcr.io/tomyprs/aria-telegram-mirror-bot:master

WORKDIR /app/

CMD ["bash", "start.sh"]
