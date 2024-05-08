

local _recipeTable = {};

_recipeTable.ID = 5;

_recipeTable.Name = "Frag Grenade";
_recipeTable.ToGive = 33
_recipeTable.RequiredPlaytime = 3600;

_recipeTable.RequiredLevel = 60;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 30 };
	{ "intelligence" , 10 };
	{ "perception" , 5 };
	
	};
_recipeTable.IsUnknown = true;
	
_recipeTable.RequiredItems = {
	{ id = 26 , amount = 15 };
	{ id = 28 , amount = 3 };
	{ id = 16 , amount = 1 };
	{ id = 20 , amount = 2 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )