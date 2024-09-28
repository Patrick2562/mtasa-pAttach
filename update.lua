function updateCheck()
    if not UPDATE then
        return
    end

    local meta = XML.load("meta.xml", true)
    if not meta then
        return
    end

    local info = meta:findChild("info", 0)
    if not info then
        return
    end

    local version         = info:getAttribute("version") or "0.0.0"
    local current_version = tonumber( (version:gsub("%.","")) )

    fetchRemote("https://api.github.com/repos/Patrick2562/mtasa-pAttach/releases/latest", function(data, status)
        assert(status == 0 and data, "[pAttach] Can't fetch 'api.github.com' for new releases! (Status code: "..tostring(status)..")")

        data = fromJSON(data)
        if not data then
            return
        end

        local tag_name       = tostring(data["tag_name"])
        local latest_version = tonumber( (tag_name:gsub("v",""):gsub("%.","")) )

        if not latest_version or not current_version or latest_version <= current_version then
            return
        end

        local asset = data["assets"][1]
        if not asset then
            return
        end

        local path = "releases/"..asset["name"]

        if fileExists(path) then
            print("[pAttach] New release ("..tag_name..") available on Github! It's already downloaded into 'releases' directory inside pAttach, just replace the old one!")

        else
            fetchRemote(asset["browser_download_url"], function(data, status)
                assert(status == 0 and data, "[pAttach] Can't download latest release ("..tag_name..") from Github! (Status code: "..tostring(status)..")")

                local zip = fileCreate(path)
                if zip then
                    fileWrite(zip, data)
                    fileClose(zip)

                    print("[pAttach] New release ("..tag_name..") available on Github! Automatically downloaded into 'releases' directory inside pAttach, just replace the old one!")
                end
            end)
        end
    end)
end
addEventHandler("onResourceStart", resourceRoot, updateCheck)
