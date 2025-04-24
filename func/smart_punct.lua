-- author: Logan
-- date: 2025-04-24
-- desc: 智能标点
-- 说明: 在中文输入法下，自动将中文标点替换为英文标点
-- 参考:
--      hs.eventtap 是监听键盘事件,而中文引号是输入法替换之后产生的文本,两者根本不是一回事
--      所以 getCharacters() 总是返回你按下的按键(英文引号),和你看到的不一样,是正常的
-- 使用:
-- 开启:    /opt/homebrew/bin/hs -c 'Smart_Punct_Start()'
-- 关闭:    /opt/homebrew/bin/hs -c 'Smart_Punct_Stop()'
-- 状态:    /opt/homebrew/bin/hs -c 'Smart_Punct_Status()'

-- 中文输入法 source id 列表
ChineseInputMethodIds = {
    ["com.apple.inputmethod.SCIM.ITABC"] = true,
    ["com.apple.inputmethod.Pinyin"] = true
}

-- 符号表
SmartPunctReplaceMap = {
    ["\""] = "\"",
    ["'"] = "'",
    [","] = ",",
    ["."] = ".",
    ["，"] = ",",
    ["。"] = ".",
    ["["] = "[",
    ["]"] = "]",
    ["「"] = "{",
    ["」"] = "}",
    ["【"] = "[",
    ["】"] = "]",
    [";"] = ";",
    [":"] = ":",
    ["；"] = ";",
    ["："] = ":",
    ["!"] = "!",
    ["?"] = "?",
    ["！"] = "!",
    ["？"] = "?",
    ["`"] = "`",
    ["·"] = "`",
    ["~"] = "~",
    ["～"] = "~",
    ["-"] = "-",
    ["("] = "(",
    [")"] = ")",
    ["（"] = "(",
    ["）"] = ")",
    ["……"] = "^",
    ["¥"] = "$",
    ["——"] = "_",
    ["｜"] = "|",

}

PunctKeyListener = nil
-- 忽略下一次 keyDown 的标志
IgnoreNextPunct = nil

-- /opt/homebrew/bin/hs -c 'Smart_Punct_Start()'
function Smart_Punct_Start()
    -- 创建一个按键事件监听器
    if not PunctKeyListener then
        PunctKeyListener = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
            local char = event:getCharacters()
            local repl = SmartPunctReplaceMap[char]
            local sourceId = hs.keycodes.currentSourceID()
            local flags = event:getFlags()
            -- print(string.format("char: %s, repl: %s, sourceId: %s, flags: [%s]",
            --     char, repl or "nil", sourceId or "nil", TableToStringOnlyKey(flags)))

            -- 判断是否按下了修饰键,排除shift
            local modifierPressed = flags["cmd"] or flags["alt"] or flags["ctrl"] or flags["fn"]

            -- 当前输入法是中文，并且有替换规则，且没有按修饰键
            if ChineseInputMethodIds[sourceId] and repl and not modifierPressed then
                if IgnoreNextPunct == char then
                    IgnoreNextPunct = nil
                    -- print("忽略这次事件,char:" .. char)
                    return false -- 不拦截，正常放行
                end

                -- 标记忽略下一次事件（模拟输入用）
                IgnoreNextPunct = repl
                hs.eventtap.keyStrokes(repl) -- 模拟英文符号输入
                --print("模拟输入,repl:", repl)
                return true                  -- 阻止原始输入
            end
            return false                     -- 放行
        end)
    end

    -- 启动监听器
    if not PunctKeyListener:isEnabled() then
        PunctKeyListener:start()
        LOGAN_ALERT("智能标点已开启")
    end
end

-- /opt/homebrew/bin/hs -c 'Smart_Punct_Stop()'
function Smart_Punct_Stop()
    if PunctKeyListener then
        PunctKeyListener:stop()
        PunctKeyListener = nil
        IgnoreNextPunct = nil
        LOGAN_ALERT("智能标点已关闭")
    end
end

-- /opt/homebrew/bin/hs -c 'Smart_Punct_Status()'
function Smart_Punct_Status()
    if PunctKeyListener and PunctKeyListener:isEnabled() then
        return 1
    else
        return 0
    end
end

-- 自启动
Smart_Punct_Start()
