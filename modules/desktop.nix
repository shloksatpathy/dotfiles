{ config, pkgs, lib, ... }:

let
  # Flip GNOME's Do Not Disturb. `show-banners` is what the DND switch in the
  # notification tray controls. WezTerm's toasts (e.g. Claude Code's terminal
  # notifications) still get through it, so its per-app switch is flipped too.
  # Uses the system gsettings so it sees the system's schemas rather than the
  # ones from nixpkgs' glib.
  dndToggle = pkgs.writeShellScript "dnd-toggle" ''
    gsettings=/usr/bin/gsettings
    banners="org.gnome.desktop.notifications show-banners"
    wezterm="org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-wezfurlong-wezterm/ enable"

    if [ "$($gsettings get $banners)" = "true" ]; then
      state=false
    else
      state=true
    fi

    $gsettings set $banners $state
    $gsettings set $wezterm $state
  '';

  # Copied to a stable path, since store paths change on every rebuild.
  wallpaper = "file://${config.home.homeDirectory}/.local/share/wallpapers/wallpaper.jpg";

  kb = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
in
{
  home.file.".local/share/wallpapers/wallpaper.jpg".source = ../wallpapers/wallpaper.jpg;

  dconf.settings = {
    # The lock screen uses the same wallpaper.
    "org/gnome/desktop/background" = {
      picture-uri = wallpaper;
      picture-uri-dark = wallpaper;
      picture-options = "zoom";
    };

    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = lib.hm.gvariant.mkUint32 0;
      picture-uri = wallpaper;
    };

    # Blank the screen after 5 minutes, which then locks it.
    "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 300;

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super>l" ];
      custom-keybindings = [
        "/${kb}/custom0/"
        "/${kb}/custom1/"
      ];
    };

    "${kb}/custom0" = {
      name = "Wezterm";
      command = "wezterm";
      binding = "<Control><Alt>space";
    };

    "${kb}/custom1" = {
      name = "Toggle Do Not Disturb";
      command = "${dndToggle}";
      binding = "<Control><Shift>m";
    };
  };
}
