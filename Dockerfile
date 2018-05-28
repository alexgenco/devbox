FROM debian:stretch

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -q -y \
      autoconf \
      bison \
      build-essential \
      curl \
      git-core \
      libffi-dev \
      libgdbm-dev \
      libgdbm3 \
      libncurses5-dev \
      libreadline6-dev \
      libssl-dev \
      libyaml-dev \
      locales \
      man \
      ruby \
      stow \
      sudo \
      tmux \
      vim \
      wget \
      zlib1g-dev

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add dev user
RUN useradd --create-home --shell /bin/bash dev
RUN adduser dev sudo
RUN echo dev:dev | chpasswd

# Install dotfiles
RUN git clone https://github.com/alexgenco/dotfiles.git /home/dev/.dotfiles
RUN cd /home/dev/.dotfiles && HOME=/home/dev rake install
RUN chown -R dev:dev /home/dev

USER dev
WORKDIR /home/dev
RUN ~/.rbenv/bin/rbenv global 2.5.1

ENTRYPOINT tmux
