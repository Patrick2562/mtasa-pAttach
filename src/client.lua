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

addEvent("pAttach:receiveCache", true)
addEventHandler("pAttach:receiveCache", resourceRoot, function(_cache, _options)
    for _, data in pairs(_cache) do
        pAttach:attach(unpack(data))
    end

    OPTIONS = _options
end)

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

function isAttached(...)
    return pAttach:isAttached(...)
end

function setDetails(...)
    return pAttach:setDetails(...)
end
addEvent("pAttach:setDetails", true)
addEventHandler("pAttach:setDetails", resourceRoot, setDetails)

function getDetails(...)
    return pAttach:getDetails(...)
end

function getAttacheds(...)
    return pAttach:getAttacheds(...)
end

function setConfigOption(...)
    return pAttach:setConfigOption(...)
end
addEvent("pAttach:setConfigOption", true)
addEventHandler("pAttach:setConfigOption", resourceRoot, setConfigOption)
