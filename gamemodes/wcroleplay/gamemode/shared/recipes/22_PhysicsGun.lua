

local _recipeTable = {};

_recipeTable.ID = 22;

_recipeTable.Name = "Physics Gun";

_recipeTable.RequiredPlaytime = 1200;
_recipeTable.ToGive = 50;

_recipeTable.RequiredSkills = {
	{ "intelligence" , 5 };
	
	};
	
_recipeTable.Category = "Useful";
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 5 };
	{ id = 27 , amount = 5 };
	{ id = 11 , amount = 1 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )