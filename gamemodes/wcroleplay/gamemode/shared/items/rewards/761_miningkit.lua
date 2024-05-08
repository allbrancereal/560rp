
local ITEM = ITEM || {};

ITEM.ID = 761
ITEM.Category = "Misc"
ITEM.Name = "Mining Kit"
ITEM.Quality = 4
ITEM.Description = "Receive 3 shovels,pickaxes and axes."
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 12500;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{29,3},{108,3},{109,3}}
ITEM.ToGive = {
	[29]	= 3,
	[108]	= 3,
	[109]	= 3,
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