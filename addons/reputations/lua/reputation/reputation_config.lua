
if PlayerReputations.ShowDebugPrints then

	print( "Including Reputation Config Files.")

end 

PlayerReputations.config = {};

PlayerReputations.config.Categories = {
	{ "Law Enforcement" , {1} };
	{ "Working Parties" , {2} };
	{ "Other" , {3} };
}

PlayerReputations.config.Factions = {
	{ "Downtown Government" , {1,2,3,6} };
	{ "Unions" , {5} };
	{ "Illegal" , {4} }; 
};
//PlayerReputations.config.Reputations[id].levels[PlayerReputations.config.Reputations[id].startlv]
PlayerReputations.config.Reputations = {
	[1] = {
		name = "Downtown Police Force";
		levels = {
			{ "Hated", 0, 20000 }; // 20000 rep 
			{ "Disliked", 20001, 32001 }; // 12000 rep
			{ "Neutral" , 32002, 38002 }; // 6000 rep
			{ "Friendly" , 38003, 50003}; // 12000 rep
			{ "Honored" , 50004, 70005 }; // 20000 rep
			{ "Revered" , 70006, 100007 }; // 30000 rep
			{ "Exalted" , 100008, 150009}; // 50000 rep
		};
		startlv = 2;
	};	
	[2] = {
		name = "Downtown Paramedic Force";
		levels = {
			{ "Hated", 0, 20000 }; // 20000 rep 
			{ "Disliked", 20001, 32001 }; // 12000 rep
			{ "Neutral" , 32002, 38002 }; // 6000 rep
			{ "Friendly" , 38003, 50003}; // 12000 rep
			{ "Honored" , 50004, 70005 }; // 20000 rep
			{ "Revered" , 70006, 100007 }; // 30000 rep
			{ "Exalted" , 100008, 150009}; // 50000 rep
		};
		startlv = 3;
	};
	[3] = {
		name = "Downtown Bank";
		levels = {
			{ "Hated", 0, 20000 }; // 20000 rep 
			{ "Disliked", 20001, 32001 }; // 12000 rep
			{ "Neutral" , 32002, 38002 }; // 6000 rep
			{ "Friendly" , 38003, 50003}; // 12000 rep
			{ "Honored" , 50004, 70005 }; // 20000 rep
			{ "Revered" , 70006, 100007 }; // 30000 rep
			{ "Exalted" , 100008, 150009}; // 50000 rep
		};
		startlv = 3;
	};
	[4] = {
		name = "Drug Dealer's";
		levels = {
			{ "Hated", 0, 20000 }; // 20000 rep 
			{ "Disliked", 20001, 32001 }; // 12000 rep
			{ "Neutral" , 32002, 38002 }; // 6000 rep
			{ "Friendly" , 38003, 50003}; // 12000 rep
			{ "Honored" , 50004, 70005 }; // 20000 rep
			{ "Revered" , 70006, 100007 }; // 30000 rep
			{ "Exalted" , 100008, 150009}; // 50000 rep
		};
		startlv = 1;
	};
	[5] = {
		name = "Storeowners";
		levels = {
			{ "Hated", 0, 20000 }; // 20000 rep 
			{ "Disliked", 20001, 32001 }; // 12000 rep
			{ "Neutral" , 32002, 38002 }; // 6000 rep
			{ "Friendly" , 38003, 50003}; // 12000 rep
			{ "Honored" , 50004, 70005 }; // 20000 rep
			{ "Revered" , 70006, 100007 }; // 30000 rep
			{ "Exalted" , 100008, 150009}; // 50000 rep
		};
		startlv = 3;
	};
	[6] = {
		name = "Downtown Government";
		levels = {
			{ "Hated", 0, 20000 }; // 20000 rep 
			{ "Disliked", 20001, 32001 }; // 12000 rep
			{ "Neutral" , 32002, 38002 }; // 6000 rep
			{ "Friendly" , 38003, 50003}; // 12000 rep
			{ "Honored" , 50004, 70005 }; // 20000 rep
			{ "Revered" , 70006, 100007 }; // 30000 rep
			{ "Exalted" , 100008, 150009}; // 50000 rep
		};
		startlv = 1;
	};	
}

PlayerReputations.config.EntityDictionary = {
	["item_ammo_357"] = {
		name = "357 Ammo",
		rep = 2,
	}
}