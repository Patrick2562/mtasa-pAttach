--[[
  _____      _        _      _
 |  __ \    | |      (_)    | |
 | |__) |_ _| |_ _ __ _  ___| | __
 |  ___/ _` | __| '__| |/ __| |/ /
 | |  | (_| | |_| |  | | (__|   <
 |_|   \__,_|\__|_|  |_|\___|_|\_\

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

	function invisibleAll(...)
		return pAttach:invisibleAll(...)
	end
	addEvent("pAttach:invisibleAll", true)
	addEventHandler("pAttach:invisibleAll", resourceRoot, invisibleAll)

	function isAttached(...)
		return pAttach:isAttached(...)
	end

	function getDetails(...)
		return pAttach:getDetails(...)
	end

else
	local cache = {}

	function attach(element, ...)
		assert(isElement(element), "Expected element at argument 1, got "..type(element))
		cache[element] = {...}
		return triggerClientEvent("pAttach:attach", resourceRoot, element, ...)
	end

	function detach(element)
		assert(isElement(element), "Expected element at argument 1, got "..type(element))
		cache[element] = nil
		return triggerClientEvent("pAttach:detach", resourceRoot, element)
	end

	function detachAll(ped)
		assert(isElement(ped), "Expected element at argument 1, got "..type(ped))
		for element, data in pairs(cache) do
			if data[1] == ped then
				cache[element] = nil
			end
		end
		return triggerClientEvent("pAttach:detachAll", resourceRoot, ped)
	end

	function setPositionOffset(element, x, y, z)
		assert(isElement(element), "Expected element at argument 1, got "..type(element))
		cache[element][3] = x or 0
		cache[element][4] = y or 0
		cache[element][5] = z or 0
		return triggerClientEvent("pAttach:setPositionOffset", resourceRoot, element, x, y, z)
	end

	function setRotationOffset(element, x, y, z)
		assert(isElement(element), "Expected element at argument 1, got "..type(element))
		cache[element][6] = x or 0
		cache[element][7] = y or 0
		cache[element][8] = z or 0
		return triggerClientEvent("pAttach:setRotationOffset", resourceRoot, element, x, y, z)
	end

	function invisibleAll(ped, bool)
		for element, data in pairs(cache) do
			if data[1] == ped then
				setElementAlpha(element, bool and 0 or 255)
			end
		end
		return true
	end

	function isAttached(element)
		return (isElement(element) and cache[element]) and true or false
	end

	function getDetails(element)
		return isAttached(element) and cache[element] or false
	end


	function requestCache()
		if isElement(client) then
			triggerClientEvent(client, "pAttach:receiveCache", resourceRoot, cache)
		end
	end
	addEvent("pAttach:requestCache", true)
	addEventHandler("pAttach:requestCache", resourceRoot, requestCache)


	addEventHandler("onPlayerQuit", root, function()
		for element, data in pairs(cache) do
			if data[1] == source then
				detachAll(source)
				break
			end
		end
	end)

	addEventHandler("onElementDestroy", root, function()
		if cache[source] then
			detach(source)
		end
	end)
end