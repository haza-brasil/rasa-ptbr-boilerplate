first-run:
	docker-compose up -d rocketchat
	cd docker && ./build-base.sh
	make train
	docker-compose run --rm bot make config-rocket
	docker-compose up -d elasticsearch
	docker-compose up -d kibana
	docker-compose up -d bot

train:
	docker build . -f docker/coach.Dockerfile -t botcoach:latest
	docker-compose build bot

console:
	docker-compose run bot make run-console
