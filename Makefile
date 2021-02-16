DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dotfiles in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Remove the dotfiles and this repo
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
