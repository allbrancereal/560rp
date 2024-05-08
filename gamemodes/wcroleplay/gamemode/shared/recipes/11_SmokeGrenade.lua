

local _recipeTable = {};

_recipeTable.ID = 11;

_recipeTable.Name = "Smoke Grenade";
_recipeTable.ToGive = 39;
_recipeTable.RequiredPlaytime = 3600;

_recipeTable.RequiredLevel = 70;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 30 };
	{ "endurance" , 15 };
	{ "luck" , 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 24 , amount = 24 };
	{ id = 19 , amount = 1 };
	{ id = 51 , amount = 3 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )