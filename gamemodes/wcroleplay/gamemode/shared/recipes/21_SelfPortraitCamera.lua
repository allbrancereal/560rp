

local _recipeTable = {};

_recipeTable.ID = 21;

_recipeTable.Name = "Selfie Camera";
_recipeTable.ToGive = 49;
_recipeTable.RequiredPlaytime = 7200;

_recipeTable.RequiredSkills = {
	{ "strength" , 10 };
	{ "dexterity" , 5 };
	
	};
	
_recipeTable.IsUnknown = true;

_recipeTable.Category = "Useful";
_recipeTable.RequiredItems = {
	{ id = 27 , amount = 7 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )