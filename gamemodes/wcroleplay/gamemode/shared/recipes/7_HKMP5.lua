

local _recipeTable = {};

_recipeTable.ID = 7;

_recipeTable.Name = "MP5";
_recipeTable.ToGive = 35;
_recipeTable.RequiredPlaytime = 900;

_recipeTable.RequiredLevel = 25;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 3 };
	{ "influence" , 2 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 25 , amount = 5 };
	{ id = 16 , amount = 2 };
	{ id = 10 , amount = 1 };
	{ id = 51 , amount = 3 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )