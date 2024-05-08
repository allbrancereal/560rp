
local ITEM = ITEM || {};

ITEM.ID = 13
ITEM.Category = "Weapon"
ITEM.Name = "Wrench"
ITEM.Quality = 0
ITEM.Description = "Helpful for fixing things"
ITEM.Model	= "models/props_c17/tools_wrench01a.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 25;
ITEM.Cost = 10;
ITEM.WeaponClass = "vc_wrench";
ITEM.CamPos = Vector(10.81, 10.81, 16.22);
ITEM.LookAt = Vector(0, 5.41, 0);

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