
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Bank ATM"
NPC.Invisible = false;
NPC.model = "models/props_unique/atm01.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
NPC.reputation = 3
-- This is the function that gets called when the player presses <E> on the NPC.
/*

fsrp.blackmarket.cache.Selling = {}
fsrp.blackmarket.cache.Buying = {}
fsrp.blackmarket.cache.PercentagePaying 	= math.random( 80, 120 );
fsrp.blackmarket.cache.PercentageSelling 	= math.random( 80, 120 );
*/

function NPC:onStart()
	local _p = LocalPlayer()
	ShowBankATMMenu()
	self:close()
	
end