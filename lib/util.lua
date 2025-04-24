-- 通用气泡通知
function LOGAN_ALERT(msg, duration)
    duration = duration or 5 -- 默认 5 秒
    hs.alert.show(msg, hs.alert.defaultStyle, hs.screen.mainScreen(), duration)
end

-- 把table的key拼接成字符串,空格分隔
function TableToStringOnlyKey(table_temp)
    -- 格式化 flags 输出
    local keyStr = ""
    local count = 1
    if not table_temp then
        return keyStr
    end
    for k, v in pairs(table_temp) do
        if v then
            if count > 1 then
                keyStr = keyStr .. " "
            end
            keyStr = keyStr .. k
            count = count + 1
        end
    end
    return keyStr
end
