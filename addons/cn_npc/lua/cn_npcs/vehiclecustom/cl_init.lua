-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Vehicle Customization"
NPC.model = "models/sentry/gtav/mexican/fvagospm.mdl"

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
	ShowVehicleCustomization()
	
	self:close()
	
end