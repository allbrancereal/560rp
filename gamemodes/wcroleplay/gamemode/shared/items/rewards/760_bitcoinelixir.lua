
local ITEM = ITEM || {};

ITEM.ID = 760
ITEM.Category = "Misc"
ITEM.Name = "Bitcoin Boost Elixir"
ITEM.Quality = 4
ITEM.Description = "Boost your bitcoin production by 200%!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 12500;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	_p:HasCooldown("BitcoinBoost",3600);
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 