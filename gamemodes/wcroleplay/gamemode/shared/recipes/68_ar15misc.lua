

local _recipeTable = {};

_recipeTable.ID = 68;

_recipeTable.Name = "AR15 Misc";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 123;
_recipeTable.RequiredLevel = 120;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 20 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15 };
	{ id = 9 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )