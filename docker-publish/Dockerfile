FROM node:latest

ENV PATH /app/node_modules/.bin:$PATH
RUN apt -qq update -y
RUN  apt -qq install -y --no-install-recommends ca-certificates \
      git \
      bash \
      aria2 \
      wget \
      unzip \
      curl \
      sudo \
      unrar
# Copy all files from BuildDir to Workdir
COPY . .
RUN npm i -g npm && npm install --force
WORKDIR /app/
ADD . /app/
RUN mv /app/src/.constants.js.example /app/src/.constants.js && \
    yarn && \
    npx tsc && \
    rm -rf /app/src/.constants.js && \
    rm -rf /app/out/.constants.js

CMD ["bash"]
