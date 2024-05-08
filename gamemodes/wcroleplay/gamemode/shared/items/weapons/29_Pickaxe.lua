
local ITEM = ITEM || {};

ITEM.ID = 29
ITEM.Category = "Weapon"
ITEM.Name = "Pickaxe"
ITEM.Quality = 0
ITEM.Description = "Useful for mining things."
ITEM.Model	= "models/weapons/HL2meleepack/w_pickaxe.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(27.03, -32.43, 10.81);
ITEM.LookAt = Vector(-100, 100, -100);
ITEM.SlotType	= 2;

ITEM.WeaponClass = "pickaxe";
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