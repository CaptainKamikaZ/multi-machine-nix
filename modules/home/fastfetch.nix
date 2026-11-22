{ config, pkgs, ... }:

{
  home.packages = [ pkgs.imagemagick ];

  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      display = {
        separator = " ";
        key = {
          width = 30; 
        };
        bar = {
          width = 10;
          char = {
            elapsed = "■";
            total = "─";
          };
          border = {
            left = "";
            right = "";
          };
        };
        percent = {
          type = [ "bar" ]; # Enables {percentage-bar} and {size-percentage-bar}
        };
      };

      modules = [
        # --- SYSTEM SECTION ---
        {
          type = "custom";
          format = "{#bright_black}┌───────────────────────────────────────────{#}";
        }
        {
          type = "custom";
          format = "{#bright_black}│ {#blue}❄  system{#}";
        }
        {
          type = "os";
          key = "{#bright_black}│  {#cyan}❄  {#}os";
          format = "{pretty-name}";
        }
        {
          type = "kernel";
          key = "{#bright_black}│  {#cyan}  {#}kernel";
          format = "{release}";
        }
        {
          type = "uptime";
          key = "{#bright_black}│  {#cyan}    {#}uptime";
          format = "{formatted}";
        }
        {
          type = "packages";
          key = "{#bright_black}│  {#cyan}    {#}packages";
          format = "{all}";
        }

        # --- DESKTOP SECTION ---
        {
          type = "custom";
          format = "{#bright_black}├───────────────────────────────────────────{#}";
        }
        {
          type = "custom";
          format = "{#bright_black}│ {#blue}  desktop{#}";
        }
        {
          type = "wm";
          key = "{#bright_black}│  {#cyan}  {#}wm";
          format = "{pretty-name}";
        }
        {
          type = "terminal";
          key = "{#bright_black}│  {#cyan}  {#}term";
          format = "{pretty-name}";
        }
        {
          type = "shell";
          key = "{#bright_black}│  {#cyan}  {#}shell";
          format = "{pretty-name}";
        }

        # --- HARDWARE SECTION ---
        {
          type = "custom";
          format = "{#bright_black}├───────────────────────────────────────────{#}";
        }
        {
          type = "custom";
          format = "{#bright_black}│ {#blue}  hardware{#}";
        }
        {
          type = "cpu";
          key = "{#bright_black}│  {#cyan}  {#}cpu";
          format = "{name}";
        }
        {
          type = "gpu";
          key = "{#bright_black}│  {#cyan}    {#}gpu";
          format = "{name}";
        }
        {
          type = "memory";
          key = "{#bright_black}│  {#cyan}  {#}ram";
          format = "{percentage-bar}  {used} / {total}";
        }
        {
          type = "disk";
          key = "{#bright_black}│  {#cyan}    {#}disk";
          folders = "/";
          format = "{size-percentage-bar}  {size-used} / {size-total}";
        }

        # --- BOTTOM BORDER & COLOR DOTS ---
        {
          type = "custom";
          format = "{#bright_black}└───────────────────────────────────────────{#}";
        }
        {
          type = "colors";
          paddingLeft = 12;
          symbol = "circle";
        }
      ];
    };
  };
}
