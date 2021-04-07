-- SETTINGS -------------------------------------------------------------------------------------------
local CHECK_FOR_UPDATES = true -- change this to 'false' if you don't want to check for new releases!
-------------------------------------------------------------------------------------------------------


if CHECK_FOR_UPDATES then
    addEventHandler("onResourceStart", resourceRoot, function()
        fetchRemote("https://api.github.com/repos/Patrick2562/mtasa-pAttach/releases/latest", function(data, status)
            assert(status == 0 and data, "[pAttach] Can't fetch 'api.github.com' for new releases! (Status code: "..tostring(status)..")")
            
            data = fromJSON(data)
            
            if data then
                local latest_id = tonumber(data["id"])
                local tag_name  = tostring(data["tag_name"])

                if latest_id then
                    local file = fileExists("release") and fileOpen("release") or fileCreate("release")
                    
                    if file then
                        local current_id = tonumber(fileRead(file, fileGetSize(file)))

                        fileSetPos(file, 0)

                        if not current_id then
                            fileWrite(file, tostring(latest_id))
                        
                        elseif latest_id > current_id then
                            local asset = data["assets"][1]

                            if asset then
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
                            end
                        end

                        fileClose(file)
                    end
                end
            end
        end)
    end)
end