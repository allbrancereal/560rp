

local _recipeTable = {};

_recipeTable.ID = 4;

_recipeTable.Name = "Flash Grenade";
_recipeTable.ToGive = 32
_recipeTable.RequiredPlaytime = 3600;

_recipeTable.RequiredLevel = 40;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 30 };
	{ "intelligence" , 25 };
	};
_recipeTable.IsUnknown = true;
	
_recipeTable.RequiredItems = {
	{ id = 26 , amount = 15 };
	{ id = 28 , amount = 3 };
	{ id = 16 , amount = 1 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )