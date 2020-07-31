json/%: FIND_JSON := find . $(FIND_EXCLUDES) -name '*.json' -type f
json/validate:
	@ $(FIND_JSON) | $(XARGS) bash -c 'jq --indent 4 -S . "{}" > /dev/null 2>&1 || (echo "[{}]: Found invalid JSON file: "{}" "; exit 1)'
	@ echo "[$@]: JSON files PASSED validation test!"

## Lints json files
json/lint: | guard/program/jq json/validate
	@ echo "[$@]: Linting JSON files..."
	$(FIND_JSON) | $(XARGS) bash -c 'cmp {} <(jq --indent 4 -S . {})'
	@ echo "[$@]: JSON files PASSED lint test!"

## Formats json files
json/format: | guard/program/jq json/validate
	@ echo "[$@]: Formatting JSON files..."
	$(FIND_JSON) | $(XARGS) bash -c 'echo "$$(jq --indent 4 -S . "{}")" > "{}"'
	@ echo "[$@]: Successfully formatted JSON files!"
