

local _recipeTable = {};

_recipeTable.ID = 2;

_recipeTable.Name = "AK74";
_recipeTable.ToGive = 30

_recipeTable.RequiredPlaytime = 300;

_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ 'intelligence', 15 };
	{ 'influence', 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 25 , amount = 3 };
	{ id = 17 , amount = 2 };
	{ id = 114 , amount = 3 };
	{ id = 1 , amount = 2 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )