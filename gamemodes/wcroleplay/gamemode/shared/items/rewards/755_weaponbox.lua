
local ITEM = ITEM || {};

ITEM.ID = 755
ITEM.Category = "Misc"
ITEM.Name = "Weapon Crate"
ITEM.Quality = 3
ITEM.Description = "Receive a random gun from an assortment of rifles."
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 1500;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {{30,1},{31,1},{32,2},{39,3},{36,1},{37,1},{35,1},{34,1},{38,1},}
ITEM.ToGive= {
	[30]=1;
	[31]=1;
	[32]=2;
	[39]=3;
	[36]=1;
	[37]=1;
	[35]=1;
	[34]=1;
	[38]=1;
};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )

	local _random = math.random(#ITEM.ToGive);
	local _count = 1;
	local _amount =1 ;
	local _id = 0

	for k ,v in pairs(ITEM.ToGive) do
		if _random == _count then
			_id=k
			_amount =v;
		end
		_count = _count + 1
	end
	local _randompack = ITEM.ToGive[_count];

	for i=1,_amount do
		_p:AddItemByID(_id);
	end
	_p:Notify("You received ".. ITEMLIST[_id].Name .. " x" .. _amount)
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 



SetupItem ( ITEM ) 