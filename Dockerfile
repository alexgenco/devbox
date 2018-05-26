FROM debian:stretch

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -q -y \
      autoconf \
      bison \
      build-essential \
      curl \
      git-core \
      golang-1.7 \
      libffi-dev \
      libgdbm-dev \
      libgdbm3 \
      libncurses5-dev \
      libreadline6-dev \
      libssl-dev \
      libyaml-dev \
      locales \
      man \
      stow \
      tmux \
      vim \
      wget \
      zlib1g-dev

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install go
RUN wget --quiet -P /usr/local/ https://dl.google.com/go/go1.9.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /usr/local/go1.9.2.linux-amd64.tar.gz

# Add dev user
RUN useradd --create-home --shell /bin/bash dev
USER dev
WORKDIR /home/dev

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /home/dev/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /home/dev/.rbenv/plugins/ruby-build

# Install ruby
ENV PATH $PATH:/home/dev/.rbenv/bin
RUN rbenv install -v 2.5.0
RUN rbenv global 2.5.0
RUN rbenv rehash
RUN /home/dev/.rbenv/shims/gem install bundler --no-document
RUN /home/dev/.rbenv/shims/gem install rake --no-document

# Set go path
ENV GOPATH /home/dev/go
ENV PATH "${PATH}:/usr/local/go/bin:/home/dev/go/bin"

# Install dotfiles
RUN git clone https://github.com/alexgenco/dotfiles.git /home/dev/.dotfiles
RUN sh -c "cd ~/.dotfiles && /home/dev/.rbenv/shims/rake install"

CMD "tmux"
