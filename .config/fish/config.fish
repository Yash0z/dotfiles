#environment variables
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
set -x HYPRSHOT_DIR ~/Pictures/screenshots


# Initialize Starship prompt (assuming 'starship' is installed)
starship init fish | source
set -U fish_greeting ""
fastfetch
# Add Node.js version manager (NVM) to PATH
set -x PATH ~/.local/share/nvm/v22.3.0/bin $PATH
#Add spicetify  to PATH
fish_add_path /home/icy/.spicetify
