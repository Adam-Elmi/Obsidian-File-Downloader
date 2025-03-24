# Obsidian File Downloader

A simple Lua script to download markdown files for Obsidian.

## Installation

1. **Clone the Repository:**
```bash
git clone https://github.com/Adam-Elmi/Obsidian-File-Downloader.git

cd Obsidian-File-Downloader
```

2. **Make the Script Executable:**
```bash
chmod +x file_downloader.lua
```

3. **Add the Folder to Your PATH:**
Edit your shell configuration file:

- Bash: `nano ~/.bashrc`
- Zsh: `nano ~/.zshrc`

Add this line at the end:
```bash
export PATH="$HOME/Obsidian-File-Downloader:$PATH"
```

Reload the shell configuration:
```bash
source ~/.bashrc  # or source ~/.zshrc, etc.
```

## Usage

You can run the script directly with Lua:
```bash
lua file_downloader.lua
```

Or, if you added it to your PATH and made it executable:
```bash
file_downloader.lua
```

## Troubleshooting
- **Script Not Found:** Make sure the script is in the right folder and added to your PATH.
- **Permission Denied:** Run this to make the script executable:
```bash
chmod +x file_downloader.lua
```
- **Lua Not Installed:** Install Lua with:
```bash
sudo apt install lua5.4  # For Debian/Ubuntu
brew install lua         # For macOS
```

## License
MIT License

## Author
[Adam Elmi](https://github.com/Adam-Elmi)