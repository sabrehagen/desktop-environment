ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install vs code, vs live share dependencies, shfmt extension dependency, and vs-wal
RUN wget -q -O code.deb -nv https://go.microsoft.com/fwlink/?LinkID=760868 && \
  sudo apt-get install -qq ./code.deb && \
  rm code.deb && \
  sudo apt-get install -qq libicu[0-9][0-9] libkrb5-3 zlib1g libsecret-1-0 desktop-file-utils x11-utils && \
  sudo wget -q -O /usr/local/bin/shfmt -nv https://github.com/mvdan/sh/releases/download/v3.2.0/shfmt_v3.2.0_linux_amd64 && \
  sudo chmod +x /usr/local/bin/shfmt

# Start an x server for applications that require one to function (wal, code)
# Install code settings sync extension, clear extension download history, start code so extensions install, forcibly terminate code after extensions install (race condition), generate wal cache
# Terminate x server and wait for shutdown
RUN echo sleep infinity >> /tmp/xstartup && \
  chmod +x /tmp/xstartup && \
  export DISPLAY=:2 && \
  vncserver $DISPLAY \
  -autokill \
  -SecurityTypes none \
  -xstartup /tmp/xstartup && \
  code --install-extension Shan.code-settings-sync && \
  sed -i '/lastDownload/d' $HOME/.config/Code/User/syncLocalSettings.json && \
  code && sleep 90 && pkill -f code && \
  code && sleep 5 && pkill -f code && \
  ~/.config/scripts/wal.sh && \
  kill -HUP $(pgrep Xtigervnc) && sleep 2
