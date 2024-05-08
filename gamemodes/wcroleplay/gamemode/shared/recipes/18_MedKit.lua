

local _recipeTable = {};

_recipeTable.ID = 18;
_recipeTable.ToGive = 46;
_recipeTable.Name = "Med-Kit";

_recipeTable.RequiredPlaytime = 300;

_recipeTable.RequiredSkills = {
	{ "regeneration" , 5 };
	{ "influence" , 5 };
	{ "intelligence" , 3 };
	
	};
_recipeTable.IsUnknown = true;

_recipeTable.Category = "Useful";	
_recipeTable.RequiredItems = {
	{ id = 51, amount = 3 };
	{ id = 25 , amount = 2 };
	{ id = 14 , amount = 3 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )