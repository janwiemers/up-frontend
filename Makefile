#!make

.DEFAULT_GOAL := test_all

test_all:
	go test -v -coverpkg=./... -coverprofile=profile.cov ./... && go tool cover -func profile.cov && rm -rf profile.cov

run.dev:
	npm run serve

build.webpack:
	npm run build


build.docker:
	docker build -t up-frontend:latest .

build: build.webpack build.docker
	