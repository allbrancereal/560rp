
local ITEM = ITEM || {};

ITEM.ID = 115
ITEM.Category = "Weapon"
ITEM.Name = "Lockpick"
ITEM.Quality = 0
ITEM.Description = "Useful for getting in to things."
ITEM.Model	= "models/weapons/w_crowbar.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Cost = 600;
ITEM.CamPos = Vector(27.03, -32.43, 10.81);
ITEM.LookAt = Vector(-100, 100, -100);
ITEM.Illegal = true
ITEM.Tradeable = false;
ITEM.SlotType = 2;
ITEM.WeaponClass = "lockpick";
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