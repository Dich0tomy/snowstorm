{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    nix-index.enable = true;

    starship = {
      enable = true;

      enableFishIntegration = true;

      settings = {
        scan_timeout = 5;

        format = "$directory[$git_branch](fg:#a2a9b0) ([$nix_shell](fg:#00fff0) )$character";

        character = {
          error_symbol = "[❯](bold red)";
          success_symbol = "[❯](bold green)";
          vicmd_symbol = "[❯](bold yellow)";
        };

        nix_shell = {
          format = "\\[\\$\\]";
        };

        directory = {
          truncation_length = 1;
          format = "[$path]($style)[$read_only]($read_only_style)";
          style = "fg:#78a9ff";
          read_only = "[RO]";
          read_only_style = "fg:#393939";
        };

        git_branch.format = " [#](fg:#525252)$branch(:$remote_branch)";
      };
    };

    fish = {
      enable = true;

      functions = {
        cd-flake = "cd $(nix flake metadata $argv --json | nix run nixpkgs#jq -- -r .path)";

        ng = "nvim +'Neogit kind=replace'";
      };

      shellAbbrs = {
        m = "mkdir";
        n = "nvim";
        ls = "eza --group-directories-first -l";
        la = "eza --group-directories-first -la";

        nl = "nix-locate";

        g = "git";
        gc = "git commit -m";
        gs = "git status";
        gl = "git l -10";
        gl2 = "git l -20";
        gl3 = "git l -50";
      };
    };
  };
}
