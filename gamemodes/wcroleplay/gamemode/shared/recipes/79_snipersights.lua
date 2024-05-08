

local _recipeTable = {};

_recipeTable.ID = 79;

_recipeTable.Name = "Sniper Sights";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 134;
_recipeTable.RequiredLevel = 90;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 15 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15};

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )