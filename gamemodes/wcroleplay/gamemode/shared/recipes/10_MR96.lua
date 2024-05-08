

local _recipeTable = {};

_recipeTable.ID = 10;

_recipeTable.Name = "MR96";
_recipeTable.ToGive = 38
_recipeTable.RequiredPlaytime = 900;

_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "influence" , 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 5 };
	{ id = 114 , amount = 3 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )