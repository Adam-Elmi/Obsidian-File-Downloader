local color = require("colorize")

local checkmark = "✔"
local crossmark = "✖"

-- Check if config.txt exist or not
local file = io.open('config.txt', "r")
local path = file:read("*a"):gsub("%s+", "")

if file then
    print(color.colorize((checkmark .. " Test passed: config.txt file is exist."), "green"))
else 
    print(color.colorize((crossmark .. " Test failed: config.txt file is not exist."), "red"))
end