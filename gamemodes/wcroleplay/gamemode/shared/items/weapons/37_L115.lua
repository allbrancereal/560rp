
local ITEM = ITEM || {};

ITEM.ID = 37
ITEM.Category = "Weapon"
ITEM.Name = "L115"
ITEM.Quality = 0
ITEM.Description = "A extremely powerful sniper rifle."
ITEM.WeaponClass = "cw_l115";
ITEM.Model	= "models/weapons/w_cstm_l96.mdl"
ITEM.Weight = 0.5;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.MaxStack = 25;
ITEM.Cost = 25000;
ITEM.CamPos = Vector(5.41, -27.03, 16.22);
ITEM.LookAt = Vector(10.81, 0, 0);
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