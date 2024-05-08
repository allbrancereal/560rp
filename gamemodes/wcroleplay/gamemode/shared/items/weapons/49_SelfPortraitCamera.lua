
local ITEM = ITEM || {};

ITEM.ID = 49
ITEM.Category = "Weapon"
ITEM.Name = "Selfie-Cam"
ITEM.Quality = 0
ITEM.Description = "With this you can take a self-portrait!"
ITEM.Model	= "models/maxofs2d/camera.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(10.81, 5.41, 16.22);
ITEM.LookAt = Vector(0, 0, 0);
ITEM.WeaponClass = "selfportrait_camera";
ITEM.SlotType = 2;
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