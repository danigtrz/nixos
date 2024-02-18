{ pkgs, config, ... }:

{
	programs.zsh = {
		enable = true;
		shellAliases = {
			update = "sudo nixos-rebuild switch --flake '.#'";
		};
		histSize = 10000;
		histFile = "~/.histfile";
		enableCompletion = true;
		enableAutosuggestions = true;
		syntaxHighlighting.enable = true;
		plugins = [
			{
				name = "zsh-autosuggestions";
				src = pkgs.fetchFromGitHub {
					owner = "zsh-users";
					repo = "zsh-autosuggestions";
					rev = "v0.7.0";
					sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
				};
			}
		];
	};
}
