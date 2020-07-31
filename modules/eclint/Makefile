eclint/install:
	@ $(MAKE) install/npm/$(@D) NPM_PKG_NAME=$(@D)

## Runs eclint against the project
eclint/lint: | guard/program/eclint guard/program/git
eclint/lint: HAS_UNTRACKED_CHANGES ?= $(shell cd $(PROJECT_ROOT) && git status -s || echo "true")
eclint/lint: ECLINT_FILES ?= git ls-files -z
eclint/lint:
	@ echo "[$@]: Running eclint..."
	cd $(PROJECT_ROOT) && \
	[ -z "$(HAS_UNTRACKED_CHANGES)" ] || (echo "untracked changes detected!" && exit 1)
	cd $(PROJECT_ROOT) && \
	$(ECLINT_FILES) | grep -zv ".bats" | xargs -0 -I {} eclint check {}
	@ echo "[$@]: Project PASSED eclint test!"
