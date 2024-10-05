FROM ubuntu:24.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd --gid 1001 user \
  && useradd --uid 1001 --gid user --shell /bin/bash --create-home user

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

RUN echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install chrome
RUN curl -sSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb && \
  apt-get install ./chrome.deb -y && \
  rm -f chrome.deb

# For debugging with VNC
EXPOSE 5900

USER user

WORKDIR /home/user/app

COPY . .

CMD [ "./entrypoint.sh" ]
