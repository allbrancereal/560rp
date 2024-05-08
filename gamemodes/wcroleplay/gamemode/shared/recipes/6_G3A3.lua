

local _recipeTable = {};

_recipeTable.ID = 6;

_recipeTable.Name = "G3A3";
_recipeTable.ToGive = 34
_recipeTable.RequiredPlaytime = 1200;

_recipeTable.RequiredLevel = 15;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "luck" , 15 };
	{ "influence" , 5 };
	{ "endurance" , 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 7 , amount = 2 };
	{ id = 114 , amount = 5 };
	{ id = 27 , amount = 5 };
	{ id = 25 , amount = 10 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )