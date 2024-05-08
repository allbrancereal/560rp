
local Business 					= {};

Business.ID = 					2;

Business.Name = 				"Bank";

Business.Description = 		"A lucrative Business";

Business.Shares = 				fsrp.config.MaxBankShares;
Business.Pos	= Vector(929.634, -707.054, -79.965);
Business.Price	=				225;
Business.Payday =	Business.Price * 0.1;

// when they attempt to buy
Business.OnSold = function( _p )



end

// bool to determine whether they can buy 
Business.CanBuy = function( _p , amt )
				if !_p:NearNPC( "bu_bank") then return false end
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
	
		else // You couldn't buy it!

	end
end

// runs when the buy went thru
Business.OnBought = function( _p )



end
Business.Upgrades =			{
  ["upgrade_1"] = {
    name = "Big Vault",
    cost = 125000,
    sharereq = 2500,
  },
  ["upgrade_2"] = {
    name = "Increased Security",
    cost = 500000,
    sharereq = 5000,
  },
};

Business.PaydayXP = 18
Business.XPTable = {
	1000,
	2500,
	5000,
};
Business.LevelUpString = { 
	"You have been better, but it's a start. Your Business is level 2!",
	"Congratulations, the crew is happy to see that we have gained so much support! Your Business is level 3!",
	"We did it boss! Through hard trial and efforts we finally done it! Your Business is level 4",
};

fsrp.SetupBusiness( Business );

if SERVER then

	net.Receive( "buybankMarketShare" , function ( len , _p )

		loadBusinesses( _p )
		_p:buyStock( 2, net.ReadInt(5) );	
		
		saveBusinesses( _p )
		
	
	end)
	
end