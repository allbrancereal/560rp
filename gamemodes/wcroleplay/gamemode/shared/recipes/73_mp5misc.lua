

local _recipeTable = {};

_recipeTable.ID = 73;

_recipeTable.Name = "MP5 Misc";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 128;
_recipeTable.RequiredLevel = 80;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 15 };
	{ "intelligence" , 5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 8 };
	{ id = 28 , amount = 6 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )