#Base Image
FROM ghcr.io/tomyprs/aria-telegram-mirror-bot:master

# Setup working directory
WORKDIR /app/

# Set proc run
CMD ["bash", "start.sh"]