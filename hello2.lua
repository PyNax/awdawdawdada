ItemInfo = require(game.ReplicatedStorage.ItemInfo)
DTS = game:GetService("DataStoreService")
data = DTS:GetDataStore("Data1")
game.Players.PlayerAdded:Connect(function(plr)
	local key = "plr-"..plr.UserId
	local plrdata = data:GetAsync(key)
	print(plrdata)
	
	local leaderstats = Instance.new("Folder",plr)
	leaderstats.Name = "leaderstats"
	
	local Money = Instance.new("NumberValue",leaderstats)
	Money.Name = "Money"
	
	local Gems = Instance.new("NumberValue",leaderstats)
	Gems.Name = "Gems"
	
	local Rebirth = Instance.new("IntValue",leaderstats)
	Rebirth.Name = "Rebirths"
	
	local Info = Instance.new("Folder",plr)
	Info.Name = "PlayerInfo"
	
	local Multiplier = Instance.new("NumberValue",Info)
	Multiplier.Name = "Multiplier"
	
	local MouseBox = Instance.new("ObjectValue",Info)
	MouseBox.Name = "MouseBox"
	
	local Inventory = Instance.new("Folder",plr)
	Inventory.Name = "Inventory"
	
	local InHand = Instance.new("Folder",plr)
	InHand.Name = "InHand"
	
	local Ranking = Instance.new("Folder",plr)
	Ranking.Name = "Ranking"
	if plrdata ~= {} or plrdata ~= nil then
		for i,v in pairs(plrdata.inventory) do
			local Item = Instance.new("NumberValue",Inventory)
			Item.Name = ItemInfo[v.ID].Name
			if v.ID ~= nil then
				Item.Value = v.ID
			else
				Item.Value = 1
			end

			local Reloaded = Instance.new("BoolValue",Item)
			Reloaded.Name = "Reloaded"
			
			local Rank = Instance.new("NumberValue",Item)
			Rank.Name = "Rank"
			if v.Rank ~= nil then
				Rank.Value = v.Rank
			end
		end
		if plrdata.ranking ~= nil then
			for i,v in pairs(plrdata.ranking) do
				local RankItem = Instance.new("NumberValue",Ranking)
				RankItem.Name = ItemInfo[v.ID].Name

				local RankTime = Instance.new("NumberValue",RankItem)
				RankTime.Name = "RankTime"
				RankTime.Value = v.RankTime

				local Rank = Instance.new("NumberValue",RankItem)
				Rank.Name = "Rank"
				if v.Rank ~= nil then
					Rank.Value = v.Rank
				end
			end
		end
		for i,v in pairs(plrdata.leaderstats) do
			plr.leaderstats[i].Value = v
		end
		for i,v in pairs(plrdata.playerinfo) do
			plr.PlayerInfo[i].Value = v
		end
	else
		Multiplier.Value = 1
		for i,v in pairs(ItemInfo) do
			if i ~= "Keys" then
				if v.Buyable == ItemInfo.Keys.Buyable.Starter then
					local StarterItem = Instance.new("NumberValue",Inventory)
					StarterItem.Name = v.Name
					StarterItem.Value = i

					local Reloaded = Instance.new("BoolValue",StarterItem)
					Reloaded.Name = "Reloaded"
					
					local Rank = Instance.new("NumberValue",StarterItem)
					Rank.Name = "Rank"
				end
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	local j = 0
	local key = "plr-"..plr.UserId
	local save = {leaderstats = {},playerinfo = {},inventory = {},ranking={}}
	for i,v in pairs(plr.leaderstats:GetChildren()) do
		save.leaderstats[v.Name] = v.Value
	end
	for i,v in pairs(plr.PlayerInfo:GetChildren()) do
		if v.Name == "MouseBox" then
			continue
		end
		save.playerinfo[v.Name] = v.Value
	end
	for i,v in pairs(plr.Inventory:GetChildren()) do
		save.inventory[ItemInfo[v.Value].Name..tostring(i)] = {ID = v.Value,Rank = v.Rank.Value}
		j = i
	end
	for i,v in pairs(plr.InHand:GetChildren()) do
		save.inventory[ItemInfo[v.Value].Name..tostring(j + i)] = {ID = v.Value,Rank = v.Rank.Value}
	end
	for i,v in pairs(plr.Ranking:GetChildren()) do
		save.ranking[ItemInfo[v.Value].Name..tostring(i)] = {ID = v.Value,RankTime = v.RankTime.Value,Rank = v.Rank.Value}
	end
	print(save)
	data:SetAsync(key,save)
end)
game:BindToClose(function()
	wait(3)
end)