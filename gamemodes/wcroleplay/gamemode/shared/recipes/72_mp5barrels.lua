

local _recipeTable = {};

_recipeTable.ID = 72;

_recipeTable.Name = "MP5 Barrels";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 127;
_recipeTable.RequiredLevel = 80;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 10};
	{ "intelligence" , 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 26 , amount = 14 };
	{ id = 24 , amount = 8 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )