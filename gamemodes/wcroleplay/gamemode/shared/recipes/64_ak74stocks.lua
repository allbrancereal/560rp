

local _recipeTable = {};

_recipeTable.ID = 64;

_recipeTable.Name = "AK 74 Stocks";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 118;
_recipeTable.RequiredLevel = 60;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 20 };
	{ "intelligence" , 4 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 4 };
	{ id = 3 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )