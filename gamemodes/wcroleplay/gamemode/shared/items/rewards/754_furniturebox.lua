
local ITEM = ITEM || {};

ITEM.ID = 754
ITEM.Category = "Misc"
ITEM.Name = "Furniture Box"
ITEM.Quality = 3
ITEM.Description = "Receive one of 7 packs of furniture!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 4500;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {
	{
	{60,1},{62,2},{75,1},{74,1},{76,1},{69,2},{66,1},{65,1},{78,1},{61,1},{67,1},{82,1},{72,1},{94,1},{68,1},
	{83,1},{81,1},{70,1},{64,1},{85,1},{86,1},{87,1},{88,1},{91,1},{92,1};
	}
}
ITEM.ToGive= {
	[1] = {
		[60] = 1;
		[62] = 2;
		[75] = 1;
	};
	[2] = {
		[74] = 1;
		[76] = 1;
		[69] = 2;
		[66] = 1
	};
	[3] = {
		[65] = 1;
		[78] = 1;
		[61] = 1;
		[67] = 1;
	};
	[4] = {
		[82] = 1;
		[72] = 1;
		[94] = 1;
		[68] = 1;
	};
	[5] = {
		[83] = 1;
		[81] = 1;
		[70] = 1;
		[64] = 1;
	};
	[6] = {
		[85] = 2;
		[86] = 2;
		[87] = 1;
		[88] = 1;
	};
	[7] = {
		[91] = 4;
		[92] = 4
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