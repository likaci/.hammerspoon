-- auto reload
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
-- cli
hs.ipc.cliInstall()
-- disable animation
hs.window.animationDuration = 0

-- right three quater / half / quater or expand to right
hs.hotkey.bind({"cmd", "ctrl"}, "L", function()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()

    if windowFrame.x == screenFrame.x then
        -- from the left, try to extend to the right
        if windowFrame.w < screenFrame.w * 0.49 then
            print("left 0.5")
            windowFrame.w = screenFrame.w * 0.5
        else
            print("right 0.66")
            windowFrame.w = screenFrame.w * 0.66
            windowFrame.x = screenFrame.x + screenFrame.w * 0.34
        end
    else
        if (windowFrame.x + windowFrame.w) < (screenFrame.x + screenFrame.w - 1) then
            print("right 0.66")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.34
            windowFrame.w = screenFrame.w * 0.66
        elseif windowFrame.w > screenFrame.w * 0.67 then
            print("right 0.66")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.34
            windowFrame.w = screenFrame.w * 0.66
        elseif windowFrame.w > screenFrame.w * 0.51 then
            print("right 0.5")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.5
            windowFrame.w = screenFrame.w * 0.5
        elseif windowFrame.w > screenFrame.w * 0.35 then
            print("right 0.34")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.66
            windowFrame.w = screenFrame.w * 0.34
        else
            print("right 0.66")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.34
            windowFrame.w = screenFrame.w * 0.66
        end
    end
    windowFrame.y = screenFrame.y
    windowFrame.h = screenFrame.h
    window:setFrame(windowFrame)
end)

-- left half or quater or expant to left
hs.hotkey.bind({"cmd", "ctrl"}, "H", function()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()

    if (windowFrame.x + windowFrame.w) >= (screenFrame.x + screenFrame.w - 1) then
        if windowFrame.w < screenFrame.w * 0.26 then
            print("right 0.5")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.5
            windowFrame.w = screenFrame.w * 0.5
        elseif windowFrame.w < screenFrame.w * 0.51 then
            print("right 0.66")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.34
            windowFrame.w = screenFrame.w * 0.66
        else
            print("left 0.5")
            windowFrame.x = screenFrame.x
            windowFrame.w = screenFrame.w * 0.5
        end
    else
        windowFrame.x = screenFrame.x
        if windowFrame.w > screenFrame.w * 0.5 then
            print("left 0.5")
            windowFrame.w = screenFrame.w * 0.5
        elseif windowFrame.w > screenFrame.w * 0.35 then
            print("left 0.34")
            windowFrame.w = screenFrame.w * 0.34
        else
            print("left 0.5")
            windowFrame.w = screenFrame.w * 0.5
        end
    end

    windowFrame.y = screenFrame.y
    windowFrame.h = screenFrame.h
    window:setFrame(windowFrame)

end)

-- full screen or top/bottom half
hs.hotkey.bind({"cmd", "ctrl"}, "K", function()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()

    if windowFrame.w == screenFrame.w and windowFrame.h == screenFrame.h then
        -- full screen to top half
        windowFrame.h = screenFrame.h * 0.5
    elseif windowFrame.x == screenFrame.x and windowFrame.y == screenFrame.y and
        (math.abs(windowFrame.h - screenFrame.h * 0.5) <= 1) then
        -- top half to bottom half
        windowFrame.y = screenFrame.y + screenFrame.h * 0.5
    else
        -- to full screen
        windowFrame.w = screenFrame.w
        windowFrame.h = screenFrame.h
        windowFrame.x = screenFrame.x
        windowFrame.y = screenFrame.y
    end
    window:setFrame(windowFrame)

end)

-- move to next screen
hs.hotkey.bind({"cmd", "ctrl"}, "J", function()
    local window = hs.window.focusedWindow()
    window:moveToScreen(window:screen():next())
end)

function window12()
    local window = hs.window.focusedWindow()
    print(window)
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()

    windowFrame.x = screenFrame.x + screenFrame.w * 0.34
    windowFrame.y = screenFrame.y
    windowFrame.w = screenFrame.w * 0.66
    windowFrame.h = screenFrame.h
    window:setFrame(windowFrame)

    local preWindow = hs.window.orderedWindows()[2]
    local preWindowFrame = preWindow:frame()
    print(preWindow)
    preWindowFrame.x = screenFrame.x
    preWindowFrame.y = screenFrame.y
    preWindowFrame.w = screenFrame.w * 0.34
    preWindowFrame.h = screenFrame.h
    preWindow:setFrame(preWindowFrame)
end

function window21()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local screenFrame = window:screen():frame()

    windowFrame.x = screenFrame.x
    windowFrame.y = screenFrame.y
    windowFrame.w = screenFrame.w * 0.34
    windowFrame.h = screenFrame.h
    window:setFrame(windowFrame)

    local preWindow = hs.window.orderedWindows()[2]
    local preWindowFrame = preWindow:frame()

    preWindowFrame.x = screenFrame.x + screenFrame.w * 0.34
    preWindowFrame.y = screenFrame.y
    preWindowFrame.w = screenFrame.w * 0.66
    prewWindowFrame.h = screenFrame.h
    preWindow:setFrame(preWindowFrame)

end

hs.hotkey.bind({"alt"}, "H", function()
    hs.eventtap.keyStroke({}, 'left')
end)
hs.hotkey.bind("alt", "J", function()
    hs.eventtap.keyStroke({}, 'down')
end)
hs.hotkey.bind("alt", "K", function()
    hs.eventtap.keyStroke({}, 'up')
end)
hs.hotkey.bind("alt", "L", function()
    hs.eventtap.keyStroke({}, 'right')
end)

hs.hotkey.bind("cmd", "Q", function()
    print("cmd q")
    if hs.application.frontmostApplication():bundleID() == "com.apple.mail" then
        print("cmd w")
        hs.eventtap.keyStroke({"cmd"}, 'W')
    else
        print("cmd q2")
        hs.eventtap.keyStroke({"cmd"}, 'Q')
    end
end)