DT = game:GetService("DataStoreService")
Inven = DT:GetDataStore("PlayerInventory")
PlrInven = nil
BasicItem = {Inventory = {},OutOfInventory = {StarterSword = "1"}}
game.Players.PlayerAdded:Connect(function(plr)
	local key = "plr-"..plr.UserId
	
	local Inventory = Instance.new("Folder",plr)
	Inventory.Name = "Inventory"
	
	local OutOfInventory = Instance.new("Folder",plr)
	OutOfInventory.Name = "OutOfInventory"
	
	local success = pcall(function()
		PlrInven = Inven:GetAsync(key)
	end)
	if success == true then
		if PlrInven ~= nil then
			if PlrInven.OutOfInventory ~= nil then
				for i,v in pairs(PlrInven.OutOfInventory) do
					local newItem = Instance.new("ObjectValue",OutOfInventory)
					local FoundedItem = game.ReplicatedStorage.Items:FindFirstChild(v)
					if FoundedItem ~= nil then
						newItem.Value = FoundedItem
						newItem.Name = FoundedItem.ItemName.Value
					else
						warn("System Didnt found the Item")
					end
				end
			end
			if PlrInven.Inventory ~= nil then
				for i,v in pairs(PlrInven.Inventory) do
					local newItem = Instance.new("ObjectValue",Inventory)
					local FoundedItem = game.ReplicatedStorage.Items:FindFirstChild(v)
					if FoundedItem ~= nil then
						newItem.Value = FoundedItem
						newItem.Name = FoundedItem.ItemName.Value
					else
						warn("System Didnt found the Item")
					end
				end
			end
		else
			PlrInven = BasicItem
			if PlrInven.OutOfInventory ~= nil then
				for i,v in pairs(PlrInven.OutOfInventory) do
					local newItem = Instance.new("ObjectValue",OutOfInventory)
					local FoundedItem = game.ReplicatedStorage.Items:FindFirstChild(v)
					if FoundedItem ~= nil then
						newItem.Value = FoundedItem
						newItem.Name = FoundedItem.ItemName.Value
					else
						warn("System Didnt found the Item")
					end
				end
			end
			if PlrInven.Inventory ~= nil then
				for i,v in pairs(PlrInven.Inventory) do
					local newItem = Instance.new("ObjectValue",Inventory)
					local FoundedItem = game.ReplicatedStorage.Items:FindFirstChild(v)
					if FoundedItem ~= nil then
						newItem.Value = FoundedItem
						newItem.Name = FoundedItem.ItemName.Value
					else
						warn("System Didnt found the Item")
					end
				end
			end
		end
	else
		warn("Something went wrong...")
	end
end)
game.Players.PlayerRemoving:Connect(function(plr)
	local key = "plr-"..plr.UserId
	local save = {Inventory = {},OutOfInventory = {}}
	for i,v in pairs(plr.OutOfInventory:GetChildren()) do
		save.OutOfInventory[v.Name..i] = tostring(v.Value)
	end
	for i,v in pairs(plr.Inventory:GetChildren()) do
		save.Inventory[v.Name..i] = tostring(v.Value)
	end
	print(save)
	Inven:SetAsync(key,save)
end)
-------------------------
PlayerInfo = nil
DT = game:GetService("DataStoreService")
UserInfo1 = DT:GetDataStore("UserInfo1")
game.Players.PlayerAdded:Connect(function(plr)
	local key = "plr-"..plr.UserId
	
	local leaderstats = Instance.new("Folder",plr)
	leaderstats.Name = "leaderstats"
	
	local Coin = Instance.new("IntValue",leaderstats)
	Coin.Name = "Coin"
	
	local Level = Instance.new("IntValue",leaderstats)
	Level.Name = "Level"
	
	local Exp = Instance.new("IntValue",leaderstats)
	Exp.Name = "Exp"
	
	local sucess = pcall(function()
		PlayerInfo = UserInfo1:GetAsync(key)
	end)
	if sucess == true then
		if PlayerInfo == nil then
			print("FirstJoinedPlayer!")
		else
			for i,v in pairs(PlayerInfo) do
				local Item = leaderstats:FindFirstChild(i)
				if Item ~= nil then
					Item.Value = v
				else	
					warn("System Didnt Found the Item Value")
				end
			end
		end
	else
		warn("Something went wrong...")
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	local key = "plr-"..plr.UserId
	local save = {}
	
	for i,v in pairs(plr.leaderstats:GetChildren()) do
		save[v.Name] = v.Value
	end
	print(save)
	UserInfo1:SetAsync(key,save)
end)

game:BindToClose(function()
	wait(3)
end)