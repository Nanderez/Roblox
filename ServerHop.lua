local teleportLib = {}
local function proxyURL(url)
    return "http://nanderez.net/proxy/HT5MkKj84qgtxRnLs6bNBm2YQvDwAeEW7uJG3FdchaVPzrfU9ZQNTcSJHZRkDqLvzdh5sEtU8Kf24yaumB3wPCFXjYgGM6WAp9VxupxVBjPmGqCJ92tRQKceUDd4bZXnyWAka68g3zHvYE7hsMfFwLJHCwYdVX3mk8EUcTnBSQD7Ntjhr5LuKfsPGeA2pa4y9RbqgFx6BdGNbFxH5LEnY8tquUkjg63Ce4yQ7WwpDXTvKP29fMsJZSmAca/?" .. teleportLib.proxy .. "=" .. url;
end


function teleportLib:setProxy(proxy)
  teleportLib.proxy = proxy
end

function teleportLib:serverHop(PlaceId, MinPlayers, MaxPlayers)

    local teleportUI = Instance.new("ScreenGui")
    local container = Instance.new("Frame")
    local teleportText = Instance.new("TextLabel")
    local creditsText = Instance.new("TextLabel")

    teleportUI.Name = "teleportUI"
    teleportUI.Parent = game.CoreGui
    teleportUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    teleportUI.DisplayOrder = 999999999
    teleportUI.IgnoreGuiInset = true

    container.Name = "container"
    container.Parent = teleportUI
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    container.BorderSizePixel = 0
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.Size = UDim2.new(1, 0, 1, 0)

    teleportText.Name = "teleportText"
    teleportText.Parent = container
    teleportText.AnchorPoint = Vector2.new(0.5, 0.5)
    teleportText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    teleportText.BackgroundTransparency = 1.000
    teleportText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    teleportText.BorderSizePixel = 0
    teleportText.Position = UDim2.new(0.5, 0, 0.5, 0)
    teleportText.Size = UDim2.new(0.300000012, 0, 0.100000001, 0)
    teleportText.Font = Enum.Font.SourceSansItalic
    teleportText.Text = "Teleporting to a new Server..."
    teleportText.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportText.TextScaled = true
    teleportText.TextSize = 14.000
    teleportText.TextWrapped = true

    creditsText.Name = "creditsText"
    creditsText.Parent = container
    creditsText.AnchorPoint = Vector2.new(0.5, 0.5)
    creditsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    creditsText.BackgroundTransparency = 1.000
    creditsText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    creditsText.BorderSizePixel = 0
    creditsText.Position = UDim2.new(0.5, 0, 0.975000024, 0)
    creditsText.Size = UDim2.new(0.800000012, 0, 0.0500000007, 0)
    creditsText.Font = Enum.Font.SourceSansItalic
    creditsText.Text = "BGSi Snipe Productions"
    creditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
    creditsText.TextScaled = true
    creditsText.TextSize = 14.000
    creditsText.TextWrapped = true

    MinPlayers = MinPlayers or 1
    local Cursor = ""
    local HttpService = game:GetService('HttpService')
    local function get_Servers()
        local temp
        local function try_site()
            local url = 'https://games.roblox.com/v1/games/' .. PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'
            if Cursor ~= "" then
                url = url .. "&cursor=" .. Cursor
            end
            temp = game:HttpGet(proxyURL(url))
        end
        try_site()
        if tostring(temp) == '{"errors":[{"code":0,"message":"Too many requests"}]}' then
            repeat wait(5); try_site() until tostring(temp) ~= '{"errors":[{"code":0,"message":"Too many requests"}]}'
        end
        local response = HttpService:JSONDecode(temp)
        Cursor = response.nextPageCursor
        return response.data
    end
    local AllIDs = {}
    
    pcall(function()
        AllIDs = HttpService:JSONDecode(readfile("NotSameServers.json"))
    end)
    for i,v in pairs(AllIDs) do
        if tonumber(v)+660 < os.time() then
            AllIDs[i] = nil
        end
    end
    local LastServerId = ""
    while true do
        Servers = get_Servers()
        for _,Server in pairs(Servers) do
            local MaxPlayers = MaxPlayers or Server.maxPlayers
            if Server.maxPlayers > Server.playing and Server.playing >= MinPlayers and Server.playing < MaxPlayers and AllIDs[Server.id] == nil then
                local PreviousServers = {}
				if isfile("NotSameServers.json") then
					PreviousServers = HttpService:JSONDecode(readfile("NotSameServers.json"))
				end
                if LastServerId ~= "" then
                    PreviousServers[LastServerId] = nil
                end
                LastServerId = tostring(Server.id)
                PreviousServers[Server.id] = os.time()
                writefile("NotSameServers.json", HttpService:JSONEncode(PreviousServers))
                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, Server.id, game:GetService("Players").LocalPlayer, nil, nil, teleportUI)
                wait(3)
		game:GetService("TeleportService"):TeleportCancel()
            end
        end
        wait(1)
    end
end

return teleportLib;
