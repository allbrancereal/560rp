
local QUEST = QUEST || {}

QUEST.ID	= 4;
QUEST.Name	= "Tutorial #4";
QUEST.Desc	= {
	"To advance this quest, you have to buy a property!", // Each step has a string here btw
	"Learn how to buy a property.", // Each step has a string here btw
	"Find a property to buy!",
	"Press Purchase Property to buy it!",
	};

QUEST.RewardTable = { 
	money = 2500,
	//xp = 25,
	rep = {[3] = 200;}
}
QUEST.canStart = function ( _p )
	return _p:getBankAccount() > 0;

end
QUEST.onStart = function( _p )

	_p:addBank( 4000 )
	_p:Notify( "Tara has given you $4000 via Electronic Transfer" )

end

QUEST.Location = {
	['rp_downtown_tits_v2'] = 5;
};

QUEST.OnQuestStep = function ( id )


end

QUEST.onComplete = function( _p )

	_p:Notify( "You have completed " .. QUEST.Name ) 

end

QUEST.Condition = function( _p )
		return true;
		
end

SetupQuest( QUEST )



