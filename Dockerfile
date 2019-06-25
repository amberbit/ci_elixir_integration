FROM ubuntu:18.04

ENV CHROMEDRIVER_VERSION=76.0.3809.25

RUN apt-get update; apt-get install -y apt-transport-https;
RUN apt-get install -y --no-install-recommends locales
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV export LC_ALL=en_US.UTF-8
ENV export LANG=en_US.UTF-8
ENV export LANGUAGE=en_US.UTF-8
RUN apt-get install -y wget curl build-essential git
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs esl-erlang=1:22.0.3-1 gettext-base unzip
RUN wget -q https://github.com/elixir-lang/elixir/releases/download/v1.9.0/Precompiled.zip
RUN unzip Precompiled.zip -d elixir
ENV PATH="/elixir/bin:${PATH}"
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN apt-get update && apt-get install -y google-chrome-stable
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
RUN rm -rf /opt/selenium/chromedriver
RUN unzip /tmp/chromedriver_linux64.zip -d /opt/selenium
RUN rm /tmp/chromedriver_linux64.zip
RUN mv /opt/selenium/chromedriver /opt/selenium/chromedriver-${CHROMEDRIVER_VERSION}
RUN chmod 755 /opt/selenium/chromedriver-${CHROMEDRIVER_VERSION}
RUN ln -fs /opt/selenium/chromedriver-${CHROMEDRIVER_VERSION} /usr/bin/chromedriver

