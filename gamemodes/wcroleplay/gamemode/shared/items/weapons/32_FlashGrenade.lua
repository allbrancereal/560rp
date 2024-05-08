
local ITEM = ITEM || {};

ITEM.ID = 32
ITEM.Category = "Weapon"
ITEM.Name = "Flashbang"
ITEM.Quality = 0
ITEM.Description = "Blinds any person that happens to look at it while going off."
ITEM.Model	= "models/weapons/w_eq_flashbang.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(-10.81, -16.22, 10.81);
ITEM.LookAt = Vector(0, 5.41, 0);
ITEM.WeaponClass = "cw_flash_grenade";
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