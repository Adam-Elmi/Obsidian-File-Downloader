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
source ~/.bashrc  # or source ~/.zshrc.
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

### Commands

Run the script and enter a command when prompted:
```bash
file_downloader.lua
Enter a command or type help:
```

- **show:**
```bash
Enter a command or type help:
show
Current folder location: /path/to/your/folder
```

- **change:**
```bash
Enter a command or type help:
change
> /new/path/to/folder
Successfully!
New folder location: /new/path/to/folder
```

- **download:**
```bash
Enter a command or type help:
download
Enter the link of the repo:
https://github.com/username/repo.git
```

- **help:**
```bash
Enter a command or type help:
help
=====================
usage:
command

The commands:
show: shows the current location
change: changes the folder location
download: downloads markdown files
help: displays this help message
=====================
```

## License
MIT License