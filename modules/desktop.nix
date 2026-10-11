{ pkgs, lib, ... }:

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

  kb = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
in
{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
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
