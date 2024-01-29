-- auto reload
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- disable animation
hs.window.animationDuration = 0

local EPSILON = 2

function setWindowFrame(window, xFactor, widthFactor)
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()
    windowFrame.x = screenFrame.x + screenFrame.w * xFactor
    windowFrame.y = screenFrame.y
    windowFrame.w = screenFrame.w * widthFactor
    windowFrame.h = screenFrame.h
    window:setFrame(windowFrame)
end

-- Check if two floats are nearly equal
function nearlyEqual(a, b)
    return math.abs(a - b) < EPSILON
end

-- Get focused window and its frame and screen frame
function getFocusedWindowInfo()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()
    return window, windowFrame, screenFrame
end

-- R2/3 or R1/3
hs.hotkey.bind({"cmd", "ctrl"}, "L", function()
    local window, windowFrame, screenFrame = getFocusedWindowInfo()
    if nearlyEqual((windowFrame.x + windowFrame.w), (screenFrame.x + screenFrame.w)) then
        if nearlyEqual(windowFrame.w, screenFrame.w * 0.66) then
            print("L, R2/3 -> R1/2")
            setWindowFrame(window, 0.5, 0.5)
        elseif nearlyEqual(windowFrame.w, screenFrame.w * 0.5) then
            print("L, R1/2 -> R1/3")
            setWindowFrame(window, 0.66, 0.34)
        else
            print("L, -> R2/3")
            setWindowFrame(window, 0.34, 0.66)
        end
    else
        print("L, -> R2/3")
        setWindowFrame(window, 0.34, 0.66)
    end
end)

-- L2/3 or L1/3
hs.hotkey.bind({"cmd", "ctrl"}, "H", function()
    local window, windowFrame, screenFrame = getFocusedWindowInfo()
    if nearlyEqual(windowFrame.x, screenFrame.x) then
        if nearlyEqual(windowFrame.w, screenFrame.w * 0.66) then
            print("R, L2/3 -> L1/3")
            setWindowFrame(window, 0, 0.5)
        elseif nearlyEqual(windowFrame.w, screenFrame.w * 0.5) then
            print("R, L1/2 -> L1/3")
            setWindowFrame(window, 0, 0.34)
        else
            print("R, -> L2/3")
            setWindowFrame(window, 0, 0.66)
        end
    else
        print("R, -> L2/3")
        setWindowFrame(window, 0, 0.66)
    end
end)

-- full screen
hs.hotkey.bind({"cmd", "ctrl"}, "K", function()
    local window = hs.window.focusedWindow()
    setWindowFrame(window, 0, 1)
end)

-- move to next screen
hs.hotkey.bind({"cmd", "ctrl"}, "J", function()
    local window = hs.window.focusedWindow()
    window:moveToScreen(window:screen():next())
end)

-- move chrome tab to new window
hs.hotkey.bind({"cmd", "ctrl"}, 'N', function()
    local chrome = hs.appfinder.appFromName("Google Chrome")
    chrome:selectMenuItem({"Tab", "Move Tab to New Window"})
end)

-- dump
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

-- remap
local function keyStrokeFun(mods, key)
    return function()
        hs.eventtap.keyStroke(mods, key, 1000)
    end
end
local function remap(mods, key, pressFn)
    hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

-- vi navigation
remap({'alt'}, 'H', keyStrokeFun({}, 'left'))
remap({'alt'}, 'J', keyStrokeFun({}, 'down'))
remap({'alt'}, 'K', keyStrokeFun({}, 'up'))
remap({'alt'}, 'L', keyStrokeFun({}, 'right'))

-- keep Mail alive for AltServer
local mapCmdQ2CmdW = hs.hotkey.new({'cmd'}, 'Q', function()
    hs.eventtap.keyStroke({"cmd"}, "W")
end)
function applicationWatcher(appName, eventType, appObject)
    if (appName == "Mail" or appName == "邮件") then
        if (eventType == hs.application.watcher.activated) then
            mapCmdQ2CmdW:enable()
        elseif (eventType == hs.application.watcher.deactivated) then
            mapCmdQ2CmdW:disable()
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
