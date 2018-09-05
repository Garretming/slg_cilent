---这个模块用于代码调试
local CURRENT_MODULE_NAME = ...
local clark_luaide_Name = string.sub(CURRENT_MODULE_NAME, 1, -6)

--自定义debug
require(clark_luaide_Name .. ".debug")


local luaide = {}

if DEBUG > 1 then
    -- local breakSocketHandle, debugXpCall = require("LuaDebugjit")("192.168.1.102", 7003)
    local breakSocketHandle, debugXpCall = require(clark_luaide_Name ..".LuaDebugjit")("localhost", 7003)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakSocketHandle, 0.3, false)
end


--重写输出打印样式
__G__TRACKBACK__ = function(msg)
    print("----------------errror start------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    local msg = debug.traceback("", 3)
    print(msg)
    print("-----------------error end-----------------------")
    debugXpCall()
    return msg
end













return luaide

