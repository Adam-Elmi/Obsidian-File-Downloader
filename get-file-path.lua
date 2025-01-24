local color = require("colorize")

local bash_input = {}

bash_input = function()
    print(color.colorize("Enter your Obsidian vault path ", "cyan"))

    os.execute("chmod +x ./interactive.sh")
    local handle = io.popen("./interactive.sh")
    local file_input = handle:read("*a")
    handle:close()

    file_input = file_input:gsub("%s+$", "")

    print(colorize(("Successful added path: " .. file_input), "green"))
    return file_input
end

return bash_input