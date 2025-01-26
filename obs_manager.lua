#!/usr/bin/env lua

-- Colorize Function
local function colorize(text, color)
    local colors = {
        reset = "\27[0m",
        red = "\27[31m",
        green = "\27[32m",
        yellow = "\27[33m",
        blue = "\27[34m",
        magenta = "\27[35m",
        cyan = "\27[36m",
        white = "\27[37m",
    }

    return (colors[color] or colors.reset) .. text .. colors.reset
end

-- Bash Input Function
local function bash_input()
    print(colorize("Enter your Obsidian vault path ", "cyan"))

    os.execute("chmod +x ./interactive.sh")
    local handle = io.popen("./interactive.sh")
    local file_input = handle:read("*a")
    handle:close()

    file_input = file_input:gsub("%s+$", "")

    print(colorize("Successfully added path: " .. file_input, "green"))
    return file_input
end

-- File Path Handling
local function get_file_path()
    local file = io.open("config.txt", "w")
    if file then
        local path = bash_input()
        print(colorize("Current vault: " .. path, "yellow"))
        file:write(path)
    end
    file:close()
end

-- Utility Functions
local function showPath()
    local file = io.open("config.txt", "r")
    if file then
        local content = file:read("*a")
        file:close()
        if content ~= "" then
            print("Current vault path: " .. colorize(content, "green"))
        else
            print(colorize("Current path is empty. Please enter your vault path!", "red"))
        end
    else
        print(colorize("Failed to open the file!", "red"))
    end
end

local function command_includes(commands, value)
    for _, v in pairs(commands) do
        if v.command == value then
            return true
        end
    end
    return false
end

-- File Manager
local function file_manager()
    local file = io.open("config.txt", "r")
    if not file then
        print(colorize("No config file found. Please set up the vault path first.", "red"))
        return
    end

    local path = file:read("*a"):gsub("%s+", "")
    file:close()

    local repo = ""

    local function download()
        print("Enter the repository URL to download:\n")
        io.write("> ")
        repo = io.read()
        print("Downloading repository:", repo)
        local handle = io.popen("cd " .. path .. " && git clone " .. repo)
        handle:close()

        local repo_name = repo:match("/([^/]+)%.git$")
        local repoPath = path .. "/" .. repo_name
        local handleRepo = io.popen(
            "cd " .. repoPath .. 
            ' && find . -type f -not -name "*.md" -delete' .. 
            ' && find . -type f -name "*.md" -exec mv {} ' .. path .. ' \\;' ..
            ' && rm -r ' .. repoPath
        )
        local result = handleRepo:read("*a")
        print(result)
        handleRepo:close()
    end

    local commands = {
        {
            command = "target_folder -c",
            action = "ls " .. path
        },
        {
            command = "showPath",
            action = showPath
        },
        {
            command = "dw",
            action = download
        }
    }

    -- Command Input
    io.write("> ")
    local command = io.read()

    for _, v in pairs(commands) do
        if v.command == command then
            if type(v.action) == "function" then
                v.action()
            else
                os.execute(v.action)
            end
            return
        end
    end

    print(colorize("command: " .. command .. " is not a valid command", "red"))
end


get_file_path()
file_manager()
