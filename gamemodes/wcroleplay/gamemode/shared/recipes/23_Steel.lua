

local _recipeTable = {}; 

_recipeTable.ID = 23;
_recipeTable.ToGive = 51;
_recipeTable.Name = "Steel";

_recipeTable.RequiredPlaytime = 0;
/*
_recipeTable.ToGive = {
	Items = {
		{ ID = 51, Amount = 3 };
	}

}
*/
	
_recipeTable.Category = "Craftable";
_recipeTable.RequiredSkills = {
	{ "intelligence" , 3 };
	
	};
_recipeTable.RequiredItems = {
	{ id = 27 , amount = 1 };
	{ id = 28 , amount = 1 };


}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )