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

local isClientSide = isElement(localPlayer)

if isClientSide then
    function attach(...)
        return pAttach:attach(...)
    end
    addEvent("pAttach:attach", true)
    addEventHandler("pAttach:attach", resourceRoot, attach)

    function detach(...)
        return pAttach:detach(...)
    end
    addEvent("pAttach:detach", true)
    addEventHandler("pAttach:detach", resourceRoot, detach)

    function detachAll(...)
        return pAttach:detachAll(...)
    end
    addEvent("pAttach:detachAll", true)
    addEventHandler("pAttach:detachAll", resourceRoot, detachAll)

    function setPositionOffset(...)
        return pAttach:setPositionOffset(...)
    end
    addEvent("pAttach:setPositionOffset", true)
    addEventHandler("pAttach:setPositionOffset", resourceRoot, setPositionOffset)

    function setRotationOffset(...)
        return pAttach:setRotationOffset(...)
    end
    addEvent("pAttach:setRotationOffset", true)
    addEventHandler("pAttach:setRotationOffset", resourceRoot, setRotationOffset)

    function setPed(...)
        return pAttach:setPed(...)
    end
    addEvent("pAttach:setPed", true)
    addEventHandler("pAttach:setPed", resourceRoot, setPed)

    function setBone(...)
        return pAttach:setBone(...)
    end
    addEvent("pAttach:setBone", true)
    addEventHandler("pAttach:setBone", resourceRoot, setBone)

    function setVisible(...)
        return pAttach:setVisible(...)
    end

    function setVisibleAll(...)
        return pAttach:setVisibleAll(...)
    end

    function invisibleAll(...)
        return pAttach:invisibleAll(...)
    end

    function isAttached(...)
        return pAttach:isAttached(...)
    end

    function setDetails(...)
        return pAttach:setDetails(...)
    end

    function getDetails(...)
        return pAttach:getDetails(...)
    end

    function getAttacheds(...)
        return pAttach:getAttacheds(...)
    end

else
    local cache = {}

    function attach(element, ped, boneid, ox, oy, oz, rx, ry, rz)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        cache[element] = { element, ped, boneid, ox or 0, oy or 0, oz or 0, rx or 0, ry or 0, rz or 0 }
        return triggerClientEvent("pAttach:attach", resourceRoot, element, ped, boneid, ox, oy, oz, rx, ry, rz)
    end

    function detach(element)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        cache[element] = nil
        return triggerClientEvent("pAttach:detach", resourceRoot, element)
    end

    function detachAll(ped)
        assert(isElement(ped), "Expected element at argument 1, got "..type(ped))

        for element, data in pairs(cache) do
            if data[2] == ped then
                cache[element] = nil
            end
        end
        return triggerClientEvent("pAttach:detachAll", resourceRoot, ped)
    end

    function setPositionOffset(element, x, y, z)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        cache[element][4] = x or 0
        cache[element][5] = y or 0
        cache[element][6] = z or 0
        return triggerClientEvent("pAttach:setPositionOffset", resourceRoot, element, x, y, z)
    end

    function setRotationOffset(element, x, y, z)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        cache[element][7] = x or 0
        cache[element][8] = y or 0
        cache[element][9] = z or 0
        return triggerClientEvent("pAttach:setRotationOffset", resourceRoot, element, x, y, z)
    end

    function setPed(element, ped)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))
        assert(isElement(ped), "Expected element at argument 2, got "..type(ped))

        cache[element][2] = ped
        return triggerClientEvent("pAttach:setPed", resourceRoot, element, ped)
    end

    function setBone(element, boneid)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        cache[element][3] = boneid
        return triggerClientEvent("pAttach:setBone", resourceRoot, element, boneid)
    end

    function setVisible(element, bool)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        return setElementAlpha(element, bool and 255 or 0)
    end

    function setVisibleAll(ped, bool)
        assert(isElement(ped), "Expected element at argument 1, got "..type(ped))

        for element, data in pairs(cache) do
            iprint(data)
            if data[2] == ped then
                setVisible(element, bool)
            end
        end
        return true
    end

    -- deprecated
    function invisibleAll(ped, bool)
        assert(isElement(ped), "Expected element at argument 1, got "..type(ped))

        return setVisibleAll(ped, not bool)
    end

    function isAttached(element)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        return cache[element] and true or false
    end

    function setDetails(element, ped, boneid, ox, oy, oz, rx, ry, rz)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))
        
        local details = getDetails(element)

        cache[element] = {
            element,
            ped or details[2],
            boneid or details[3],
            ox or details[4], oy or details[5], oz or details[6],
            rx or details[7], ry or details[8], rz or details[9]
        }
        return triggerClientEvent("pAttach:setDetails", resourceRoot, element, ped, boneid, ox, oy, oz, rx, ry, rz)
    end

    function getDetails(element)
        assert(isElement(element), "Expected element at argument 1, got "..type(element))

        return cache[element] or false
    end

    function getAttacheds(ped)
        assert(isElement(ped), "Expected element at argument 1, got "..type(element))

        local list = {}
        
        for element, data in pairs(cache) do
            if data[2] == ped then
                list[ #list + 1 ] = element
            end
        end
        return list
    end

    addEventHandler("onPlayerResourceStart", root, function(res)
        if res ~= resource then return end
        
        triggerClientEvent(source, "pAttach:receiveCache", resourceRoot, cache)
    end)

    addEventHandler("onPlayerQuit", root, function()
        detachAll(source)
    end)

    addEventHandler("onElementDestroy", root, function()
        if cache[source] then
            detach(source)

        elseif getElementType(source) == "ped" then
            for element, data in pairs(cache) do
                if data[2] == source then
                    cache[element] = nil
                end
            end
        end
    end)
end