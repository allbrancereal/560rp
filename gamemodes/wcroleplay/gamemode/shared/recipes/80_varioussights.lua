

local _recipeTable = {};

_recipeTable.ID = 80;

_recipeTable.Name = "Various Sights";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 136;
_recipeTable.RequiredLevel = 120;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 20 };
	{ "intelligence" , 10 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 35 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )