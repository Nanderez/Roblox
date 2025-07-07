--[[

  @Author: Nanderez
  @Description: Basic Notification Library loadstring.
  @Updates:
    - Added CoreGui Support (safely this time).
    - Added Themes

]]

local NotificationLibrary = {}

local themes = {
	['github-dark'] = {
		Primary = Color3.fromRGB(31, 36, 40);
		Secondary = Color3.fromRGB(36, 41, 46);
		Text = Color3.fromRGB(255, 255, 255);
	};
	['github-light'] = {
		Primary = Color3.fromRGB(230, 231, 237);
		Secondary = Color3.fromRGB(214, 216, 223);
		Text = Color3.fromRGB(0, 0, 0);
	};
	
	['tokyo-night'] = {
		Primary = Color3.fromRGB(22, 22, 30);
		Secondary = Color3.fromRGB(26, 27, 38);
		Text = Color3.fromRGB(192, 202, 245);
	};
	['tokyo-day'] = {
		Primary = Color3.fromRGB(230, 231, 237);
		Secondary = Color3.fromRGB(214, 216, 223);
		Text = Color3.fromRGB(52, 59, 88);
	};

	['one-dark-pro'] = {
		Primary = Color3.fromRGB(22, 25, 29);
		Secondary = Color3.fromRGB(35, 39, 46);
		Text = Color3.fromRGB(181, 191, 208);
	};

	['dracula'] = {
		Primary = Color3.fromRGB(40, 42, 54);
		Secondary = Color3.fromRGB(25, 26, 33);
		Text = Color3.fromRGB(255, 255, 255);
	};

	['ayu-dark'] = {
		Primary = Color3.fromRGB(13, 16, 23);
		Secondary = Color3.fromRGB(11, 14, 20);
		Text = Color3.fromRGB(221, 219, 211);
	};
	['ayu-light'] = {
		Primary = Color3.fromRGB(248, 249, 250);
		Secondary = Color3.fromRGB(212, 213, 214);
		Text = Color3.fromRGB(76, 80, 84);
	};

	['vue'] = {
		Primary = Color3.fromRGB(0, 41, 51);
		Secondary = Color3.fromRGB(20, 196, 170);
		Text = Color3.fromRGB(139, 225, 215);
	};
}

function NotificationLibrary.new(theme:string)
	theme = theme or 'github-dark'
	theme = theme:lower()
	if not themes[theme] then
		theme = 'github-dark'
	end
	
	local currentTheme = themes[theme]
	
	local lib = {}
	local active = {}
	
	local fontId = 12187365364
	local font = Font.fromId(fontId)
	
	local NotificationUI = Instance.new("ScreenGui")

	NotificationUI.Name = game:GetService('HttpService'):GenerateGUID(false)
	
	local parent
	local success, error = pcall(function()
		parent = game.CoreGui
		NotificationUI.Parent = parent 
	end)
	
	if not success then
		parent = game:GetService('Players').LocalPlayer:WaitForChild("PlayerGui")
		NotificationUI.Parent = parent 
	end
	
	NotificationUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	function lib.Notify(header:string, content:string, duration:number, settings:{})

		header = header or ''
		content = content or ''
		duration = duration or 3
		settings = settings or {}
		local color = settings['color'] or Color3.fromRGB(3, 102, 214)
		local soundId = settings['sound'] or 'rbxassetid://1862047553'
		
		local NotificationTemplate = Instance.new("Frame")
		local __Shadow__ = Instance.new("Frame")
		local __3__ = Instance.new("ImageLabel")
		local __2__ = Instance.new("ImageLabel")
		local __1__ = Instance.new("ImageLabel")
		local Container = Instance.new("Frame")
		local Progress = Instance.new("Frame")
		local Fill = Instance.new("Frame")
		local Header = Instance.new("TextLabel")
		local Header_UIPadding = Instance.new("UIPadding")
		local Content = Instance.new("TextLabel")
		local Content_UIPadding = Instance.new("UIPadding")

		NotificationTemplate.Name = game:GetService('HttpService'):GenerateGUID(false)
		NotificationTemplate.AnchorPoint = Vector2.new(1, 1)
		NotificationTemplate.BackgroundColor3 = Color3.fromRGB(31, 36, 40)
		NotificationTemplate.BackgroundTransparency = 1.000
		NotificationTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotificationTemplate.BorderSizePixel = 0
		NotificationTemplate.Position = UDim2.new(1.175, 20, 1 - ((#active - .25) * 0.125), -20)
		NotificationTemplate.Size = UDim2.new(0.175, 0, 0.1, 0)

		__Shadow__.Name = "__Shadow__"
		__Shadow__.Parent = NotificationTemplate
		__Shadow__.AnchorPoint = Vector2.new(0.5, 0.5)
		__Shadow__.BackgroundTransparency = 1.000
		__Shadow__.BorderColor3 = Color3.fromRGB(27, 42, 53)
		__Shadow__.Position = UDim2.new(0.5, 0, 0.5, 0)
		__Shadow__.Size = UDim2.new(1, 15, 1, 15)
		__Shadow__.ZIndex = -999

		__3__.Name = "__3__"
		__3__.Parent = __Shadow__
		__3__.AnchorPoint = Vector2.new(0.5, 0.5)
		__3__.BackgroundTransparency = 1.000
		__3__.BorderColor3 = Color3.fromRGB(27, 42, 53)
		__3__.Position = UDim2.new(0.5, 0, 0.5, 0)
		__3__.Size = UDim2.new(1, 4, 1, 4)
		__3__.ZIndex = 0
		__3__.Image = "rbxassetid://1316045217"
		__3__.ImageColor3 = Color3.fromRGB(0, 0, 0)
		__3__.ImageTransparency = 0.860
		__3__.ScaleType = Enum.ScaleType.Slice
		__3__.SliceCenter = Rect.new(10, 10, 118, 118)

		__2__.Name = "__2__"
		__2__.Parent = __Shadow__
		__2__.AnchorPoint = Vector2.new(0.5, 0.5)
		__2__.BackgroundTransparency = 1.000
		__2__.BorderColor3 = Color3.fromRGB(27, 42, 53)
		__2__.Position = UDim2.new(0.5, 0, 0.5, 0)
		__2__.Size = UDim2.new(1, 4, 1, 4)
		__2__.ZIndex = 0
		__2__.Image = "rbxassetid://1316045217"
		__2__.ImageColor3 = Color3.fromRGB(0, 0, 0)
		__2__.ImageTransparency = 0.880
		__2__.ScaleType = Enum.ScaleType.Slice
		__2__.SliceCenter = Rect.new(10, 10, 118, 118)

		__1__.Name = "__1__"
		__1__.Parent = __Shadow__
		__1__.AnchorPoint = Vector2.new(0.5, 0.5)
		__1__.BackgroundTransparency = 1.000
		__1__.BorderColor3 = Color3.fromRGB(27, 42, 53)
		__1__.Position = UDim2.new(0.5, 0, 0.5, 0)
		__1__.Size = UDim2.new(1, 4, 1, 4)
		__1__.ZIndex = 0
		__1__.Image = "rbxassetid://1316045217"
		__1__.ImageColor3 = Color3.fromRGB(0, 0, 0)
		__1__.ImageTransparency = 0.880
		__1__.ScaleType = Enum.ScaleType.Slice
		__1__.SliceCenter = Rect.new(10, 10, 118, 118)

		Container.Name = "Container"
		Container.Parent = NotificationTemplate
		Container.BackgroundColor3 = currentTheme['Primary']
		Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(1, 0, 1, 0)

		Progress.Name = "Progress"
		Progress.Parent = Container
		Progress.AnchorPoint = Vector2.new(0, 1)
		Progress.BackgroundColor3 = currentTheme['Secondary']
		Progress.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Progress.BorderSizePixel = 0
		Progress.Position = UDim2.new(0, 0, 1, 0)
		Progress.Size = UDim2.new(1, 0, 0.125, 0)

		Fill.Name = "Fill"
		Fill.Parent = Progress
		Fill.BackgroundColor3 = color
		Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Fill.BorderSizePixel = 0
		Fill.Size = UDim2.new(1, 0, 1, 0)

		Header.Name = "Header"
		Header.Parent = Container
		Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Header.BackgroundTransparency = 1.000
		Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0.349999994, 0)
		Header.FontFace = font
		Header.Text = header
		Header.TextColor3 = currentTheme['Text']
		Header.TextScaled = true
		Header.TextSize = 20
		Header.TextTruncate = Enum.TextTruncate.SplitWord
		Header.TextXAlignment = Enum.TextXAlignment.Left
		Header.RichText = true
		Header.TextScaled = false

		Header_UIPadding.Name = "Header_UIPadding"
		Header_UIPadding.Parent = Header
		Header_UIPadding.PaddingBottom = UDim.new(0.1, 0)
		Header_UIPadding.PaddingLeft = UDim.new(0.025, 0)
		Header_UIPadding.PaddingTop = UDim.new(0.1, 0)

		Content.Name = "Content"
		Content.Parent = Container
		Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Content.BackgroundTransparency = 1
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 0, 0.35, 0)
		Content.Size = UDim2.new(1, 0, 0.5, 0)
		Content.FontFace = font
		Content.Text = content
		Content.TextColor3 = currentTheme['Text']
		Content.TextSize = 16.000
		Content.TextWrapped = true
		Content.TextXAlignment = Enum.TextXAlignment.Left
		Content.TextYAlignment = Enum.TextYAlignment.Top
		Content.RichText = true
		Content.TextScaled = false
		
		Content_UIPadding.Name = "Content_UIPadding"
		Content_UIPadding.Parent = Content
		Content_UIPadding.PaddingBottom = UDim.new(0.1, 0)
		Content_UIPadding.PaddingLeft = UDim.new(0.025, 0)
		Content_UIPadding.PaddingTop = UDim.new(0.1, 0)
		
		NotificationTemplate.Size = UDim2.new(
			NotificationTemplate.Size.X.Scale, 
			NotificationTemplate.Size.X.Offset - 50,
			NotificationTemplate.Size.Y.Scale, 
			NotificationTemplate.Size.Y.Offset - 50
		)
		
		NotificationTemplate.Parent = NotificationUI
		
		task.spawn(function()
			local sound = Instance.new('Sound', NotificationTemplate)
			sound.Name = game:GetService('HttpService'):GenerateGUID(false)
			sound.SoundId = soundId
			sound.Volume = 0.35
			sound:Play()
			sound.Ended:Wait()
			sound:Destroy()
		end)
		
		Fill:TweenSize(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, duration + .5)
		NotificationTemplate:TweenSize(UDim2.new(0.175, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .35)
		
		table.insert(active, NotificationTemplate)
		
		task.spawn(function()
			while NotificationTemplate and table.find(active, NotificationTemplate) do
				NotificationTemplate:TweenPosition(UDim2.new(1, -20, 1 - ((table.find(active, NotificationTemplate) - 1) * 0.125), -20),
					Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .25
				)
				task.wait()
			end
		end)

		task.spawn(function()
			task.wait(duration)
			table.remove(active, table.find(active, NotificationTemplate))
			task.wait(.1)
			NotificationTemplate:TweenPosition(UDim2.new(1.175, 20, NotificationTemplate.Position.Y.Scale, -20), 
				Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .3
			)
			task.wait(.3)
			NotificationTemplate:Destroy()
		end)

	end

	return lib
end

return NotificationLibrary
