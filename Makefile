DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUSIONS := .DS_Store .config .git .gitmodules .gitignore .travis.yml
DOTCANDIDATES := $(wildcard .??*)
XDGCANDIDATES := $(wildcard .config/??*)
DOTFILES   := $(filter-out $(EXCLUSIONS), $(DOTCANDIDATES))
XDGFILES   := $(filter-out $(EXCLUSIONS), $(XDGCANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dotfiles in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
	@$(foreach val, $(XDGFILES), /bin/ls -dF $(val);)

install: dot xdg ## Create symlink to home directory

dot:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

xdg:
	@$(foreach val, $(XDGFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Remove the dotfiles and this repo
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	@-$(foreach val, $(XDGFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
