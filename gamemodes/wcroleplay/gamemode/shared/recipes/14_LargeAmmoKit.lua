

local _recipeTable = {};

_recipeTable.ID = 14;

_recipeTable.Name = "Large Ammo Kit";
_recipeTable.ToGive = 42;
_recipeTable.RequiredPlaytime = 4200;

_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "influence" , 5 };
	{ "intelligence" , 10 };
	{ "strength" , 10 };
	{ "perception" , 5 };
	
	};
_recipeTable.IsUnknown = true;
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 30 };
	{ id = 27 , amount = 30 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )