-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Gas Station Clerk"

NPC.model = "models/sentry/gtav/mexican/mexboss2pm.mdl"
-- Uncomment to make the NPC sit.
NPC.reputation =5;
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart(entity)

	local bFound = false;
	for k, v in pairs(fsrp.config.RobberyConfig[entity:GetQuest()].rewards) do
		if(LocalPlayer():GetActiveWeapon():GetClass():find(k:lower())) then
			bFound = true
		end
	end
	-- self:addText(<text>) adds text that comes from the NPC.

	local _p = LocalPlayer()

	local _beingRobbed = entity:getFlag("beingRobbed", false);

	if _beingRobbed then self:close() end;
	
	if (!bFound) then
		self:addText("Welcome to AMPM, how may I help you?")

		if !_p:IsNearCNPC( "gasstation" , 150 ) then self:close() return _p:Notify("Move closer to the Clerk to trade with them.") end;

		self:addOption("Sure let me see what you have in stock!", function()
			
			ItemShopUI( 2 )
			self:close()

		end) 
		self:addLeave("No thanks.")

	else


		self:addText("Oh shit what the fuck is that a gun!?")

		self:addOption("YEA HAND ME OVER ALL YOUR MONEY!", function()
			
		if !_p:IsNearCNPC( "gasstation" , 150 ) then self:close() return _p:Notify("Move closer to the Clerk to Rob them.") end;

			self:send("StartRobbery")
			self:close()
		
		end)
	
		self:addLeave("<LEAVE> Noooo its just a meditation gun!")
	

	end
					
end