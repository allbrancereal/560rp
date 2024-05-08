
local ITEM = ITEM || {};

ITEM.ID = 52
ITEM.Category = "Misc"
ITEM.Name = "Flash Light"
ITEM.Quality = 0
ITEM.Description = "A flash light that allows you to see in the dark."
ITEM.Model	= "models/maxofs2d/lamp_flashlight.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(27.03, -16.22, 0);
ITEM.LookAt = Vector(0, 0, -2);
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