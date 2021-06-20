#Base Image
FROM ghcr.io/tomyprs/aria-telegram-mirror-bot:dev

WORKDIR /app/

CMD ["bash", "start.sh"]
