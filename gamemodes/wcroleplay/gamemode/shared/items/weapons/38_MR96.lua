
local ITEM = ITEM || {};

ITEM.ID = 38
ITEM.Category = "Weapon"
ITEM.Name = "MR 96"
ITEM.Quality = 0
ITEM.Description = "A fine revolver."
ITEM.Model	= "models/weapons/w_357.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 1650;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(10.81, 20, 0);
ITEM.LookAt = Vector(-5.41, -100, 5.41);
ITEM.WeaponClass = "cw_mr96";
ITEM.SlotType = 2;
// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade
ITEM.WepType = 5;
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