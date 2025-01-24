local color = require("colorize")

local bash_input = {}

bash_input = function()
    print(color.colorize("Enter your Obsidian vault path ", "cyan"))

    os.execute("chmod +x ./interactive.sh")
    local handle = io.popen("./interactive.sh")
    local file_input = handle:read("*a")
    handle:close()

    file_input = file_input:gsub("%s+$", "")

    print("You entered: " .. file_input)
    return file_input
end

return bash_input