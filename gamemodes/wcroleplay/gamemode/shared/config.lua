
fsrp.config = fsrp.config or {}
fsrp.config.showCatDebug = true
fsrp.mining = fsrp.mining || {} 
fsrp.mining.config = {};
fsrp.mining.cache = {};
fsrp.config.atmfeesurcharge = {
	[1] = {0.025,0.05,25};-- interest on payday, fee on withdrawal, fee on payday
	[2] = {0.005,0.0125,25};
	[3] = {0.01, 0.002,150};
}
fsrp.mining.cache.SpawnedRocks = {};
fsrp.stores = fsrp.stores or {};
fsrp.config.TradeSlots = 16;
fsrp.config.PropertyInvestmentMin = 20// 5 times the property value to invest in it.
fsrp.config.PropertyInvestmentReturn = 12.5// 5 times the property value to invest in it.
fsrp.config.PropertyInvestmentMaxLevels = 3 // how many times can a property return investment
fsrp.config.PropertyIncome = 15 // percent of the property worth to return per upgrade level
fsrp.config.PropertyMinPricePerc = 25 // percent of the property worth to return per upgrade level
fsrp.config.SalePerLevel = 10 // percent of the property worth to return per upgrade level
function Print(...)
	if select("#", ...) == 1	-- only 1 element
		and type(...) == "table"	-- which is a table
		and (getmetatable(...) == nil or not debug.getmetatable(...).__tostring)	-- that has no custom tostring function
	then
		PrintTable(...)
	else
		print(...)
	end
end
fsrp.config.Printer = fsrp.config.Printer or {}
fsrp.config.Printer.SupplyAmount 	= 5000; -- determines how long a supply works for
fsrp.config.Printer.Cost 			= 25; -- determines how much a print will cost
fsrp.config.Printer.Time 			= 8; -- time per print
fsrp.config.Printer.Amount 			= 150; -- amount a money bag will be printing
fsrp.config.Printer.MaxPrintSpeed 	= 4; -- The maximum amount of upgrade
fsrp.config.Printer.UpgradeCost 	= 5000; -- Cost of one upgrade
fsrp.config.Meth = {
	timebetweeningredient = {20,40}; // time between putting each ingredient in
	timeuntilexplode = 60; // time until the meth explodes from overheating
	itemtoreceive = 766; // what item to give
	itemreceivechance = {50,100}; // how many of x item to give
	itemamountchance = {2,8};// How many ingredients to put in per grow
	mixrange = 150;
	itemstoconsider = {
		[1]="meth_ingredient_a",
		[2]="meth_ingredient_b",
		[3]="meth_ingredient_c",
	}; 
	smokes = {
		["meth_ingredient_a"] = "meth_smoke_a";
		["meth_ingredient_b"] = "meth_smoke_b";
		["meth_ingredient_c"] = "meth_smoke_c";
	};
	itemcolors = {
		["meth_ingredient_a"] = Color(0,0,255);
		["meth_ingredient_b"] = Color(255,0,0);
		["meth_ingredient_c"] = Color(0,255,0);
	}
}

fsrp.config.VisibleContainers = {
	[1] = {
		name = "Wood Crate",
		model = "models/props_junk/wood_crate001a.mdl",
		slots = 32,
		scale = 1,
		cost = 500,
	};
	[2] = {
		name = "Large Crate",
		model = "models/props_junk/wood_crate002a.mdl",
		slots = 64,
		scale = 1,
		cost = 1000,
	};
	[3] = {
		name = "Small Box",
		model = "models/props_junk/cardboard_box004a.mdl",
		slots = 4,
		scale = 1,
		cost = 200,
	};
	[4] = {
		name = "Moving Box",
		model = "models/props_junk/cardboard_box002b.mdl",
		slots = 8,
		scale = 1,
		cost = 600,
	};
	[5] = { 
		name = "File Cabinet",
		model = "models/props_lab/filecabinet02.mdl",
		slots = 4,
		scale = 1,
		cost = 150,
	};
	[6] = {
		name = "Closet",
		model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
		slots = 16,
		scale = 1,
		cost = 1200,
	};
	[7] = {
		name = "Fridge",
		model = "models/props_c17/FurnitureFridge001a.mdl",
		slots = 12,
		scale = 1,
		cost = 1500,
	};
	[8] = {
		name = "Industrial Fridge",
		model = "models/props_wasteland/kitchen_fridge001a.mdl",
		slots = 18,
		scale = 1,
		cost = 2000,
	};
	[9] = {
		name = "Drawer",
		model = "models/props_c17/FurnitureDrawer001a.mdl",
		slots = 10,
		scale = 1,
		cost = 3000,
	};
}
fsrp.config.LawSections = {'G - General','R - Traffic','C - Contraband','V - Violence'};
fsrp.config.Laws = 		{
				{'Wasting Police Time',200,1},
				{'Prank Calls',200,1},
				{'Disturbing peace (disruptive)',600,1},
				{'Resting arrest or questioning (running away)',500,1},
				{'Refusing to listen',200,1},
				{'Helping a suspect',500,1},
				{'Attempt to break a law',100,1},
				{'Swearing/Unpleasant Talk',200,1},
				{'Prostitution',1450,1},
				{'Threatening or Intimidating',250,1},
				{'Reckless driving',500,2},
				{'Driving through a red light',150,2},
				{'Illegal U-Turn',250,2},
				{'Speeding',350,2},
				{'Illegal Parking',200,2},
				{'Ramming Cars',700,2},
				{'Illegal race',3400,2},
				{'Driving while being drunk or on drugs',800,3},
				{'Car Theft',800,3},
				{'Growing Drugs',3000,3},
				{'Consuming Drugs',250,3},
				{'Selling Drugs',1250,3},
				{'Asking for Drugs',250,3},
				{'Owning Heavy Weapon',250,4},
				{'Wielding weapon in public',500,4},
				{'Assault',600,4},
				{'Murder',5000,4},
				{'Kidnapping',1000,4},
				{'Sexual Assault / Rape',2500,4},
				{'Burglary',550,4},
				{'Robbery',1500,4},
				{'Public Damage',300,4},
				};

	
fsrp.config.InvestmentZones = {
['rp_downtown_tits_v2'] = {
		[1] = {
			Name="Industrial Development",
			StartingInvestment = 25000000,
			Properties={89,90,93,92,91,94,
			},
		};
		[2] = {
			Name="Suburban Development",
			StartingInvestment = 45000000,
			Properties={6,5,1,4,3,2,16,17,18,19,20,7,22,23,24,21,15,14,13,12,11,10,8,9,103,102,29,28,27,26,25,30,100,31
			},
		};
		[3] = {
			Name="Urban Development",
			StartingInvestment = 50000000,
			Properties={77,79,78,104,85,88,87,86,81,82,83,84,80,

			},
		};
		[4] = {
			Name="Ghetto Development",
			StartingInvestment = 70000000,
			Properties={32,36,41,42,43,44,37,39,40,38,33,34,35,45,46,47,65,48,50,49,65,62,61,63,64,59,60,58,57,51,52,53,54,55,56
			},
		};
		[5] = {
			Name="Uptown Development",
			StartingInvestment = 125000000,
			Properties={66,67,68,69,70,108,105,106,107,73,71,72,74,75,
			},
		};
	};
}
fsrp.config.WarrentTime = 450;
fsrp.config.DefaultStallType = 'general';
fsrp.config.StallStartLevel = 1;
fsrp.config.StallTypes = {	
	['armor'] = "models/mosi/fallout4/workshop/vendor/armorstand0%d.mdl",
	['bar'] = "models/mosi/fallout4/workshop/vendor/barstand0%d.mdl",
	['clinic'] =  "models/mosi/fallout4/workshop/vendor/clinicstand0%d.mdl",
	['clothing'] = "models/mosi/fallout4/workshop/vendor/clothingstand0%d.mdl",
	['general'] = "models/mosi/fallout4/workshop/vendor/generalstand0%d.mdl",
	['weapon'] = "models/mosi/fallout4/workshop/vendor/weaponstand0%d.mdl",
};
fsrp.config.mayorgovernment = fsrp.config.mayorgovernment or {};
fsrp.config.mayorgovernment.functions = fsrp.config.mayorgovernment.functions or {  } 
fsrp.config.mayoral = fsrp.config.mayoral or {}
fsrp.config.mayoral = {
	// per ten players
	DefaultName = "Downtown City",
	citybaseincome = 1500,
	warrantcost = 1000,
	allowadminincometax = false,
	carlimits = {
		police = {
			maxpolicecars = 8,
			policecarcost = 50,
			default = 2,
		},
		ambulance = {
			maxambulances = 8,
			ambulancecost = 50,
			default = 2,
		},
		limo = {
			maxlimousines = 1,
		},
	},
	taxinfo = {
		sales = {
			min = 0,
			max = 35,
			default = 15,
		},
		income = {
			min = 0,
			max = 50,
			default = 15,
		},
		sexchangeincome = 350,
		demoteincome = 150,
		namechangeincome = 150,
	},
	functions = {},
	salaryinfo = {

		[TEAM_PARAMEDIC] = {
			min = 75,
			max = 145,
			default = 110,
			timerank = true,
		},

		[TEAM_MAYOR] = {
			min = 9000,
			max = 16000,
			default = 12000,
			timerank = true,
		},
		[TEAM_POLICE] = {
			min = 95,
			max = 160,
			default = 120,
			timerank = true,
		},
		[TEAM_CIVILLIAN] = {
			min = 30,
			max = 130,
			default = 45,
			timerank = false,
		},
	},
}


fsrp.config.OrgBoostCost = 1500000
fsrp.config.warehouses = {}
fsrp.config.warehouses.SlotsUser = 20;
fsrp.config.warehouses.SlotsDonator = 40;
fsrp.config.warehouses.SlotsPremium = 60;
fsrp.config.warehouses.ItemWithdrawalFee = 10;
fsrp.config.warehouses.ItemDisposalFee = 50;
fsrp.config.warehouses.ItemDepositFee = 25;
fsrp.config.warehouses.RemoteWarehouseFeeIncrease = 2.5; // Times
fsrp.config.CarRetrievalCost = 2000;
fsrp.config.ShopItemsPerColumn = 5;
fsrp.config.ShopItemColumns = 2;
fsrp.config.SupplyLength = 3600 // how long does it take to use up 1 supply
// vr = vehicle retrieval
fsrp.config.BusinessTagsToLoad = { ["vrt"]=true, ["dtstr"]=true , ["trv" ] = true, ["tak"] = true, ["dtv"] = true}
fsrp.config.SupplyMissions = {
	["vrt"] = {
		// on start / spawn with mission , on finish / leave check
		supplycountmax = 4;
		location = {"rp_downtown_tits_v2",2};
		pickup = {
			['rp_downtown_tits_v2'] ={ 
				Vector(2104.122 , -1720.699 , -170.969 );
				Angle(0 , 58 , 90 );
			};
		};
		initFlags = { 

		};
		supplyStep = {
			["rp_downtown_tits_v2"] = { 
				StartMission = function(_p,_data) 
					_p:setFlag("supplyFlagTag","vrt")
				end , 
				JoinedServer = function(_p,_data) 
					_p:setFlag("supplyFlagTag","vrt")
					_p:Notify("You are on a supply mission.")
				end , 
				AdvanceCriteria = function(_p, ent) 
					local _supptag = ent:getFlag("supplyFlagTag","");		
					local _data = _p:GetBusiness(true);
					for k , v in pairs(_data) do
						if (v[7] && v[7][1] == _supptag) and (v[7][4]) then
							
							_data[k][7][4][1] = true;
						end
					end		

					_p:setFlag("DT_BusinessData" , _data )

					local _data = _p:GetBusiness(false);
					for k , v in pairs(_data) do
						if (v[7] && v[7][1] == _supptag) and (v[7][4]) then
							
							_data[k][7][4][1] = true;
						end
					end		

					_p:setFlag("EVO_BusinessData" , _data )
					_p:SaveBusinessData(false)
					_p:SaveBusinessData(true)
					_p:setFlag("supplyFlagTag",nil)
				end,
				LeftServer = function(_p,_data) 

				end ,
			};
			
		};
	};
["trv"] = {
		// on start / spawn with mission , on finish / leave check
		supplycountmax = 4;
		location = {"rp_southside_day",4};
		pickup = {
			['rp_southside_day'] ={ 
				Vector(1950.366 , 4295.707 , -30.904  );
				Angle(0 , 58 , 90 );
			};
		};
		initFlags = { 

		};
		supplyStep = {
			["rp_southside_day"] = { 
				StartMission = function(_p,_data) 
					_p:setFlag("supplyFlagTag","trv")
				end , 
				JoinedServer = function(_p,_data) 
					_p:setFlag("supplyFlagTag","trv")
					_p:Notify("You are on a supply mission.")
				end , 
				AdvanceCriteria = function(_p, ent) 
					local _supptag = ent:getFlag("supplyFlagTag","");		
					local _data = _p:GetBusiness(true);
					for k , v in pairs(_data) do
						if (v[7] && v[7][1] == _supptag) and (v[7][4]) then
							
							_data[k][7][4][1] = true;
						end
					end		

					_p:setFlag("DT_BusinessData" , _data )

					local _data = _p:GetBusiness(false);
					for k , v in pairs(_data) do
						if (v[7] && v[7][1] == _supptag) and (v[7][4]) then
							
							_data[k][7][4][1] = true;
						end
					end		

					_p:setFlag("EVO_BusinessData" , _data )
					_p:SaveBusinessData(false)
					_p:SaveBusinessData(true)
					_p:setFlag("supplyFlagTag",nil)
				end,
				LeftServer = function(_p,_data) 

				end ,
			};
		};
	};

};
fsrp.config.InitMissions = {
	["dtstr"] = {
		// on start / spawn with mission , on finish / leave check
		supplycountmax = 4;
		location = {"rp_downtown_tits_v2",4};
		pickup = {
			['rp_downtown_tits_v2'] ={ 
				Vector(-1730.481 , -2774.732 , -175.969 );
				Angle(0 , 28 , 90 );
			};
		};
		initFlags = { 

		};
		supplyStep = {
			
			["rp_downtown_tits_v2"] = {
				StartMission = function(_p,_data) 
					_p:setFlag("supplyFlagTag","dtstr")
				end , 
				JoinedServer = function(_p,_data) 
					_p:setFlag("supplyFlagTag","dtstr")
					_p:Notify("You are on a supply mission.")
				end , 
				AdvanceCriteria = function(_p, ent) 
					local _supptag = ent:getFlag("supplyFlagTag","");		
					local _data = _p:GetBusiness(true);
					for k , v in pairs(_data) do
						if (v[5] && v[5][1] == _supptag) and (v[5][4]) then
							
							_data[k][5][4][1] = true;
						end
					end		

					_p:setFlag("DT_BusinessData" , _data )

					local _data = _p:GetBusiness(false);
					for k , v in pairs(_data) do
						if (v[5] && v[5][1] == _supptag) and (v[5][4]) then
							
							_data[k][5][4][1] = true;
						end
					end		

					_p:setFlag("EVO_BusinessData" , _data )
					_p:SaveBusinessData(false)
					_p:SaveBusinessData(true)
					_p:setFlag("supplyFlagTag",nil)
				end,
				LeftServer = function(_p,_data) 

				end ,
			};
		};
	};
};
fsrp.config.DeliveryMissions = {
	["dtv"] = {
		// on start / spawn with mission , on finish / leave check
		location = {"rp_downtown_tits_v2",2};
		pickup = {
			['rp_downtown_tits_v2'] ={ 
				Vector(3921.86 , 2103.204 , -195.969 );
				Angle(32.826 , -81.178 , 0 );
			};
		};
		initFlags = { 

		};
		supplyStep = {
			["rp_downtown_tits_v2"] = { 
				StartMission = function(_p,_data) 
					_p:setFlag("supplyFlagTag","dtv")
				end , 
				JoinedServer = function(_p,_data) 
					_p:setFlag("supplyFlagTag","dtv")
					_p:Notify("You are on a delivery mission.")
				end , 
				AdvanceCriteria = function(_p, ent) 	
					local _data = _p:GetBusiness(true);
					for k , v in pairs(_data) do
						if (v[8] && istable(v[8])) and (v[8][4]) then
							
							_data[k][8][4][1] = true;
						end
					end		

					_p:setFlag("DT_BusinessData" , _data )

					local _data = _p:GetBusiness(false);
					for k , v in pairs(_data) do
						if (v[8] && istable(v[8])) and (v[8][4]) then
							
							_data[k][8][4][1] = true;
						end
					end		

					_p:Notify("Return to your business to begin money laundering.");
					_p:setFlag("EVO_BusinessData" , _data )
					_p:SaveBusinessData(false)
					_p:SaveBusinessData(true)
					_p:setFlag("supplyFlagTag",nil)
				end,
				LeftServer = function(_p,_data) 

				end ,
			};
		};
	};
["tak"] = {
		
		location = {"rp_southside_day",4};
		pickup = {
			['rp_southside_day'] ={ 
				Vector(1918.19 , 5024.958 , 20.225  );
				Angle(0 , 28 , 90 );
			};
		};
		initFlags = { 

		};
		supplyStep = {
			["rp_southside_day"] = {
				StartMission = function(_p,_data) 
					_p:setFlag("supplyFlagTag","tak")
				end , 
				JoinedServer = function(_p,_data) 
					_p:setFlag("supplyFlagTag","tak")
					_p:Notify("You are on a supply mission.")
				end , 
				AdvanceCriteria = function(_p, ent) 
					local _supptag = ent:getFlag("supplyFlagTag","");		
					local _data = _p:GetBusiness(true);
					for k , v in pairs(_data) do
						if (v[8] && v[8][1] == _supptag) and (v[8][4]) then
							
							_data[k][8][4][1] = true;
						end
					end		

					_p:setFlag("DT_BusinessData" , _data )

					local _data = _p:GetBusiness(false);
					for k , v in pairs(_data) do
						if (v[8] && v[8][1] == _supptag) and (v[8][4]) then
							
							_data[k][8][4][1] = true;
						end
					end		

					_p:Notify("Return to your business to begin money laundering.");
					_p:setFlag("EVO_BusinessData" , _data )
					_p:SaveBusinessData(false)
					_p:SaveBusinessData(true)
					_p:setFlag("supplyFlagTag",nil)
				end,
				LeftServer = function(_p,_data) 

				end ,
			};
		};
	};
};
fsrp.config.IllegalBusinessTypes = {
	[1] = {
		Name = "Cannabis";
		Desc = "A farm that cultivates female cannabis plants via supplied seeds.";
		SupplyBuyWorth = 20000;// How much is 1 supply worth
		SupplySellWorth = 150000;// How much is 1 supply worth
		MaxSupply = 4;// How many supply points to fill up our supplies
		SupplyChance = 40;// Percentage chance to get another supply (this stacks)
		SupplyMissions = { "vrt" , "trv" }; // Which missions do you do for resupplying
		DeliveryMissions = { "dtv" , "trv" }; // Which missions do you do for resupplying
		InitMission = "dtstr";
		ItemToGive = 57;
		LaunderNPCs = {
			[1] = "bu_bank",
			[2] = "hatguy",
			[3] = "warehouse",
			[4] = "job_paramedic",
			[5] = "gasstation"
		};
	};
	[2] = {
		Name = "Meth";
		Desc = "A farm that cultivates meth plants via supplied chemicals.";
		SupplyBuyWorth = 50000;// How much is 1 supply worth
		SupplySellWorth = 255000;// How much is 1 supply worth
		MaxSupply = 4;// How many supply points to fill up our supplies
		SupplyChance = 20;// Percentage chance to get another supply (this stacks)
		SupplyMissions = { "vrt" , "trv" }; // Which missions do you do for resupplying
		DeliveryMissions = { "dtv" , "trv" }; // Which missions do you do for resupplying
		InitMission = "dtstr";
		LaunderNPCs = {
			[1] = "bu_bank",
			[2] = "hatguy",
			[3] = "warehouse",
			[4] = "job_paramedic",
			[5] = "cardealer"
		};
	};
};
fsrp.config.TimeBetweenRobbery = 600;
fsrp.config.IntimidationPerRobber = 600;
fsrp.config.RobberyConfig = {
	['realtor'] = {
		name = 'Realtor';
		placename = 'Bank';
		rewards = {
			["cw_ak74"] = {
				5500,
				14000,
			},
			["cw_ar15"] = {
				5500,
				14000,

			}, 
			["cw_deagle"] = {
				1500,
				3000,
			}, 
			["cw_g3a3"] = {
				9500,
				29000,
			}, 
			["cw_l115"] = {
				9500,
				29000,
			}, 
			["cw_mp5"] = {
				5500,
				14000,
			}, 
		};
	};


	['gasstation'] = {
		name = 'Clerk';
		placename = 'Gas Station';
		rewards = {
			["cw_ak74"] = {
				1500,
				4500,
			},
			["cw_ar15"] = {
				1500,
				4500,

			}, 
			["cw_deagle"] = {
				1500,
				3000,
			}, 
			["cw_g3a3"] = {
				1500,
				4500,
			}, 
			["cw_l115"] = {
				1500,
				4500,
			}, 
			["cw_mp5"] = {
				1500,
				4500,
			}, 
		};
	};

	['furniturestore'] = {
		name = 'Clerk';
		placename = 'Store';
		rewards = {
			["cw_ak74"] = {
				1500,
				8500,
			},
			["cw_ar15"] = {
				1500,
				8500,

			}, 
			["cw_deagle"] = {
				1500,
				3500,
			}, 
			["cw_g3a3"] = {
				1500,
				8500,
			}, 
			["cw_l115"] = {
				1500,
				8500,
			}, 
			["cw_mp5"] = {
				1500,
				8500,
			}, 
		};
	};

	['marioswarehouse'] = {
		name = 'Mario';
		placename = 'Store';
		rewards = {
			["cw_ak74"] = {
				1500,
				8500,
			},
			["cw_ar15"] = {
				1500,
				8500,

			}, 
			["cw_deagle"] = {
				1500,
				3500,
			}, 
			["cw_g3a3"] = {
				1500,
				8500,
			}, 
			["cw_l115"] = {
				1500,
				8500,
			}, 
			["cw_mp5"] = {
				1500,
				8500,
			}, 
		};
	};
};


fsrp.config.SeedChance = 40;
// goto systems/store.lua for all items, update them too you cunt theres a function
fsrp.stores.cache = {
	[1] = {
		ID			= 1;
		Name 		= "Mario's Warehouse";
		Items		= { 768,1,2, 8, 17, 16, 13, 10, 9, 7, 23,59, 24, 21, 20, 19, 18, 86,88,52,  58,765,764};
		Description = "A collection of Mario's most useful crafting items.";
		SellRate 	= 0.3;	
		CName		= "marioswarehouse";
	};
	[2] = {
		ID			= 2;
		Name		= "Gas Station";
		Items		= { 14 ,101 ,13 , 52, 15,95,97,98,99,100 ,105,768};
		Description = "Delicate treats from this place.";
		SellRate	= 0.3;
		CName		= "gasstation";
	};
	[3] = {
		ID			= 3;
		Name		= "Ore Store";
		Items		= { 768,1001 , 9, 7, 6, 5 };
		Description = "Your finest ore here!";
		SellRate	= 0.3;	
		CName		= "oreguy";
	};
	[4] = {
		ID			= 4;
		Name		= "Sofa King";
		Items		= {768,60, 61, 62, 63, 64,68,72,74,77,78, 79,101,101,102,103,104,105,106, 80, 81,83,93, 94,111};
		Description = "For your sofakingneeds.";
		SellRate	= 0.3;	
		CName		= "furniturestore";
	};
	[5] = {
		ID			= 5;
		Name		= "Police Store";
		Items		= {500,112,113};
		Description = "Don't beat the minorities!.";
		SellRate	= 0.1;	
		CName		= "copmachine";
	};
	[6] = {
		ID			= 6;
		Name		= "Hat Store";
		Items		= {   140,141,142,143,144,145,146,148,149,151,153,154,156};
		Description = "Your finest hats here!";
		SellRate	= 0.3;	
		CName		= "hatguy";
	};
	[7] = {
		ID			= 7;
		Name		= "Gun Store";
		Items		= {  36,38,30,31,35,34, 40};
		Description = "Your finest guns here!";
		SellRate	= 0.1;	
		CName		= "gunguy";
	};

};
fsrp.stores.config = {};
fsrp.skills = skills || {}
fsrp.skills.config = fsrp.skills.config || {}
if SERVER then

	fsrp.skills.helper = fsrp.skills.helper || {}

end
fsrp.skills.config.SkillTypes = fsrp.skills.config.SkillTypes || {}
fsrp.config.WorkshopSounds = "1119277025";
fsrp.config.MayorVoting = {};
fsrp.config.MayorVoting.CandidateCache = {};

fsrp.JobRanks = { 
	[TEAM_POLICE] = {
		[1] = { name = 'Deputy', time = 0 };
		[2] = { rank = 2, name = 'Detective', time = 18000 };
		[3] = { rank = 3, name = 'Sergeant', time = 36000 };
		[4] = { rank = 4, name = 'Lieutenant', time = 54000 };
		[5] = { rank = 5, name = 'Captain', time = 72000 };
		[6] = { rank = 6, name = 'Major', time = 108000 };
		[7] = { rank = 7, name = 'Deputy Chief', time = 180000 };
		[8] = { rank = 8, name = 'Assistant Chief', time = 216000 };
		[9] = { rank = 9, name = 'Chief of Police', time = 360000 };
		[10] = { rank = 10, name = 'Head Coordinator', time = 9999999 };
	};
	[TEAM_PARAMEDIC] = {
		[1] = { rank = 1, name = 'Medic Trainee', time = 0 };
		[2] = { rank = 2, name = 'Medic', time = 18000 };
		[3] = { rank = 3, name = 'Medical Scientist', time = 36000 };
		[4] = { rank = 4, name = 'Junior Doctor', time = 54000 };
		[5] = { rank = 5, name = 'Doctor', time = 72000 };
		[6] = { rank = 6, name = 'Plastic Surgeon', time = 108000 };
		[7] = { rank = 7, name = 'Brain Surgeon', time = 180000 };
		[8] = { rank = 8, name = 'Chief Physician', time = 216000 };
		[9] = { rank = 9, name = 'Ambulance Operations Manager', time = 360000 };
		[10] = { rank = 10, name = 'Head Coordinator', time = 9999999 };
	};
	
	[TEAM_MAYOR] = {
		[1] = { rank = 1, name = 'Advocate', time = 0 };
		[2] = { rank = 2, name = 'Ward', time = 18000 };
		[3] = { rank = 3, name = 'Councillor', time = 36000 };
		[4] = { rank = 4, name = 'Mayor', time = 54000 };
		[5] = { rank = 5, name = 'Senator', time = 72000 };
		[6] = { rank = 6, name = 'Federal Judge', time = 108000 };
		[7] = { rank = 7, name = 'Govenor', time = 180000 };
		[8] = { rank = 8, name = 'Vice President', time = 216000 };
		[9] = { rank = 9, name = 'President', time = 360000 };
		[10] = { rank = 10, name = 'Führer', time = 9999999 };
	};
}
fsrp.specialThanks = {
	"Biggie Rich",
	"Fried Rice",
	"Acecool",
}
function fsrp.devprint( t )
	
	if CLIENT then
	
		if GM_MODE != 0 then
		
			print( t )
			
		end
	
	end
	
end
fsrp.config.CrippleSpeed = 75;
fsrp.config.WalkSpeed = 180;
fsrp.config.RunSpeed = 300;
fsrp.config.MaxProperties = 2;
fsrp.config.PhysgunColorPrice = 500;
fsrp.config.MaxCannabisPlants = 4; 
fsrp.config.MaxCannabisPlants_DONATOR = 6;
fsrp.config.MaxCannabisPlants_PREMIUM = 8;
fsrp.config.MaxPrinters = 2; 
fsrp.config.MaxPrinters_DONATOR = 4;
fsrp.config.MaxPrinters_PREMIUM = 6;
fsrp.config.MaxPlayers = 128;
FLAG_COOLDOWN = "cooldown";
FLAG_PLAYER = "player";
FLAG_DOOR = "propertydoor";
fsrp.config.InventoryWSlots 	= 10
fsrp.config.InventoryYSlots	= 6
fsrp.config.ValidCharacters 			= 	{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
								"1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",", "-", "_", "=", "+", "0"};

fsrp.config.ValidNameCharacters		=	{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
								"-"};
fsrp.config.OrgCharacter		=	{"!","."," ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
								"-"};
MODEL_AVAILABLE 							= {};
fsrp.blackmarket 							= {}
fsrp.blackmarket.cache 						= {}
fsrp.blackmarket.help 						= {}
fsrp.blackmarket.cache.Selling 				= {}
fsrp.blackmarket.cache.Buying 				= {}
fsrp.blackmarket.cache.PercentagePaying 	= math.random( 80, 120 );
fsrp.blackmarket.cache.PercentageSelling 	= math.random( 80, 120 );
fsrp.blackmarket.help.ChanceToSell 			= 40;
fsrp.blackmarket.help.ChanceToBuy 			= 50;
fsrp.blackmarket.help.PotentialSelling 		= { 1001 , 9, 7, 6, 5 , 50,107,766};
fsrp.blackmarket.help.PotentialBuying		= { 57 ,767,769};
fsrp.blackmarket.help.PermanentlyBuy 		= {  };
fsrp.blackmarket.help.PermanentlySell 		= { 96 , 770,769,768,771};
fsrp.config.VehicleCustomizationCost		= 5000
/*

    local RandomLocationTable = {
  {Vector(-10792.823242, -10371.587891, 72.0313), Angle(0,-133.087616, 0)}, // Behind Apartments
{Vector(-9398.309570, -9589.371094, 72.0313), Angle(0,124.219582,0)},
	  {Vector(-8772.556641, 14735.007813, 186.940582), Angle(0, 0, 0)}, // Beside River
{Vector(3096.951172, 12236.088867, 60.302422), Angle(0, 53.549553, 0)}, // Subs
{Vector(-7315.252441, 10491.769531, 186.663956), Angle(0, 90, 0)}, // Sub Lake Area
	{Vector(-4885.917969, -6517.792969, 72.0313), Angle(0, -145.563538, 0)}, // Facial Store
	{Vector(3850.455078, 6859.381836, 72.0313), Angle(0, -135, 0)}, // Industrial
	{Vector(-2641.720947, -952.860962, 72.0313), Angle(0,90,0)}, // Bus Stop at middle.
		{Vector(-437.204010, -8346.512695, 60.302422), Angle(10,0,0)}, // Behind Whispering Oaks
{Vector(-6693.130859, -14562.541016, 72.0313), Angle(0, 180,0)}, // Izzies Place
	{Vector(-7566.971191, -4347.167480, 72.0313), Angle(-4.767782, 137.504044,0)} ,// Burger King
	{Vector(9979.085938, 4661.190430, 0), Angle(0,90, 0)}, //  Somewhere
	{Vector(-6860.461914, -9545.329102, -431.9688), Angle(0, -142,0)}, // Jail Holding Cell
								};   

	*/

fsrp.blackmarket.help.PotentialLocations 	= { 
	[1] = {
		Name 		= "Back Alley";
		Text 		= "near the back alley.";
		Location 	= Vector(-733.796 , 2098.547 , -192.475 );
		Angles		= Angle(0.036 , -119.04 , 0 );
	};
	[2] = {
		Name 		= "City Square";
		Text 		= "near the city square.";
		Location 	= Vector(-2319.161 , -18.201 , -192.2349 );
		Angles		= Angle(0.92 , -88.416 , 0 );
	};
};


function fsrp.blackmarket.help.Network()
	
	if SERVER then
	
		net.Start( "networkBlackmarketCache" )
		
			net.WriteTable( fsrp.blackmarket.cache );
		
		net.Broadcast( )
		
	end
		
end

if CLIENT then

	net.Receive( "networkBlackmarketCache" , function(  _l , _p)
	
		LocalPlayer():setFlag( "blackMarket", net.ReadTable() )
		
	end )
	
else 

	util.AddNetworkString( "networkBlackmarketCache" )

end

fsrp.config.InvalidRPNames = {
	"Ass";
	"gay";
	"dick";
	"fag";
	"kike";
	"jew";
	"nigger";
	"nigga";
	"jewkike";
	"you";
	"awawaw";
	"asadsdasd";
	"cunt";
	"asshole";
	"titty";
	"tit";
	"piss";
	"shit";
	"bitch";
	"fuck";
	"retard";
	"stupid";
	"server";
	"cunts";
	"doe";
}					

INVENTORY_WIDTH 			= 13;
INVENTORY_HEIGHT 			= 6;


fsrp.config.SexChangeCost = 25000;
fsrp.config.BankAccountChangeCost = 25000;
fsrp.config.NameChangeCost = 5000;
fsrp.config.OrganizationCost = 25000;
fsrp.config.FacialCost = 1000;
fsrp.config.HealthResetCost = 1000;
fsrp.config.MaxWeight	= 500
fsrp.config.PayDayTime =  450;
fsrp.config.MinimumPayday = 55;

fsrp.config.MaxBusinessLevels = 3; 

fsrp.config.MaxAirportShares	= 30;
fsrp.config.MaxBankShares		= 30;
fsrp.config.MaxCinemaShares	= 30;
fsrp.config.MaxFarmerShares	= 30;
fsrp.config.MaxGasShares		= 30;
fsrp.config.MaxHarborShares	= 30;
fsrp.config.MaxLabShares		= 30; 
fsrp.config.MaxLumberShares	= 30;
fsrp.config.MaxMiningShares	= 30;
fsrp.config.MaxResShares		= 30;
fsrp.config.MaxStripClubShares	= 30;
fsrp.config.MaxWeaponShares		= 30;
fsrp.config.adviceTable = {
	"Information:",
	"We are excited to have you here!",
	"",
	"You need to create a role-play name.",
	"This is you, your character and persona in this world.",
	"",
	"For any support or special inquiries please visit the forum or email us at:",
	"support@560roleplay.com",
	"",
	"You can not include any special characters in your first",
	"or last name except for dash. (-)",
}

//
// MINING
//

fsrp.mining.config.ShovelOre = { 24, 25, 26, 27, 29 , 9, 8 , 7 ,6, 5 , 4 };
fsrp.mining.config.ShovelChance = 20;
fsrp.mining.config.AxeTable = {1,2,3};
fsrp.mining.config.AxeChance = 20;
fsrp.mining.config.RockTypes = {

	["granite"] = { 
	
		Name 			= "Granite";
		ItemID 			= 24;
		MinDropChance	= 1;
		MaxDropChance	= 4;
		CompatibleRocks = { "iron", "silicon" };
		ConsideredPercentage = 30;
		
	};
	
	["iron"] = { 
	
		Name 			= "Iron";
		ItemID 			= 25;
		MinDropChance	= 1;
		MaxDropChance	= 3;
		LuckyMaxDrop	= 4;
		CompatibleRocks = { "aluminum", "granite" };
		ConsideredPercentage = 70;
		
	};
	
	["silicon"] = { 
		Name 			= "Silicon";
		ItemID 			= 26;
		MinDropChance	= 1;
		MaxDropChance	= 4;
		LuckyMaxDrop	= 2;
		CompatibleRocks = { "sodium", "aluminum", "iron" };
		ConsideredPercentage = 60;
		
	};
	
	["aluminum"] = { 
	
		Name 			= "Aluminum";
		ItemID 			= 27;
		MinDropChance	= 1;
		MaxDropChance	= 5;
		LuckyMaxDrop	= 1;
		CompatibleRocks = { "sodium", "silicon", "granite" };
		ConsideredPercentage = 60;
		
	};
	
	["sodium"] = { 
	
		Name 			= "Sodium";
		ItemID 			= 28;
		MinDropChance	= 1;
		MaxDropChance	= 2;
		LuckyMaxDrop	= 5;
		CompatibleRocks = { "iron", "granite", "aluminum" };
		ConsideredPercentage = 80;
	};
}

fsrp.mining.config.MaximumRockTypesToGive		= 5;
fsrp.mining.config.RockViewDistance				= 4550;
fsrp.mining.config.PickRockChance 				= { 0 , 100 }; // ( Min , Max )
fsrp.mining.config.PickaxeBreakChance			= { 0 , 100 }; // ( Min , Max )

// Dominant Type // Position // Angles // Vectors 
fsrp.mining.config.RockSpawns = {


{ dominanttype = "granite" , pos =  Vector(-277.471 , -7409.595 , -140.969   ), ang = Angle(0.69 , -92.95 , 0 ) , mdl = 'models/props_canal/rock_riverbed02c.mdl' };
{ dominanttype = "silicon" , pos =Vector(237.405 , -7433.44 , -170.969  ), ang = Angle(-0.011 , -70.806 , 0.044) , mdl = 'models/props_canal/rock_riverbed02a.mdl' };

{ dominanttype = "aluminum", pos =Vector(2142.191 , 8154.782 , 0.568 ), ang = Angle(0.016 , -114.392 , 1.67 ) , mdl = 'models/props_canal/rock_riverbed02b.mdl' };
{ dominanttype = "sodium" ,pos = Vector(1761.933 , 4364.952 , -80.931 ), ang = Angle(-13.134 ,178.253 ,-9.410) , mdl = 'models/props_wasteland/rockcliff01j.mdl' };

//{ dominanttype = "granite" , pos = Vector(6116.107422, 12203.809570, 167.048752), ang = Angle(-7.163, 73.647, -55.525) , mdl = 'models/props_wasteland/rockcliff05a.mdl' };
{ dominanttype = "iron" , pos = Vector(495.39 , 5075.433 , 0.37 ), ang = Angle(9.668, 163.350, -0.401) , mdl = 'models/props_wasteland/rockcliff05e.mdl' };
//{ dominanttype = "silicon" , pos = Vector(-5484.909668 ,4456.842285 ,171.115036), ang = Angle(0.742 ,-13.343, -0.379) , mdl = 'models/props_wasteland/rockcliff_cluster03a.mdl' };
//{ dominanttype = "aluminum", pos = Vector(-511.809 , -5175.605 , 129.058), ang = Angle(-0.033 , -143.658 , 0.027) , mdl = 'models/props_wasteland/rockcliff01j.mdl' };
{ dominanttype = "sodium" ,pos = Vector(-4556.818 , -6039.594 , -150.331 ), ang = Angle(-0.033, -28.268, 0.027) , mdl = 'models/props_wasteland/rockcliff01k.mdl' };


}



fsrp.skills.config.SkillTypes = {
	["strength"] = {
		Name				= "Strength";
		Description 		= "Increases physical strength with melee weapons.";
		MaxPoints 			= 30;
	};
	["intelligence"] = {
		Name				= "Intelligence";
		Description 		= "Broadens the amount of crafting recipes available.";		
		MaxPoints 			= 30;
	};
	["influence"] = {
		Name				= "Influence";
		Description 		= "Allows you to influence npc's for better prices.";
		MaxPoints 			= 25;
	};
	["perception"] = {
		Name				= "Perception";
		Description 		= "Increases the distance you can see certain entities from.";
		MaxPoints 			= 5;
	};
	["regeneration"] = {
		Name				= "Regeneration";
		Description 		= "Allows for regeneration of vehicle and normal health.";
		MaxPoints 			= 10;
	};
	["dexterity"] = {
		Name				= "Dexterity";
		Description 		= "Affects your running speed.";
		MaxPoints 			= 10;
	};
	["luck"] = {
		Name				= "Luck";
		Description 		= "Enhances the potential of items to be found from resources and manufacturing.";
		MaxPoints 			= 5;
	};
	["endurance"] = {
		Name				= "Endurance";
		Description 		= "Affects your walking speed.";
		MaxPoints 			= 15;
	};
}

fsrp.skills.config.SkillpointCost		= 1500;

fsrp.business = { }
fsrp.business.config = {}

fsrp.business.cache = { }
fsrp.business.functions = { }

fsrp.business.config.Companies = {
	['airport'] = {
		Name = "Downtown Airport";
		StartingStock = 1350;
		WorkTime	= 15;
		//ItemRewardPool	= { };
	};
	['cinema'] = {
		Name = "Downtown Cineplex";
		StartingStock = 400;
		WorkTime	= 15;
	};
	['bank'] = {
		Name = "Bank of America";
		StartingStock = 1600;
		WorkTime	= 15;
	};
	['farmersmarket'] = {
		Name = "Downtown Farmers Market";
		StartingStock = 700;
		WorkTime	= 15;
	};
	['downtownelectronics'] = {
		Name = "Downtown Electronics Inc.";
		StartingStock = 2000;
		WorkTime	= 15;
	};
	
}

fsrp.business.config.ItemBuffer		= 30 // Seconds between item buffer updates. (Minutes)
fsrp.business.config.WorkTime			= 60 // Time between working
fsrp.business.config.WorkTimeSkew		= 5 // Maximum amount of time that work can be extra.
fsrp.business.config.StartingStockSkewMin		= -75 // Maximum amount of time that work can be extra.
fsrp.business.config.StartingStockSkewMax		= 75 // Maximum amount of time that work can be extra.
