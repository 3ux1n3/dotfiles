Below is a **revised README** that aligns with your script’s behavior—namely, the script handles **Homebrew**, **Brewfile**, and **mas** installations automatically, so there’s no need for extra user steps on that front.

---

# macOS Automated Setup

This repository contains a script (`setup.sh`) that automates installing and configuring common tools, shell configurations, and system preferences on a fresh macOS installation.

## What This Script Does

1. **Installs Homebrew** (if not already installed).  
2. **Installs all packages** specified in the `Brewfile` (using `brew bundle`).  
3. **Switches** your default shell to **Fish**.  
4. **Copies** everything in `config/` to `~/.config/` (e.g., configs for Fish, Alacritty, etc.).  
5. **Decrypts and sets up SSH keys** (requires an encrypted `ssh.tar.gz.enc` file).  
6. **Prompts for Git user name/email** and configures Git globally.  
7. **Customizes the Dock** by clearing icons, moving it to the left, and disabling recent apps.  
8. **Installs Mac App Store apps** (via `mas`) after prompting you to confirm you’re signed in.

## How to Use

1. **Clone this Repository**

   ```bash
   mkdir CodeBases
   cd ~/CodeBases
   git clone https://github.com/<your-username>/dotfiles.git
   cd dotfiles
   ```

2. **Make the Script Executable**

   ```bash
   chmod +x setup.sh
   ```

3. **Run the Script**

   ```bash
   ./setup.sh
   ```

   - The script will handle installing Homebrew, running `brew bundle --file=Brewfile`, switching shells, etc.
   - When prompted, enter your **decryption password** for the SSH configuration, as well as your **Git user name** and **Git email**.
   - When the script prompts you to sign in to the Mac App Store, do so, then press **Enter** to continue installing Mac App Store apps.

## Customizing

1. **Brewfile**:  
   - Located at `~/CodeBases/dotfiles/Brewfile`.  
   - Edit to add/remove Homebrew packages and casks.  
2. **macOS Defaults**:  
   - Currently, the script only customizes the Dock.  
   - To add other macOS tweaks (Finder, keyboard settings, etc.), use more `defaults write` commands and restart the relevant services.
3. **`config/` Folder**:  
   - Place all your configuration files (e.g., Fish, Alacritty, etc.) into `config/` so they’re copied to `~/.config/`.
4. **Mac App Store Apps**:  
   - Change the `mas install <app_id>` lines to install whatever apps you need.

## Troubleshooting

- **Permission Issues**: Ensure `setup.sh` is executable (`chmod +x setup.sh`).  
- **Homebrew Fails to Install**: Update macOS or install Xcode Command Line Tools manually.  
- **SSH Decryption Fails**: Check your password or ensure `ssh.tar.gz.enc` exists.  
- **macOS Not Signed In**: If `mas install` fails, confirm you’re logged in with your Apple ID in the Mac App Store.

## Contributing

Feel free to open issues or pull requests to improve or extend this script for your own use cases or to help others.

## License

You can include a license of your choice here (MIT, Apache 2.0, etc.) if you plan to share this repository publicly.

---

That’s it! With this README, anyone can quickly see what your script does and how to run it. Enjoy your automated macOS setup!