/*
models/props_c17/fence01a.mdl // long without rocks
models/props_c17/fence01b.mdl // short without rocks
models/props_c17/fence02a.mdl // with rocks long
models/props_c17/fence02b.mdl // with rocks short
models/props_lab/blastdoor001b.mdl // Container door short
models/props_lab/blastdoor001c.mdl // container door long
models/props_wasteland/wood_fence01a.mdl // long
models/props_wasteland/wood_fence02a.mdl // short
models/props/CS_militia/gun_cabinet.mdl // gun cabinet
models/props/CS_militia/furniture_shelf01a.mdl // shelf
*/
local ITEM = ITEM || {};

ITEM.ID = 90;
ITEM.Category = "Furniture"
ITEM.Name = "Long Container Door"
ITEM.Quality = 0
ITEM.Description = "With the most space between you and the end."
ITEM.Model	= "models/props_lab/blastdoor001c.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Cost = 800;
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