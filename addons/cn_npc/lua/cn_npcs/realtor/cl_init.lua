-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Realtor Max"

NPC.model = "models/player/mai_nk.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
NPC.reputation =3;

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart(entity)
	local bFound = false;

	for k, v in pairs(fsrp.config.RobberyConfig[entity:GetQuest()].rewards) do
		if(LocalPlayer():GetActiveWeapon():GetClass():find(k:lower())) then
			bFound = true
		end
	end

	local _beingRobbed = entity:getFlag("beingRobbed", false);

	if _beingRobbed then self:close() end;
	
	if (!bFound) then
			
		-- self:addText(<text>) adds text that comes from the NPC.
		self:addText("Hello there! I am 2B, you can find a property here!")

		self:addOption("I would like to see all the properties that are available in the city.", function()
		
			MakeRealtorScreen()
			self:close()
		end)
		self:addLeave("<Leave> No, thanks.")
	
	elseif bFound then

		self:addText("Oh shit what the fuck is that a weapon!?")

		self:addOption("YEA HAND ME OVER ALL YOUR MONEY!.", function()
			
			self:send("StartRobbery")
			self:close()
		
		end)
	
		self:addLeave("<LEAVE> Noooo its just a water gun!")
	end
	
end