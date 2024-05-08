
local ITEM = ITEM || {};

ITEM.ID = 6
ITEM.Category = "Craftable"
ITEM.Name = "Platinum"
ITEM.Quality = 0
ITEM.Description = "When in doubt, just throw metals at it"
ITEM.Model	= "models/okxapack/valuables/valuable_bar.mdl"
ITEM.Skin = 2;
ITEM.Weight = 10;
ITEM.MaxStack =25 ;
ITEM.Cost = 100;

ITEM.CamPos = Vector(5.41, 5.41, 16.22);
ITEM.LookAt = Vector(0, 0, -5.41);
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