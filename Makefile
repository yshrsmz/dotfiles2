DOTFILES_DIR := $(PWD)
SYMLINK_TARGETS := $(wildcard _*)
DESTINATIONS = $(patsubst _%, .%, $(wildcard _*))

targets:
	@$(foreach file, $(SYMLINK_TARGETS), ls -dF $(file);)

destinations:
	@$(foreach file, $(SYMLINK_TARGETS), echo $(file) -- $(patsubst _%,.%,$(file));)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master


deploy:
	@echo 'Start sym-linking dotfiles to current directory.'
	@echo ''
	@$(foreach val, $(SYMLINK_TARGETS), ln -sfnv $(abspath $(val)) $(HOME)/$(patsubst _%,.%,$(val));)

init:
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)

ifeq ($(shell uname), Darwin)
	@$(foreach val, $(wildcard ./etc/init/osx/*.sh), bash $(val);)

homebrew:
	@echo 'Installing homebrew...'
	@echo ''
	@bash $(DOTFILES_DIR)/etc/init/osx/install_homebrew.sh

brew: homebrew
	@echo 'Installing homebrew formulae...'
	@bash $(DOTFILES_DIR)/etc/init/osx/Brewfile

cask: homebrew
	@bash $(DOTFILES_DIR)/etc/init/osx/Caskfile
endif

install: update deploy init
	@exec $$SHELL

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES_FILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTFILES_DIR)
