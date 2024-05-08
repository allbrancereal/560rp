
local ITEM = ITEM || {};

ITEM.ID = 39
ITEM.Category = "Weapon"
ITEM.Name = "Smoke Grenade"
ITEM.Quality = 0
ITEM.Description = "Makes a cloud of smoke appear at the thrown location"
ITEM.Model	= "models/weapons/w_eq_smokegrenade.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(5.41, 10.81, 10.81);
ITEM.LookAt = Vector(-5.41, -5.41, 0);
ITEM.WeaponClass = "cw_smoke_grenade";
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