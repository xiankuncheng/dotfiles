--vim = hs.loadSpoon('VimMode')
--
---- Basic key binding to ctrl+;
---- You can choose any key binding you want here, see:
----   https://www.hammerspoon.org/docs/hs.hotkey.html#bind
--
--hs.hotkey.bind({'ctrl'}, ';', function()
  --vim:enter()
--end)

---
--  @author     Dongliang Ma <mdl2009@vip.qq.com>
--  @license    MIT

-- Enable Spotlight support to check alternate app names
hs.application.enableSpotlightForNameSearches(true)

-- 设置Grid 12x8(水平x竖直)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 12
hs.grid.GRIDHEIGHT = 8

-- 修饰键
local m_alt = {"alt"}
local m_shift_cmd = {"shift", "cmd"}
local m_shift_alt = {"shift", "alt"}
local m_ctrl_cmd = {"ctrl", "cmd"}

local m_switch_app = m_ctrl_cmd
local m_mod1 = m_shift_cmd
local m_mod2 = m_shift_alt

-- 应用列表映射
local APPNAMES = {
	IM = "Slack",
	Mail = "Mail",
	Doc = "Dash",
	Term = "iTerm2",
	TermApp = "iTerm",
  Emacs = "Emacs",
	FileManager = "Finder",
	Browser = "Google Chrome",
	Xcode = "Xcode",
	VSCode = "Visual Studio Code",
	TextEditor = "Emacs",
	AS = "Android Studio",
	WeChat = "WeChat",
	Discord = "Discord",
	Preview = "Preview",
	Music = "Music", -- "Spotify",
	RNDebuger = "React Native Debugger",
	Sagas = "Reactotron",
	Simulator = "Simulator",
	ChatGPT = "ChatGPT",
  Note = "Notion"
}

-- 显示器
local SCREENS = {
  HOME = {
    LEFT = 1,
    MIDDLE = 3,
    RIGHT = 2,
  },
  WORK = {
    LEFT = 1,
    MIDDLE = 3,
    RIGHT = 2,
  }
}

---
--  常用布局(Grid 12x8) {水平起始位置, 竖直起始位置, 宽度占比, 高度占
--  比}
local LAYOUTS = {
    fullscreen = {0, 0, 12, 8},
    center = {0.25, 0.25, 11.5, 7.5},
    center_h = {2, 0, 8, 8},
    center_s = {3.5, 2, 5, 4},
    left = {0, 0, 6, 8},
    right = {6, 0, 6, 8},
    left4 = {0, 0, 4, 8},
    left6 = {0, 0, 6, 8},
    left8 = {0, 0, 8, 8},
    right4 = {8, 0, 4, 8},
    right6 = {6, 0, 6, 8},
    right8 = {4, 0, 8, 8},
    left_top = {0, 0, 6, 4},
    left_bottom = {0, 4, 6, 4},
    right_top = {6, 0, 6, 4},
    right_bottom = {6, 4, 6, 4},
    top = {0, 0, 12, 4},
    bottom = {0, 4, 12, 4}
}

---
--  常用应用布局
local APP_LAYOUT = {
    [1] = {
        one_monitor = {
            [APPNAMES.Term] = {1, LAYOUTS.center_s},
            [APPNAMES.Browser] = {1, LAYOUTS.center_h},
            [APPNAMES.Mail] = {1, LAYOUTS.left},
            [APPNAMES.Doc] = {1, LAYOUTS.right},
            [APPNAMES.FileManager] = {1, LAYOUTS.center},
            [APPNAMES.WeChat] = {1, LAYOUTS.center_s},
            [APPNAMES.Preview] = {1, LAYOUTS.right},
        },
        one_small_monitor = {
            [APPNAMES.Term] = {1, LAYOUTS.center},
            [APPNAMES.Browser] = {1, LAYOUTS.fullscreen},
            [APPNAMES.Mail] = {1, LAYOUTS.fullscreen},
            [APPNAMES.Doc] = {1, LAYOUTS.fullscreen},
            [APPNAMES.FileManager] = {1, LAYOUTS.center},
            [APPNAMES.WeChat] = {1, LAYOUTS.center},
            [APPNAMES.Preview] = {1, LAYOUTS.fullscreen},
        },
        two_monitor = {
          -- 上显示器 Emacs
          [APPNAMES.TextEditor] = {SCREENS.HOME.LEFT, LAYOUTS.fullscreen},
          -- 下显示器 Chrome | Slack
          [APPNAMES.Browser] = {SCREENS.HOME.MIDDLE, LAYOUTS.left},
          [APPNAMES.IM] = {SCREENS.HOME.MIDDLE, LAYOUTS.right},
        },
        three_monitor_work = {
          -- 左显示器 iTerm2 | IM
          [APPNAMES.Term] = {SCREENS.WORK.LEFT, LAYOUTS.left},
          [APPNAMES.IM] = {SCREENS.WORK.LEFT, LAYOUTS.fullscreen},
          -- 中显示器 Emacs
          [APPNAMES.TextEditor] = {SCREENS.WORK.MIDDLE, LAYOUTS.fullscreen},
          -- 右显示器 Chrome
          [APPNAMES.Browser] = {SCREENS.WORK.RIGHT, LAYOUTS.fullscreen},
        },
        three_monitor_home = {
          -- 左显示器 iTerm2 | IM
          [APPNAMES.Term] = {SCREENS.WORK.LEFT, LAYOUTS.left},
          [APPNAMES.IM] = {SCREENS.WORK.LEFT, LAYOUTS.fullscreen},
          -- 中显示器 Emacs
          [APPNAMES.TextEditor] = {SCREENS.WORK.MIDDLE, LAYOUTS.fullscreen},
          -- 右显示器 Chrome
          [APPNAMES.Browser] = {SCREENS.WORK.RIGHT, LAYOUTS.fullscreen},
        }
    }
}

---
--  调整窗口大小以及位置(基于网格布局)
--  @int    x       水平起始位置
--  @int    y       竖直起始位置
--  @int    w       宽度占比
--  @int    h       高度占比
--  @table  cell
local set_windows_to_grid = function(cell)
    return function()
        local win = hs.window.focusedWindow()
        if win then
            hs.grid.set(win, {
                x=cell[1],
                y=cell[2],
                w=cell[3],
                h=cell[4]
            }, win:screen())
        else
            hs.alert.show("No focused window.")
        end
    end
end

---
--  移动窗口
local move_window = function(x, y)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        f.x = f.x + x
        f.y = f.y + y
        win:setFrame(f)
    end
end

---
--  数组长度可变的cycle
function mutable_cycle()
    local i = 1
    return function(arr)
        local x = arr[i % (#arr + 1)]
        i = i % #arr + 1
        return x
    end
end

---
--  打开/切换到App
local launch_or_focus_window = function(name)
    local mutable_cycle_func = mutable_cycle()
    return function()
        local app = hs.appfinder.appFromName(name)
        if not app then
            hs.application.launchOrFocus(name)
            return
        end

        if #app:allWindows() == 1 then
            hs.application.launchOrFocus(name)
            return
        end

        local window_list = hs.fnutils.filter(app:allWindows(), function(item)
            return item:role() == "AXWindow" end)

        if #window_list == 0 then
            hs.application.launchOrFocus(name)
            return
        end

        -- 修复Preview窗口被隐藏后取不到ID的BUG!!!
        local allWinHasId = true
        for i,v in ipairs(window_list) do
            if v:id() == nil then 
                allWinHasId = false
                break
            end
        end
        -- End

        if allWinHasId then
            table.sort(window_list, function(x, y) return x:id() < y:id() end)
        end

        win = mutable_cycle_func(window_list)
        if win then
            win:focus()
        end
    end
end

---
--  移动窗口到指定屏幕&调整大小
function move_and_resize(win, layout_meta)
    local pos = layout_meta[2]
    local screens = hs.screen.allScreens()
    local cell = {
        x=pos[1],
        y=pos[2],
        w=pos[3],
        h=pos[4]
    }

    hs.grid.set(win, cell, screens[layout_meta[1]])
end

---
--  切换布局
function change_layout(layout)
    return function()
        local screens = hs.screen.allScreens()

        local layout_meta = nil

        local screen_count = #screens

        if screen_count == 1 then
            if screens[1]:id() == 2077751741 then
                layout_meta = layout.one_small_monitor
            else
                layout_meta = layout.one_monitor
            end
        elseif screen_count == 2 then
            layout_meta = layout.two_monitor
        elseif screen_count == 3 then
          layout_meta = layout.three_monitor_home
          for i,v in ipairs(screens) do
            if v:getUUID() == "000010AC-0000-D065-3035-564C00000000" or v:name() == 'DELL U2715H' then
              print("Detected work environment.")
              layout_meta = layout.three_monitor_work
              break
            elseif v:name() == "DELL U2718Q" then
              print("Detected home environment.")
              layout_meta = layout.three_monitor_home
            else
              layout_meta = layout.three_monitor_home
            end
          end
        else
            return
        end

        for name, place in pairs(layout_meta) do
            local app = hs.appfinder.appFromName(name)

            if not app then
                hs.application.launchOrFocus(name)
            end

            if app then
                for i, win in ipairs(app:allWindows()) do
                    move_and_resize(win, layout_meta[name])
                end
            end
        end
    end
end

--
--  修改窗口大小
local resize_window = function(w, h)
    return function()
        local win = hs.window.focusedWindow()
        if win then
            local size = win:size()
            size.w = size.w + w
            size.h = size.h + h
            win:setSize(size)
        else
            hs.alert.show("No focused window.")
        end
    end
end

-----------------------------------------------------------------------------
-- 快捷键
-----------------------------------------------------------------------------

---
--  常用的窗口布局
-- hs.fnutils.each({
--     {key = "`", layout = LAYOUTS.fullscreen},
--     {key = "1", layout = LAYOUTS.left},
--     {key = "2", layout = LAYOUTS.right},
--     {key = "3", layout = LAYOUTS.left_top},
--     {key = "4", layout = LAYOUTS.left_bottom},
--     {key = "5", layout = LAYOUTS.right_top},
--     {key = "6", layout = LAYOUTS.right_bottom},
--     {key = "0", layout = LAYOUTS.center},
--     {key = "8", layout = LAYOUTS.top},
--     {key = "9", layout = LAYOUTS.bottom},
-- }, function(meta)
--     hs.hotkey.bind(m_mod1, meta.key, set_windows_to_grid(meta.layout))
-- end)

---
--  移动窗口
--  y   k   u
--  h       l
--  b   j   n
-- hs.fnutils.each({
--     {key = "h", w = -20, h = 0},
--     {key = "j", w = 0, h = 20},
--     {key = "k", w = 0, h = -20},
--     {key = "l", w = 20, h = 0},
-- }, function(meta)
--     hs.hotkey.bind(m_mod1, meta.key, move_window(meta.w, meta.h),
--         nil, move_window(meta.w, meta.h))
-- end)

---
--  移动到屏幕
-- hs.hotkey.bind(m_mod2, "n", hs.grid.pushWindowNextScreen)
-- hs.hotkey.bind(m_mod2, "p", hs.grid.pushWindowPrevScreen)

---
--  修改窗口大小
-- hs.fnutils.each({
--     {key = "h", w = -20, h = 0},
--     {key = "j", w = 0, h = 20},
--     {key = "k", w = 0, h = -20},
--     {key = "l", w = 20, h = 0},
-- }, function(meta)
--     hs.hotkey.bind(m_mod2, meta.key, resize_window(meta.w, meta.h),
--         nil, resize_window(meta.w, meta.h))
-- end)


---
--  平铺并选择App
-- hs.hotkey.bind(m_mod2, "e", hs.hints.windowHints)

---
--  切换布局
hs.hotkey.bind(m_mod2, "1", change_layout(APP_LAYOUT[1]))

---
--  加载/切换到指定App
hs.fnutils.each({
    {key = "v", app = APPNAMES.VSCode},
    {key = "s", app = APPNAMES.IM},
    {key = "d", app = APPNAMES.Discord},
    {key = "c", app = APPNAMES.Browser},
    {key = "t", app = APPNAMES.TermApp},
    {key = "e", app = APPNAMES.Emacs},
    {key = "g", app = APPNAMES.ChatGPT},
    {key = "u", app = APPNAMES.Doc},
    {key = "y", app = APPNAMES.Music},
}, function(meta)
    hs.hotkey.bind(m_switch_app, meta.key, launch_or_focus_window(meta.app))
end)


-- Set hyper to ctrl + alt + cmd + shift
local hyper      = {'ctrl', 'cmd', 'alt'}

-- Move Mouse to center of next Monitor
-- hs.hotkey.bind(hyper, '1', function()
--     local screen = hs.mouse.getCurrentScreen()
--     local nextScreen = screen:next()
--     local rect = nextScreen:fullFrame()
--     local center = hs.geometry.rectMidPoint(rect)

--     hs.mouse.setAbsolutePosition(center)
-- end)

---
--  重新加载配置文件
hs.hotkey.bind(hyper, "r", function()
                 hs.reload()
                 hs.alert.show("Config loaded")
end)
