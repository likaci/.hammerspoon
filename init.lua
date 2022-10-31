hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

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

function openWithFinder(path)
    hs.execute("open " .. path)
end

timeoutExit = 5

-- key to break out of every layer and back to normal
escapeKey = {keyNone, 'escape'}

-- max length of helper measured in character
recursiveBindHelperMaxLineLengthInChar = 80

-- format of helper, the helper is just a hs.alert
recursiveBindHelperFormat = {
    atScreenEdge = 2,
    strokeColor = {
        white = 0,
        alpha = 2
    },
    textFont = 'Courier'
}

-- whether to show helper
showBindHelper = true

-- used by next model to close previous helper
local previousHelperID = nil

-- generate a string representation of a key spec
-- {{'shift', 'command'}, 'a} -> 'shift+command+a'
local function createKeyName(key)
    -- key is in the form {{modifers}, key, (optional) name}
    -- create proper key name for helper
    if #key[1] == 1 and key[1][1] == 'shift' then
        -- shift + key map to Uppercase key
        -- shift + d --> D
        return keyboardUpper(key[2])
    else
        -- append each modifiers together
        local keyName = ''
        if #key[1] >= 1 then
            for count = 1, #key[1] do
                if count == 1 then
                    keyName = key[1][count]
                else
                    keyName = keyName .. ' + ' .. key[1][count]
                end
            end
        end
        -- finally append key, e.g. 'f', after modifers
        return keyName .. key[2]
    end
end

-- show helper of available keys of current layer
local function showHelper(keyFuncNameTable)
    -- keyFuncNameTable is a table that key is key name and value is description
    local helper = ''
    local separator = '' -- first loop doesn't need to add a separator, because it is in the very front. 
    local lastLine = ''
    for keyName, funcName in pairs(keyFuncNameTable) do
        -- only measure the length of current line
        lastLine = string.match(helper, '\n.-$')
        if lastLine and string.len(lastLine) > recursiveBindHelperMaxLineLengthInChar then
            separator = '\n'
        elseif not lastLine then
            separator = '\n'
        end
        helper = helper .. separator .. keyName .. ' → ' .. funcName
        separator = '   '
    end
    helper = string.match(helper, '[^\n].+$')
    -- bottom of screen, lasts for 3 sec, no border
    previousHelperID = hs.alert.show(helper, recursiveBindHelperFormat, nil, timeoutExit)
    --    previousHelperID = hs.alert.show(helper)
end

-- Spec of keymap:
-- Every key is of format {{modifers}, key, (optional) description}
-- The first two element is what you usually pass into a hs.hotkey.bind() function.
--
-- Each value of key can be in two form:
-- 1. A function. Then pressing the key invokes the function
-- 2. A table. Then pressing the key bring to another layer of keybindings.
--    And the table have the same format of top table: keys to keys, value to table or function

-- the actual binding function
function recursiveBind(keymap)
    if type(keymap) == 'function' then
        -- in this case "keymap" is actuall a function
        return keymap
    end
    local modal = hs.hotkey.modal.new()
    local keyFuncNameTable = {}
    for key, map in pairs(keymap) do
        local func = recursiveBind(map)
        -- key[1] is modifiers, i.e. {'shift'}, key[2] is key, i.e. 'f' 
        modal:bind(key[1], key[2], function()
            modal:exit()
            hs.alert.closeSpecific(previousHelperID)
            func()
        end)
        modal:bind(escapeKey[1], escapeKey[2], function()
            modal:exit()
            hs.alert.closeSpecific(previousHelperID)
        end)
        if #key >= 3 then
            keyFuncNameTable[createKeyName(key)] = key[3]
        end
    end
    return function()
        modal:enter()
        if showBindHelper then
            showHelper(keyFuncNameTable)
        end
        hs.timer.doAfter(timeoutExit, function()
            modal:exit()
        end)
    end
end

-- this function is used by helper to display 
-- appropriate 'shift + key' bindings
-- it turns a lower key to the corresponding
-- upper key on keyboard
function keyboardUpper(key)
    local upperTable = {
        a = 'A',
        b = 'B',
        c = 'C',
        d = 'D',
        e = 'E',
        f = 'F',
        g = 'G',
        h = 'H',
        i = 'I',
        j = 'J',
        k = 'K',
        l = 'L',
        m = 'M',
        n = 'N',
        o = 'O',
        p = 'P',
        q = 'Q',
        r = 'R',
        s = 'S',
        t = 'T',
        u = 'U',
        v = 'V',
        w = 'W',
        x = 'X',
        y = 'Y',
        z = 'Z',
        ['`'] = '~',
        ['1'] = '!',
        ['2'] = '@',
        ['3'] = '#',
        ['4'] = '$',
        ['5'] = '%',
        ['6'] = '^',
        ['7'] = '&',
        ['8'] = '*',
        ['9'] = '(',
        ['0'] = ')',
        ['-'] = '_',
        ['='] = '+',
        ['['] = '}',
        [']'] = '}',
        ['\\'] = '|',
        [';'] = ':',
        ['\''] = '"',
        [','] = '<',
        ['.'] = '>',
        ['/'] = '?'
    }
    uppperKey = upperTable[key]
    if uppperKey then
        return uppperKey
    else
        return key
    end
end

function singleKey(key, name)
    local mod = {}
    if key == keyboardUpper(key) then
        mod = {'shift'}
        key = string.lower(key)
    end

    if name then
        return {mod, key, name}
    else
        return {mod, key, 'no name'}
    end
end

-- Spec of keymap:
-- Every key is of format {{modifers}, key, (optional) description}
-- The first two element is what you usually pass into a hs.hotkey.bind() function.
--
-- Each value of key can be in two form:
-- 1. A function. Then pressing the key invokes the function
-- 2. A table. Then pressing the key bring to another layer of keybindings.
--    And the table have the same format of top table: keys to keys, value to table or function

mymapWithName = {
    [singleKey('`', 'run command')] = runCommand,
    [singleKey('f', 'find+')] = {
        [singleKey('d', 'Desktop')] = function()
            openWithFinder('~/Desktop')
        end,
        [singleKey('p', 'Project')] = function()
            openWithFinder('~/p')
        end,
        [singleKey('o', 'Download')] = function()
            openWithFinder('~/Downloads')
        end,
        [singleKey('a', 'Application')] = function()
            openWithFinder('~/Applications')
        end,
        [singleKey('h', 'home')] = function()
            openWithFinder('~')
        end,
        [singleKey('f', 'hello')] = function()
            hs.alert.show('hello!')
        end
    },
    [singleKey('t', 'toggle+')] = {
        [singleKey('v', 'file visible')] = function()
            hs.eventtap.keyStroke({'cmd', 'shift'}, '.')
        end
    },
    [singleKey('w', 'window control')] = {
        [singleKey('1', '1')] = {
            [singleKey('2', '1')] = function()
                window12()
            end
        },
        [singleKey('2', '1')] = {
            [singleKey('1', '1')] = function()
                window21()
            end
        }
    },
    [singleKey('h', '←')] = function()
        moveAndResize('left')
        moveWindowMode()
    end,
    [singleKey('j', '↓')] = function()
        moveAndResize('down')
        moveWindowMode()
    end,
    [singleKey('k', '↑')] = function()
        moveAndResize('up')
        moveWindowMode()
    end,
    [singleKey('l', '→')] = function()
        moveAndResize('right')
        moveWindowMode()
    end
}
hs.hotkey.bind("cmd-ctrl", 'space', nil, recursiveBind(mymapWithName))

hs.urlevent.bind("window12", function(eventName, params) window12() end)
hs.urlevent.bind("window21", function(eventName, params) window21() end)

hs.ipc.cliInstall()