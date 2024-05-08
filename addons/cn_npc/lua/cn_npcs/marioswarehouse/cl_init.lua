-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Mario's Warehouse"

NPC.reputation =5;
-- Uncomment to make the NPC sit.
NPC.model = "models/player/Berserk/Guts_Teen.mdl"
--NPC.sequence = "sit"

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
		self:addText("Hello there, you want to check out my store?")

		self:addOption("Sure!", function()
		
			if !_p:IsNearCNPC( "marioswarehouse" , 150 ) then self:addLeave("Thanks.") return _p:Notify("Move closer to the clerk to trade with them.") end;
		
			ItemShopUI( 1 )
			self:close()
		end)

		self:addLeave("No thanks.")
	
	else


		self:addText("Oh shit what the fuck is that a weapon!?")

		self:addOption("YEA HAND ME OVER ALL YOUR MONEY!", function()
			
			if !_p:IsNearCNPC( "marioswarehouse" , 150 ) then self:close() return _p:Notify("Move closer to the Clerk to Rob them.") end;

			self:send("StartRobbery")
			self:close()
		
		end)
	
		self:addLeave("<LEAVE> Noooo its just a water gun!")

	end
	
end