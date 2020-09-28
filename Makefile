.PHONY: setup deps clean iex rel live

APPNAME := hello

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
	MIX_ENV=prod mix release --overwrite $(APPNAME)

live: rel
	REPLACE_OS_VARS=true _build/prod/rel/$(APPNAME)/bin/$(APPNAME) start_iex

target-release:
	cd build && $(MAKE) $(APPNAME).tar.gz

build-latest-tag:
	$(MAKE) target-release \
           commit_ref=$(shell git tag --sort=-v:refname | head -1)

build-latest-commit:
	$(MAKE) target-release \
	   COMMIT_REF=$(shell git describe --always --tags)
