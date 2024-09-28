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
 

-- SETTINGS - You can modify these variables ----------------------------------------------------------
UPDATE = true -- change this to 'false' if you don't want to check for new releases!

-- default options
OPTIONS = {
    toggleCollisions = true, -- change this to 'false' if you want to manage collisions by yourself
    dimensionChanges = true, -- change this to 'false' if you want to manage dimension changes by yourself
    interiorChanges  = true  -- change this to 'false' if you want to manage interior changes by yourself
}
-------------------------------------------------------------------------------------------------------


-- AVAILABLE BONE IDS
boneIDs = {
    [1]  = true,
    [2]  = true,
    [3]  = true,
    [4]  = true,
    [5]  = true,
    [6]  = true,
    [7]  = true,
    [8]  = true,
    [21] = true,
    [22] = true,
    [23] = true,
    [24] = true,
    [25] = true,
    [26] = true,
    [31] = true,
    [32] = true,
    [33] = true,
    [34] = true,
    [35] = true,
    [36] = true,
    [41] = true,
    [42] = true,
    [43] = true,
    [44] = true,
    [51] = true,
    [52] = true,
    [53] = true,
    [54] = true,
}

-- AVAILABLE BONE NAMES
boneNames = {
    ["pelvis"]            = 1,
    ["pelvis2"]           = 2,
    ["spine"]             = 3,
    ["neck"]              = 4,
    ["head"]              = 5,
    ["head2"]             = 6,
    ["head3"]             = 7,
    ["jaw"]               = 8,
    ["right-upper-torso"] = 21,
    ["right-shoulder"]    = 22,
    ["right-elbow"]       = 23,
    ["right-wrist"]       = 24,
    ["right-hand"]        = 25,
    ["right-thumb"]       = 26,
    ["left-upper-torso"]  = 31,
    ["left-shoulder"]     = 32,
    ["left-elbow"]        = 33,
    ["left-wrist"]        = 34,
    ["left-hand"]         = 35,
    ["left-thumb"]        = 36,
    ["left-hip"]          = 41,
    ["left-knee"]         = 42,
    ["left-tankle"]       = 43,
    ["left-foot"]         = 44,
    ["right-hip"]         = 51,
    ["right-knee"]        = 52,
    ["right-tankle"]      = 53,
    ["right-foot"]        = 54,
    -- extra
    ["backpack"]          = 3,
    ["weapon"]            = 24,
}
