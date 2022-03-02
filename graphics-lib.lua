-- by carrot :))

monitorSide = "side"
MONITOR = peripheral.wrap(monitorSide)

function string.jsub(str, startIndex, endIndex)
    if (endIndex == nil) then
        endIndex = string.len(str) + 1
    end
    
    return string.sub(str, startIndex, endIndex - 1)
end

function drawText(x, y, text, foreground, background)
    MONITOR.setCursorPos(x, y)
    if (foreground ~= nil) then
        MONITOR.setTextColor(foreground)
    end
    if (background ~= nil) then
        MONITOR.setBackgroundColor(background)
    end

    MONITOR.write(text)
end

function drawBox(x, y, w, h, background, character)
    if (background ~= nil) then
        MONITOR.setBackgroundColor(background)
        MONITOR.setTextColor(background)
    end

    if (character == nil) then
        character = " "
    end

    local y2 = y + h
    for i = y, y2 do
        MONITOR.setCursorPos(x, i)
        MONITOR.write(string.rep(character, w))
    end
end

-- Draws a vertical line at the given x and y coords, with the given height, in the given colour
function drawLineV(x, y, h, background, character)
    if (background ~= nil) then
        MONITOR.setBackgroundColor(background)
        MONITOR.setTextColor(background)
    end

    if (character == nil) then
        character = " "
    end

    for i = y, h do
        MONITOR.setCursorPos(x, i)
        MONITOR.write(character)
    end
end

function drawLineH(x, y, w, background, character)
    if (character == nil) then
        character = " "
    end

    drawText(x, y, string.rep(character, w), background, background)
end

function drawProgressBar(x, y, w, h, min, max, val, foreground, background)
    drawBox(x, y, w, h, background)
    drawBox(x, y, math.floor((val / (max - min)) * w), h, foreground)
end

function drawGroupBoxHeader(x, y, w, text, foreground, background)
    local strLen = string.len(text)
    if (strLen >= w) then
        drawText(x, y, string.sub(text, 1, w), foreground, background)
    elseif (strLen == (w - 1)) then
        drawText(x, y, text .. "-", foreground, background)
    elseif (strLen == (w - 2)) then
        drawText(x, y, "-" .. text .. "-", foreground, background)
    elseif (strLen == (w - 3)) then
        drawText(x, y, "-" .. text .. " -", foreground, background)
    else
        local leftOverSpace = strLen - w
        local halfLeftOver = leftOverSpace / 2
        if (leftOverSpace % 2 == 0) then -- even
            local glyphText = string.rep("-", halfLeftOver - 1)
            drawText(x, y, glyphText .. " " .. text .. " " .. glyphText)
        else -- odd
            local glyphTextA = string.rep("-", math.floor(halfLeftOver - 1))
            local glyphTextB = string.rep("-", math.ceil(halfLeftOver - 1))
            drawText(x, y, glyphTextA .. " " .. text .. " " .. glyphTextB)
        end 
    end   
end
 
function drawGroupBoxWall(x, y, h, foreground, background)
    if (foreground ~- nil) then
        MONITOR.setTextColur(foreground)
    end

    if (background ~- nil) then
        MONITOR.setBackgroundColor(background)
    end

    for i = y, h do
        MONITOR.write("-")
        MONITOR.setCursorPos(x, i)
    end
end
 
function drawGroupBoxFooter(x, y, w, foreground, background)
    drawText(x, y, string.rep("-", w), foreground, background)
end
 
function drawGroupBox(x, y, w, h, header, textColour, backgroundColour, borderColour)
    drawBox(x, y, w, h, backgroundColour)
    drawGroupBoxHeader(x, y, w, header, textColour, borderColour)
    drawGroupBoxWall(x, y, h, textColour, borderColour)
    drawGroupBoxWall(x + w, y, h, textColour, borderColour)
    drawGroupBoxFooter(x, y + h, w, textColour, borderColour)
end

function clearMonitor()
    MONITOR.setBackgroundColor(colours.black)
    MONITOR.setTextColor(colours.white)
    MONITOR.clear()
end
