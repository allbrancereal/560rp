

local _recipeTable = {};

_recipeTable.ID = 17;
_recipeTable.ToGive = 45;
_recipeTable.Name = "Camera";

_recipeTable.RequiredPlaytime = 900;

_recipeTable.RequiredSkills = {
	{ "influence" , 25 };
	{ "intelligence" , 30 };
	{ "perception" , 5 };
	
	};
	
_recipeTable.Category = "Useful";
_recipeTable.RequiredItems = {
	{ id = 1 , amount = 5 };
	{ id = 22 , amount = 1 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )