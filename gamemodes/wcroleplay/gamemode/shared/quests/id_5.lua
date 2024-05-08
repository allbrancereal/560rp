
local QUEST = QUEST || {}

QUEST.ID	= 5;
QUEST.Name	= "Paramedic Training: A Start.";
QUEST.Desc	= {
	"To advance this quest, you have to solve a 3 question quiz.", // Each step has a string here btw

	};

QUEST.RewardTable = { 
	money = 500,
	//xp = 25,
}
QUEST.canStart = function ( _p )
	return true;

end
QUEST.onStart = function( _p )

end

QUEST.Location = {
	['rp_downtown_tits_v2'] = 6;
};
QUEST.OnQuestStep = function ( id , _p )


end

QUEST.onComplete = function( _p )


end

QUEST.Condition = function( _p )
		
	return true
		
end

SetupQuest( QUEST )



