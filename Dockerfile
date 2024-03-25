FROM ubuntu:latest as builder

COPY skyscraper.sh /

RUN apt update && \
  apt upgrade -y && \
  # Install build essentials
  apt install -y \
    build-essential \
    qtbase5-dev \
    qt5-qmake \
    qtbase5-dev-tools \
    wget \
    sudo && \
  # Clean up apt cache
  apt autoremove -y && \
    apt clean && \
    rm -rf /var/cache/apt && \
  # Pull down latest skysource
  mkdir /skysource && \
  cd /skysource && \
  wget https://raw.githubusercontent.com/muldjord/skyscraper/master/update_skyscraper.sh && \
  chmod a+x update_skyscraper.sh && \
  # Run installer
  cd /skysource && \
  ./update_skyscraper.sh

ENV CONFIG_FILE=/config.ini \
    ROMS_PATH=/roms \
    RUN_SCREENSCRAPER=1

ENTRYPOINT [ "/skyscraper.sh" ]
