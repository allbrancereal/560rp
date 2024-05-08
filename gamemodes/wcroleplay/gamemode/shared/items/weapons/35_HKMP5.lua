
local ITEM = ITEM || {};

ITEM.ID = 35
ITEM.Category = "Weapon"
ITEM.Name = "MP5-K"
ITEM.Quality = 0
ITEM.Description = "A standard issue military weapon in some countries."
ITEM.Model	= "models/weapons/w_smg_mp5.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 4500;
ITEM.CamPos = Vector(5.41, -32.43, 5.41);
ITEM.LookAt = Vector(0, 75.68, 0);
ITEM.WeaponClass = "cw_mp5";
ITEM.SlotType = 1;
// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade
ITEM.WepType = 2;
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