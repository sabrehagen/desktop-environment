ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install chrome
RUN sudo apt-get update -qq && \
  sudo apt-get install -qq \
  apt-transport-https \
  ca-certificates \
  gnupg \
  hicolor-icon-theme \
  libcanberra-gtk* \
  libgl1-mesa-dri \
  libgl1-mesa-glx \
  libpango1.0-0 \
  libpulse0 \
  libv4l-0 \
  fonts-symbola \
  --no-install-recommends && \
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
  echo deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google.list && \
  sudo apt-get update -qq && \
  sudo apt-get install -qq google-chrome-stable --no-install-recommends || sudo apt-get install -qq --fix-broken && \
  sudo rm /etc/apt/sources.list.d/google-chrome.list && \
  sudo wget -O /etc/fonts/local.conf -nv https://raw.githubusercontent.com/jessfraz/dockerfiles/master/chrome/stable/local.conf && \
  sudo groupadd --system chrome
