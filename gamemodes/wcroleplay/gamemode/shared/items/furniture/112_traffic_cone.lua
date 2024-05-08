
local ITEM = ITEM || {};

ITEM.ID = 112
ITEM.Category = "Furniture"
ITEM.Name = "Traffic Cone"
ITEM.Quality = 0
ITEM.Description = "The lights toggle!"
ITEM.Model	="models/props_junk/trafficcone001a.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 50;
ITEM.Class = "traffic_cone";
ITEM.Cost = 150;
ITEM.CamPos = Vector(0, -37.84, 0);
ITEM.LookAt = Vector(0, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return _p:IsGovernmentOfficial() || _p:IsSuperAdmin()
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 