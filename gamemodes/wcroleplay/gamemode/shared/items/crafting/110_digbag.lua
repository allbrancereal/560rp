
local ITEM = ITEM || {};

ITEM.ID = 110
ITEM.Category = "Craftable"
ITEM.Name = "Dig Bag"
ITEM.Quality = 0
ITEM.Description = "A bag containing possible metals. Use to uncover!"
ITEM.Model	= "models/sal/trash/binbag.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 150;
ITEM.CamPos = Vector(10.81, 5.41, 16.22);
ITEM.LookAt = Vector(-5.41, 0, 15);
ITEM.Tradeable = false;

ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p ) return true
end



ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return false
end


SetupItem ( ITEM ) 