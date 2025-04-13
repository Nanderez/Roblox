local AllIDs = {}
local foundAnything = ""
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
for i,v in pairs(AllIDs) do
    if tonumber(v)+660 < os.time() then
        AllIDs[i] = nil
    end
end

local teleportLib = {}
local function proxyURL(url)
    return "http://nanderez.net/proxy/HT5MkKj84qgtxRnLs6bNBm2YQvDwAeEW7uJG3FdchaVPzrfU9ZQNTcSJHZRkDqLvzdh5sEtU8Kf24yaumB3wPCFXjYgGM6WAp9VxupxVBjPmGqCJ92tRQKceUDd4bZXnyWAka68g3zHvYE7hsMfFwLJHCwYdVX3mk8EUcTnBSQD7Ntjhr5LuKfsPGeA2pa4y9RbqgFx6BdGNbFxH5LEnY8tquUkjg63Ce4yQ7WwpDXTvKP29fMsJZSmAca/?" .. teleportLib.proxy .. "=" .. url;
end


function teleportLib:setProxy(proxy)
  teleportLib.proxy = proxy
end

function teleportLib:serverHop(PlaceId)
    local function tp_void()
        local Site;
        if foundAnything == "" then
            local response = game:HttpGet(proxyURL('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
            Site = game.HttpService:JSONDecode(response)
        else
            local response = game:HttpGet(proxyURL('https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            Site = game.HttpService:JSONDecode(response)
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) and tonumber(v.playing) > 2 then
                for _,Existing in pairs(AllIDs) do
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                end
                if Possible == true then
                    AllIDs[ID] = os.time()
                    wait()
                    local success, response = pcall(function()
                        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, ID, game.Players.LocalPlayer)
                    end)
                    if not success then
                        warn(response)
                    end
                    wait(4)
                end
            end
        end
    end
    while true do
        pcall(function()
            tp_void()
        end)
        print(1)
        task.wait(3)
    end
end

return teleportLib;
