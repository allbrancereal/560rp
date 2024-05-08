

local _recipeTable = {};

_recipeTable.ID = 59;

_recipeTable.Name = "Shovel";

_recipeTable.RequiredPlaytime = 300;
_recipeTable.ToGive = 108;

_recipeTable.RequiredSkills = {
	{ "strength" , 1 };
	{ "intelligence" , 1 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 2 , amount = 2 };
	{ id = 24 , amount = 1 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

_recipeTable.Category = "Useful";
fsrp.functions.RegisterRecipe( _recipeTable )