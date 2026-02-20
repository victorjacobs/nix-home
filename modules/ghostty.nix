{...}: {
  xdg.configFile."ghostty/config".text = ''
    auto-update-channel = tip

    # Font
    font-family = MesloLGS NF
    font-size = 13
    font-thicken = true

    # Theme
    background = 000000
    foreground = e5e5e5
    cursor-color = e5e5e5
    cursor-style = block
    split-divider-color = 444444

    palette = 2=00d700
    palette = 6=00aaaa
    palette = 10=00ff00
    palette = 14=00ffff

    # Window
    unfocused-split-opacity = 0.5

    # Behavior
    copy-on-select = false
    confirm-close-surface = false
    shell-integration = zsh

    # Cursor
    cursor-style = block
    cursor-style-blink = false
  '';
}
