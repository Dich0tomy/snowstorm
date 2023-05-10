{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "b4mbus";
    userEmail = "danielzaradny@gmail.com";

    extraConfig = {
      init.defaultBranch = "trunk";
      safe = {
        directory = "*";
      };

      core = {
        editor = "nvim";
      };

      push.default = "current";
      merge.stat = "true";

      commit.gpgsign = true;
      gpg = {
        format  ="ssh";
      };

      user.signingkey = "~/.ssh/id_ed25519.pub";
    };

    delta = {
      enable = true;
      options = {
        side-by-side = true;
      };
    };

    aliases = {
      co = "checkout";

      s = "switch -C";
      b = "branch";
      l = ''
      log --color --abbrev-commit --decorate --date=short --pretty="%C(yellow)%h%C(auto)%d %s (%C(bold blue)%an%Creset, %C(blue)%ar%C(reset))" -10
      '';
    };
  };
}
