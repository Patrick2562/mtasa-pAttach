# pAttach
Optimized bone attach thanks to the new MTA functions/events.

This resource doesn't match with well known bone_attach, you can not use the same parameters!


# Documentation
You can find the documentation on Wiki page. [(click here)](https://github.com/Patrick2562/mtasa-pAttach/wiki)


# Performance Comparison
\- There are not so much similiar resources but I will run some performance tests on them.
CPU usages (Ryzen 5 2600), streamed-in/out attached objects to a ped, on default MTA server with play gamemode.

| Objects count | pAttach (in_stream) | pAttach (out_of_stream) | attachToBones (in_stream) | attachToBones (out_of_stream) | bone_attach (in_stream) | bone_attach (out_of_stream) |
| :------------ | :-----------------: | :---------------------: | :-----------------------: | :---------------------------: | :---------------------: | :-------------------------: |
| 10 objects    |        0.63%        |            -            |           0.84%           |             0.15%             |          1.64%          |            0.17%            |
| 100 objects   |        4.56%        |            -            |           6.44%           |             0.38%             |         12.82%          |            0.43%            |
| 500 objects   |       28.87%        |            -            |          36.91%           |             1.36%             |         69.40%          |            1.62%            |
| 1000 objects  |       46.34%        |            -            |          61.62%           |             2.60%             |         113.12%         |            3.11%            |


# How to use
\- Server sided example to attach objects (parachute, weapon, hat) to player.

```lua
addCommandHandler("testattach", function(player)
    local backpack = createObject(371, 0, 0, 0)
    exports.pAttach:attach(backpack, player, "backpack", 0, -0.15, 0, 0, 90, 0)

    local weaponRight = createObject(3965, 0, 0, 0)
    exports.pAttach:attach(weaponRight, player, "weapon")

    local weaponLeft = createObject(3965, 0, 0, 0)
    exports.pAttach:attach(weaponLeft, player, 34, 0.02, 0.05, 0, 20, 190, 190)

    local hat = createObject(1265, 0, 0, 0)
    setObjectScale(hat, 0.5)
    exports.pAttach:attach(hat, player, "head", 0.1, -0.05, 0, 0, 90, 0)
end)
```

<img src="https://i.imgur.com/8QLhKrv.png">

\- Server sided example to attach object to player, but you are in control of element collision
```lua
addCommandHandler("testattach", function(player)
    local x,y,z = getElementPosition(player)
    local backpack = createObject(1337, x, y + 2, z)
    exports.pAttach:setConfigOption("toggleCollision", false)
    setElementCollisionsEnabled(backpack, false)
    setTimer(function()
        exports.pAttach:attach(backpack, player, "backpack", 0, -0.45, 0, 0, 90, 0)
        setTimer(function()
            exports.pAttach:detach(backpack)
        end, 1000, 1)
    end, 2500, 1)
end)
```

# Known issues
\- There are desynchronization problems when attaching a player to ped or player.
