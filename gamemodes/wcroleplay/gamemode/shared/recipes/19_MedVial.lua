

local _recipeTable = {};

_recipeTable.ID = 19;
_recipeTable.ToGive = 47;
_recipeTable.Name = "Med-Vial";

_recipeTable.RequiredPlaytime = 0;

_recipeTable.RequiredSkills = {
	{ "strength" , 3 };
	{ "dexterity" , 1 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 2 };
	{ id = 14 , amount = 1 };


}
	
_recipeTable.Category = "Useful";
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )