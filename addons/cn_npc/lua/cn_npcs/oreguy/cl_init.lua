-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Oreman Mining Co."

NPC.model = "models/player/tfa_cso2/tr_yuri01.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hello there, you want to check out my valuable ores?")

	local _p = LocalPlayer()
	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("Sure!", function()
	
		if !_p:IsNearCNPC( "oreguy" , 150 ) then self:addLeave("Thanks.") return _p:Notify("Move closer to Oreman to trade with him.") end;
	
		ItemShopUI( 3 )
		self:close()
	end)

	self:addLeave("No thanks.")
	
end