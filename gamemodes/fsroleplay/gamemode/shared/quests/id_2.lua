
local QUEST = QUEST || {}

QUEST.ID	= 2;
QUEST.Name	= "Tutorial #2";
QUEST.Desc	= {
	"To complete this quest, you have to change your model at the facial trainer!", // Each step has a string here btw
	"Choose your model!",
	};

QUEST.RewardTable = { 
	money = 2500,
	//xp = 25,
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



