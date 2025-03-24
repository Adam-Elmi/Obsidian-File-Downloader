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
-- Add_location Function: Adds the location of the folder
local function add_location(filename, location)
    local file = io.open(filename, "w")
    if file then
        file:write(location)
        file:close()
    end
end
-- Bash Input Function
local function bash_input(message, enable_print_message)
    if message then
        print(colorize(message, "cyan"))
    else
        print(colorize("Enter folder location: ", "cyan"))
    end

    os.execute("chmod +x ./interactive.sh")
    local handle = io.popen("./interactive.sh")
    if handle then
        local file_input = handle:read("*a")
        handle:close()
        file_input = file_input:gsub("%s+$", "")
        if enable_print_message then
            add_location("location.txt", file_input)
            print(colorize("Successfully!", "green"))
            print(colorize("New folder location: ", "cyan") .. colorize(file_input, "yellow"))
        end
        return file_input
    end
end
-- Check Function: Checks if file content is empty or not
local function check_file_content(filename)
    local file = io.open(filename)
    if file then
        local content = file:read("*a")
        if content == "" then
            return true, content
        else
            return false, content
        end
        file:close()
    end
end
-- Download Function: downloads markdown files
local function download()
    local is_empty, folder_location = check_file_content("location.txt")
    if not is_empty then
        local output = bash_input("Enter the link of the repo", false)
        if output then
            os.execute("cd " .. folder_location .. "&&" .. "git clone " .. output)
            local repo_name = output:match("/([^/]+)%.git$")
            os.execute("cd " .. folder_location .. "/" .. repo_name .. "&&" ..
                "find . -type f -not -name *.md -delete" ..
                "&& find . -type f -name *.md -exec mv {} " .. folder_location .. ' \\;')
            os.execute("sleep 1")
            os.execute('rm -r ' .. folder_location .. "/" .. repo_name)
        end
    end
end
-- Execute Function: executes commands
local function execute()
    local commands = {
        show = {
            action = function()
                local is_empty, folder_location = check_file_content("location.txt")
                if not is_empty then
                    print(colorize("Current folder location: ", "cyan") .. colorize(folder_location, "yellow"))
                end
            end
        },
        change = {
            action = function()
                return bash_input(true)
            end
        },
        download = {
            action = function()
                return download()
            end
        },
        help = {
            action = function()
                local guide = [[
=====================
usage:
command

The commands:
show: shows the current location
change: changes the folder location
help: displays this help message
=====================
]]
                print(guide)
            end
        }
    }
    local input_command = bash_input("Enter a command or type help:", false)
    if not input_command then return end
    local cmd = string.lower(input_command)
    local is_matched = false
    for k, v in pairs(commands) do
        if k == cmd then
            is_matched = true
            if is_matched then
                return v.action()
            end
        end
    end
    if not is_matched then
        print(colorize("Command ", "red") ..
            colorize(cmd, "yellow") .. colorize(" is not a valid command", "red"))
    end
end

local is_empty, file_content = check_file_content("location.txt")

if is_empty then
    print(colorize("Folder location is empty.", "red"))
    bash_input()
else
    print(colorize("Current folder location: ", "cyan") .. colorize(file_content, "yellow"))
    execute()
end
