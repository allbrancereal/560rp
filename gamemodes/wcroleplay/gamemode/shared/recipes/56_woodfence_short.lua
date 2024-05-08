
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

_recipeTable.ID = 56;

_recipeTable.Name = "Wood Fence (Short)";

_recipeTable.RequiredPlaytime = 300;// 5 mins
_recipeTable.ToGive = 92;

_recipeTable.RequiredSkills = {
	{ "intelligence" , 2 };
	};
	
_recipeTable.Category = "Building";
_recipeTable.RequiredItems = {
	{ id = 2 , amount = 3 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )