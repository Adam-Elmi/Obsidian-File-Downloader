#!/usr/bin/env lua

local color = {}

function color.colorize(text, color)
    local colors = {
        reset = "\27[0m",
        red = "\27[31m",
        green = "\27[32m",
        yellow = "\27[33m",
        blue = "\27[34m",
        magenta = "\27[35m",
        cyan = "\27[36m",
        white = "\27[37m",
    }

    return (colors[color] or colors.reset) .. text .. colors.reset
end

return color
