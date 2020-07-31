shellcheck/install: SHELLCHECK_VERSION ?= latest
shellcheck/install: $(BIN_DIR) guard/program/xz
	$(MAKE) -s stream/gh-release/$(@D) OWNER=koalaman REPO=shellcheck VERSION=$(SHELLCHECK_VERSION) QUERY='.name | endswith("$(OS).x86_64.tar.xz")' | tar -xJv
	mv $(@D)-*/$(@D) $(BIN_DIR)
	rm -rf $(@D)-*
	$(@D) --version

sh/%: FIND_SH := find . $(FIND_EXCLUDES) -name '*.sh' -type f
## Lints bash script files
sh/lint: | guard/program/shellcheck
	@ echo "[$@]: Linting shell scripts..."
	$(FIND_SH) | $(XARGS) shellcheck {}
	@ echo "[$@]: Shell scripts PASSED lint test!"
