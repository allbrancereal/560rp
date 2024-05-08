

local _recipeTable = {};

_recipeTable.ID = 66;

_recipeTable.Name = "Shotgun Ammo Types";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 120;
_recipeTable.RequiredLevel = 10;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 30 };
	{ "intelligence" , 30};
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 25 , amount = 20 };
	{ id = 51 , amount = 10 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )