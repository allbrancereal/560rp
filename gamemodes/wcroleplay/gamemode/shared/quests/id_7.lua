
local QUEST = QUEST || {}

QUEST.ID	= 7;
QUEST.Name	= "Rescue Cat";
QUEST.Desc	= {
	"To advance this quest, you have to rescue the stuck kitty.",
	"You got the cat now go back to John Cena!",
	"Hand John Cena the Cat.", // Each step has a string here btw
	};
QUEST.Cooldown = 300

QUEST.RewardTable = { 
	money = 3000,
	items = {{1,1}};
	//xp = 25,
}
QUEST.canStart = function ( _p )
	return true;

end
QUEST.onStart = function( _p )

end
QUEST.Location = {
	['rp_downtown_tits_v2'] = 1;
};

QUEST.OnQuestStep = function ( id , _p )


end

QUEST.OnItemUse = function( self, entity)
	local _finished, _lfinished = entity:FinishedQuest(7)
	local _quest = self:getFlag("quest",nil);
	local _pTable = entity:getFlag("questTable", {} );
	
	if _finished != true and _pTable[7] and _pTable[7].Step == 1 then
		entity:SetQuestStep(_quest,2 )

	end
end

QUEST.onComplete = function( _p )


end

QUEST.Condition = function( _p )
	return true
		
end

SetupQuest( QUEST )



