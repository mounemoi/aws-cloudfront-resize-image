image:
	docker build --tag amazonlinux:nodejs .

build:
	docker run --rm --volume ${PWD}/lambda/origin-response-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install sharp --save; npm install querystring --save; npm install --only=prod"
	docker run --rm --volume ${PWD}/lambda/viewer-request-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install querystring --save; npm install --only=prod"
	mkdir -p dist && cd lambda/origin-response-function && zip -FS -q -r ../../dist/origin-response-function.zip * && cd ../..
	mkdir -p dist && cd lambda/viewer-request-function && zip -FS -q -r ../../dist/viewer-request-function.zip * && cd ../..

clean:
	rm -rf dist/*.zip
	rm -rf lambda/origin-response-function/node_modules/
	rm -rf lambda/origin-response-function/package.json
	rm -rf lambda/origin-response-function/package-lock.json
	rm -rf lambda/viewer-request-function/node_modules/
	rm -rf lambda/viewer-request-function/package.json
	rm -rf lambda/viewer-request-function/package-lock.json
