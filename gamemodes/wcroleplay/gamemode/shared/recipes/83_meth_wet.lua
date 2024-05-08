

local _recipeTable = {};

_recipeTable.ID = 83;

_recipeTable.Name = "Meth (Wet)";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 767;
_recipeTable.RequiredLevel = 5;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "perception" , 2};
	{ "intelligence" , 15};
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 9 , amount = 2 };
	{ id = 19 , amount = 1 };
	{ id = 20 , amount = 1 };
}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )