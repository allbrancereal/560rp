
local Business 					= {};

Business.ID = 					1;

Business.Name = 				"Airport";

Business.Description = 		"A lucrative Business";

Business.Shares = 				fsrp.config.MaxAirportShares;
Business.Pos	= Vector(654.310, -797.532, -79.968);
Business.Price	=				100;
Business.Interest		= 0.05
Business.Payday =	Business.Price * 0.1;
Business.Upgrades =			{
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

Business.LevelUpString = { 
	"You have been better, but it's a start. Your Business is level 2!",
	"Congratulations, the crew is happy to see that we have gained so much support! Your Business is level 3!",
	"We did it boss! Through hard trial and efforts we finally done it! Your Business is level 4",
};
Business.PaydayXP = 20
Business.XPTable = {
	1000,
	2500,
	5000,
};

// when they attempt to buy
Business.OnSold = function( _p )



end

// bool to determine whether they can buy 
Business.CanBuy = function( _p , amt )
				if !_p:NearNPC( "bu_airport") then return false end
				
				if _p:getShares( Business.ID ).shares + amt > Business.Shares then 
					
						_p:Notify("You can not buy more shares than the limit")
						
					return false
					
				end
				
				local _total = Business.Price * amt;
		
				if !_p:canAffordBank( _total ) then
				
					_p:Notify( "You do not have enough money to buy x" .. amt .. " " .. Business.Name .. " stock!" )
					return false
				end  
				
				return true;
end

// Runs both when bought and not
Business.PostCanBuy = function( _p , bool )
	if bool then // You bought it!
		if !_p:IsOnQuest( 3 ) then
		
			_p:RewardQuest( 3 )
			
		end
		else // You couldn't buy it!

	end
end

// runs when the buy went thru
Business.OnBought = function( _p )

	if !_p:IsOnQuest( 3 ) then
		
		_p:RewardQuest( 3 )
			
	end


end

fsrp.SetupBusiness( Business );

if SERVER then

	net.Receive( "buyairportMarketShare" , function ( len , _p )

		loadBusinesses( _p )
		_p:buyStock( 1, net.ReadInt(5) );	
		
		saveBusinesses( _p )
		
	
	end)
	
end