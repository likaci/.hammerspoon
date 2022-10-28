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
            print("right 0.75")
            windowFrame.w = screenFrame.w * 0.75
            windowFrame.x = screenFrame.x + screenFrame.w * 0.25
        end
    else
        if (windowFrame.x + windowFrame.w) < (screenFrame.x + screenFrame.w - 1) then
            print("right 0.75")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.25
            windowFrame.w = screenFrame.w * 0.75
        elseif windowFrame.w > screenFrame.w * 0.751 then
            print("right 0.75")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.25
            windowFrame.w = screenFrame.w * 0.75
        elseif windowFrame.w > screenFrame.w * 0.51 then
            print("right 0.5")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.5
            windowFrame.w = screenFrame.w * 0.5
        elseif windowFrame.w > screenFrame.w * 0.26 then
            print("right 0.25")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.75
            windowFrame.w = screenFrame.w * 0.25
        else
            print("right 0.75")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.25
            windowFrame.w = screenFrame.w * 0.75
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
            print("right 0.75")
            windowFrame.x = screenFrame.x + screenFrame.w * 0.25
            windowFrame.w = screenFrame.w * 0.75
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
        elseif windowFrame.w > screenFrame.w * 0.26 then
            print("left 0.25")
            windowFrame.w = screenFrame.w * 0.25
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
