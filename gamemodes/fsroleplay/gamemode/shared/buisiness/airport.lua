
local BUISINESS 					= {};

BUISINESS.ID = 					1;

BUISINESS.Name = 				"Airport";

BUISINESS.Description = 		"A lucrative buisiness";

BUISINESS.Shares = 				MAX_AIRPORT_SHARES;
BUISINESS.Pos	= Vector(654.310, -797.532, -79.968);
BUISINESS.Price	=				100;
BUISINESS.Interest		= 0.05
BUISINESS.Payday =	BUISINESS.Price * 0.1;
BUISINESS.Upgrades =			{
  ["upgrade_1"] = {
    name = "Tower",
    cost = 50000,
    sharereq = 350,
  },
  ["upgrade_2"] = {
    name = "Second Terminal",
    cost = 250000,
    sharereq = 500,
  },
};

BUISINESS.LevelUpString = { 
	"You have been better, but it's a start. Your buisiness is level 2!",
	"Congratulations, the crew is happy to see that we have gained so much support! Your buisiness is level 3!",
	"We did it boss! Through hard trial and efforts we finally done it! Your buisiness is level 4",
};
BUISINESS.PaydayXP = 5
BUISINESS.XPTable = {
	1000,
	2500,
	5000,
};

// when they attempt to buy
BUISINESS.OnSold = function( _p )



end

// bool to determine whether they can buy 
BUISINESS.CanBuy = function( _p , amt )

				if _p:getShares( BUISINESS.ID ).shares + amt > BUISINESS.Shares then 
					
						_p:Notify("You can not buy more shares than the limit")
						
					return false
					
				end
				
				local _total = BUISINESS.Price * amt;
		
				if !_p:canAffordBank( _total ) then
				
					_p:Notify( "You do not have enough money to buy x" .. amt .. " " .. BUISINESS.Name .. " stock!" )
					return false
				end  
				
				return true;
end

// Runs both when bought and not
BUISINESS.PostCanBuy = function( _p , bool )
	if bool then // You bought it!
		if !_p:IsOnQuest( 3 ) then
		
			_p:RewardQuest( 3 )
			
		end
		else // You couldn't buy it!

	end
end

// runs when the buy went thru
BUISINESS.OnBought = function( _p )

	if !_p:IsOnQuest( 3 ) then
		
		_p:RewardQuest( 3 )
			
	end


end

fsrp.SetupBuisiness( BUISINESS );

if SERVER then

	net.Receive( "buyairportMarketShare" , function ( len , _p )

		loadBuisinesses( _p )
		_p:buyStock( 1, net.ReadInt(5) );	
		
		saveBuisinesses( _p )
		
	
	end)
	
end