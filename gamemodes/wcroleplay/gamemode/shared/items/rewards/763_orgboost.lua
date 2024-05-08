
local ITEM = ITEM || {};

ITEM.ID = 763
ITEM.Category = "Misc"
ITEM.Name = "Organization Boost Elixir"
ITEM.Quality = 5
ITEM.Description = "Boost your organization production 200% for 2 hours!"
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 1502500;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return (_p:getFlag("organization",0)>0)
end

ITEM.OnUsed = function( _p )
	if _p:getFlag("organization",0) > 0 then
		fsrp.BoostOrg(_p:getFlag("organization",0),3600*2,_p)
	end
	return true
end

ITEM.OnDropped = function( _p )
	return false
end 


SetupItem ( ITEM ) 