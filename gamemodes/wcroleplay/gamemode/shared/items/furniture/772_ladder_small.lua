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

ITEM.ID = 772
ITEM.Category = "Furniture"
ITEM.Name = "Ladder Small"
ITEM.Quality = 0
ITEM.Description = "Useful for going up!"
ITEM.Model	="models/props_c17/metalladder001.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Class = "ladder_small";
ITEM.Cost = 4000;
ITEM.CamPos = Vector(0, -37.84, 0);
ITEM.LookAt = Vector(0, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return (( _p:IsGovernmentOfficial() || _p:IsSuperAdmin() ) && ( _p:getFlag("amountLamps", 0 ) < 5 ) )
end

ITEM.OnUsed = function( _p )
	_p:setFlag("amountLamps", _p:getFlag("amountLamps", 0 ) + 1 );
	
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 