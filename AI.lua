-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Esp = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Aimlock = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Chams = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")

--Properties:

ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.0988112837, 0, 0.376687109, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 200)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.32, Color3.fromRGB(216, 216, 216)), ColorSequenceKeypoint.new(0.54, Color3.fromRGB(194, 194, 194)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(180, 180, 180)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(136, 136, 136))}
UIGradient.Rotation = 90
UIGradient.Parent = MainFrame

Esp.Name = "Esp"
Esp.Parent = MainFrame
Esp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Esp.BorderSizePixel = 0
Esp.Position = UDim2.new(0.0970341563, 0, 0.0574934483, 0)
Esp.Size = UDim2.new(0, 200, 0, 50)
Esp.Font = Enum.Font.Gotham
Esp.Text = "Esp"
Esp.TextColor3 = Color3.fromRGB(253, 253, 253)
Esp.TextSize = 14.000
Esp.MouseButton1Down:connect(function()
	local lplr = game.Players.LocalPlayer
	local camera = game:GetService("Workspace").CurrentCamera
	local CurrentCamera = workspace.CurrentCamera
	local worldToViewportPoint = CurrentCamera.worldToViewportPoint

	local HeadOff = Vector3.new(0, 0.5, 0)
	local LegOff = Vector3.new(0,3,0)

	for i,v in pairs(game.Players:GetChildren()) do
		local BoxOutline = Drawing.new("Square")
		BoxOutline.Visible = false
		BoxOutline.Color = Color3.new(0,0,0)
		BoxOutline.Thickness = 3
		BoxOutline.Transparency = 1
		BoxOutline.Filled = false

		local Box = Drawing.new("Square")
		Box.Visible = false
		Box.Color = Color3.new(1,1,1)
		Box.Thickness = 1
		Box.Transparency = 1
		Box.Filled = false

		local HealthBarOutline = Drawing.new("Square")
		HealthBarOutline.Thickness = 3
		HealthBarOutline.Filled = false
		HealthBarOutline.Color = Color3.new(0,0,0)
		HealthBarOutline.Transparency = 1
		HealthBarOutline.Visible = false

		local HealthBar = Drawing.new("Square")
		HealthBar.Thickness = 1
		HealthBar.Filled = false
		HealthBar.Transparency = 1
		HealthBar.Visible = false

		function boxesp()
			game:GetService("RunService").RenderStepped:Connect(function()
				if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
					local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

					local RootPart = v.Character.HumanoidRootPart
					local Head = v.Character.Head
					local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
					local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
					local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

					if onScreen then
						BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
						BoxOutline.Visible = true

						Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
						Box.Visible = true

						HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
						HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
						HealthBarOutline.Visible = true

						HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / math.clamp(game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value, 0, game:GetService("Players")[v.Character.Name].NRPBS:WaitForChild("MaxHealth").Value)))
						HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
						HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 0)
						HealthBar.Visible = true

						if v.TeamColor == lplr.TeamColor then
							--- Our Team
							BoxOutline.Visible = false
							Box.Visible = false
							HealthBarOutline.Visible = false
							HealthBar.Visible = false
						else
							---Enemy Team
							BoxOutline.Visible = true
							Box.Visible = true
							HealthBarOutline.Visible = true
							HealthBar.Visible = true
						end

					else
						BoxOutline.Visible = false
						Box.Visible = false
						HealthBarOutline.Visible = false
						HealthBar.Visible = false
					end
				else
					BoxOutline.Visible = false
					Box.Visible = false
					HealthBarOutline.Visible = false
					HealthBar.Visible = false
				end
			end)
		end
		coroutine.wrap(boxesp)()
	end

	game.Players.PlayerAdded:Connect(function(v)
		local BoxOutline = Drawing.new("Square")
		BoxOutline.Visible = false
		BoxOutline.Color = Color3.new(0,0,0)
		BoxOutline.Thickness = 3
		BoxOutline.Transparency = 1
		BoxOutline.Filled = false

		local Box = Drawing.new("Square")
		Box.Visible = false
		Box.Color = Color3.new(1,1,1)
		Box.Thickness = 1
		Box.Transparency = 1
		Box.Filled = false

		local HealthBarOutline = Drawing.new("Square")
		HealthBarOutline.Thickness = 3
		HealthBarOutline.Filled = false
		HealthBarOutline.Color = Color3.new(0,0,0)
		HealthBarOutline.Transparency = 1
		HealthBarOutline.Visible = false

		local HealthBar = Drawing.new("Square")
		HealthBar.Thickness = 1
		HealthBar.Filled = false
		HealthBar.Transparency = 1
		HealthBar.Visible = false

		function boxesp()
			game:GetService("RunService").RenderStepped:Connect(function()
				if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
					local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

					local RootPart = v.Character.HumanoidRootPart
					local Head = v.Character.Head
					local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
					local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
					local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

					if onScreen then
						BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
						BoxOutline.Visible = true

						Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
						Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
						Box.Visible = true

						HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
						HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
						HealthBarOutline.Visible = true

						HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / math.clamp(game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value, 0, game:GetService("Players")[v.Character.Name].NRPBS:WaitForChild("MaxHealth").Value)))
						HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/HealthBar.Size.Y))
						HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 255 / (game:GetService("Players")[v.Character.Name].NRPBS["MaxHealth"].Value / game:GetService("Players")[v.Character.Name].NRPBS["Health"].Value), 0)                    
						HealthBar.Visible = true

						if v.TeamColor == lplr.TeamColor then
							--- Our Team
							BoxOutline.Visible = false
							Box.Visible = false
							HealthBarOutline.Visible = false
							HealthBar.Visible = false
						else
							---Enemy Team
							BoxOutline.Visible = true
							Box.Visible = true
							HealthBarOutline.Visible = true
							HealthBar.Visible = true
						end

					else
						BoxOutline.Visible = false
						Box.Visible = false
						HealthBarOutline.Visible = false
						HealthBar.Visible = false
					end
				else
					BoxOutline.Visible = false
					Box.Visible = false
					HealthBarOutline.Visible = false
					HealthBar.Visible = false
				end
			end)
		end
		coroutine.wrap(boxesp)()
	end)	
end)
UICorner.Parent = Esp

Aimlock.Name = "Aimlock"
Aimlock.Parent = MainFrame
Aimlock.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Aimlock.BorderSizePixel = 0
Aimlock.Position = UDim2.new(0.0970341563, 0, 0.372493446, 0)
Aimlock.Size = UDim2.new(0, 200, 0, 50)
Aimlock.Font = Enum.Font.Gotham
Aimlock.Text = "box aimlock (made by 2scars)"
Aimlock.TextColor3 = Color3.fromRGB(253, 253, 253)
Aimlock.TextSize = 14.000
Aimlock.MouseButton1Down:connect(function()
	local Settings = {
		rewrittenmain = {
			Enabled = true,
			Key = "b",
			DOT = true,
			AIRSHOT = true,
			NOTIF = false,
			AUTOPRED = false,
			FOV = math.huge,
			RESOVLER = false
		}
	}

	local SelectedPart = "HumanoidRootPart"
	local Prediction = true
	local PredictionValue = 0.129


	local AnchorCount = 0
	local MaxAnchor = 50

	local CC = game:GetService"Workspace".CurrentCamera
	local Plr;
	local enabled = false
	local accomidationfactor = 0.1301
	local mouse = game.Players.LocalPlayer:GetMouse()
	local placemarker = Instance.new("Part", game.Workspace)

	function makemarker(Parent, Adornee, Color, Size, Size2)
		local e = Instance.new("BillboardGui", Parent)
		e.Name = "PP"
		e.Adornee = Adornee
		e.Size = UDim2.new(Size, Size2, Size, Size2)
		e.AlwaysOnTop = Settings.rewrittenmain.DOT
		local a = Instance.new("Frame", e)
		if Settings.rewrittenmain.DOT == true then
			a.Size = UDim2.new(1, 0, 1, 0)
		else
			a.Size = UDim2.new(0, 0, 0, 0)
		end
		if Settings.rewrittenmain.DOT == true then
			a.Transparency = 0
			a.BackgroundTransparency = 0
		else
			a.Transparency = 1
			a.BackgroundTransparency = 1
		end
		a.BackgroundColor3 = Color
		local g = Instance.new("UICorner", a)
		if Settings.rewrittenmain.DOT == false then
			g.CornerRadius = UDim.new(0, 0)
		else
			g.CornerRadius = UDim.new(1, 1) 
		end
		return(e)
	end


	local data = game.Players:GetPlayers()
	function noob(player)
		local character
		repeat wait() until player.Character
		local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(107, 184, 255), 0.3, 3)
		handler.Name = player.Name
		player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)


		spawn(function()
			while wait() do
				if player.Character then
				end
			end
		end)
	end

	for i = 1, #data do
		if data[i] ~= game.Players.LocalPlayer then
			noob(data[i])
		end
	end

	game.Players.PlayerAdded:connect(function(Player)
		noob(Player)
	end)

	spawn(function()
		placemarker.Anchored = true
		placemarker.CanCollide = false
		if Settings.rewrittenmain.DOT == true then
			placemarker.Size = Vector3.new(8, 8, 8)
		else
			placemarker.Size = Vector3.new(0, 0, 0)
		end
		placemarker.Transparency = 0.75
		if Settings.rewrittenmain.DOT then
			makemarker(placemarker, placemarker, Color3.fromRGB(232, 186, 200), 0.40, 0)
		end
	end)

	game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
		if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
			if enabled == true then
				enabled = false
				if Settings.rewrittenmain.NOTIF == true then
					Plr = getClosestPlayerToCursor()
					game.StarterGui:SetCore("SendNotification", {
						Title = "";
						Text = "Unlocked :)",
						Duration = 5
					})
				end
			else
				Plr = getClosestPlayerToCursor()
				enabled = true
				if Settings.rewrittenmain.NOTIF == true then

					game.StarterGui:SetCore("SendNotification", {
						Title = "";
						Text = "Target: "..tostring(Plr.Character.Humanoid.DisplayName),
						Duration = 5
					})

				end
			end
		end
	end)



	function getClosestPlayerToCursor()
		local closestPlayer
		local shortestDistance = Settings.rewrittenmain.FOV

		for i, v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
				local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
				local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
				if magnitude < shortestDistance then
					closestPlayer = v
					shortestDistance = magnitude
				end
			end
		end
		return closestPlayer
	end

	local pingvalue = nil;
	local split = nil;
	local ping = nil;

	game:GetService"RunService".Stepped:connect(function()
		if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
			placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
		else
			placemarker.CFrame = CFrame.new(0, 9999, 0)
		end
		if Settings.rewrittenmain.AUTOPRED == true then
			pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
			split = string.split(pingvalue,'(')
			ping = tonumber(split[1])
			if ping < 130 then
				PredictionValue = 0.151
			elseif ping < 125 then
				PredictionValue = 0.149
			elseif ping < 110 then
				PredictionValue = 0.146
			elseif ping < 105 then
				PredictionValue = 0.138
			elseif ping < 90 then
				PredictionValue = 0.136
			elseif ping < 80 then
				PredictionValue = 0.134
			elseif ping < 70 then
				PredictionValue = 0.131
			elseif ping < 60 then
				PredictionValue = 0.1229
			elseif ping < 50 then
				PredictionValue = 0.1225
			elseif ping < 40 then
				PredictionValue = 0.1256
			end
		end
	end)

	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...)
		local args = {...}
		if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" and Settings.rewrittenmain.Enabled and Plr.Character ~= nil then

			-- args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
            --[[
            if Settings.rewrittenmain.AIRSHOT == true then
                if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
                    
                    --// Airshot
                    args[3] = Plr.Character.LeftFoot.Position+(Plr.Character.LeftFoot.Velocity*PredictionValue)

                else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)

                end
            else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
            end
            ]]
			if Prediction == true then

				args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*PredictionValue)

			else

				args[3] = Plr.Character[SelectedPart].Position

			end

			return old(unpack(args))
		end
		return old(...)
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and Settings.rewrittenmain.Enabled then
			if Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then

				if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall

					--// Airshot

					--// Anchor Check

					if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
						AnchorCount = AnchorCount + 1
						if AnchorCount >= MaxAnchor then
							Prediction = false
							wait(2)
							AnchorCount = 0;
						end
					else
						Prediction = true
						AnchorCount = 0;
					end

					SelectedPart = "LeftFoot"

				else
					--// Anchor Check

					if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
						AnchorCount = AnchorCount + 1
						if AnchorCount >= MaxAnchor then
							Prediction = false
							wait(2)
							AnchorCount = 0;
						end
					else
						Prediction = true
						AnchorCount = 0;
					end

					SelectedPart = "HumanoidRootPart"

				end
			else

				--// Anchor Check

				if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
					AnchorCount = AnchorCount + 1
					if AnchorCount >= MaxAnchor then
						Prediction = false
						wait(2)
						AnchorCount = 0;
					end
				else
					Prediction = true
					AnchorCount = 12;
				end

				SelectedPart = "HumanoidRootPart"
			end

		else
			SelectedPart = "HumanoidRootPart"
		end
	end)
end)
UICorner_2.Parent = Aimlock

Chams.Name = "Chams"
Chams.Parent = MainFrame
Chams.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Chams.BorderSizePixel = 0
Chams.Position = UDim2.new(0.109034181, 0, 0.662493467, 0)
Chams.Size = UDim2.new(0, 194, 0, 55)
Chams.Font = Enum.Font.Gotham
Chams.Text = "Chams"
Chams.TextColor3 = Color3.fromRGB(253, 253, 253)
Chams.TextSize = 14.000

UICorner_3.Parent = Chams

-- Scripts:

local function QMLRK_fake_script() -- MainFrame.Toggle 
	local script = Instance.new('LocalScript', MainFrame)

	local plr = game.Players.LocalPlayer
	local TS = game:GetService("TweenService")
	local Close = TS:Create(script.Parent,TweenInfo.new(.55,Enum.EasingStyle.Sine,Enum.EasingDirection.In),{Position = UDim2.new(0.44,0,1.2,0)})
	
	local Enabled = false
	
	plr:GetMouse().KeyDown:connect(function(key)
		if key == "v" then
			if Enabled == false then
				Pos = script.Parent.Position
				Close:Play()
				Enabled = true
			else 
				local Open = TS:Create(script.Parent,TweenInfo.new(.45,Enum.EasingStyle.Sine,Enum.EasingDirection.Out),{Position = Pos})
				Open:Play()
				Enabled = false
			end
		end
	end)
	
end
coroutine.wrap(QMLRK_fake_script)()
local function ZKVBJDZ_fake_script() -- MainFrame.Drag 
	local script = Instance.new('LocalScript', MainFrame)

	local Drag = script.Parent
	gsCoreGui = game:GetService("CoreGui")
	gsTween = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		local dragTime = 0.04
		local SmoothDrag = {}
		SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		local dragSmoothFunction = gsTween:Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
		dragSmoothFunction:Play()
	end
	Drag.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Drag.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	Drag.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging and Drag.Size then
			update(input)
		end
	end)
	
	
end
coroutine.wrap(ZKVBJDZ_fake_script)()
