-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Sofa King Co."

NPC.model = "models/sentry/gtav/mexican/fvagospm.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
NPC.reputation =5;


function NPC:onStart(entity)

	local bFound = false;
	for k, v in pairs(fsrp.config.RobberyConfig[entity:GetQuest()].rewards) do
		if(LocalPlayer():GetActiveWeapon():GetClass():find(k:lower())) then
			bFound = true
		end
	end
	local _p = LocalPlayer()

	local _beingRobbed = entity:getFlag("beingRobbed", false);

	if _beingRobbed then self:close() end;
	
	if (!bFound) then
		self:addText("Hello there, you want to check out my great furniture?")


		self:addOption("Sure!", function()
		
			if !_p:IsNearCNPC( "furniturestore" , 150 ) then self:addLeave("Thanks.") return _p:Notify("Move closer to the clerk to trade with them.") end;
		
			ItemShopUI( 4 )
			self:close()
		end)

		self:addLeave("No thanks.")
	
	else


		self:addText("Oh shit what the fuck is that a weapon!?")

		self:addOption("YEA HAND ME OVER ALL YOUR MONEY!", function()
			
			if !_p:IsNearCNPC( "furniturestore" , 150 ) then self:close() return _p:Notify("Move closer to the Clerk to Rob them.") end;

			self:send("StartRobbery")
			self:close()
		
		end)
	
		self:addLeave("<LEAVE> Noooo its just a water gun!")

	end
	
end