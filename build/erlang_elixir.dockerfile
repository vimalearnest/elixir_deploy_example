FROM ubuntu:18.04

ARG ERLANG_VER
ARG ELIXIR_VER

RUN apt-get update && \
    apt-get -y install wget make git dnsutils locales unzip

# locale configuration to make elixir happy
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN echo "LANG='en_US.UTF-8'\nLANGUAGE='en_US:en'\nLC_ALL='en_US.UTF-8'" \
	> /etc/default/locale

#RUN apt-get -qq install procps libc6 libncurses5 libssl1.0 libgcc1 \
#    libstdc++6 libsctp1 libwxbase3.0-0v5 libwxgtk3.0-0v5
#RUN apt-get -f install

RUN apt-get -qq install nodejs npm
RUN apt-get -f install

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get -y install esl-erlang=1:${ERLANG_VER}-1 && \
    apt-get -y install elixir=${ELIXIR_VER}-1
