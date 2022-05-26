.DEFAULT_GOAL := help

CMDNAME := cheat
INSTALLPATH := $$HOME/bin


.PHONY: all
all:


.PHONY: help
help:
	@echo "Usage: make <target> [options]\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Examples:"
	@echo "make install"


.PHONY: install
install: ## Install cheat command
	rm -rf $(INSTALLPATH)/$(CMDNAME)
	cp $(PWD)/bin/cheat.sh $(INSTALLPATH)/$(CMDNAME)
	chmod +x $(INSTALLPATH)/$(CMDNAME)
	@echo ""
	@echo "Install Completion. Usage: $(CMDNAME) --help"

