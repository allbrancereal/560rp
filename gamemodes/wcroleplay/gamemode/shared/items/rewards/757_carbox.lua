
local ITEM = ITEM || {};

ITEM.ID = 757
ITEM.Category = "Misc"
ITEM.Name = "Car Crate"
ITEM.Quality = 0
ITEM.Description = "Receive a random Car!"
/*
	\nCadillac Escalade 2012 Keys
	\nDelorean DMC-12 Keys
    \nNoble M600 Keys
    \nMorgan Aero SS Keys
    \nNissan 350z Keys
    \nNissan GT-R Black Edition Keys
    \nBMW 340i Keys
    \nJaguar E-Type Keys
    \nSubaru Impreza WRX STi Keys
    \nKTM X-BOW Keys
    \nTesla Model S Keys
    \nHonda S2000 Keys
    \nMazda RX-7 Keys
    \nJeep Willys Keys
    \nJeep Wrangler 1988 Keys
    \nAudi RS4 Avant Keys
    \nCadillac LMP Keys
    */
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Illegal = true
ITEM.RestrictPlayerTrade = true;
ITEM.RestrictBlackMarketSale = true;
ITEM.Cost = 125888;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
ITEM.Contains = {303,309};
ITEM.ToGive = {303,309,317,319,331,334,338,340,352,353,357,364,374,398,340,319};
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	_p:AddItemByID(ITEM.ToGive[math.random(#ITEM.ToGive)]);
	return true
end


ITEM.OnDropped = function( _p )
    return false
end 



SetupItem ( ITEM ) 