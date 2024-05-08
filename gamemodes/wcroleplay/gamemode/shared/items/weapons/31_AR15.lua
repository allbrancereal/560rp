
local ITEM = ITEM || {};

ITEM.ID = 31
ITEM.Category = "Weapon"
ITEM.Name = "AR-15"
ITEM.Quality = 0
ITEM.Description = "A really deadly gun for how slow it shoots."
ITEM.Model	= "models/weapons/w_rif_m4a1.mdl"
ITEM.WeaponClass = "cw_ar15";
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 4850;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(16.22, 32.43, 16.22);
ITEM.LookAt = Vector(-5.41, -10.81, 0);
ITEM.SlotType = 1;
// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade
ITEM.WepType = 1;
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return _p:Team() == TEAM_CIVILLIAN;
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 