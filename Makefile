.PHONY: switch update check

switch:
	home-manager switch --flake .#ideapad

update:
	nix flake update

check:
	nix build .#homeConfigurations.ideapad.activationPackage --no-link
