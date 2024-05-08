-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Gundealer"

NPC.model = "models/sentry/gtav/mexican/mexgangpm.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hello there, you want to check out my valuable guns?")

	local _p = LocalPlayer()
	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("Sure!", function()
	
		if !_p:IsNearCNPC( "gunguy" , 150 ) then self:addLeave("Thanks.") return _p:Notify("Move closer to Gundealer to trade with her.") end;
	
		ItemShopUI( 7 )
		self:close()
	end)

	self:addLeave("No thanks.")
	
end