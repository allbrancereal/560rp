
local QUEST = QUEST || {}

QUEST.ID	= 6;
QUEST.Name	= "Paramedic Training: True beginnings.";
QUEST.Desc	= {
	"To advance this quest, you have to get 3 people healed.", // Each step has a string here btw
	"You now only have to heal two more people.",
	"You now have to heal one more person to finish this quest.",
	};

QUEST.RewardTable = { 
	money = 1275,
	items = {{1,1}};
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



