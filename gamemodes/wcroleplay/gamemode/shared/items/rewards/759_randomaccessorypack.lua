
local ITEM = ITEM || {};

ITEM.ID = 759
ITEM.Category = "Misc"
ITEM.Name = "Accessory Pack"
ITEM.Quality = 0
ITEM.Description = "Get a set of various attatchment packs:"
/*
	\nAR-15 Acc. Pack
	\nMP5 Acc. Pack
	\nAK-74 Acc. Pack
	\nSights Acc. Pack
	*/
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 25;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{116,3},{117,3},{118,3},{121,3},{122,3}, {123,3},{124,3},{127,3},{128,3},{129,3},{131,3},{132,3},{133,3},{134,3},{136,3}};
ITEM.ToGive= {
	[1] = {
		[116] = 3;
		[117] = 3;
		[118] = 3;
	};
	[2] = {
		[121] = 3;
		[122] = 3;
		[123] = 3;
		[124] = 3;
	};
	[3] = {
		[127] = 3;
		[128] = 3;
		[129] = 3;
	};
	[4] = {
		[131] = 3;
		[132] = 3;
		[133] = 3;
		[134] = 3;
		[136] = 3;
	};
};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	local _randompack = ITEM.ToGive[math.random(#ITEM.ToGive)];
	for k ,v in pairs(_randompack) do
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