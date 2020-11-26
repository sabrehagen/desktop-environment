ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install skype
RUN wget -O skype.deb -q https://go.skype.com/skypeforlinux-64.deb && \
  sudo dpkg -i skype.deb || sudo apt-get install -qq --fix-broken && \
  rm skype.deb

# Start skype
CMD skypeforlinux
