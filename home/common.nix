{
  config,
  pkgs,
  lib,
  ...
}:

{
  home = {
    username = "ksa";
    homeDirectory = "/home/ksa";
    stateVersion = "25.11";
  };
  
  programs.home-manager.enable = true;
  programs.git = {
      enable = true;
      package = pkgs.git;
      userName = "seko2000-ksa";
      userEmail = "seko2000@gmail.com";
      settings = {
          core.editor = "nvim";
      };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyo-night";
      theme_background = true;
      truecolor = true;
    };
  };

  xdg.configFile = {
    "starship.toml".source = ../config/starship/starship.main.toml;
    "eza/theme.yml".source = ../config/eza/eza.main.yml;
    "fuzzel/fuzzel.ini".source = ../config/fuzzel/tokyonight.fuzzel.ini;
    "fastfetch/config.jsonc".source = ../config/fastfetch/main.fastfetch;
    "fastfetch/violet.png".source = ../config/icons/violet.png;
    "qt5ct/qt5ct.conf".source = ../config/qt5ct/qt5ct.conf;
    "qt5ct/colors/noctalia.conf".source = ../config/qt5ct/colors/noctalia.conf;
    "nvim/".source = ../config/nvim;
  };
}
