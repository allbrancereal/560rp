
local QUEST = QUEST || {}

QUEST.ID	= 1;
QUEST.Name	= "Tutorial #1";
QUEST.Desc	= {
	"Learn what bank accounts are and how they affect you.", // Each step has a string here btw
	"Choose your Bank account!",
	};

QUEST.RewardTable = { 
	money = 1000,
	xp = {id = 2, name = "The Bank" , xp = 25},
	rep = {[3] = 200;}
}
QUEST.canStart = function ( _p )
	return true;

end
QUEST.Location = {
	['rp_downtown_tits_v2'] = 5;
};

QUEST.OnQuestStep = function ( id )




end

QUEST.Condition = function( _p )
		
	if _p:IsValid() && _p:IsPlayer() then
		
		if _p:getBankAccount() < 1 then
			
			return false
		else
			return true;
		end

	end
		
end


SetupQuest( QUEST )



