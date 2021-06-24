#Base Image
FROM ghcr.io/tomyprs/aria-telegram-mirror-bot:dev

# Setup working directory
WORKDIR /app/

# Set proc run
CMD ["bash", "start.sh"]
