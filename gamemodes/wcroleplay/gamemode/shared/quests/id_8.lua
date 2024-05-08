
local QUEST = QUEST || {}

QUEST.ID	= 8;
QUEST.Name	= "Grow-Op";
QUEST.Desc	= {
	"Craft a Marijuana Plant",
	"Start Growing a Marijuana Plant",
	"Sell your Marijuana",
	};

QUEST.RewardTable = { 
	items = {{57,150}};	
	items = {{96,20}};
	//xp = 25,
}
QUEST.canStart = function ( _p )
	return true;

end
QUEST.onStart = function( _p )

end
QUEST.Location = {
	['rp_downtown_tits_v2'] = 7;
};

QUEST.OnQuestStep = function ( id , _p )


end

QUEST.onComplete = function( _p )


end

QUEST.Condition = function( _p )
	return true
		
end

SetupQuest( QUEST )



