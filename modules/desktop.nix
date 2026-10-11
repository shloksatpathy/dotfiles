{ pkgs, lib, ... }:

let
  # Flip GNOME's Do Not Disturb. `show-banners` is what the DND switch in the
  # notification tray controls. Uses the system gsettings so it sees the
  # system's schemas rather than the ones from nixpkgs' glib.
  dndToggle = pkgs.writeShellScript "dnd-toggle" ''
    gsettings=/usr/bin/gsettings
    key="org.gnome.desktop.notifications show-banners"

    if [ "$($gsettings get $key)" = "true" ]; then
      $gsettings set $key false
    else
      $gsettings set $key true
    fi
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
