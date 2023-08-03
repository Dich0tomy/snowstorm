{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."git/allowed_signers".text =
    ''
    danielzaradny@gmail.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvkKM0pCOfJOuTJo8EUOWy6ckl1Gffkus3RHf1D4LSo danielzaradny@gmail.com
    '';


  programs.git = {
    enable = true;

    userName = "b4mbus";
    userEmail = "danielzaradny@gmail.com";

    lfs = {
      enable = true;
    };

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
        format = "ssh";
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      };

      user.signingkey = "~/.ssh/id_ed25519.pub";

      pretty = {
        b4-log = "%C(yellow #550000 bold)%h%C(auto)%d %C(white #772244) %s %C(auto) (%C(blue bold)%an%Creset, %C(#5499c7)%ar%C(reset))";
      };
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
      today = ''log --oneline --after="5am" --stat --stat-graph-width=50 --pretty=b4-log'';
      after-breakfast = ''!git log --oneline --after="8am" --pretty=b4-log && git diff HEAD~$(git rev-list --count --after="8am" HEAD) --shortstat'';
    };
  };
}
