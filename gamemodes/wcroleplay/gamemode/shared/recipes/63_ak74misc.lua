

local _recipeTable = {};

_recipeTable.ID = 63;

_recipeTable.Name = "AK 74 Misc";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 117;
_recipeTable.RequiredLevel = 60;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 20 };
	{ id = 114 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )