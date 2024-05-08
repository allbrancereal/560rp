
local ITEM = ITEM || {};

ITEM.ID = 500
ITEM.Category = "Misc"
ITEM.Name = "Police Ammo Kit"
ITEM.Quality = 0
ITEM.Description = "This crate contains loads of ammo."
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return _p:Team() == TEAM_POLICE
end

ITEM.OnUsed = function( _p )
	_p:GiveAmmo(160,'pistol')
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 