with import <nixpkgs> {};

pkgs.discord.override {
    nss = pkgs.nss_3_89_1;
}