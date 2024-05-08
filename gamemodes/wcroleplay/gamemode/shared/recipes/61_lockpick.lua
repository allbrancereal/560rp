

local _recipeTable = {};

_recipeTable.ID = 61;

_recipeTable.Name = "Lockpick";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 115;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "strength" , 2 };
	{ "intelligence" , 4 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 4 };
	{ id = 13 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )