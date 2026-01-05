{ config, pkgs, ... }:

let
  MyAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch --flake /data/dotfiles#catnux";
  };
in

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = MyAliases;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "steeef";
    };
    #initContent = ''
    #  # Cek jika tmux belum berjalan, jalankan tmux
   #   if [[ -z "$TMUX" ]]; then
  #      tmux attach-session -t default || tmux new-session -s default
 #     fi
#    '';
  };
}
