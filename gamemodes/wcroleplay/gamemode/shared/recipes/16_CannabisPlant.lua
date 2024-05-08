

local _recipeTable = {};

_recipeTable.ID = 16;
_recipeTable.ToGive = 44;
_recipeTable.Name = "Cannabis Plant";

_recipeTable.Category = "Illegal";
_recipeTable.RequiredPlaytime = 300;

_recipeTable.RequiredSkills = {
	{ "intelligence" , 1 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 2 , amount = 2 };
	{ id = 96 , amount = 1 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )
	local _finished = _p:FinishedQuest(8);
	if _finished == false then
		_p:SetQuestStep(8,2)
	end
end

fsrp.functions.RegisterRecipe( _recipeTable )