
local ITEM = ITEM || {};

ITEM.ID = 36
ITEM.Category = "Weapon"
ITEM.Name = "Desert Eagle"
ITEM.Quality = 0
ITEM.Description = "Lots of kids think this is good."
ITEM.WeaponClass = "cw_deagle";
ITEM.Model	= "models/weapons/w_pist_deagle.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 1800;
ITEM.CamPos = Vector(0, 10.81, 10.81);
ITEM.LookAt = Vector(5.41, -16.22, -10.81);
ITEM.SlotType = 5;
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return _p:Team() == TEAM_CIVILLIAN;
end

ITEM.OnUsed = function( _p )
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 