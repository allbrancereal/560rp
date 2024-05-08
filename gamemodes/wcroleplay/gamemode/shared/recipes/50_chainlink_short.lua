
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

_recipeTable.ID = 50;

_recipeTable.Name = "Short Chain Link Fence";

_recipeTable.RequiredPlaytime = 300;// 5 mins
_recipeTable.ToGive =86 ;

_recipeTable.RequiredSkills = {
	{ "intelligence" , 2 };
	};
	
_recipeTable.Category = "Building";
_recipeTable.RequiredItems = {
	{ id = 51 , amount = 3 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )