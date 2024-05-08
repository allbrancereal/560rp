
local ITEM = ITEM || {};

ITEM.ID = 100
ITEM.Category = "Misc"
ITEM.Name = "Vehicle Light"
ITEM.Quality = 5
ITEM.Description = "Allows you replace your car's light."
ITEM.Model	= "models/maxofs2d/light_tubular.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 50;
ITEM.Cost = 40;

ITEM.Class = "vc_pickup_light";
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