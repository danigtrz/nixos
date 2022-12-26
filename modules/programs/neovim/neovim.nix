{ config, lib, pkgs, ...}:

{
programs.neovim = {
enable = true;
extraConfig = ''
luafile /home/rafa/.nixos/modules/programs/neovim/settings.lua
lua require'nvim-tree'.setup {}
'';
plugins = with pkgs.vimPlugins; [
# file tree
nvim-web-devicons
nvim-tree-lua


# languages
vim-nix

indentLine
];
};
}

