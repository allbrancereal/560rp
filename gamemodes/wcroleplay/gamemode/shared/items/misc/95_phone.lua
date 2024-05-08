
local ITEM = ITEM || {};

ITEM.ID = 95
ITEM.Category = "Misc"
ITEM.Name = "Phone"
ITEM.Quality = 5
ITEM.Description = "Allows you to commuicate with people across the city."
ITEM.Model	= "models/props/cs_office/phone_p2.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 1;
ITEM.Cost = 1200;
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