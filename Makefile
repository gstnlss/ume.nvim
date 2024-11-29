target = $(HOME)/.config
package = config

stow:
	stow --target $(target) --verbose $(package)

dry-run:
	stow --no --target $(target) --verbose $(package)

restow:
	stow --target $(target) --verbose --restow $(package)

delete:
	stow --target $(target) --verbose --delete $(package)
