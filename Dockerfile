FROM ubuntu:24.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN /usr/bin/apt-get update && \
	/usr/bin/apt-get upgrade -y && \
	/usr/bin/apt-get install -y \
  curl \
  sudo \
  pulseaudio \
  xvfb \
  libnss3-tools \
  ffmpeg \
  xdotool \
  unzip \
  x11vnc \
  libfontconfig \
  libfreetype6 \
  xfonts-cyrillic \
  xfonts-scalable \
  fonts-liberation \
  fonts-ipafont-gothic \
  fonts-wqy-zenhei

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - 
RUN apt-get install -y \
  nodejs \
  npm

RUN sudo npm install -g puppeteer

# Install chrome
RUN curl -sSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb && \
  apt-get install ./chrome.deb -y && \
  rm -f chrome.deb

# For debugging with VNC
EXPOSE 5900

WORKDIR /root/app

COPY . .

CMD [ "./entrypoint.sh" ]
