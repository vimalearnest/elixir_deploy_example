.PHONY: _deploy docker-base docker-tar-builder

ERLANG_VER := 23.0.3
ELIXIR_VER := 1.10.4
APPNAME := hello
BUILD_ARTIFACT := $(APPNAME).tar.gz

check-vars:
ifndef COMMIT_REF
	$(error COMMIT_REF is undefined)
endif
ifndef APPNAME
	$(error APPNAME is undefined)
endif


${BUILD_ARTIFACT}: target-release
	@rm -f $(BUILD_ARTIFACT)
	@echo "built $(BUILD_ARTIFACT) from $(COMMIT_REF)"
	@mv _deploy/$(BUILD_ARTIFACT) .

target-release: check-vars docker-tar-builder
	-docker rm -f build-box
	docker run --name build-box \
                -e APPNAME='hello' \
		-v $$(pwd)/_deploy:/root/_deploy \
                $(APPNAME)_tar_builder

docker-base:
	docker build -t erlang-elixir:$(ERLANG_VER)-$(ELIXIR_VER) \
	--build-arg ERLANG_VER=$(ERLANG_VER) \
	--build-arg ELIXIR_VER=$(ELIXIR_VER) \
	-f erlang_elixir.dockerfile .

docker-tar-builder: docker-base checkout-version
	docker build -t $(APPNAME)_tar_builder \
	--build-arg ERLANG_VER=$(ERLANG_VER) \
	--build-arg ELIXIR_VER=$(ELIXIR_VER) \
        -f builder.dockerfile .

_deploy:
	rm -rf _deploy && mkdir _deploy

_deploy/$(APPNAME): _deploy
	# We want to be able to test commits that haven't been pushed.
	# So, we check out the local git repo from disk
	repo_dir=$$(cd .. && pwd); \
	git clone --local $$repo_dir _deploy/$(APPNAME)

checkout-version: _deploy/$(APPNAME)
	cd _deploy/$(APPNAME) && \
	git fetch && \
	git checkout $(COMMIT_REF) && \
	make setup deps
