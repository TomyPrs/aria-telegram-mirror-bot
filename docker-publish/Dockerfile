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

# Copy all files from BuildDir to Workdir
WORKDIR /app/
ADD . /app/
RUN npm i -g npm 
CMD ["bash"]
