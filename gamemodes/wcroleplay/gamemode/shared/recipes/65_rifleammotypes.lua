

local _recipeTable = {};

_recipeTable.ID = 65;

_recipeTable.Name = "Rifle Ammo Types";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 119;
_recipeTable.RequiredLevel = 10;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" ,25 };
	{ "intelligence" , 25 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 10 };
	{ id = 114 , amount = 10 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )