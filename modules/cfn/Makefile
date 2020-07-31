cfn-lint/install:
	@ $(MAKE) install/pip/$(@D) PYPI_PKG_NAME=$(@D)

cfn/%: FIND_CFN ?= find . $(FIND_EXCLUDES) -name '*.template.cfn.*' -type f
## Lints CloudFormation files
cfn/lint: | guard/program/cfn-lint
	$(FIND_CFN) | $(XARGS) cfn-lint -t {}
