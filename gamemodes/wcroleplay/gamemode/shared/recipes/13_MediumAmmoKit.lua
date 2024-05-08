

local _recipeTable = {};

_recipeTable.ID = 13;

_recipeTable.Name = "Medium Ammo Kit";
_recipeTable.ToGive = 41;
_recipeTable.RequiredPlaytime = 300;

_recipeTable.Category = "Illegal";
_recipeTable.RequiredSkills = {
	{ "influence" , 5 };
	{ "dexterity" , 5 };
	{ "intelligence" , 5 };
	{ "strength" , 2 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15 };
	{ id = 27 , amount = 15 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )