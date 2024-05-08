
local ITEM = ITEM || {};

ITEM.ID = 48
ITEM.Category = "Misc"
ITEM.Name = "Kevlar"
ITEM.Quality = 0
ITEM.Description = "Using this will protect you from bullets."
ITEM.Model	= "models/combine_vests/obseletevest.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(43.24, 43.24, 37.84);
ITEM.LookAt = Vector(-59.46, -43.24, -27.03);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	_p:SetArmor(255)
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 