

local _recipeTable = {};

_recipeTable.ID = 69;

_recipeTable.Name = "AR15 Stocks";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 124;
_recipeTable.RequiredLevel = 120;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "intelligence" ,25 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 25 };
	{ id = 26 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )