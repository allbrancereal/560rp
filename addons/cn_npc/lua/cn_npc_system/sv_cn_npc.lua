--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2
--]]

AddCSLuaFile("cl_quest.lua")

util.AddNetworkString("npcOpen")
util.AddNetworkString("npcData")
util.AddNetworkString("npcClose")

local function saveQuests()
	local data = {}

	for k, v in ipairs(ents.FindByClass("cn_npc")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetQuest()}
	end

	file.CreateDir("cnrp")
	file.CreateDir("cnrp/quests")
	file.Write("cnrp/quests/"..game.GetMap()..".txt", util.TableToJSON(data))
end

cnNPCSaveQuests = saveQuests

local function loadNPCs()
	local encoded = file.Read("cnrp/quests/"..game.GetMap()..".txt", "DATA")
	if (encoded) then
		local decoded = util.JSONToTable(encoded)
		for k , v in pairs(ents.FindByClass("cn_npc")) do v:Remove() end
	
		if (decoded) then
			for k, v in ipairs(decoded) do
				local data = cnQuests[v[3]]

				if (data) then
					if (data.gamemode and data.gamemode:lower() != engine.ActiveGamemode():lower()) then
						continue
					end
					
					
					local entity = ents.Create("cn_npc")
					entity:SetPos(v[1])
					entity:SetAngles(v[2])
					entity:Spawn()
					entity:SetModel(data.model)
					entity:SetQuest(v[3])
					entity:setAnim()
					if data.reputation then entity:SetEntityReputation( data.reputation ) end;
				end
			end
		end
	end
end

hook.Add("InitPostEntity", "cnLoadNPC", function()
	timer.Simple(1, loadNPCs)
end)

hook.Add("PostCleanupMap", "cnLoadNPC", loadNPCs)

hook.Add("KeyPress", "cnNPCPress", function(client, key)
	if (key == IN_USE and client:GetMoveType() == MOVETYPE_WALK) then
		local data = {}
			data.start = client:EyePos()
			data.endpos = client:EyePos() + client:GetAimVector()*108
			data.filter = client
			data.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER
		local entity = util.TraceLine(data).Entity

		if (IsValid(entity) and entity:GetClass() == "cn_npc") then
			entity:Interact(client)

			return false
		end
	end
end)

hook.Add("canPocket", "cnNPCNoPocket", function(client, entity)
	if (IsValid(entity) && entity:GetClass() == "cn_npc") then
		return false
	end
end)

concommand.Add("cn_createnpc", function(client, command, arguments)
	if (!client:IsSuperAdmin()) then
		return
	end

	local uniqueID = arguments[1] and arguments[1]:lower() or ""
	local data = cnQuests[uniqueID]

	if (!data) then
		return client:ChatPrint("The NPC type you provided does not exist.")
	end

	if (data.gamemode and data.gamemode:lower() != engine.ActiveGamemode():lower()) then
		return client:ChatPrint("That NPC is not available in this gamemode.")
	end

	local position = client:GetEyeTrace().HitPos
	local angles = (position - client:GetPos()):Angle()
	angles.r = 0
	angles.p = 0
	angles.y = angles.y + 180

	local entity = ents.Create("cn_npc")
	entity:SetPos(client:GetEyeTrace().HitPos)
	entity:SetAngles(angles)
	entity:Spawn()
	entity:SetModel(data.model)
	entity:SetQuest(uniqueID)
	entity:setAnim()
	if data.reputation then entity:SetEntityReputation( data.reputation ) end;

	saveQuests()
end)

concommand.Add("cn_removenpc", function(client, command, arguments)
	if (!client:IsSuperAdmin()) then
		return
	end

	local uniqueID = arguments[1] and arguments[1]:lower()

	if (uniqueID) then
		local i = 0

		for k, v in ipairs(ents.FindByClass("cn_npc")) do
			if (v:GetQuest() == uniqueID) then
				v:Remove()
				i = i + 1
			end
		end

		if (i > 0) then
			saveQuests()
		end
	else
		local entity = client:GetEyeTrace().Entity

		if (IsValid(entity) and entity:GetClass() == "cn_npc") then
			entity:Remove()
			saveQuests()
		end
	end
end)

net.Receive("npcClose", function(length, client)
	client.cnQuest = nil
end)

net.Receive("npcData", function(length, client)
	local uniqueID = net.ReadString()
	local questID = net.ReadString()
	local args = net.ReadTable()
	local entity = client.cnQuest

	if (IsValid(entity) and client:GetPos():Distance(entity:GetPos()) <= 128 and entity:GetQuest() == questID) then
		local data = cnQuests[entity:GetQuest()]

		if (data and type(data["on"..uniqueID]) == "function") then
			data["on"..uniqueID](data, client, unpack(args))
		end
	end
end)