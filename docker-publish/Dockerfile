FROM node:buster-slim

ENV PATH /app/node_modules/.bin:$PATH

# Update all packages..
RUN echo deb http://http.us.debian.org/debian \
    stable main contrib non-free > /etc/apt/sources.list && \ 
    apt -qq update -y && \
    apt -qq upgrade -y && \
    apt-get dist-upgrade -y
RUN  apt -qq install -y --no-install-recommends ca-certificates \
      git \
      bash \
      aria2 \
      wget \
      unzip \
      curl \
      sudo \
      unrar
# Copy all files from BuildDir to Workdir>
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
