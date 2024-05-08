
local ITEM = ITEM || {};

ITEM.ID = 753
ITEM.Category = "Misc"
ITEM.Name = "Computer Kit"
ITEM.Quality = 0
ITEM.Description = "The Ultimate in Computing Power. A L I E N W A R E"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{137,1},{79,1}}
local _togive = {
	[137]	= 1,
	[79]	= 1,
};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	for k , v in pairs(_togive) do
		_p:AddItemByID(k);				
	end
	
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 