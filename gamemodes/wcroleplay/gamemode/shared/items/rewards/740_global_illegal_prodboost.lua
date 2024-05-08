
local ITEM = ITEM || {};

ITEM.ID = 740
ITEM.Category = "Misc"
ITEM.Name = "Global Illegal Drug Production Boost Bell"
ITEM.Quality = 3
ITEM.Description = "Boost the production and sales of cannabis by 200% for everyone on the server!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 25;
ITEM.Cost = 250000;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	LastGlobalWeedBoost = os.time();
	for k ,v in pairs(player.GetAll()) do
		v:ChatPrint(_p:getRPName() .. " has initiated a Global Illegal Drug Production Boost Bell!")
	end

	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 