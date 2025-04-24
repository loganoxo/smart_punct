-- ~/.hammerspoon/init.lua
-- 主入口

-- 加载 hs.ipc 模块,否则命令行工具将无法工作;
-- 用法: 命令行中执行  /opt/homebrew/bin/hs -c "LOGAN_ALERT('Received someAlert')"
require("hs.ipc")

-- 加载功能
require('func')
