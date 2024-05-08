
local ITEM = ITEM || {};

ITEM.ID = 771
ITEM.Category = "Misc"
ITEM.Name = "Meth Starter Guide"
ITEM.Quality = 3
ITEM.Description = "The cooking special!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 5;
ITEM.MaxStack = 1;
ITEM.Cost = 10000;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{767,1},{764,1},{765,1},{768,10},{19,1},}
ITEM.ToGive= {
	[767] = 1,
	[764] = 1,
	[765] = 1,
	[768]	= 10,
	[19] = 1,
};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	_p:ChatPrint("You have to put paint in red smoke, paint thinner in green smoke and bleach in blue smoke.")
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