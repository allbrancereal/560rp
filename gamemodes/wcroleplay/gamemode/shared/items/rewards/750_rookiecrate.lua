
local ITEM = ITEM || {};

ITEM.ID = 750
ITEM.Category = "Misc"
ITEM.Name = "Rookie Introductory Crate"
ITEM.Quality = 3
ITEM.Description = "The ultimate cannabis starter kit!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 5;
ITEM.MaxStack = 25;
ITEM.Cost = 1500;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{96,5},{2,10}}
ITEM.ToGive= {
	[96] = 5,
	[2]	= 10
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