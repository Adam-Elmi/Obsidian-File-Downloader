local color = require("colorize")
local utils = require("utils")

function run_cmd()
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
     io.write("")
     local command = io.read()

     for _, v in pairs(commands) do
        if v.command == command then
         if type(v.action) == "function" then
            os.execute(v.action())
         else 
            os.execute(v.action)
         end
        else 
            if not utils.includes(commands, command) then
                print(color.colorize(("command: " .. command .. " is not a valid command"), "red"))
                break
            end
        end
     end
end

run_cmd()