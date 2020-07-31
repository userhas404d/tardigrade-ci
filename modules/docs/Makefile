docs/%: TFDOCS ?= terraform-docs --sort-by-required markdown table
docs/%: README_FILES ?= find . $(FIND_EXCLUDES) -type f -name README.md
docs/%: README_TMP ?= $(TMP)/README.tmp
docs/%: TFDOCS_START_MARKER ?= <!-- BEGIN TFDOCS -->
docs/%: TFDOCS_END_MARKER ?= <!-- END TFDOCS -->

docs/tmp/%: | guard/program/terraform-docs
	@ sed '/$(TFDOCS_START_MARKER)/,/$(TFDOCS_END_MARKER)/{//!d}' $* | awk '{print $$0} /$(TFDOCS_START_MARKER)/ {system("$(TFDOCS) $$(dirname $*)")} /$(TFDOCS_END_MARKER)/ {f=1}' > $(README_TMP)

docs/generate/%:
	@ echo "[$@]: Creating documentation files.."
	@ $(MAKE) docs/tmp/$*
	mv -f $(README_TMP) $*
	@ echo "[$@]: Documentation files creation complete!"

docs/lint/%:
	@ echo "[$@]: Linting documentation files.."
	@ $(MAKE) docs/tmp/$*
	diff $* $(README_TMP)
	rm -f $(README_TMP)
	@ echo "[$@]: Documentation files PASSED lint test!"

## Generates Terraform documentation
docs/generate: | terraform/format
	@ $(README_FILES) | $(XARGS) $(MAKE) docs/generate/{}

## Lints Terraform documentation
docs/lint: | terraform/lint
	@ $(README_FILES) | $(XARGS) $(MAKE) docs/lint/{}
