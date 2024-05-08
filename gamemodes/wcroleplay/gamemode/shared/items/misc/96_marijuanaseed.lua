
local ITEM = ITEM || {};

ITEM.ID = 96
ITEM.Category = "Misc"
ITEM.Name = "Marijuana Seed"
ITEM.Quality = 5
ITEM.Description = "Allows you to pot some plants.."
ITEM.Model	= "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 150;
ITEM.Cost = 200;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(48.648648648649, 5.4054054054054, 27.027027027027);
ITEM.LookAt = Vector(-16.216216216216, 0, 0);

ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return false
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end


SetupItem ( ITEM ) 