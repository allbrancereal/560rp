

local _recipeTable = {};

_recipeTable.ID = 12;

_recipeTable.Name = "Small Ammo Kit";
_recipeTable.ToGive = 40;
_recipeTable.RequiredPlaytime = 0;
_recipeTable.Category = "Useful";
_recipeTable.RequiredSkills = {
	{ "strength" , 2 };
	{ "influence" , 2 };
	{ "dexterity" , 1 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 5 };
	{ id = 27 , amount = 4 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )