local function traverse_(node, prefix, seperator, step)
    print((prefix or "") .. (step and ("[" .. step .. "] ") or "") .. (node.name or '""'))
    if node.getChildren then
        for i, child in ipairs(node:getChildren()) do
            traverse_(child, prefix .. seperator, seperator, step and step + 1)
        end
    end
end

function dumpChildren(node)
    if DEBUG < 1 then
        return
    end
    traverse_(node or {}, "--", "--", 1)
end

function dlogPBC(value, desciption, nesting)
    if DEBUG > 0 then
        if type(value) == "table" then
            protobuf.extract(value)
        end
        dlog(value, desciption, nesting, 3)
    end
end

--[[--

输出值的内容

### 用法示例

~~~ lua

local t = {comp = "chukong", engine = "quick"}

dlog(t)

~~~

@param mixed value 要输出的值

@param [string desciption] 输出内容前的文字描述

@parma [integer nesting] 输出时的嵌套层级，默认为 3

]]
function dlog(value, desciption, nesting, level)
 
    level = level or 2
    if type(nesting) ~= "number" then
        nesting = 3
    end

    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = string.format('"%s"', v)
        end
        return tostring(v)
    end
    local function _k(k)
        if type(k) ~= "string" then
            k = string.format("[%s]", k)
        end
        return k
    end

    local traceback = string.split(debug.traceback("", level), "\n")
    -- print("log from: " .. string.trim(traceback[3]))
    print("------------------dlog start--------------")
    print(string.format("[%s]> %s", os.date("%y%m%d %H:%M:%S", os.time()), string.trim(traceback[3])))

    local function _dump(value, desciption, indent, nest, keylen, sep)
        sep = sep or ""
        desciption = desciption or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(_k(desciption)))
        end
        if type(value) ~= "table" then
            result[#result + 1] = string.format("%s%s%s = %s%s", indent, _k(desciption), spc, _v(value), sep)
        elseif lookupTable[value] then
            result[#result + 1] = string.format("%s%s%s = *REF*", indent, desciption, spc)
        else
            lookupTable[value] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, desciption)
            else
                result[#result + 1] = string.format("%s%s = {", indent, _k(desciption))
                local indent2 = indent .. "    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = _v(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then
                        keylen = vkl
                    end
                    values[k] = v
                end
                table.sort(
                    keys,
                    function(a, b)
                        if type(a) == "number" and type(b) == "number" then
                            return a < b
                        else
                            return tostring(a) < tostring(b)
                        end
                    end
                )
                for i, k in ipairs(keys) do
                    _dump(values[k], k, indent2, nest + 1, keylen, ",")
                end
                result[#result + 1] = string.format("%s}%s", indent, sep)
            end
        end
    end
    _dump(value, desciption, "- ", 1)

    for i, line in ipairs(result) do
        print(line)
    end
    print("------------------dlog end--------------")

end
local dtoast = nil
local function removeDtoast()
    local _dtoast = dtoast
    dtoast = nil
    if _dtoast and _dtoast:getParent() then
        _dtoast:removeFromParent()
    end
end
local function dtoastShowText(text)
    removeDtoast()

    local k = require("app.Constant")
    local Toast = import(".Toast", k.pkg.view)

    dtoast = Toast.new()
    local label = dtoast.label
    if label then
        label:setTouchEnabled(true)
        label:addNodeEventListener(
            cc.NODE_TOUCH_EVENT,
            function(event)
                if event.name == "ended" then
                    removeDtoast()
                end
                return true
            end
        )
    end
    dtoast:setText(text):addTo(display.getRunningScene(), k.zorder.toast)
end
function derror(value, desciption, nesting, level)
    if DEBUG < 1 then
        return
    end
    local desc = string.format("❌%s", desciption or "<var>")
    dlog(value, desc, nesting, (level or 2) + 1)
    if DEBUG > 1 then
        dtoastShowText(desc)
    end
end

function dtrace(fromLevel, toLevel)
    if DEBUG < 1 then
        return
    end
    fromLevel = fromLevel or 1
    toLevel = toLevel or fromLevel
    local tracebacks = string.split(debug.traceback("", fromLevel), "\n")
    for i = 1, toLevel - fromLevel + 1 do
        print(">>>", tracebacks[i + 2])
    end
end



-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
-- function __G__TRACKBACK__(msg)
--     cclog("----------------------------------------")
--     cclog("LUA ERROR: " .. tostring(msg) .. "\n")
--     cclog(debug.traceback())
--     cclog("----------------------------------------")
--     return msg
-- end


function print_lua_table(lua_table, indent)
    if lua_table == nil or type(lua_table) ~= "table" then
        return
    end

    local function print_func(str)
        print("[Clark-->>] " .. tostring(str))
    end
    indent = indent or 0
    for k, v in pairs(lua_table) do
        if type(k) == "string" then
            k = string.format("%q", k)
        end
        local szSuffix = ""
        if type(v) == "table" then
            szSuffix = "{"
        end
        local szPrefix = string.rep("    ", indent)
        formatting = szPrefix .. "[" .. k .. "]" .. " = " .. szSuffix
        if type(v) == "table" then
            print_func(formatting)
            print_lua_table(v, indent + 1)
            print_func(szPrefix .. "},")
        else
            local szValue = ""
            if type(v) == "string" then
                szValue = string.format("%q", v)
            else
                szValue = tostring(v)
            end
            print_func(formatting .. szValue .. ",")
        end
    end
end
