
local QUEST = QUEST || {}

QUEST.ID	= 2;
QUEST.Name	= "Tutorial #2";
QUEST.Desc	= {
	"To complete this quest, you have to change your model at the facial trainer!", // Each step has a string here btw
	"Vella has given you $1000. Choose your model!",
	};

QUEST.RewardTable = { 
	money = 2500,
	//xp = 25,
	rep = {[5] = 200;}
}
QUEST.canStart = function ( _p )
	return true;

end

QUEST.Location = {
	['rp_downtown_tits_v2'] = 1;
};
QUEST.OnQuestStep = function ( id, _p )

	if id == 2 then
	
		_p:addBank( 1000 )
		_p.__PreQuest2Model = _p:GetModel();
	end

end

QUEST.Condition = function( _p )
		
	if _p:IsValid() && _p:IsPlayer() then
		
		if _p.__PreQuest2Model != _p:GetModel() then
			
			return true
		else
			return false;
		end

	end
		
end

SetupQuest( QUEST )



