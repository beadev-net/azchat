start:
	cd src && npm start

docker:
	docker-compose up --build -d

azure-setup:
	sh setup.sh