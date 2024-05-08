

local _recipeTable = {};

_recipeTable.ID = 81;

_recipeTable.Name = "Various Suppressors";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 135;
_recipeTable.RequiredLevel = 100;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 25 };
	{ "intelligence" , 25 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 4 };
	{ id = 5 , amount = 10 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )