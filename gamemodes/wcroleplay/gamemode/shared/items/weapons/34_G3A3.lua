
local ITEM = ITEM || {};

ITEM.ID = 34
ITEM.Category = "Weapon"
ITEM.Name = "G3A3"
ITEM.Quality = 0
ITEM.Description = "A powerful sniper rifle."
ITEM.Model	= "models/weapons/w_snip_g3sg1.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 12500;
ITEM.CamPos = Vector(0, 21.62, 27.03);
ITEM.LookAt = Vector(-5.41, -59.46, -59.46);
ITEM.WeaponClass = "cw_g3a3";
ITEM.SlotType = 1;
// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade
ITEM.WepType = 4;
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