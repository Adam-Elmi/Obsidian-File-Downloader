local color = require("colorize")

local utils = {}

function utils.showPath()
    local file = io.open("config.txt", "r")
    if file then
        local content = file:read("*a")
        file:close()
        if content ~= "" then
            print("Current path: " .. color.colorize(content, "green"))
        else
            print(color.colorize("Current path is empty. Please enter your vault path!", "red"))
        end
    else
        print(color.colorize("Failed to open the file!", "red"))
    end
    file:close()
end

function utils.includes(table, value)
    for _, v in pairs(table) do
        if v.command == value then
            return true
        end
    end
    return false
end

return utils

