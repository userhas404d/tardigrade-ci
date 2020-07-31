yamllint/install:
	@ $(MAKE) install/pip/$(@D) PYPI_PKG_NAME=$(@D)

yq/install:
	@ $(MAKE) install/pip/$(@D) PYPI_PKG_NAME=$(@D)

yaml/%: FIND_YAML ?= find . $(FIND_EXCLUDES) -type f \( -name '*.yml' -o -name "*.yaml" \)
## Lints YAML files
yaml/lint: | guard/program/yamllint
yaml/lint: YAMLLINT_CONFIG ?= .yamllint.yml
yaml/lint:
	@ echo "[$@]: Running yamllint..."
	$(FIND_YAML) | $(XARGS) yamllint -c $(YAMLLINT_CONFIG) --strict {}
	@ echo "[$@]: Project PASSED yamllint test!"
