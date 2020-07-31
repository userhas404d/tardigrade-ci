install/pip/%: PYTHON ?= python3
install/pip/%: | guard/env/PYPI_PKG_NAME
	@ echo "[$@]: Installing $*..."
	$(PYTHON) -m pip install --user $(PYPI_PKG_NAME)
	ln -sf ~/.local/bin/$* $(BIN_DIR)/$*
	$* --version
	@ echo "[$@]: Completed successfully!"

black/install:
	@ $(MAKE) install/pip/$(@D) PYPI_PKG_NAME=$(@D)

python/%: FIND_PYTHON := find . $(FIND_EXCLUDES) -name '*.py' -type f
## Lints Python files
python/lint: | guard/program/black
	@ echo "[$@]: Linting Python files..."
	$(FIND_PYTHON) | $(XARGS) black --check $$(dirname {})
	@ echo "[$@]: Python files PASSED lint test!"

## Formats Python files
python/format: | guard/program/black
	@ echo "[$@]: Formatting Python files..."
	$(FIND_PYTHON) | $(XARGS) black $$(dirname {})
	@ echo "[$@]: Successfully formatted Python files!"
