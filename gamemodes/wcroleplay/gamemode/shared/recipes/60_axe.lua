

local _recipeTable = {};

_recipeTable.ID = 60;

_recipeTable.Name = "Axe";

_recipeTable.RequiredPlaytime = 300;
_recipeTable.ToGive = 109;

_recipeTable.RequiredSkills = {
	{ "strength" , 1 };
	{ "intelligence" , 1 };
	{ "dexterity" , 1 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 2 , amount = 2 };
	{ id = 24 , amount = 1 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end
_recipeTable.Category = "Useful";

fsrp.functions.RegisterRecipe( _recipeTable )