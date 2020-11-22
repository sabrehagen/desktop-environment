ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install discord
RUN wget -q -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb" && \
  sudo dpkg -i discord.deb || sudo apt-get install -qq --fix-broken && \
  rm discord.deb
