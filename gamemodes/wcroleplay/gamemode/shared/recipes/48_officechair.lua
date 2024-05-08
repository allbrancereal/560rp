
/*
local _tbl = {

"models/props_c17/FurnitureDresser001a.mdl" ,// Dresser
"models/props_c17/furnitureStove001a.mdl" ,// Stove
"models/props/cs_office/sofa.mdl" ,// Sofa
"models/props/cs_office/Shelves_metal.mdl", // Metal shelves
"models/props/CS_militia/couch.mdl" ,// Couch
"models/props_c17/FurnitureCupboard001a.mdl", // Cupboard
"models/props_c17/FurnitureDrawer001a.mdl", // Drawer
"models/props_c17/FurnitureFridge001a.mdl" ,// Fridge
"models/props_c17/FurnitureSink001a.mdl", // Sink
"Chair_Wood", // ENT: Wooden Chair
"Chair_Office2", // ENT: Big Office Chair
"Chair_Office1", // ENT: Office Chair
"Chair_Plastic", // ENT: Plastic Chair
"models/props_interiors/BathTub01a.mdl", // BathTub
"models/props_wasteland/kitchen_stove001a.mdl", // DualStoves
"models/props_c17/FurnitureTable002a.mdl", // Table
"models/props/cs_office/Table_coffee.mdl", // Coffee Table
"models/props/cs_office/Bookshelf1.mdl", // Bookshelf full
"models/props/cs_office/Bookshelf3.mdl", // Bookshelf empty
"models/props/cs_office/microwave.mdl", // Microwave
"models/gaming-models/nebukadnezar/environment/indoors/alien_pc.mdl", // alienware
"models/props_lab/bewaredog.mdl", // Beware of dog
"models/props_interiors/Furniture_Desk01a.mdl", // Desk
"models/props_c17/FurnitureToilet001a.mdl", // toilet
"models/props/cs_office/TV_plasma.mdl", // tv
}
*/

local _recipeTable = {};

_recipeTable.ID = 48;

_recipeTable.Category = "Furniture";
_recipeTable.Name = "Office Chair";

_recipeTable.RequiredPlaytime = 300;// 5 mins
_recipeTable.ToGive = 84;

_recipeTable.RequiredSkills = {
	{ "intelligence" , 2 };
	{ "influence" , 3 };
	
	};
	
_recipeTable.RequiredItems = {
	{ id = 2 , amount = 2 };

}
	
_recipeTable.OnCrafted = function ( _p , sucess )


end

fsrp.functions.RegisterRecipe( _recipeTable )