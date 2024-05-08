

local _recipeTable = {};

_recipeTable.ID = 76;

_recipeTable.Name = "Close Quarter Sights";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 131;
_recipeTable.RequiredLevel = 5;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 10 };
	{ "intelligence" , 2 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 114 , amount = 4 };
	{ id = 51 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )