{ pkgs, config, lib, ... }:

{
	programs.zsh = {
		enable = true;
		dotDir = ".config/zsh";
		shellAliases = {
			update = "sudo nixos-rebuild switch --flake '.#'";
			start = "Hyprland";
			n = "nvim .";
		};
		#histSize = 10000;
		#histFile = "~/.histfile";
		#enableCompletion = true;
		autosuggestion.enable = true;
		# syntaxHighlighting.enable = true;
		# plugins = [
		# 	{
		# 		name = "zsh-autosuggestions";
		# 		src = pkgs.fetchFromGitHub {
		# 			owner = "zsh-users";
		# 			repo = "zsh-autosuggestions";
		# 			rev = "v0.7.0";
		# 			sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
		# 		};
		# 	}
		# ];
	};
}
