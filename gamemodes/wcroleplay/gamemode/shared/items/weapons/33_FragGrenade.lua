
local ITEM = ITEM || {};

ITEM.ID = 33
ITEM.Category = "Weapon"
ITEM.WeaponClass = "cw_frag_grenade";
ITEM.Name = "Frag Grenade"
ITEM.Quality = 0
ITEM.Description = "Explodes shrapnel in all directions, you have more of a chance to survive if you duck."
ITEM.Model	= "models/weapons/w_eq_fraggrenade.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(5.41, 12, 5.41);
ITEM.LookAt = Vector(0, 0, 3);
// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade

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