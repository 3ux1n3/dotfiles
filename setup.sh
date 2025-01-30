#!/bin/bash

# --- Start Setup ---
echo "Starting system setup..."

# --- Install Homebrew if needed ---
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# --- Install packages using Brewfile ---
echo "Installing packages from Brewfile..."
brew bundle --file="$HOME/CodeBases/dotfiles/Brewfile"


# --- Switch to Fish Shell ---
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
  echo "Adding Fish shell to /etc/shells..."
  echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi

echo "Switching shell to Fish..."
chsh -s /opt/homebrew/bin/fish

# --- Setup Configs ---
echo "Setting up configuration files..."
cp -r "$HOME/CodeBases/dotfiles/config" "$HOME/.config"


# --- Setup SSH Configuration ---
echo "Setting up SSH configuration..."

ENCRYPTED_SSH_ARCHIVE="$HOME/CodeBases/dotfiles/ssh.tar.gz.enc"
EXTRACTED_ARCHIVE="$HOME/ssh.tar.gz"

# Check if the encrypted archive exists
if [ ! -f "$ENCRYPTED_SSH_ARCHIVE" ]; then
  echo "Error: Encrypted SSH archive not found!"
  exit 1
fi

# Prompt for decryption password
echo "Enter the password to decrypt SSH configuration:"
read -s DECRYPTION_PASSWORD

# Decrypt and extract the SSH archive
openssl enc -aes-256-cbc -d -in "$ENCRYPTED_SSH_ARCHIVE" -out "$EXTRACTED_ARCHIVE" -pass pass:"$DECRYPTION_PASSWORD"
tar -xzf "$EXTRACTED_ARCHIVE" -C "$HOME"

# Set permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
chmod -R 600 ~/.ssh/keys

# Clean up temporary files
rm -f "$EXTRACTED_ARCHIVE"

echo "SSH configuration setup complete."

# --- Setup Git Config with Git Commands ---
echo "Configuring Git..."

# Prompt for user.name
read -p "Enter your Git user.name: " GIT_USER
git config --global user.name "$GIT_USER"

# Prompt for user.email
read -p "Enter your Git user.email: " GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

# Optionally configure other settings
git config --global core.editor "nano"
git config --global pull.rebase false
git config --global init.defaultBranch main

echo "Git configuration complete!"


# --- MacOS settings ---
echo "Configuring the Dock..."

# Clear all apps/folders
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Move Dock to the left
defaults write com.apple.dock orientation -string "left"

# Disable recent apps
defaults write com.apple.dock show-recents -bool false

# Restart Dock to apply changes
killall Dock

echo "Installing Mac App Store apps..."
echo "Make sure you're signed in to the Mac App Store before continuing."
echo "Press Enter to continue, or Ctrl+C to abort."
read  # Wait for user input

# Now install your Mac App Store apps with mas install <app_id>
mas install 497799835  # Xcode
mas install 409201541  # Pages    
mas install 409203825  # Numbers




