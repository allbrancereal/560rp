

local _recipeTable = {};

_recipeTable.ID = 1;

_recipeTable.Name = "Pickaxe";

_recipeTable.RequiredPlaytime = 300;
_recipeTable.ToGive = 29;

_recipeTable.Category = "Useful";
_recipeTable.RequiredSkills = {
	{ "strength" , 1 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 2 , amount = 2 };
	{ id = 24 , amount = 1 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )