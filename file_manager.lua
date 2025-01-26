local color = require("colorize")
local utils = require("utils")

function file_manager()
    local file = io.open("config.txt", "r")
    local path = file:read("*a"):gsub("%s+", "")

    local repo = ""

    function download()
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
            action = utils.showPath
        },
        {
            command = "dw",
            action = download
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