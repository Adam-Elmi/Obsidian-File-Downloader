local color = require("colorize")

local utils = {}

function utils.showPath()
    local file = io.open("config.txt", "r")
    if file then
        local content = file:read("*a")
        file:close()
        if content ~= "" then
            print("Current vault path: " .. color.colorize(content, "green"))
        else
            print(color.colorize("Current path is empty. Please enter your vault path!", "red"))
        end
    else
        print(color.colorize("Failed to open the file!", "red"))
    end
end

function utils.command_includes(table, value)
    for _, v in pairs(table) do
        if v.command == value then
            return true
        end
    end
    return false
end

local function getFileExtension(filename)
    return filename:match("%.(%w+)$")
end

local function scanFolder()
    local f = io.open("config.txt", "r")
    if not f then
        print("Failed to open config.txt")
        return
    end

    local path = f:read("*l")
    f:close()

    if not path then
        print("No path found in config.txt")
        return
    end

    local handle = io.popen('ls "' .. path .. '"')
    if not handle then
        print("Failed to list folder contents")
        return
    end

    for file in handle:lines() do
        local fullPath = path .. "/" .. file
        print(fullPath)
    end

    handle:close()
end

scanFolder()

return utils