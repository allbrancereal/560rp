
local ITEM = ITEM || {};

ITEM.ID = 57
ITEM.Category = "Misc"
ITEM.Name = "Dimebag of Weed"
ITEM.Quality = 0
ITEM.Description = "A mystical force pushes the equilibrium of this weed from eversolasting bong bowls."
ITEM.Model	= "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 1000;
ITEM.Cost = 50;
ITEM.Illegal = true;
ITEM.Tradeable = false;
ITEM.CamPos = Vector(5.41, 0, 16.22);
ITEM.LookAt = Vector(0, 0, -10.81);

ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return false
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnIllegalSale = function( _p )
	local _finished = _p:FinishedQuest(8);
	if _finished == false then
		_p:RewardQuest(8)
	end
end
ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 