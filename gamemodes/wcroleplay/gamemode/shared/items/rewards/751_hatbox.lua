
local ITEM = ITEM || {};

ITEM.ID = 751
ITEM.Category = "Misc"
ITEM.Name = "Hat Box"
ITEM.Quality =3
ITEM.Description = "Use to get a hat from a selection of rare hats."
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 2500;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Contains = {{139,1},{147,1},{152,1},{150,1},{155,1}};
ITEM.ToGive = {139,147,152,150,155};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	local _hatid = ITEM.ToGive[math.random(#ITEM.ToGive)]
	_p:Notify("You got a " .. ITEMLIST[_hatid].Name)
	_p:AddItemByID(_hatid);
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 