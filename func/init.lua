-- ~/.hammerspoon/func/init.lua
-- 所有模块统一加载点

require("lib.util")
local logger = require("lib.logger").new("func")

local modules = {
    "smart_punct",
}

for _, m in ipairs(modules) do
    local ok, err = pcall(function()
        require("func." .. m)
    end)
    if not ok then
        logger.ef("加载模块[%s]失败:\n%s", m, err)
    else
        logger.f("加载模块[%s]成功", m)
    end
end
