node/install: NODE_VERSION ?= 10.x
node/install: NODE_SOURCE ?= https://deb.nodesource.com/setup_$(NODE_VERSION)
node/install:
	@ echo "[$@]: Installing $(@D)..."
	$(CURL) "$(NODE_SOURCE)" | bash -
	apt-get install nodejs -y
	npm --version
	@ echo "[$@]: Completed successfully"

npm/install: node/install

install/npm/%: | guard/program/npm
	@ echo "[$@]: Installing $*..."
	npm install -g $(NPM_PKG_NAME)
	$* --version
	@ echo "[$@]: Completed successfully!"
