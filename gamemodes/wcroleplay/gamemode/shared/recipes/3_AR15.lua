

local _recipeTable = {};

_recipeTable.ID = 3;

_recipeTable.Name = "AR15";
_recipeTable.ToGive = 31
_recipeTable.RequiredPlaytime = 1800;

_recipeTable.RequiredLevel = 50;
_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "dexterity" , 10 };
	{ "influence" , 8 };
	{ "intelligence" , 2 };
	
	};
_recipeTable.IsUnknown = true;
	
_recipeTable.RequiredItems = {
	{ id = 27 , amount = 8 };
	{ id = 19 , amount = 3 };
	{ id = 9 , amount = 2 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )