

local _recipeTable = {};

_recipeTable.ID = 70;

_recipeTable.Name = "Deagle Barrels";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 125;
_recipeTable.RequiredLevel = 20;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 25 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 5};

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )