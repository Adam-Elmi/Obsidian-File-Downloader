local color = require("colorize")
local utils = require("utils")

function file_manager()
    local file = io.open("config.txt", "r")
    local path = file:read("*a")
    local commands = {
        {
            command = "target_folder -c",
            action = "ls " .. path
        },
        {
            command = "showPath",
            action = utils.showPath
        }
    }
     -- command input
     io.write("> ")
     local command = io.read()
     print(command)
     for _, v in pairs(commands) do
        if v.command == command then
         if type(v.action) == "function" then
            os.execute(v.action())
         else 
            os.execute(v.action)
         end
        else 
            if not utils.command_includes(commands, command) then
                print(color.colorize(("command: " .. command .. " is not a valid command"), "red"))
                break
            end
        end
     end
     file:close()
end

file_manager()