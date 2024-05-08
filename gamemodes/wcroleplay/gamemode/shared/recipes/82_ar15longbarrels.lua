

local _recipeTable = {};

_recipeTable.ID = 82;

_recipeTable.Name = "AR 15 Long Barrels";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 122;
_recipeTable.RequiredLevel = 130;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5};
	{ "intelligence" , 25};
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 15 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )