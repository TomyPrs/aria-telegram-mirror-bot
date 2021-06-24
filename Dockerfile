#Base Image
FROM ghcr.io/tomyprs/aria-telegram-mirror-bot:dev

# Setup working directory
WORKDIR /app/
RUN npm install --force
RUN cp /app/src/.constants.js.example /app/src/.constants.js && \
    yarn && \
    npx tsc && \
    rm -rf /app/src/.constants.js && \
    rm -rf /app/out/.constants.js

# Set proc run
CMD ["bash", "start.sh"]
