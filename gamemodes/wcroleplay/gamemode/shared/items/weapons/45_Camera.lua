
local ITEM = ITEM || {};

ITEM.ID = 45
ITEM.Category = "Weapon"
ITEM.Name = "Camera"
ITEM.Quality = 0
ITEM.Description = "A camera can be used to take pictures with!"
ITEM.Model	= "models/maxofs2d/camera.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.WeaponClass = "gmod_camera";
ITEM.CamPos = Vector(10.81, 5.41, 16.22);
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