{ pkgs, config, ... }:

{
	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			# python
			ms-python.python
			ms-python.vscode-pylance

			# c
			ms-vscode.cpptools

			# latex
			james-yu.latex-workshop
		];
	};
}
