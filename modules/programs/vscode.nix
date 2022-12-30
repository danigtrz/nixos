{ config, lib, pkgs, ... }:

{
	programs.vscode = {
		enable = true;
		package = pkgs.vscode.fhs;
		# extensions = with pkgs.vscode-extensions; [
		#     # python
		#     ms-python.python
		#     ms-python.vscode-pylance

		#     # c
		#     ms-vscode.cpptools

		#     # latex
		#     james-yu.latex-workshop

		#     # themes
		#     catppuccin.catppuccin-vsc
		# ];
	};
}
