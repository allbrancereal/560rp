

local _recipeTable = {};

_recipeTable.ID = 8;

_recipeTable.Name = "Desert Eagle";

_recipeTable.Category = "Illegal";
_recipeTable.RequiredPlaytime = 600;
_recipeTable.ToGive = 36;
_recipeTable.RequiredSkills = {
	{ "influence" , 3 };
	{ "luck" , 1 };
	{ "perception" , 2 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 10 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )