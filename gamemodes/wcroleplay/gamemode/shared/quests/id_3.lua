
local QUEST = QUEST || {}

QUEST.ID	= 3;
QUEST.Name	= "Tutorial #3";
QUEST.Desc	= {
	"To advance this quest, you have to buy an airport share!", // Each step has a string here btw
	"Click on the airport share to buy it!",
	};

QUEST.RewardTable = { 
	money = 2500,
	//xp = 25,
}
QUEST.canStart = function ( _p )
	return true;

end
QUEST.onStart = function( _p )

	_p:addBank( 500 )
	_p:Notify( "The Dealer has given you $500" )

end

QUEST.Location = {
	['rp_downtown_tits_v2'] = 3;
};
QUEST.OnQuestStep = function ( id )




end

QUEST.onComplete = function( _p )



end

QUEST.Condition = function( _p )
		
	if _p:getShares( 1 ) > 0 then
	
		return true
		
	else
	
		return false
		
	end
		
end

SetupQuest( QUEST )



