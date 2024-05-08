
local ITEM = ITEM || {};

ITEM.ID = 111
ITEM.Category = "Misc"
ITEM.Name = "Editable Sign"
ITEM.Quality = 5
ITEM.Description = "Put a sign down!"
ITEM.Model	= "models/props_c17/FurnitureShelf001b.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 10;
ITEM.Cost = 500;

ITEM.Class = "editable_sign";
ITEM.Illegal = false;
ITEM.Tradeable = true;
ITEM.CamPos = Vector(48.648648648649, 5.4054054054054, 27.027027027027);
ITEM.LookAt = Vector(-16.216216216216, 0, 0);

ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	//_p:Notify( ITEM.Name .. " dropped for limited time. (2 minutes)" );
	return false
end

ITEM.OnDropped = function( _p )
	return true
end


SetupItem ( ITEM ) 