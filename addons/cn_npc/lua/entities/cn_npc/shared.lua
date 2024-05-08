--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2
--]]

ENT.Type = "anim"
ENT.PhysgunDisable = true
ENT.PhysgunDisabled = true
ENT.AutomaticFrameAdvance  =true
function ENT:setAnim()
    local uniqueID = self:GetQuest()
    local custom = uniqueID and cnQuests[uniqueID] and cnQuests[uniqueID].sequence
    
   --if (custom) then
        --custom = custom:lower()
    if self:GetSequenceList()[custom] then
    	return self:ResetSequence(self:GetSequenceList()[custom])
    end
	for k, v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("idle") and v != "idlenoise") then
			return self:ResetSequence(k)
		end
	end 
	

	self:ResetSequence(3)

end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Quest")
end

