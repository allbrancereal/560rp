

local _recipeTable = {};

_recipeTable.ID = 62;

_recipeTable.Name = "AK 74 Barrel";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 116;
_recipeTable.RequiredLevel = 60;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 20 };
	{ "intelligence" , 15 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15 };
	{ id = 11 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )