-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Vehicle Retrieval"

NPC.model = "models/captainbigbutt/vocaloid/chibi_miku_ap.mdl"
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
	if _p:Team() != TEAM_CIVILLIAN then _p:Notify("You must be a civillian to use this garage" ) 
	
		if _p:Team() == TEAM_POLICE then
		
			_p:Notify( "Go to the building where you got your job, and take the elevator near the waterfall to find your garage!" )
		
		elseif _p:Team() == TEAM_PARAMEDIC then
		
			_p:Notify( "You must go back to the building where you got your job to retrieve an ambulance" )
			
		end
		
		return self:close() 
		
	end
	
	ShowCarRetrieval( 1 )
	self:close()
	
end