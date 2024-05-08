

local _recipeTable = {};

_recipeTable.ID = 75;

_recipeTable.Name = "MR96 Barrels";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 130;
_recipeTable.RequiredLevel = 80;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 4 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )