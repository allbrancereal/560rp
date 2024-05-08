--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	self:SetSolid(SOLID_BBOX)
	self:PhysicsInit(SOLID_BBOX)
	self:SelectWeightedSequence( ACT_IDLE)
	self.receivers = {}

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	timer.Simple(1, function()
		if (!IsValid(self)) then
			return
		end

	    local uniqueID = self:GetQuest()
	    local info = uniqueID and cnQuests[uniqueID]

	    if (info and type(info.onEntityCreated) == "function") then
	    	info:onEntityCreated(self)
	    end
	end)
	
end

function ENT:Interact(activator)
	if (!self:GetQuest()) then
		return 
	end
	
	local info = cnQuests[self:GetQuest()]

	if (info) then

		if info.reputation && !activator:KnowsReputation( info.reputation ) then
		
			activator:DiscoverReputation( info.reputation )
			//activator:ChatPrint( "You are now " .. PlayerReputations.config.Reputations[info.reputation].levels[PlayerReputations.config.Reputations[info.reputation].startlv][1] .. " with " .. PlayerReputations.config.Reputations[info.reputation].name )
		end

		if (info.customUse) then
			if (!info:customUse(activator, self)) then
				return 
			end
		end

			activator.cnQuest = self
/*
		if (!IsValid(activator.cnQuest)) then
			activator.cnQuest = self
		else
			return 
		end
*/
		net.Start("npcOpen")
			net.WriteUInt(self:EntIndex(), 14)
		net.Send(activator)
	end
end