-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Hatman Hat Co."

NPC.model = "models/sentry/gtav/mexican/aztecapm.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hello there, you want to check out my valuable hats?")

	local _p = LocalPlayer()
	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("Sure!", function()
	
		if !_p:IsNearCNPC( "hatguy" , 150 ) then self:addLeave("Thanks.") return _p:Notify("Move closer to Hat dude to trade with him.") end;
	
		ItemShopUI( 6 )
		self:close()
	end)

	self:addLeave("No thanks.")
	
end