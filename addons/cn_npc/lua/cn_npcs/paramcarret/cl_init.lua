-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Vehicle Retrieval"

NPC.model = "models/player/tfa_cso2/tr_yuri01.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
/*

fsrp.blackmarket.cache.Selling = {}
fsrp.blackmarket.cache.Buying = {}
fsrp.blackmarket.cache.PercentagePaying 	= math.random( 80, 120 );
fsrp.blackmarket.cache.PercentageSelling 	= math.random( 80, 120 );
*/

function NPC:onStart()
	local _p = LocalPlayer()
	if _p:Team() != TEAM_PARAMEDIC then _p:Notify("You must be a paramedic to retrieve ambulances") return self:close() end
	
	ShowCarRetrieval( 3 )
	self:close()
	
end