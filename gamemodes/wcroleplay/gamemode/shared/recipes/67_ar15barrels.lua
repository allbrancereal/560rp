

local _recipeTable = {};

_recipeTable.ID = 67;

_recipeTable.Name = "AR 15 Barrels";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 121;
_recipeTable.RequiredLevel = 120;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 10 };
	{ "intelligence" ,5 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 20 };
	{ id = 7 , amount = 5 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )