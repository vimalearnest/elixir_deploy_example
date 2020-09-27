.PHONY: setup deps clean iex rel live

setup:
	mix local.hex --force && mix local.rebar --force

deps:
	mix deps.get

clean:
	mix clean

iex:
	iex -S mix phx.server

rel:
	MIX_ENV=prod mix compile
	MIX_ENV=prod mix release --overwrite hello

live: rel
	REPLACE_OS_VARS=true _build/prod/rel/hello/bin/hello start_iex
