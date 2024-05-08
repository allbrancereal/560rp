
local ITEM = ITEM || {};

ITEM.ID = 770
ITEM.Category = "Misc"
ITEM.Name = "Money Printer Supply"
ITEM.Quality = 1;
ITEM.Description = "A supply package for money printers."
ITEM.Model	= "models/props_junk/cardboard_box003a.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 25;
ITEM.Cost = 600;
ITEM.Class = "mp_supply";
ITEM.Illegal = true;
ITEM.Scale =1
ITEM.Tradeable = true;
ITEM.CamPos = Vector(100, 100, 21.62);
ITEM.LookAt = Vector(-16.22, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p ) return true
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end


SetupItem ( ITEM ) 