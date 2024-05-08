
local ITEM = ITEM || {};

ITEM.ID = 30
ITEM.Category = "Weapon"
ITEM.Name = "AK74"
ITEM.Quality = 0
ITEM.Description = "A powerful submachine gun."
ITEM.WeaponClass = "cw_ak74";
ITEM.Model	= "models/weapons/w_rif_ak47.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 3750;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(44.12, 0, 8.82);
ITEM.LookAt = Vector(0, 0, 0);
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