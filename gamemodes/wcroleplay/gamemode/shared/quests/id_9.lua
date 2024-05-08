
local QUEST = QUEST || {}

QUEST.ID	= 9;
QUEST.Name	= "Long Come-Up";
QUEST.Desc	= {
	"Obtain $5,000,000 and hand it to the country clerk.",
	};

QUEST.RewardTable = { 
	//xp = 25,
	misc = {"VIP Rank"};
	rank = 8;
}
QUEST.canStart = function ( _p )
	return true;

end
QUEST.onStart = function( _p )

end
QUEST.Location = {
	['rp_downtown_tits_v2'] = 8;
};

QUEST.OnQuestStep = function ( id , _p )


end

QUEST.onComplete = function( _p )
	_p:AddTag("donator",false)
	_p:AddTag("vip",false)

end

QUEST.Condition = function( _p )
	return _p:canAfford(5000000)
		
end

SetupQuest( QUEST )



