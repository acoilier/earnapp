IMAGE ?= earnapp-safe:local
INSTALL_URL ?= https://brightdata.com/static/earnapp/install.sh
INSTALL_SHA256 ?= ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e

.PHONY: check build scan compose-up compose-down

check:
	bash scripts/check-installer.sh
	docker compose config >/dev/null

build:
	docker build 		--build-arg EARNAPP_INSTALL_URL=$(INSTALL_URL) 		--build-arg EARNAPP_INSTALL_SHA256=$(INSTALL_SHA256) 		-t $(IMAGE) .

scan:
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --exit-code 1 --severity HIGH,CRITICAL $(IMAGE)

compose-up:
	docker compose up -d --build

compose-down:
	docker compose down
