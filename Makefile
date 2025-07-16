IMAGE=vladbelo2/ubuntu-lab
TAG=latest

build:
	docker build -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)

run:
	docker run -it $(IMAGE):$(TAG)
