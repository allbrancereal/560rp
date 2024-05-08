
local ITEM = ITEM || {};

ITEM.ID = 3
ITEM.Category = "Craftable"
ITEM.Name = "High Quality Wood"
ITEM.Quality = 0
ITEM.Description = "Wood has never been this pristine."
ITEM.Model	= "models/props_docks/channelmarker_gib01.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 25;
ITEM.Cost = 100;

ITEM.CamPos = Vector(-32.432432432432, -86.486486486486, 5.4054054054054);
ITEM.LookAt = Vector(43.243243243243, 100, -10.810810810811);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p ) return true
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end


SetupItem ( ITEM ) 