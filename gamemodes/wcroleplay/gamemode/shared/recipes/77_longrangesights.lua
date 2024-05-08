

local _recipeTable = {};

_recipeTable.ID = 77;

_recipeTable.Name = "Long Range Sights";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 132;
_recipeTable.RequiredLevel = 30;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 5 };
	{ "intelligence" , 20 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 40 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )