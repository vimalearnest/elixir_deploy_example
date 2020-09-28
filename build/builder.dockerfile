ARG ERLANG_VER
ARG ELIXIR_VER

FROM erlang-elixir:${ERLANG_VER}-${ELIXIR_VER}

WORKDIR /root

VOLUME /root/_deploy

ENV PATH="/opt/elixir/${ELIXIR_VER}/bin:${PATH}"

CMD cd /root/_deploy/${APPNAME} && rm -rf _build && \
  echo "appname : ${APPNAME}" && \
  make setup deps rel && \
  cp _build/prod/${APPNAME}-`mix ver`.tar.gz ../ && \
  cd /root && chmod -R a+rw *
