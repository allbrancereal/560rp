

local _recipeTable = {};

_recipeTable.ID = 9;

_recipeTable.Name = "L115";
_recipeTable.ToGive = 37;
_recipeTable.RequiredPlaytime = 4200;

_recipeTable.RequiredLevel = 80;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 30 };
	{ "luck" , 5 };
	{ "dexterity" , 5 };
	
	};
_recipeTable.IsUnknown = true;
	
_recipeTable.RequiredItems = {
	{ id = 17 , amount = 4 };
	{ id = 51 , amount = 4 };
	{ id = 2 , amount = 1 };
	{ id = 5 , amount = 1 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )