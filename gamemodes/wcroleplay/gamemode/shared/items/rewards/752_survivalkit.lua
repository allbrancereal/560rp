
local ITEM = ITEM || {};

ITEM.ID = 752
ITEM.Category = "Misc"
ITEM.Name = "Survival Kit"
ITEM.Quality = 1
ITEM.Description = "A set of items to help you survive."
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{52,1},{40,1},{46,1},{48,1}}
ITEM.ToGive = {
	[52]	= 1,
	[40]	= 1,
	[46]	= 3,
	[48]	= 3,
};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	for k , v in pairs(ITEM.ToGive) do
		for i=1,v do
			_p:AddItemByID(k);
		end
	end
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 