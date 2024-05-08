
local QUEST = QUEST || {}

QUEST.ID	= 1;
QUEST.Name	= "Tutorial #1";
QUEST.Desc	= {
	"In this tutorial the you must seek the banking NPC and create a bank account", // Each step has a string here btw
	"Choose your Bank account!",
	};

QUEST.RewardTable = { 
	money = 1000,
	xp = {id = 2, name = "The Bank" , xp = 25},
}
QUEST.canStart = function ( _p )
	return true;

end

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


fsrp.SetupQuest( QUEST )



