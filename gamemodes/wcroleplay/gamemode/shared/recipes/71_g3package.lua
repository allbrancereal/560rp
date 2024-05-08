

local _recipeTable = {};

_recipeTable.ID = 71;

_recipeTable.Name = "G3 Package";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 126;
_recipeTable.RequiredLevel = 120;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 15 };
	{ "intelligence" , 15 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 25 , amount = 4 };
	{ id = 26 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )