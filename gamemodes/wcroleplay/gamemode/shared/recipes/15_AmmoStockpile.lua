

local _recipeTable = {};

_recipeTable.ID = 15;

_recipeTable.Name = "Ammo Stockpile";
_recipeTable.ToGive = 43;
_recipeTable.RequiredPlaytime = 7200;

_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "influence" , 20 };
	{ "intelligence" , 5 };
	{ "luck" , 3 };
	
	};
	
_recipeTable.IsUnknown = true;
_recipeTable.RequiredItems = {
	{ id = 51, amount = 30 };
	{ id = 27 , amount = 50 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )