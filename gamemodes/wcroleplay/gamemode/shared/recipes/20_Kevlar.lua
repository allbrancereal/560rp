

local _recipeTable = {};

_recipeTable.ID = 20;
_recipeTable.ToGive = 48;

_recipeTable.Name = "Kevlar Vest";

_recipeTable.RequiredPlaytime = 7200;

_recipeTable.RequiredLevel = 40;
_recipeTable.RequiredSkills = {
	{ "strength" , 15 };
	{ "dexterity" , 10 };
	{ "influence" , 10 };
	
	};
_recipeTable.IsUnknown = true;
	
_recipeTable.Category = "Useful";
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15 };
	{ id = 27 , amount = 5 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )