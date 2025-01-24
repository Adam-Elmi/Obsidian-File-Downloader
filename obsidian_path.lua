local get_file_path = require("get_file_path")
local color = require("colorize")
colorize = color.colorize
user_input = get_file_path

local file = io.open("config.txt", "w")

if file then
    local path = user_input()
    print(colorize(("Current vault: " .. path), "yellow"))
    file:write(path)
end

file:close()