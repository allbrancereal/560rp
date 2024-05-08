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
local ITEM = ITEM || {};

ITEM.ID = 83
ITEM.Category = "Furniture"
ITEM.Name = "UHD TV"
ITEM.Quality = 0
ITEM.Description = "4K HDR, premium for most peoples tastes."
ITEM.Model	= "models/props/cs_office/TV_plasma.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
//ITEM.Class = "whk_tv";
ITEM.Cost = 4999;
ITEM.CamPos = Vector(0, -37.84, 0);
ITEM.LookAt = Vector(0, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 