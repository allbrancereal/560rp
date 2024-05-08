

local _recipeTable = {};

_recipeTable.ID = 78;

_recipeTable.Name = "Mid-Range Sights";

_recipeTable.RequiredPlaytime = 3600;
_recipeTable.ToGive = 133;
_recipeTable.RequiredLevel = 60;
_recipeTable.Category = "Attachments";
_recipeTable.RequiredSkills = {
	{ "strength" , 2 };
	{ "intelligence" , 15 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 20 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )