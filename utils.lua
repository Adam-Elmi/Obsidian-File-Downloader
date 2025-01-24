local color = require("colorize")

local utils = {}

function showPath()
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
end

function target_folder()
    local file = io.open("config.txt", "r")
    if file then
        local path = file:read("*a")
        local commands = {
            {
                command = "target_folder -c",
                action = "ls " .. path
            }
        }
        -- command input
        io.write("")
        local command = io.read()

        for _, v in pairs(commands) do
           if v.command == command then
            os.execute(v.action)
           else 
            print(color.colorize(("command: " .. command .. " is not found"), "red"))
           end
        end
    end
end
target_folder()