
/*
local _tbl = {

85 ch long
86 ch short
87 ch long rock
88 ch short rock
89 container short 
90 container long
91 long wood fence
92 short wood fence
93 gun cabinet
94 shelf
}
*/

local _recipeTable = {};

_recipeTable.ID = 57;

_recipeTable.Name = "Gun Cabinet";

_recipeTable.RequiredPlaytime = 12500;// 5 mins
_recipeTable.ToGive = 93;

_recipeTable.RequiredSkills = {
	{ "intelligence" , 20 };
	{ "strength" , 20 };
	};
	
_recipeTable.Category = "Furniture";
_recipeTable.RequiredItems = {
	{ id = 3 , amount = 20 };
	{ id = 51 , amount = 10 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )