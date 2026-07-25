{ pkgs, ... }:

# 仕事用 Mac (Apple Silicon)
{
  home.username = "masanori.onda";
  home.homeDirectory = "/Users/masanori.onda";

  # このホストだけで使うパッケージ
  home.packages = with pkgs; [
    biome
    dbmate
    azure-cli
    pdftoipe
  ];
}
