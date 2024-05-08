//print("New Properties Loaded")


/*

local PROPERTY = {};

PROPERTY.ID = 1;
 
PROPERTY.Name = "Foundainside Store";
PROPERTY.Category = "Business";
PROPERTY.Description = "A small store with two rooms and a window.";
PROPERTY.Mat	= 'fountainsidestore';

PROPERTY.Cost = 1650;

PROPERTY.PrimaryOwner = PROPERTY.PrimaryOwner || nil;
PROPERTY.Doors = 	{ 

			{ Index = 2308 ,Vector(-1219, -2436, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
			{ Index = 2495 ,Vector(-1618, -2796, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
			{ Index = 2496 ,Vector(-1354, -2937, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

					};
					
PROPERTY.OnSold = function( _p )

	_p:Notify( "You have sold " .. PROPERTY.Name )
	

end;
PROPERTY.CanBuy = function( _p )

	return true;

end; 

PROPERTY.PostCantBuy = function( _p , bool )
	if bool then // You bought it!

	else 
	
	end
end
					
PROPERTY.OnBought = function( _p )

	_p:Notify( "You have bought " .. PROPERTY.Name )


end; 


SetupProperty(PROPERTY );

local PROPERTY = {};

PROPERTY.ID = 35;
 
PROPERTY.Name = "Ghetto Club House";
PROPERTY.Category = "House";
PROPERTY.Description = "";
PROPERTY.Mat	= 'ghettohouse4';

PROPERTY.Cost = 532000;

PROPERTY.PrimaryOwner = PROPERTY.PrimaryOwner || nil;

PROPERTY.Doors = 	{ 

{  RemoveDoor = false,Index = 1355 ,Vector(2315, 382, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{  RemoveDoor = true,Index = 2539 ,Vector(2149, 108, -141.99600219727), 'models/props_c17/door01_left.mdl', '' }, 

					};
					
PROPERTY.ClubHouseInformation = {
	Desc = "A cozy house along a T-Junktion. Perfect for daily operations.";
	EnterLoc = {Vector(2297.692139, 343.692688, -188.273346),Angle(0,-90 ,0.000000)};	
	ExitLoc = {Vector(2297.416748, 438.108093  ,-188.968750),Angle(0,90,0)};	
	Tag = "gch",
	DisplayProps = {
		/*
		{"EntityClass", Vector(Position), Angle(Angle), model,Nocollide};
		*//*
		{"fsrpmonitor", Vector(1904.616 , -198.722 , -158.362 ), Angle(0.0 , 0.0 , 0 ),nil, false};
		{"wcrp_ibusinessprop", Vector(1903.08 , -187.73 , -177.316 ), Angle(0.0 , 0.0 , 0 ),"models/props_c17/furnituretable002a.mdl" ,false};
		{"fsrpcomputer", Vector(1916.458 , -236.641 , -195.497 ), Angle(0.0 , 0.0 , 0 ),nil, false};
	};	
}
SetupProperty(PROPERTY,2);


local PROPERTY = {};

PROPERTY.ID =53; 
 
PROPERTY.Name = "Outskirt Apartment";
PROPERTY.Category = "Apartment";
PROPERTY.Description = "";
PROPERTY.Mat	= 'outskirtapartment';
  
PROPERTY.Cost = 321500; 
 
PROPERTY.PrimaryOwner = PROPERTY.PrimaryOwner || nil;
PROPERTY.Doors = 	{ 
{ RemoveDoor = false,Index = 2417 ,Vector(-3284, 3619, -142), 'models/props_c17/door01_left.mdl', '' },
{ RemoveDoor = true,Index = 2427 ,Vector(-3180, 3872, -17.718799591064), 'models/props_c17/door01_left.mdl', '' },
{ RemoveDoor = true,Index = 2422 ,Vector(-3144, 3591.0900878906, -17.718799591064), 'models/props_c17/door01_left.mdl', '' },

					};
					
PROPERTY.BusinessInformation = {
	
	Type = 1;	
	Scalar = 1;	
	EnterLoc = {Vector(-3248.429443 ,3648.565918 ,-185.053741),Angle(0,90 ,0.000000)};	
	ExitLoc = {Vector(-3320.818359, 3641.880127 ,-185.968750),Angle(0,180,0)};	
	DisplayProps = {
		/*
		{"EntityClass", Vector(Position), Angle(Angle), model,Nocollide};
		*//*
	};	
	Tag = "oskrt",
	BusinessInitIdentifier = "dtstr";
	Upgrades = {
		[1] = {
			Name = "Grow Lights";
			Cost = 384000;
			Description = "Adds extra grow lights to the facility.";
			DisplayProps = {
				//{"EntityClass", Vector(Position), Angle(Angle), InvisibleUntilUpgrade, Nocollide};
			};
			GrowValueIncrease = 25;// % PERCENT
			GrowSpeedIncrease = 10; // % PERCENT
		};
		[2] = {
			Name = "Employee Lounge";
			Cost = 745000;
			Description = "Unlocks the employee lounge, allowing your workers to rest more comfortably.";
			DisplayProps = {
				//{"EntityClass", Vector(Position), Angle(Angle), InvisibleUntilUpgrade, Nocollide};
			};
			GrowValueIncrease = 20;// % PERCENT
			GrowSpeedIncrease = 50; // % PERCENT
		};	
		[3] = {
			Name = "Paid Off Deliveries";
			Cost = 554000;
			Description = "Increases the money you retain when laundering.";
			DisplayProps = {
				//{"EntityClass", Vector(Position), Angle(Angle), InvisibleUntilUpgrade, Nocollide};
			};
			GrowValueIncrease = 50;// % PERCENT
			GrowSpeedIncrease = 0; // % PERCENT
		};
	};
}

PROPERTY.OnSold = function( _p )

	_p:Notify( "You have sold " .. PROPERTY.Name )
	

end;
PROPERTY.CanBuy = function( _p )

	return true;

end; 

PROPERTY.PostCantBuy = function( _p , bool )
	if bool then // You bought it!

	else  
	
	end
end
					
PROPERTY.OnBought = function( _p )

	_p:Notify( "You have bought " .. PROPERTY.Name )


end; 


SetupProperty(PROPERTY,1);
*/
/*

local PROPERTY = {};

PROPERTY.ID = ;

PROPERTY.Name = "";
PROPERTY.Category = "Business";
PROPERTY.Description = "";
PROPERTY.Mat	= '';

PROPERTY.Cost = 1650;

PROPERTY.PrimaryOwner = PROPERTY.PrimaryOwner || nil;
PROPERTY.Doors = 	{ 

					};
					
PROPERTY.OnSold = function( _p )

	_p:Notify( "You have sold " .. PROPERTY.Name )
	

end;
PROPERTY.CanBuy = function( _p )

	return true;

end; 

PROPERTY.PostCantBuy = function( _p , bool )
	if bool then // You bought it!

	else 
	
	end
end
					
PROPERTY.OnBought = function( _p )

	_p:Notify( "You have bought " .. PROPERTY.Name )


end; 


SetupProperty(PROPERTY);

*/
// Onsold
local _os = function( self, _p ) _p:Notify( "You have sold " .. self.Name ) end
// Canbuy
local _cb = function( self, _p )	return true; end
// Post can buy
local _pcb = function( self, _p , bool ) if bool then else end end
// OnBought
local _ob = function( self, _p ) _p:Notify( "You have bought " .. self.Name ) end

/*
local _pr = {
 	ID = 80,
 	Name = "Pharmacy",
 	Category = "Business",
 	Description = "A cozy jewlery store behind spawn!",
 	Mat = "rp_southside_day0010_jewlery_store.jpg",
 	Cost = 165000,
 	Doors = {
 		{ Index = 2125 ,Vector(-6564.009765625, 3705.9899902344, 20), '*169', '' },
		{ Index = 2533 ,Vector(-6662, 3483, 28), '*304', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;	
	ClubHouseInformation = {
		Desc = "A cozy house along a T-Junktion. Perfect for daily operations.";
		EnterLoc = {Vector(-6676.163 , 3532.526 , -31.969),Angle(0,90 ,0.000000)};	
		ExitLoc = {Vector(-6705.561 , 3382.481 , -23.969),Angle(0,-90,0)};	
		Tag = "gch",
		DisplayProps = {

			{"fsrpmonitor", Vector(-6604.952 , 3568.891 , 1.101 ), Angle(0.296 , 179.622 , 0.037 ),nil, false};
			{"fsrpcomputer", Vector(-6617.107 , 3606.022 , -31.574 ), Angle(-0.365 , -176.865 , 0  ),nil, false};
		};	
	}
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr,2);


local _pr = {
 	ID = 81,
 	Name = "Hardware Store",
 	Category = "Business",
 	Description = "A cozy hardware store behind spawn!",
 	Mat = "rp_southside_day0010_jewlery_store.jpg",
 	Cost = 825000,
 	Doors = {{ Index = 2522 ,Vector(1414, -1691, -44), '*303', '' },
{ Index = 2521 ,Vector(1907.0100097656, -1750, -44), '*302', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
	ClubHouseInformation = {
		Desc = "A great location to start finding new buyers..";
		EnterLoc = {Vector(1864.937 , -1778.352 , -95.969),Angle(0,-180 ,0.000000)};	
		ExitLoc = {Vector(1974.701 , -1789.845 , -103.969),Angle(0,90,0)};	
		Tag = "abm",
		DisplayProps = {

			{"fsrpmonitor", Vector(1673.39 , -1957.013 , -60.731  ), Angle(0.296 , 90.622 , 0.037 ),nil, false};
			{"fsrpcomputer", Vector(1706.59 , -1962.23 , -62.808  ), Angle(-0.365 , 86.865 , 0  ),nil, false};
		};	
	}
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr,2);

local _pr = {
 	ID = 49,
 	Name = "Private Alley Storage",
 	Category = "Business",
 	Description = "A nice storage with 2 car capacity behind the mechanic.",
 	Mat = "rp_southside_day0039_Private_Alley_Storage.jpg",
 	Cost = 1425000,
 	Doors = {{ Index = 2654 ,Vector(-3849.0100097656, 6022, 100), '*352', '' },
{ Index = 2653 ,Vector(-3888, 6304, 160), '*351', '' },
{ Index = 2655 ,Vector(-4218, 7160.009765625, 180), '*353', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
	BusinessInformation = {		
		Type = 2;	
		Scalar = 1;	
		EnterLoc = {Vector(-3896.53 , 6049.172 , 48.031),Angle(0,180 ,0.000000)};	
		ExitLoc = {Vector( -3754.523 , 6062.36 , 48.031),Angle(0,0,0)};	
		DisplayProps = {

		};	
		Tag = "cchurch",
		BusinessInitIdentifier = "dtstr";
		Upgrades = {
		};
	}
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr,1);

local _pr = {
 	ID = 43,
 	Name = "Back Alley Workshop",
 	Category = "Business",
 	Description = "A shop tucked in to the corner of the city with a upstairs and garage.",
 	Mat = "rp_southside_day0038_Back_Alley_Workshop.jpg",
 	Cost = 365000,
 	Doors = {{ Index = 2646 ,Vector(-9338, 2953, 52), '*348', '' },
{ Index = 2645 ,Vector(-9056, 3000, 104), '*347', '' },
{ Index = 2647 ,Vector(-8712, 3702, 244), '*349', '' },


	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;				
	BusinessInformation = {		
		Type = 1;	
		Scalar = 1;	
		EnterLoc = {Vector(-9295.114 , 3007.602 , 0.031),Angle(0,90 ,0.000000)};	
		ExitLoc = {Vector(-9311.409 , 2860.29 , 0.031 ),Angle(0,-90,0)};	
		DisplayProps = {

		};	
		Tag = "oskrt",
		BusinessInitIdentifier = "dtstr";
		Upgrades = {
			[1] = {
				Name = "Grow Lights";
				Cost = 384000;
				Description = "Adds extra grow lights to the facility.";
				DisplayProps = { 
					//{"EntityClass", Vector(Position), Angle(Angle), InvisibleUntilUpgrade, Nocollide};
				};
				GrowValueIncrease = 25;// % PERCENT
				GrowSpeedIncrease = 10; // % PERCENT
			};
			[2] = {
				Name = "Employee Lounge";
				Cost = 745000;
				Description = "Unlocks the employee lounge, allowing your workers to rest more comfortably.";
				DisplayProps = {
					//{"EntityClass", Vector(Position), Angle(Angle), InvisibleUntilUpgrade, Nocollide};
				};
				GrowValueIncrease = 20;// % PERCENT
				GrowSpeedIncrease = 50; // % PERCENT
			};	
			[3] = {
				Name = "Paid Off Deliveries";
				Cost = 554000;
				Description = "Increases the money you retain when laundering.";
				DisplayProps = {
					//{"EntityClass", Vector(Position), Angle(Angle), InvisibleUntilUpgrade, Nocollide};
				};
				GrowValueIncrease = 50;// % PERCENT
				GrowSpeedIncrease = 0; // % PERCENT
			};
		};
	}
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr,1);
*/


local _pr = {
 	ID = 1,
 	Name = "Suburb Condo 2F-1",
 	Category = "Condos",
 	Description = "",
 	Mat = "subsapartments",
 	Cost = 1250,
 	Doors = {
 		{ Index = 1917 ,Vector(-360, -7901, -3), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 2,
 	Name = "Suburbs Condo 2F-2",
 	Category = "Condos",
 	Description = "",
 	Mat = "subsapartments",
 	Cost = 1500,
 	Doors = {{ Index = 1921 ,Vector(110, -7767, -3), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1916 ,Vector(260, -7901, -3), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 3,
 	Name = "Suburbs Condo 3F-2",
 	Category = "Condos",
 	Description = "",
 	Mat = "subsapartments",
 	Cost = 1750,
 	Doors = {{ Index = 1914 ,Vector(190, -7767, 133), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1915 ,Vector(-8, -7901, 133), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 4,
 	Name = "Suburbs Condo 3F-1",
 	Category = "Condos",
 	Description = "",
 	Mat = "subsapartments",
 	Cost = 1750,
 	Doors = {{ Index = 1910 ,Vector(-302, -7771, 132.75), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1912 ,Vector(-164, -7901, 133), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr); 
local _pr = {
 	ID = 5,
 	Name = "Suburbs Workshop",
 	Category = "Houses",
 	Description = "",
 	Mat = "",
 	Cost = 3200,
 	Doors = {
 		{ Index = 1924 ,Vector(-1872.5, -7538, -139), '*122', '' },
		{ Index = 1907 ,Vector(-2219, -7311, -143), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1908 ,Vector(-1791, -7728.8198242188, -143), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1961 ,Vector(-2222, -7659, -11), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 6,
 	Name = "Suburbs Corner House",
 	Category = "Houses",
 	Description = "",
 	Mat = "",
 	Cost = 4125,
 	Doors = {
 		{ Index = 2247 ,Vector(-2355, -7829, -109), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2248 ,Vector(-2762, -7790, -109), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2458 ,Vector(-3069, -7931, -109), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 7,
 	Name = "Suburbs House",
 	Category = "Houses",
 	Description = "",
 	Mat = "",
 	Cost = 5000,
 	Doors = {
 		{ Index = 1252 ,Vector(-326, -5312, -142.43699645996), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1250 ,Vector(-564, -5168, -142.43699645996), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1251 ,Vector(-726.17999267578, -4994, -143.43699645996), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1247 ,Vector(-609, -5270, -14.437700271606), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1246 ,Vector(-456, -5209, -14.437700271606), 'models/props_c17/door01_left.mdl', '' },
	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 8,
 	Name = "Suburbs Side Condo 1F-1",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {
 		{ Index = 2442 ,Vector(-3116, -6806, -143), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2447 ,Vector(-3500, -7136, -143), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 9,
 	Name = "Suburbs Side Condo 2F-1",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2441 ,Vector(-3116, -7137, -7), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2446 ,Vector(-3500, -7136, -7), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 10,
 	Name = "Suburbs Side Condo 1F-2",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2443 ,Vector(-3116, -6537, -143), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2448 ,Vector(-3500, -6204, -143), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 11,
 	Name = "Suburbs Side Condo 2F-2",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2444 ,Vector(-3116, -6206, -7), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2445 ,Vector(-3500, -6204, -7), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 12,
 	Name = "Suburbs Side Condo 2F-3",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2449 ,Vector(-3116, -6028, -7), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2454 ,Vector(-3500, -6027, -7), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 13,
 	Name = "Suburbs Side Condo 1F-3",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2450 ,Vector(-3116, -5697, -143), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2455 ,Vector(-3500, -6027, -143), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 14,
 	Name = "Suburbs Side Condo 1F-4",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2451 ,Vector(-3116, -5428, -143), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2456 ,Vector(-3500, -5095, -143), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 15,
 	Name = "Suburbs Side Condo 2F-4",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 2452 ,Vector(-3116, -5097, -7), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2453 ,Vector(-3500, -5095, -7), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 16,
 	Name = "Suburbs Bungalow #1",
 	Category = "Bungalows",
 	Description = "",
 	Mat = "",
 	Cost = 1000,
 	Doors = {{ Index = 1243 ,Vector(-299, -6539, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1255 ,Vector(-624.82000732422, -6480, -144.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 17,
 	Name = "Suburbs Bungalow #2",
 	Category = "Bungalows",
 	Description = "",
 	Mat = "",
 	Cost = 1000,
 	Doors = {{ Index = 1240 ,Vector(-299, -6277, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1244 ,Vector(-624, -6186, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 18,
 	Name = "Suburbs Bungalow #3",
 	Category = "Bungalows",
 	Description = "",
 	Mat = "",
 	Cost = 1000,
 	Doors = {{ Index = 1241 ,Vector(-298.10000610352, -5943, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1236 ,Vector(-624, -5924, -144.71699523926), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 19,
 	Name = "Flooded Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 850,
 	Doors = {{ Index = 3397 ,Vector(542, -5447, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3398 ,Vector(542, -5353, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 20,
 	Name = "Suburbs Corner Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 5400,
 	Doors = {
 		{ Index = 3396 ,Vector(980, -4481, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3395 ,Vector(980, -4575, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 21,
 	Name = "Suburb Jungle Apt. #2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 6000,
 	Doors = {
 		{ Index = 3256 ,Vector(-1773, -3377, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3255 ,Vector(-1773, -3471, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3262 ,Vector(-1676, -3952, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3261 ,Vector(-1770, -3952, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3266 ,Vector(-1531, -3665, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3265 ,Vector(-1531, -3759, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3269 ,Vector(-1773, -4071, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3268 ,Vector(-1027, -3759, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3267 ,Vector(-1027, -3665, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3249 ,Vector(-1167, -4079, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3250 ,Vector(-1073, -4079, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3263 ,Vector(-454, -3952, 0), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3264 ,Vector(-548, -3952, 0), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 22,
 	Name = "Suburb Jungle Apt. #1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 4500,
 	Doors = {{ Index = 3254 ,Vector(-1771, -3596, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3253 ,Vector(-1771, -3690, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3259 ,Vector(-1489, -4079, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3260 ,Vector(-1583, -4079, -142), 'models/props_c17/door01_left.mdl', '' },


	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 23,
 	Name = "Suburb Jungle Apt. #3",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 4750,
 	Doors = {
 		{ Index = 3248 ,Vector(-1583, -4079, 128), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3247 ,Vector(-1489, -4079, 128), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3273 ,Vector(-1241, -3755, 128), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3272 ,Vector(-1241, -3661, 128), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 24,
 	Name = "Suburb Jungle Apt. #4",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 5000,
 	Doors = {
 		{ Index = 3873 ,Vector(-1267, -4132, 266), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3258 ,Vector(-1925, -3369, 255), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3257 ,Vector(-1925, -3463, 255), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 25,
 	Name = "Island Mansion",
 	Category = "Mansions",
 	Description = "",
 	Mat = "",
 	Cost = 12500,
 	Doors = {
 		{ Index = 1265 ,Vector(12143, -8776, -254), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1266 ,Vector(12049, -8776, -254), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1268 ,Vector(12616, -8481, -94), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1267 ,Vector(12616, -8575, -94), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 26,
 	Name = "Beachfront Mansion",
 	Category = "Mansions",
 	Description = "",
 	Mat = "",
 	Cost = 8000,
 	Doors = {{ Index = 3159 ,Vector(4630, -4596, -254), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3158 ,Vector(4724, -4596, -254), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3107 ,Vector(4973, -5039, -254), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3106 ,Vector(4973, -4945, -254), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3104 ,Vector(4973, -5039, -94), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3105 ,Vector(4973, -4945, -94), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 27,
 	Name = "Beachfront Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 3200,
 	Doors = {
 		{ Index = 1614 ,Vector(2377, -2263, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 28,
 	Name = "Beachfront Storage Unit",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 1700,
 	Doors = {{ Index = 1613 ,Vector(2377, -1639, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 29,
 	Name = "Park Tunnel Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 3000,
 	Doors = {{ Index = 1607 ,Vector(2376, -1454, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 30,
 	Name = "Park Condo",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 2200,
 	Doors = {
 		{ Index = 2164 ,Vector(1980, 1510, -145.91999816895), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2163 ,Vector(1980, 1416, -145.91999816895), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2175 ,Vector(1619, 1528, -145.91999816895), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2176 ,Vector(1486, 1810, -145.91999816895), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 31,
 	Name = "Dilapitated House",
 	Category = "House",
 	Description = "",
 	Mat = "",
 	Cost = 4900,
 	Doors = {
 		{ Index = 2296 ,Vector(5531.1801757813, 1731.6300048828, -140), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2297 ,Vector(5753.2099609375, 2225.1899414063, -140), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 32,
 	Name = "Central Ghetto Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 2000,
 	Doors = {{ Index = 1743 ,Vector(4104.08984375, 3382, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1744 ,Vector(3928.0900878906, 3561, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1745 ,Vector(3928.0900878906, 3372, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1746 ,Vector(3857.0900878906, 3183, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 33,
 	Name = "Ghetto Shop",
 	Category = "Small Shops",
 	Description = "",
 	Mat = "",
 	Cost = 2800,
 	Doors = {
 		{ Index = 1763 ,Vector(2319, 3443, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1765 ,Vector(2047, 3517, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1764 ,Vector(1795, 3575, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 34,
 	Name = "Ghetto Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 2400,
 	Doors = {{ Index = 1786 ,Vector(2223, 2709, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1758 ,Vector(1795, 2807, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 35,
 	Name = "Alleyway Ghetto Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 4000,
 	Doors = {{ Index = 1860 ,Vector(3675, 2485, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1861 ,Vector(3631, 2379, -8.71875), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1863 ,Vector(3625, 2127, -8.71875), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1862 ,Vector(3511, 2127, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 36,
 	Name = "Northern Petrol Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 7250,
 	Doors = {
 		{ Index = 1789 ,Vector(4954.91015625, 3300.7199707031, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1790 ,Vector(4954.91015625, 3206.7199707031, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1798 ,Vector(5112, 3161.9099121094, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID =37 ,
 	Name = "Ghetto Apt. 2F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1804 ,Vector(3101, 4812, 54), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1805 ,Vector(2612, 4657, 54), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 38,
 	Name = "Ghetto Apt. -1F-3",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1814 ,Vector(3007, 4677, -218), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 39,
 	Name = "Ghetto Apt. -1F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1812 ,Vector(3237, 4601, -218), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 40,
 	Name = "Ghetto Apt. -1F-2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1813 ,Vector(3007, 4358, -218), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 41,
 	Name = "Ghetto Apt. 1F-4",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1808 ,Vector(3269, 4785, -82), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 42,
 	Name = "Ghetto Apt. 1F-3",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1891 ,Vector(2949, 4785, -82), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 43,
 	Name = "Ghetto Apt. 1F-2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1806 ,Vector(2565, 4785, -82), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 44,
 	Name = "Ghetto Apt. 1F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 900,
 	Doors = {{ Index = 1807 ,Vector(2565, 4657, -82), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 45,
 	Name = "Outskirt Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 5300,
 	Doors = {{ Index = 3580 ,Vector(2561, 6178, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3581 ,Vector(2561, 6271.9702148438, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 46,
 	Name = "Strip Club",
 	Category = "Unique",
 	Description = "",
 	Mat = "",
 	Cost = 10000,
 	Doors = {{ Index = 3152 ,Vector(3262, 7182, -118), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3153 ,Vector(3262, 7276, -118), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3127 ,Vector(2810, 6870, -120), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3131 ,Vector(2661, 7294, -118), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3157 ,Vector(2577, 7590, -118), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 47,
 	Name = "Outskirt Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 2300,
 	Doors = {{ Index = 2538 ,Vector(2017, 5886, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2540 ,Vector(1851, 5612, -141.99600219727), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2563 ,Vector(1645, 5422, -141.99600219727), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 48,
 	Name = "Church",
 	Category = "Unique",
 	Description = "",
 	Mat = "",
 	Cost = 8250,
 	Doors = {{ Index = 2840 ,Vector(1253, 5155, -130), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2839 ,Vector(1347, 5155, -130), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2835 ,Vector(1323, 4972, 30), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 49,
 	Name = "Outskirt Storage Space",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 1200,
 	Doors = {{ Index = 2333 ,Vector(1727, 6495, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2334 ,Vector(1633.0300292969, 6495, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 50,
 	Name = "Outskirt Shop",
 	Category = "Small Shops",
 	Description = "",
 	Mat = "",
 	Cost = 7400,
 	Doors = {{ Index = 2370 ,Vector(800.96002197266, 6468.08984375, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2371 ,Vector(707.03997802734, 6468.08984375, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2362 ,Vector(506.08999633789, 6714, -141.36599731445), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2361 ,Vector(570, 6769, -141.36599731445), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2360 ,Vector(953, 6777, -5.3662099838257), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2368 ,Vector(587, 6514, 2.6337900161743), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2369 ,Vector(587, 6634, 2.6337900161743), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 51,
 	Name = "Brick Apt. 2F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1400,
 	Doors = {{ Index = 2379 ,Vector(369, 7952, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2856 ,Vector(233, 7747, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 52,
 	Name = "Brick Apt. 2F-2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1400,
 	Doors = {{ Index = 2378 ,Vector(673, 7952, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2854 ,Vector(641, 7747, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 53,
 	Name = "Brick Apt. 2F-3",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1400,
 	Doors = {{ Index = 2377 ,Vector(977, 7952, -2), 'models/props_c17/door01_left.mdl', '' },

{ Index = 2852 ,Vector(945, 7747, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 54,
 	Name = "Brick Apt. 2F-4",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1400,
 	Doors = {{ Index = 2374 ,Vector(1583, 7952, -2), 'models/props_c17/door01_left.mdl', '' },

{ Index = 2850 ,Vector(1353, 7747, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 55,
 	Name = "Brick Apt. 2F-5",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1400,
 	Doors = {{ Index = 2375 ,Vector(1887, 7952, -2), 'models/props_c17/door01_left.mdl', '' },

{ Index = 2848 ,Vector(1657, 7747, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 56,
 	Name = "Brick Apt. 1F-6",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1400,
 	Doors = {{ Index = 2376 ,Vector(2191, 7952, -2), 'models/props_c17/door01_left.mdl', '' },

{ Index = 2846 ,Vector(1961, 7747, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 57,
 	Name = "Outskirt Apt. 2F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2861 ,Vector(-473, 7416, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2891 ,Vector(-268, 7448, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 58,
 	Name = "Outskirt Apt. 2F-2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2878 ,Vector(-632, 7368, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2893 ,Vector(-837, 7400, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 59,
 	Name = "Outskirt Apt. 2F-3",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2860 ,Vector(-473, 7112, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2889 ,Vector(-268, 7144, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 60,
 	Name = "Outskirt Apt. 2F-4",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2877 ,Vector(-632, 7064, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2895 ,Vector(-837, 7096, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 61,
 	Name = "Outskirt Apt. 2F-5",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2863 ,Vector(-473, 6202, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2885 ,Vector(-268, 6432, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 62,
 	Name = "Outskirt Apt. 2F-6",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2876 ,Vector(-632, 6250, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2899 ,Vector(-837, 6480, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 63,
 	Name = "Outskirt Apt. 2F-7",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2862 ,Vector(-473, 6506, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2887 ,Vector(-268, 6736, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 64,
 	Name = "Outskirt Apt. 2F-8",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 1800,
 	Doors = {{ Index = 2875 ,Vector(-632, 6554, -2), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2897 ,Vector(-837, 6784, -2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 65,
 	Name = "Playground Townhouse",
 	Category = "Townhouses",
 	Description = "",
 	Mat = "",
 	Cost = 3450,
 	Doors = {{ Index = 2566 ,Vector(653, 5791, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2573 ,Vector(748, 5363, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 66,
 	Name = "Small Industrial Shop - Downstairs",
 	Category = "Large Shops",
 	Description = "",
 	Mat = "",
 	Cost = 7500,
 	Doors = {{ Index = 1685 ,Vector(1007, 3698, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1684 ,Vector(913, 3698, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1686 ,Vector(937, 3439, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1688 ,Vector(1450, 3439, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1690 ,Vector(1461, 3299, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1689 ,Vector(833, 3325, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1691 ,Vector(917, 2879, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1722 ,Vector(1337, 2653, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 67,
 	Name = "Small Industrial Shop - Upstairs",
 	Category = "Large Shops",
 	Description = "",
 	Mat = "",
 	Cost = 3500,
 	Doors = {{ Index = 1723 ,Vector(1065, 2913, 14), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1738 ,Vector(798, 3388, 14), '*92', '' },
{ Index = 1737 ,Vector(698, 3388, 14), '*91', '' },
{ Index = 1724 ,Vector(1225, 3013, 14), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 68,
 	Name = "Small Industrial Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 6500,
 	Doors = {{ Index = 1565 ,Vector(-523, 3286, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1563 ,Vector(-526.5, 3586, -102), '*59', '' },
{ Index = 1564 ,Vector(-526.5, 3820, -102), '*60', '' },
{ Index = 1680 ,Vector(-995, 3391, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 69,
 	Name = "Bar",
 	Category = "Unique",
 	Description = "",
 	Mat = "",
 	Cost = 7850,
 	Doors = {{ Index = 1469 ,Vector(497, 1609, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1468 ,Vector(987, 1543, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1854 ,Vector(923, 1759, 2), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 70,
 	Name = "Marr Freight Company Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 9000,
 	Doors = {{ Index = 1561 ,Vector(-17, 1519, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1562 ,Vector(-17, 1425, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1407 ,Vector(-200, 1222, -125), '*13', '' },
{ Index = 1406 ,Vector(-96, 1222, -125), '*12', '' },
{ Index = 1355 ,Vector(-269, 1017, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1356 ,Vector(-269, 1111, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1373 ,Vector(-500, 976.5, -78), '*5', '' },
{ Index = 1371 ,Vector(-651, 970, -86), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 71,
 	Name = "Cafe Baltic",
 	Category = "Large Shops",
 	Description = "",
 	Mat = "",
 	Cost = 5900,
 	Doors = {{ Index = 1416 ,Vector(-1005.9299926758, 308.36401367188, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1601 ,Vector(-842, 87, 250), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 72,
 	Name = "Parker Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 3650,
 	Doors = {{ Index = 1354 ,Vector(-1441, 428, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1353 ,Vector(-1441, 522, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1465 ,Vector(-1439.5, 653, -102), '*30', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 73,
 	Name = "Back Alley Condo",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 2300,
 	Doors = {{ Index = 2131 ,Vector(-888, 1988, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2136 ,Vector(-1001, 1627, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 74,
 	Name = "J&M Glass Company Shop",
 	Category = "Large Shops",
 	Description = "",
 	Mat = "",
 	Cost = 11000,
 	Doors = {{ Index = 3385 ,Vector(-1030, -365, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3993 ,Vector(-589, -376, 15), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3994 ,Vector(-589, -736, 15), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 75,
 	Name = "J&M Glass Company Storage",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 4000,
 	Doors = {
 		{ Index = 2246 ,Vector(-1030, -620, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2142 ,Vector(-1034.9899902344, -818, -134), '*154', '' },
{ Index = 2195 ,Vector(-505, -742, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 76,
 	Name = "Fountain-side Shop",
 	Category = "Small Shops",
 	Description = "",
 	Mat = "",
 	Cost = 3000,
 	Doors = {{ Index = 2706 ,Vector(-1741.4699707031, -762.35198974609, -142.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2707 ,Vector(-1835.4699707031, -762.35198974609, -142.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2667 ,Vector(-1958.0300292969, -456.0119934082, -143), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 77,
 	Name = "Overlook Shop",
 	Category = "Small Shops",
 	Description = "",
 	Mat = "",
 	Cost = 3200,
 	Doors = {{ Index = 2706 ,Vector(-1741.4699707031, -762.35198974609, -142.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2707 ,Vector(-1835.4699707031, -762.35198974609, -142.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2667 ,Vector(-1958.0300292969, -456.0119934082, -143), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 78,
 	Name = "Fountain-side Storage Locker",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 750,
 	Doors = {{ Index = 2118 ,Vector(-1818, -2821, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2121 ,Vector(-1818, -3065, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 79,
 	Name = "The Overlook",
 	Category = "Mansion",
 	Description = "",
 	Mat = "",
 	Cost = 14000,
 	Doors = {{ Index = 2642 ,Vector(-1886.0300292969, -518.00201416016, 13), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2703 ,Vector(-2008.4699707031, -422.35198974609, 13.281000137329), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2647 ,Vector(-1966.0300292969, -156.00199890137, 13), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2646 ,Vector(-1972.0300292969, -498.00201416016, 141), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2653 ,Vector(-1978.0300292969, -350.00201416016, 285), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 80,
 	Name = "Downtown Apt. - Janitor Closet",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 800,
 	Doors = {{ Index = 1461 ,Vector(-818, -1363, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 81,
 	Name = "Downtown Apt. 2F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 2400,
 	Doors = {{ Index = 1447 ,Vector(-810, -1300, -5.7186999320984), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2100 ,Vector(-883, -1005, -5.71875), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2098 ,Vector(-1028, -1303, -5.7187600135803), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 82,
 	Name = "Downtown Apt. 3F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 2800,
 	Doors = {{ Index = 1446 ,Vector(-810, -1303, 122), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2099 ,Vector(-883, -1005, 122), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1957 ,Vector(-1028, -1303, 122), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 83,
 	Name = "Downtown Apt. 4F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 3300,
 	Doors = {{ Index = 1445 ,Vector(-810, -1303, 250), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1440 ,Vector(-882.9990234375, -1005, 250), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 84,
 	Name = "Downtown Apt. - 5F-1",
 	Category = "Penthouses",
 	Description = "",
 	Mat = "",
 	Cost = 6000,
 	Doors = {{ Index = 1448 ,Vector(-810, -1303, 378), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1560 ,Vector(-798, -920.15002441406, 378), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1453 ,Vector(-853, -941, 506), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2096 ,Vector(-853, -1133, 506.28100585938), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 85,
 	Name = "Fountain Apt. 2F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 3400,
 	Doors = {{ Index = 1497 ,Vector(-872, -2086, -14), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1530 ,Vector(-1034, -2242, -14), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 86,
 	Name = "Fountain Apt. 2F-2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 3400,
 	Doors = {{ Index = 1498 ,Vector(-872, -1702, -14), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1507 ,Vector(-1034, -1672, -14), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 87,
 	Name = "Fountain Apt. 3F-1",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 3600,
 	Doors = {{ Index = 1481 ,Vector(-872, -1702, 114), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1508 ,Vector(-1034, -1672, 114), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 88,
 	Name = "Fountain Apt. 3F-2",
 	Category = "Apartments",
 	Description = "",
 	Mat = "",
 	Cost = 3600,
 	Doors = {{ Index = 1482 ,Vector(-872, -1958, 114), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1532 ,Vector(-1034, -2242, 114), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 89,
 	Name = "Container Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 6000,
 	Doors = {{ Index = 2773 ,Vector(-2415, 2188, -150), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2774 ,Vector(-2556, 2433, -150), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2775 ,Vector(-2556, 2527, -150), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2732 ,Vector(-3276.9899902344, 2185.9899902344, -142), '*200', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 90,
 	Name = "Long Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 6500,
 	Doors = {{ Index = 2043 ,Vector(-3281, 3249, -157.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2042 ,Vector(-3281, 3343, -157.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2077 ,Vector(-3279.9899902344, 2864, -142), '*150', '' },
{ Index = 2082 ,Vector(-2837, 2705, -150), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3346 ,Vector(-2837, 2799, -150), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 91,
 	Name = "Industrial Workshop",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 5500,
 	Doors = {{ Index = 2165 ,Vector(-3973.0100097656, 1844.0100097656, -142), '*158', '' },
{ Index = 2173 ,Vector(-4508, 1864, -149.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2085 ,Vector(-4444, 2618, -150), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 92,
 	Name = "Yellow Steel Warehouse",
 	Category = "Warehouses",
 	Description = "",
 	Mat = "",
 	Cost = 6200,
 	Doors = {{ Index = 2046 ,Vector(-3973.9899902344, 3280, -142), '*148', '' },
{ Index = 2045 ,Vector(-3971, 3365, -150), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2044 ,Vector(-3973.9899902344, 3496, -142), '*147', '' },
{ Index = 2083 ,Vector(-4908, 3495, -149.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 93,
 	Name = "Garage",
 	Category = "Garages",
 	Description = "",
 	Mat = "",
 	Cost = 8000,
 	Doors = {{ Index = 3518 ,Vector(-3809.0100097656, 4189.990234375, -148), '*277', '' },
{ Index = 3516 ,Vector(-3442, 4191, -157.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3517 ,Vector(-3536, 4191, -157.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 94,
 	Name = "Industrial Corner Garage",
 	Category = "Garages",
 	Description = "",
 	Mat = "",
 	Cost = 3000,
 	Doors = {{ Index = 3887 ,Vector(-5640.009765625, 4036, -142), '*289', '' },
{ Index = 3882 ,Vector(-5637, 4121, -150), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 95,
 	Name = "Sewer Warehouse #1",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 8500,
 	Doors = {{ Index = 2995 ,Vector(-497, 3061, -602), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 96,
 	Name = "Sewer Warehouse #2",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 6500,
 	Doors = {{ Index = 3473 ,Vector(97, 2664, -602), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 97,
 	Name = "Sewer Warehouse #3",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 12000,
 	Doors = {{ Index = 2969 ,Vector(104, 1751, -602), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2968 ,Vector(104, 1845, -602), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2970 ,Vector(104, 1568, -606), '*228', '' },
{ Index = 2972 ,Vector(508, 2038, -602), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2971 ,Vector(508, 2132, -602), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2977 ,Vector(780, 2065, -386), 'models/props_c17/door01_left.mdl', '' }, 
	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 98,
 	Name = "Broken Track Lookout",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 4000,
 	Doors = {{ Index = 2938 ,Vector(-177, 103, -602), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 99,
 	Name = "Broken Track Storage",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 3800,
 	Doors = {{ Index = 2939 ,Vector(-223, 201, -602), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 100,
 	Name = "Park Shop",
 	Category = "Small Shops",
 	Description = "",
 	Mat = "",
 	Cost = 2500,
 	Doors = {{ Index = 2304 ,Vector(2987, 1980, -141.90899658203), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2303 ,Vector(3081, 1980, -141.90899658203), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 101,
 	Name = "Hidden Room",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 4000,
 	Doors = {{ Index = 1584 ,Vector(-235, -2162, -97), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1667 ,Vector(-326, -2533, -97), 'models/props_c17/door01_left.mdl', '' },
	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 102,
 	Name = "Small Industrial Space",
 	Category = "Warehouse",
 	Description = "",
 	Mat = "",
 	Cost = 2500,
 	Doors = {{ Index = 2211 ,Vector(1004, -358, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2210 ,Vector(910, -358, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2212 ,Vector(1058, -306, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 103,
 	Name = "Large Industrial Space",
 	Category = "Warehouse",
 	Description = "",
 	Mat = "",
 	Cost =5000 ,
 	Doors = {{ Index = 1585 ,Vector(955, -1487.9100341797, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1586 ,Vector(861, -1487.9100341797, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1872 ,Vector(815.90899658203, -1645, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1588 ,Vector(360.48999023438, -1946, -78), '*72', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
local _pr = {
 	ID = 104,
 	Name = "Fountain-side Shop",
 	Category = "Large Shops",
 	Description = "",
 	Mat = "",
 	Cost = 7000,
 	Doors = {{ Index = 1985 ,Vector(-1219, -2436, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2114 ,Vector(-1618, -2796, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2115 ,Vector(-1354, -2937, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 105,
 	Name = "Uptown Shop",
 	Category = "Small Shops",
 	Description = "",
 	Mat = "",
 	Cost = 1250,
 	Doors = {{ Index = 1390 ,Vector(694, 404, -114), '*8', '' },
{ Index = 1385 ,Vector(563, 407, -142), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 106,
 	Name = "Uptown Condo",
 	Category = "Condos",
 	Description = "",
 	Mat = "",
 	Cost = 4000,
 	Doors = {{ Index = 2168 ,Vector(150, 215, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2172 ,Vector(78, -92, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2171 ,Vector(428, 170, -145.71899414063), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 107,
 	Name = "Uptown Lookout",
 	Category = "Unique",
 	Description = "",
 	Mat = "",
 	Cost = 8000,
 	Doors = {{ Index = 1600 ,Vector(-190, 402.90899658203, -138), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1615 ,Vector(-305, 63, -10), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1616 ,Vector(-305, 63, 118), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 108,
 	Name = "Safe X-Change",
 	Category = "Unique",
 	Description = "",
 	Mat = "",
 	Cost = 12000,
 	Doors = {
{ Index = 1391 ,Vector(497, 1139, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1393 ,Vector(714, 1251.5, -136), '*9', '' },

{ Index = 1415 ,Vector(766, 1251.5, -105), '*20', '' },
{ Index = 1392 ,Vector(837, 1279, -142), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1858 ,Vector(509, 1041, -14), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 109,
 	Name = "Hidden Hole",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 4000,
 	Doors = {{ Index = 2940 ,Vector(-153, -1627, -656), 'models/props_c17/door01_left.mdl', '' },
{ Index = 2941 ,Vector(-247, -1627, -656), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 110,
 	Name = "Thieves Storeway #1",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 8500,
 	Doors = {{ Index = 3024 ,Vector(-196, 3089, -383), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3025 ,Vector(-196, 3183, -383), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 111,
 	Name = "Thieves Storeway #2",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 8500,
 	Doors = {{ Index = 3028 ,Vector(-140, 2181, -383), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3029 ,Vector(-140, 2275, -383), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);

local _pr = {
 	ID = 112,
 	Name = "Thieves Storeway #3",
 	Category = "Sewers",
 	Description = "",
 	Mat = "",
 	Cost = 8500,
 	Doors = {{ Index = 3027 ,Vector(-548, 2591, -383), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3026 ,Vector(-548, 2497, -383), 'models/props_c17/door01_left.mdl', '' },

	},
	OnSold = _os;
	CanBuy = _cb; 
	PostCanBuy = _pcb;
	OnBought = _ob;
}
_pr.PrimaryOwner = fsrp.PropertyTable[_pr.ID] and fsrp.PropertyTable[_pr.ID].PrimaryOwner or nil,
SetupProperty(_pr);
