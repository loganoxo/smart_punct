-- 日志模块封装
local function newLogger(tag)
    local log = hs.logger.new(tag, "info")
    return log
end

return {
    new = newLogger
}
