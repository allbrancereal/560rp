

local _recipeTable = {};

_recipeTable.ID = 74;

_recipeTable.Name = "MP5 Stocks";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 129;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 10 };
	{ "intelligence" , 10 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 12 };
	{ id = 25 , amount = 12 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )