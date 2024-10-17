# Makefile

# Variables
URL := https://raw.githubusercontent.com/figma/rest-api-spec/refs/heads/main/openapi/openapi.yaml
OPENAPIFILE := OpenAPI/openapi.yaml
CONFIG := OpenAPI/openapi-generator-config.yaml
OUTPUT := Sources/FigmaAPI

# Targets
.PHONY: all download patch generate

all: download patch generate

download:
	@curl -sS -o $(OPENAPIFILE) $(URL)
	@echo "Download completed. $(OPENAPIFILE)"

patch:
	# swift-openapi-generator has an issue with type: "null"; Workaround is to convert "null" to null (without quotes)
	# See https://github.com/apple/swift-openapi-generator/issues/553
	# See https://github.com/apple/swift-openapi-generator/issues/565
	@git apply OpenAPI/Patches/remove-type-null-quotes.patch
	# Responses may lack the type field in Hyperlink objects
	@git apply OpenAPI/Patches/remove-hyperlink-required-type.patch
	# Responses return CUSTOM_BEZIER insted of CUSTOM_CUBIC_BEZIER
	@git apply OpenAPI/Patches/rename-custom-cubic-bezier.patch

generate:
	@swift run swift-openapi-generator generate \
		--config $(CONFIG) \
		--output-directory $(OUTPUT) \
		$(OPENAPIFILE)
