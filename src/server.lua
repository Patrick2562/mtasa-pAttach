--[[             _    _                _
           /\   | |  | |              | |
  _ __    /  \  | |_ | |_  __ _   ___ | |__
 | '_ \  / /\ \ | __|| __|/ _` | / __|| '_ \
 | |_) |/ ____ \| |_ | |_| (_| || (__ | | | |
 | .__//_/    \_\\__| \__|\__,_| \___||_| |_|
 | |
 |_|

 -- https://github.com/Patrick2562/mtasa-pAttach
 -- https://mtasa.com/discord
]]

local CACHE = {}

addEventHandler("onPlayerResourceStart", root, function(res)
    if res ~= resource then
        return
    end
    
    triggerClientEvent(source, "pAttach:receiveCache", resourceRoot, CACHE, OPTIONS)
end)

function attach(element, ped, boneid, ox, oy, oz, rx, ry, rz)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    CACHE[element] = {
        element,
        ped,
        boneid,
        ox or 0,
        oy or 0,
        oz or 0,
        rx or 0,
        ry or 0,
        rz or 0
    }

    return triggerClientEvent(root, "pAttach:attach", resourceRoot, element, ped, boneid, ox, oy, oz, rx, ry, rz)
end

function detach(element)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    CACHE[element] = nil

    return triggerClientEvent(root, "pAttach:detach", resourceRoot, element)
end

function detachAll(ped)
    assert(isElement(ped), "Expected element at argument 1, got "..type(ped))

    for element, data in pairs(CACHE) do
        if data[2] == ped then
            CACHE[element] = nil
        end
    end

    return triggerClientEvent(root, "pAttach:detachAll", resourceRoot, ped)
end

function setPositionOffset(element, x, y, z)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    CACHE[element][4] = x or 0
    CACHE[element][5] = y or 0
    CACHE[element][6] = z or 0

    return triggerClientEvent(root, "pAttach:setPositionOffset", resourceRoot, element, x, y, z)
end

function setRotationOffset(element, x, y, z)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    CACHE[element][7] = x or 0
    CACHE[element][8] = y or 0
    CACHE[element][9] = z or 0

    return triggerClientEvent(root, "pAttach:setRotationOffset", resourceRoot, element, x, y, z)
end

function setPed(element, ped)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))
    assert(isElement(ped), "Expected element at argument 2, got "..type(ped))

    CACHE[element][2] = ped

    return triggerClientEvent(root, "pAttach:setPed", resourceRoot, element, ped)
end

function setBone(element, boneid)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    CACHE[element][3] = boneid

    return triggerClientEvent(root, "pAttach:setBone", resourceRoot, element, boneid)
end

function setVisible(element, bool)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    return setElementAlpha(element, bool and 255 or 0)
end

function setVisibleAll(ped, bool)
    assert(isElement(ped), "Expected element at argument 1, got "..type(ped))

    for element, data in pairs(CACHE) do
        if data[2] == ped then
            setVisible(element, bool)
        end
    end

    return true
end

function isAttached(element)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    return CACHE[element] and true or false
end

function setDetails(element, ped, boneid, ox, oy, oz, rx, ry, rz)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))
    
    local details = getDetails(element)

    CACHE[element] = {
        element,
        ped or details[2],
        boneid or details[3],
        ox or details[4],
        oy or details[5],
        oz or details[6],
        rx or details[7],
        ry or details[8],
        rz or details[9]
    }

    return triggerClientEvent(root, "pAttach:setDetails", resourceRoot, element, ped, boneid, ox, oy, oz, rx, ry, rz)
end

function getDetails(element)
    assert(isElement(element), "Expected element at argument 1, got "..type(element))

    return CACHE[element] or false
end

function getAttacheds(ped)
    assert(isElement(ped), "Expected element at argument 1, got "..type(element))

    local list = {}
    
    for element, data in pairs(CACHE) do
        if data[2] == ped then
            list[#list + 1] = element
        end
    end

    return list
end

function setConfigOption(name, value)
    assert(OPTIONS[name] ~= nil, "Expected valid option at argument 1, got "..tostring(name))
    assert(type(value) == "boolean", "Expected boolean at argument 2, got "..type(value))

    OPTIONS[name] = value

    return triggerClientEvent(root, "pAttach:setConfigOption", resourceRoot, name, value)
end

addEventHandler("onPlayerQuit", root, function()
    detachAll(source)
end)

addEventHandler("onElementDestroy", root, function()
    if CACHE[source] then
        detach(source)

    elseif getElementType(source) == "ped" then
        for element, data in pairs(CACHE) do
            if data[2] == source then
                CACHE[element] = nil
            end
        end
    end
end)
