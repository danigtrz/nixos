{ config, lib, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            r = "ranger";
            update = "sudo nixos-rebuild switch --flake '.#'";
        };
        history = {
            size = 10000;
            path = "~/.histfile";
        };
        enableAutosuggestions = true;
        initExtra = "
        ";
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
