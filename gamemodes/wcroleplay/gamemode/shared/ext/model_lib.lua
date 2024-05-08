
fsrp.devprint( "[WC-RP] - Fetching Model Library" )

SEX_FEMALE = 'f' || 1;
SEX_MALE = 'm' || 2;


CAM_LOOK_AT = {};
CAM_LOOK_AT[2] = Vector(-48.64869, 0, 54.05405);
CAM_LOOK_AT_CAMMODEL_POS = {};
CAM_LOOK_AT_CAMMODEL_POS[2] = Vector(54.05405454, 0, 54.0540);
CAM_LOOK_AT_CAMMODEL_POS[1] = Vector(43.24324323, 0, 59.4594559);
CAM_LOOK_AT[1] = Vector(-100, 10.8110811, 37.8378);
CAM_LOOK_AT[1] = CAM_LOOK_AT[1];
CAM_LOOK_AT[2] = CAM_LOOK_AT[2];
function PreCacheAllCivillianModels()
	if !SERVER then return end
	for k , v in pairs( mdlTable[2] ) do
		util.PrecacheModel( v.path )
	end
	for k , v in pairs( mdlTable[1] ) do
		util.PrecacheModel( v.path )

	end

	for k , v in pairs( jobMdlTable[TEAM_PARAMEDIC][1] ) do
		util.PrecacheModel( v.model )

	end
	for k , v in pairs( jobMdlTable[TEAM_PARAMEDIC][2] ) do
		util.PrecacheModel( v.model )

	end

	for k , v in pairs( jobMdlTable[TEAM_POLICE][2] ) do
		util.PrecacheModel( v.model )

	end
	local _vList = list.Get( "Vehicles" )
	
	for k , v in pairs( fsrp.VehicleDatabase ) do
		
		if _vList[v.VehicleName] then
		
			util.PrecacheModel( _vList[v.VehicleName].Model )
	
		end
		
	end
	for k , v in pairs (ITEMLIST) do
		
		if v.Model then
			util.PrecacheModel(v.Model)
		end
	end
	
end
mdlTable = {
	// f
	[1] = { 
		[1] = {
			path 	= "models/captainbigbutt/vocaloid/tda_kenzie.mdl",
			name 	= "Casual Girl",
			desc 	= "",
			beginner = true,
		};
		[2] = {
			path 	= "models/captainbigbutt/vocaloid/chibi_miku_ap.mdl",
			name 	= "Chibi Hatsune Miku",
			desc 	= "",
			beginner = true,
		};
		[3] = {
			path 	= "models/player/tfa_cso2/tr_yuri01.mdl",
			name 	= "Yuri",
			desc 	= "",
			beginner = true,
		};
		[4] = {
			path 	= "models/player/mai_nk.mdl",
			name 	= "Mai",
			desc 	= "",
			beginner = true,
		};
		[5] = {
			path 	= "models/kemono_friends/gray_wolf/gray_wolf_player.mdl",
			name 	= "Gray Wolf",
			desc 	= "",
			beginner = true,
		};
		[6] = {
			path 	= "models/kemono_friends/oinari_sama/oinari_sama_player.mdl",
			name 	= "Oinara Sama",
			desc 	= "",
			beginner = true,
		};
		[7] = {
			path 	= "models/vocaloid/kasane_teto_v1.02/kasane_teto_v1_02_player.mdl",
			name 	= "Kasane",
			desc 	= "",
			beginner = true,
		};
		[8] = {
			path 	= "models/virtual_youtuber/sister_cleaire/sister_cleaire_player.mdl",
			name 	= "Sister Claire",
			desc 	= "",
			beginner = true,
		};
		[9] = {
			path 	= "models/sentry/gtav/mexican/fvagospm.mdl",
			name 	= "Vagos Girl",
			desc 	= "",
			beginner = true,
		};/*
		[10] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};
		[11] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};
		[12] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};*/
	};
	// m
	[2] = { 
		[1] = {
			path 	= "models/sentry/gtav/mexican/mexboss2pm.mdl",
			name 	= "Vagos Leader",
			desc 	= "",
			beginner = true,
		};
		[2] = {
			path 	= "models/sentry/gtav/mexican/pologoon1pm.mdl",
			name 	= "Madrazo Goon",
			desc 	= "",
			beginner = true,
		};
		[3] = {
			path 	= "models/sentry/gtav/mexican/mexgangpm.mdl",
			name 	= "Mexican Gang Member",
			desc 	= "",
			beginner = true,
		};
		[4] = {
			path 	= "models/sentry/gtav/mexican/aztecapm.mdl",
			name 	= "Azteca",
			desc 	= "",
			beginner = true,
		};
		[5] = {
			path 	= "models/sentry/gtav/mexican/mexboss1pm.mdl",
			name 	= "Azteca Leader",
			desc 	= "",
			beginner = true,
		};
		[6] = {
			path 	= "models/player/real/prawnmodels/pepsiman.mdl",
			name 	= "Pepsi-Man",
			desc 	= "",
			beginner = true,
		};
		[7] = {
			path 	= "models/player/tfa_dcu_cptcold.mdl",
			name 	= "Captain Cold",
			desc 	= "",
			beginner = true,
		};
		[8] = {
			path 	= "Guts",
			name 	= "models/player/Berserk/Guts_Teen.mdl",
			desc 	= "",
			beginner = true,
		};/*
		[9] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};
		[10] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};
		[11] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};
		[12] = {
			path 	= "",
			name 	= "",
			desc 	= "",
			beginner = true,
		};*/
	}

}
/*
mdlTable = {

	[1] = { 
	
		[1] = { 
			path	= "models/player/tfa_vi_dwyn.mdl",
			name	= "Dwyn", 
			desc	= "She's cute.",
			beginner = true,
		},
		[2] = { 
			path	= "models/player/tfa_vi_lynn.mdl",
			name	= "Lynn", 
			desc	= "She's got a couple tails.",
			beginner = true,
		},
		[3] = { 
			path	= "models/player/tfa_vi_vella.mdl",
			name	= "Vella", 
			desc	= "She's cute.",
			beginner = true,
		},
		[4] = {
			path = "models/kuma96/a2/a2lh_pm.mdl";
			name = "A2";
			desc = "Cyborgro";
			beginner = true,
		},
		[5] = { 
			path	= "models/player/tfa_vi_dwyn_mgo.mdl",
			name	= "Dwyn (Clothed)", 
			desc	= "With more stuff on ",
			beginner = true,
		},
		[6] = { 
			path	= "models/player/tfa_vi_lynn_mgo.mdl",
			name	= "Lynn (Clothed)", 
			desc	= "You are a pervert.",
			beginner = true,
		},
		[7] = { 
			path	= "models/player/tfa_vi_vella_mgo.mdl",
			name	= "Vella (Clothed)", 
			desc	= "Stunning at least.",
			beginner = true,
		},
		[8] = {
		
			path	= "models/player/ratedr4ryan/triss_tw3.mdl",
			name	= "Triss",
			desc	= "She's got jiggly bobs.",
			beginner = true,
		
		},
		[9] = {
		
			path	= "models/player/ratedr4ryan/yennefer_tw3.mdl",
			name	= "Yennefer",
			desc	= "She's also got jiggly bobs.",
			beginner = true,
		
		},
		[10] = {
		
			path	= "models/player/asia_heleana.mdl",
			name	= "Aisa Heleana",
			desc	= "Quite the adventurer.",
			beginner = true,
		
		},
		[11] = {
		
			path	= "models/characters/tfa_seds_ow_dva.mdl",
			name	= "D.va",
			desc	= "You're a fanboy!",
			beginner = true,
		
		},
		[12] = {
		
			path	= "models/player/ow_tracer.mdl",
			name	= "Tracer",
			desc	= "Her butt is kinda cute in that overall",
			beginner = true,
		
		},
		[13] = {
		
			path	= "models/lightningplayer/lightningplayer.mdl",
			name	= "Lightning",
			desc	= "You always wanted to be her!",
			beginner = true,
		
		},
		[14] = {
		
			path	= "models/player/ratedr4ryan/ciri_tw3.mdl",
			name	= "Ciri",
			desc	= "Cirilla is her full name.",
			beginner = true,
		
		},
		
		[15] = {
			path	= "models/player/dewobedil/dw8/xiaoqiao/dw6dlc.mdl",
			name	= "Xiao Qiao",
			desc	= "Some chinese girl.",
			beginner = true,
		
		},
		[16] = {
			path	= "models/player/doa_honoka_bunny.mdl",
			name	= "Honoka",
			desc	= "Bigger tits",
			beginner = true,
		
		},
		
		[17] = {
			path = "models/kuma96/serah2/serah2_pm.mdl",
			name = "Serah",
			desc = "You can roleplay as sisters now",
			beginner = true,
		},
		
		[18] = {
			path = "models/player/rikku_nk.mdl";
			name = "Rikku";
			desc = "She was cool in the game until you realized who her voice actor was";
			beginner = true,
		};
	
		[19] = {
			path = "models/player/tfa_mgsv_quiet.mdl",
			name = "Quiet",
			desc = "She breathes through her skin.",
			beginner = true,
		};
		[20] = {
			path = "models/models/konnie/tiffany/tiffany.mdl",
			name = "Tiffany",
			desc = "She sadly only fucks everyone in the world.",
			beginner = true,
		};
		[21] = {
			path = "models/kuma96/2b/2b_pm.mdl",
			name = "2B",
			beginner = true,
			desc = "It's a robot, but a person this time.",
		};
		[22] = {
			path = "models/player/dewobedil/doa5/marie_rose/school_p.mdl";
			name = "Marie";
			desc = "She's got some nice dids";
			beginner = true,
		}; 
		[23] = {
			path = "models/player/tfa_p5_futaba.mdl";
			name = "Futaba";
			desc = "Shes cool";
			beginner = true,
		};
		[24] = {
			path = "models/player/dewobedil/vocaloid/l7/default_p.mdl";
			name = "L7";
			desc = "I don't even know her";	
			beginner = true,	
		};
		[25] = {
			path = "models/player/reimu_hakurei_bikini.mdl";
			name = "Reimu Hakurei";
			beginner = true,
			desc = "Fanservice.";		
		};
		[26] = {
			path = "models/player_sinonsao.mdl";
			name = "Sinon!";
			desc = "Animu!";
			beginner = true,
		};
		[27] = {
			path = "models/models/konnie/deborah/deborah.mdl";
			name = "Deborah";
			desc = "In-case you dont like friday the 13th or cant afford it";
			beginner = true,
		};
		[28] = {
			path = "models/models/konnie/punkgirl/punkgirl.mdl";
			name = "AJ Mason";
			desc = "Geralt?";
			beginner = true,
		};
		[29] = {
			path = "models/ontherailroad/bioshock_infinite/elizabeth/player/lizdlcb_player.mdl";
			name = "Elizabeth";
			desc = "Black skirt yum.";
			beginner = true,
		};
		[30] = {
			path = "models/player/dewobedil/vocaloid/haku/bikini_p.mdl";
			name = "Haku";
			desc = "She's got a nice bikini.";
			beginner = true,
		};
		[31] = {
			path = "models/player/tfa_ow_mercy.mdl";
			name = "Mercy";
			desc = "Angela Ziegler Reporting for Duty!";
			beginner = true,
		};
		[32] = {
			path = "models/player/Group01/female_01.mdl";
			name = "Citizen Female 1";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[33] = {
			path = "models/player/Group01/female_02.mdl";
			name = "Citizen Female 2";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[34] = {
			path = "models/player/Group01/female_03.mdl";
			name = "Citizen Female 3";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[35] = {
			path = "models/player/Group01/female_04.mdl";
			name = "Citizen Female 4";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[36] = {
			path = "models/player/Group01/female_05.mdl";
			name = "Citizen Female 5";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[37] = {
			path = "models/player/Group01/female_06.mdl";
			name = "Citizen Female 6";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};

		[38] = {
			path = "models/jazzmcfly/rwby/weiss_schnee.mdl";
			name = "Weiss Schnee";
			beginner = true,
			desc = "Did you know her name is White Snow translated German to English?",
			nopremium = true,
		},
	},

	[2] = { 
	
		[1] = {
			path = "models/grandtheftauto5/michael.mdl",
			name = "Michael Townsley",
			desc = "He's got too many problems with video games, so he joined another one.",
			beginner = true,
		};
		[2] = {
			path = "models/grandtheftauto5/trevor.mdl",
			name = "Trevor Phillips",
			desc = "Not the brightest of people.",
			beginner = true,
		};
	
		[3] = { 
			path	= "models/gtaiv/characters/niko.mdl",
			name	= "Niko Bellic", 
			desc	= "The lesser half of the bowling career.",
			beginner = true,
		},
	
		
		[4] = {
			path = "models/gaben/gabe_3.mdl",
			name = "Gabe",
			desc = "The founder and CEO of Valve?",
			beginner = true,
		},
		
		[5] = { 
			path	= "models/serioussam/sam_stone_bfe.mdl",
			name	= "Sam Stone", 
			desc	= "Fought a couple guys and did some stuff.",
			beginner = true,
		},
		
		[6] = {
			path = "models/player/bully/principal.mdl",
			name = "Crabblesnitch",
			desc = "Quite the rude folk",
			beginner = true,
		
		},
		
		[7] = {
			path	=	"models/deadrising/frankwest.mdl",
			name	= "Frank West",
			desc	= "He was always a fucking orange.",
			beginner = true,
		
		},
		
		[8] = {
			path	= "models/player/if2_colemacgrath.mdl",
			name	= "Cole MacGrath",
			desc	= "Some kyke.",
			beginner = true,
		
		},
		
		[9]	= {
			path = "models/player/tfa_vi_kai_explorer.mdl",
			name = "Kai The Explorer",
			desc = "More polys than the female ones",	
			beginner = true,	
		},
		
		[10] = {
			path = "models/obese_male.mdl",
			name = "Bruno",
			desc = "He's gay on the inside!",
			beginner = true,
		},
		
		[11] = {
			path = "models/player/lulsec.mdl",
			name = "Anon",
			beginner = true,
			desc = "from 4chan",		
		},
		
		[12] = {
			path = "models/player/tfa_vi_kai_bare.mdl",
			name = "Kai Bare",
			desc = "For the ladies?",
			beginner = true,
		},
		[13] = {
			path = "models/winningrook/gtav/fabien/fabien.mdl",
			name = "Fabien",
			desc = "Quite the cuck.",
			beginner = true,
		},
		[14] = {
			path = "models/player/postal2_dude.mdl",
			name = "Postal Dude",
			desc = "From the second one.",
			beginner = true,
		},
		
		[15] = {
			path = "models/fzone96/johncena/johncena.mdl";
			name = "John Cena";
			desc = "Du du du duuu";
			beginner = true,
		};
		[16] = {
			path = "models/player/pyroteknik/ayylmao.mdl",
			name = "Ayy Lmao",
			desc = "Quite the treat",
			beginner = true,
		};
		
		[17] = {
			path = "models/attackheli/attackheli.mdl",
			name = "Attack Helicopter",
			desc = "I don't even know.",
			beginner = true,
		};
		
		[18] = {
			path = "models/player/norrland/homer.mdl",
			name = "Homer Simpson",
			beginner = true,
			desc = "Quite the dumbo.",
		};
		
		[19] = {
			path = "models/aap15/foldername/picolas_cage_pm/picolas_cage_reference.mdl",
			name = "Picolas Cage",
			desc = "Retarded I know.",
			beginner = true,
		};
		
		[20] = {
			path = "models/player/sanic/kojimap.mdl",
			name = "Hideo Kojima",
			desc = "If he isnt in here then what are we doing?",
			beginner = true,
		};
		[21] = {
			path = "models/grandtheftauto5/franklin.mdl",
			name = "Franklin",
			desc = "Arguably, the main character.",
			beginner = true,
		};
		[22] = {
			path = "models/player/Group01/male_01.mdl";
			name = "Citizen Male 1";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[23] = {
			path = "models/player/Group01/male_02.mdl";
			name = "Citizen Male 2";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[24] = {
			path = "models/player/Group01/male_03.mdl";
			name = "Citizen Male 3";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[25] = {
			path = "models/player/Group01/male_04.mdl";
			name = "Citizen Male 4";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[26] = {
			path = "models/player/Group01/male_05.mdl";
			name = "Citizen Male 5";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[27] = {
			path = "models/player/Group01/male_06.mdl";
			name = "Citizen Male 6";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[28] = {
			path = "models/player/Group01/male_07.mdl";
			name = "Citizen Male 7";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[29] = {
			path = "models/player/Group01/male_08.mdl";
			name = "Citizen Male 8";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		[30] = {
			path = "models/player/Group01/male_09.mdl";
			name = "Citizen Male 9";
			beginner = true,
			desc = "This model does not contain any bodygroups.";		
			nopremium = true,
		};
		
		
	};
	
}*/
function ExplodeModelInfo ( path )
	local split = string.Explode("_", path);
	
	local newTable = {};
	
	newTable.sex = 1;
	if (split[1] == "2") then newTable.sex = 2; end
	
	newTable.id = tonumber(split[2]);
	//fsrp.devprintTable( newTable );
	return newTable;
end

function iterateModelTable( gender, id )
	if !gender then return end
	if !id then return end
	local newTable = {};
			
	if gender == 1 then
	
	for k ,v in pairs( mdlTable ) do
		
		//fsrp.devprint( k )
		if k == gender then
			newTable.id = id;
			newTable.sex = 1;
			newTable.mdl = mdlTable[k][id].path ;
			newTable.name = mdlTable[k][id].name;
			newTable.desc = mdlTable[k][id].desc;
			if mdlTable[k][id].desc then
				newTable.beginner = mdlTable[k][id].beginner;
			end
		end
		
	end
	
	elseif gender == 2 then 
	
	for k ,v in pairs( mdlTable ) do
		
		//fsrp.devprint( k )
		if k == gender then
			newTable.id = id;
			newTable.sex = 2;
			newTable.mdl = mdlTable[k][id].path ;
			newTable.name = mdlTable[k][id].name;
			newTable.desc = mdlTable[k][id].desc;
			if mdlTable[k][id].beginner then
				newTable.beginner = mdlTable[k][id].beginner;
			end
		end
		
	end
	
	end
	//fsrp.devprintTable( newTable )
	return newTable;
end
local plyMeta = FindMetaTable('Player');
function plyMeta:GetModelPath( g ,id )

	return iterateModelTable( g, id );
		
end
function tryThis( )
local Models = {};

		local id = 1
		for k, v in pairs(mdlTable) do 
		if mdlTable[k] == "f" then
				
			local iterator = iterateModelTable( 1, id );
				
			if iterator.beginner then
				table.insert(Models, {1, id }); 
			end
			id = id + 1;
		end
		id = 0;
		if mdlTable[k] == "m" then
			local iterator = iterateModelTable( 1, id );
			if iterator.beginner then
				table.insert(Models, {2, id }); 
				
			end
			id = id + 1;
		end
	
	end
	//fsrp.devprintTable(Models)
end
/*
player_manager.AddValidModel( "LightningPlayer", 	"models/lightningplayer/lightningplayer.mdl" );
player_manager.AddValidModel( "Dva", 	"models/characters/tfa_seds_ow_dva.mdl" );
player_manager.AddValidModel( "triss_tw3", 	"models/player/ratedr4ryan/triss_tw3.mdl" );
player_manager.AddValidModel( "yennefer_tw3", 	"models/player/ratedr4ryan/yennefer_tw3.mdl" );
player_manager.AddValidModel( "ciri_tw3", 	"models/player/ratedr4ryan/ciri_tw3.mdl" );
player_manager.AddValidHands( "LightningPlayer", "models/lightningplayer/c_arms.mdl", 0, "00000000" )
player_manager.AddValidHands( "Dva", "models/weapons/c_arms_dva.mdl", 0, "00000000" )
player_manager.AddValidHands( "triss_tw3", "models/player/ratedr4ryan/triss_hands.mdl", 0, "00000000" )
player_manager.AddValidHands( "yennefer_tw3", "models/player/ratedr4ryan/yennefer_hands.mdl", 0, "00000000" )
player_manager.AddValidHands( "ciri_tw3", "models/player/ratedr4ryan/ciri_hands.mdl", 0, "00000000" )

player_manager.AddValidModel( "fc3villager_female", 	"models/farcry/villagers/villager_female.mdl" );
player_manager.AddValidModel( "fc3villager_male", 	"models/farcry/villagers/villager_male.mdl" );
player_manager.AddValidModel( "fc3villager_male_old", 	"models/farcry/villagers/villager_male_old.mdl" );
player_manager.AddValidModel( "fc3villager_female", 	"models/farcry/villagers/villager_female.mdl" );
player_manager.AddValidModel( "fc3villager_male", 	"models/farcry/villagers/villager_male.mdl" );
player_manager.AddValidModel( "fc3villager_male_old", 	"models/farcry/villagers/villager_male_old.mdl" );
player_manager.AddValidHands( "fc3villager_female", "models/farcry/villagers/villager_hands.mdl", 0, "00000000" )
player_manager.AddValidHands( "fc3villager_male", "models/farcry/villagers/villager_hands.mdl", 0, "00000000" )
player_manager.AddValidHands( "fc3villager_male_old", "models/farcry/villagers/villager_hands.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel",  "ciri_tw3", "models/player/ratedr4ryan/ciri_hands.mdl")
list.Set( "PlayerOptionsModel", "LightningPlayer", 	"models/lightningplayer/lightningplayer.mdl" );
list.Set( "PlayerOptionsModel", "Dva", 	"models/characters/tfa_seds_ow_dva.mdl" );
list.Set( "PlayerOptionsModel",  "triss_tw3", 	"models/player/ratedr4ryan/triss_tw3.mdl" );
list.Set( "PlayerOptionsModel", "yennefer_tw3", 	"models/player/ratedr4ryan/yennefer_tw3.mdl" );
list.Set( "PlayerOptionsModel", "Dr. Crabblesnitch", 	"models/player/ratedr4ryan/yennefer_tw3.mdl" );
list.Set( "PlayerOptionsModel", "Pac Civilian", 	"models/player/ratedr4ryan/yennefer_tw3.mdl" );
list.Set( "PlayerOptionsModel", "yennefer_tw3", 	"models/player/ratedr4ryan/yennefer_tw3.mdl" );
list.Set( "PlayerOptionsModel", "yennefer_tw3", 	"models/player/ratedr4ryan/yennefer_tw3.mdl" );
*/
local includeMdls = {
{ name = 'Asia_Heleana',mdl='models/player/Asia_Heleana.mdl'},
{ name = 'Ciri_TW3',mdl='models/player/RatedR4Ryan/Ciri_TW3.mdl'},
{ name = 'Dauge',mdl='models/spike/Dauge.mdl'},
{ name = 'Dr. Crabblesnitch',mdl='models/player/bully/principal.mdl'},
{ name = 'Dreadout - Shelly',mdl='models/player/dewobedil/dreadout/shelly/shelly.mdl', hands='models/player/dewobedil/dreadout/shelly/c_arms/shelly.mdl'},
{ name = 'Dva',mdl='models/characters/tfa_seds_ow_dva.mdl'},
{ name = 'Female Villager A',mdl='models/FarCry/Villagers/Villager_Female_Old.mdl'},
{ name = 'Female Villager B',mdl='models/FarCry/Villagers/Villager_Female.mdl'},
{ name = 'Honoka',mdl='models/player/doa5/honoka/honoka.mdl', hands='models/player/doa5/honoka/c_arms/honoka.mdl'},
{ name = 'IF2: Cole Macgrath',mdl='models/player/IF2_ColeMacgrath.mdl', hands='models/player/if2_colemacgrath_hands.mdl'},
{ name = 'Kizuna AI',mdl='models/player/dewobedil/vocaloid/kizuna_ai/default_p.mdl', hands='models/player/dewobedil/vocaloid/kizuna_ai/c_arms/default_p.mdl'},
{ name = 'Kyoko Kirigiri',mdl='models/player/dewobedil/kyouko_kirigiri/default_p.mdl', hands='models/player/dewobedil/kyouko_kirigiri/c_arms/default_p.mdl'},
{ name = 'LightningPlayer',mdl='models/lightningplayer/lightningplayer.mdl'},
{ name = 'Male Villager A',mdl='models/FarCry/Villagers/Villager_Male_Old.mdl'},
{ name = 'Male Villager B',mdl='models/FarCry/Villagers/Villager_Male.mdl'},
{ name = 'Mikan Tsumiki',mdl='models/player/dewobedil/mikan_tsumiki/default_p.mdl', hands ='models/player/dewobedil/mikan_tsumiki/c_arms/default_p.mdl'},
{ name = 'MrWilliamWytee',mdl='models/WilliamWytee/mrwillianmytee.mdl'},
{ name = 'OW: Tracer',mdl='models/player/ow_tracer.mdl'},
{ name = 'Vindictus-Vella',mdl='models/player/tfa_seds_ow_dva.mdl'},
{ name = 'Pac',mdl='models/pac_pm.mdl'},
{ name = 'Pac Civilian',mdl='models/pac_civ_pm.mdl'},
{ name = 'SamStone',mdl='models/SeriousSam/Sam_Stone_BFE.mdl'},
{ name = 'Triss_TW3',mdl='models/player/RatedR4Ryan/Triss_TW3.mdl'},
{ name = 'Vindictus-Arisha',mdl='models/player/tfa_vi_arisha.mdl'},
{ name = 'Vindictus-Arisha-MGO',mdl='models/player/tfa_vi_arisha_mgo.mdl'},
{ name = 'Vindictus-Dwyn',mdl='models/player/tfa_vi_dwyn.mdl'},
{ name = 'Vindictus-Dwyn-MGO',mdl='models/player/tfa_vi_dwyn_mgo.mdl'},
{ name = 'Vindictus-Kai-Bare',mdl='models/player/tfa_vi_kai_bare.mdl'},
{ name = 'Vindictus-Kai-Explorer',mdl='models/player/tfa_vi_kai_explorer.mdl'},
{ name = 'Vindictus-Lynn',mdl='models/player/tfa_vi_lynn.mdl'},
{ name = 'Vindictus-Lynn-MGO',mdl='models/player/tfa_vi_lynn_mgo.mdl'},
{ name = 'Vindictus-Vella',mdl='models/player/tfa_vi_vella.mdl'},
{ name = 'Vindictus-Vella-MGO',mdl='models/player/tfa_vi_vella_mgo.mdl'},
{ name = 'Xiaoqiao DW6 Costume',mdl='models/player/dewobedil/dw8/xiaoqiao/dw6dlc.mdl', hands='models/player/dewobedil/dw8/xiaoqiao/c_arms/dw6dlc.mdl'},
{ name = 'Yennefer_TW3',mdl='models/player/RatedR4Ryan/Yennefer_TW3.mdl'},
{ name = 'alyx',mdl='models/player/alyx.mdl'},
{ name = 'barney',mdl='models/player/barney.mdl'},
{ name = 'breen',mdl='models/player/breen.mdl'},
{ name = 'charple',mdl='models/player/charple.mdl'},
{ name = 'chell',mdl='models/player/p2_chell.mdl'},
{ name = 'ciri_tw3',mdl='models/player/ratedr4ryan/ciri_tw3.mdl'},
{ name = 'combine',mdl='models/player/combine_soldier.mdl'},
{ name = 'combineelite',mdl='models/player/combine_super_soldier.mdl'},
{ name = 'combineprison',mdl='models/player/combine_soldier_prisonguard.mdl'},
{ name = 'corpse',mdl='models/player/corpse1.mdl'},
{ name = 'css_arctic',mdl='models/player/arctic.mdl'},
{ name = 'css_gasmask',mdl='models/player/gasmask.mdl'},
{ name = 'css_guerilla',mdl='models/player/guerilla.mdl'},
{ name = 'css_leet',mdl='models/player/leet.mdl'},
{ name = 'css_phoenix',mdl='models/player/phoenix.mdl'},
{ name = 'css_riot',mdl='models/player/riot.mdl'},
{ name = 'css_swat',mdl='models/player/swat.mdl'},
{ name = 'css_urban',mdl='models/player/urban.mdl'},
{ name = 'dod_american',mdl='models/player/dod_american.mdl'},
{ name = 'dod_german',mdl='models/player/dod_german.mdl'},
{ name = 'eli',mdl='models/player/eli.mdl'},
{ name = 'fc3villager_female',mdl='models/farcry/villagers/villager_female.mdl'},
{ name = 'fc3villager_male',mdl='models/farcry/villagers/villager_male.mdl'},
{ name = 'fc3villager_male_old',mdl='models/farcry/villagers/villager_male_old.mdl'},
{ name = 'female01',mdl='models/player/Group01/female_01.mdl'},
{ name = 'female02',mdl='models/player/Group01/female_02.mdl'},
{ name = 'female03',mdl='models/player/Group01/female_03.mdl'},
{ name = 'female04',mdl='models/player/Group01/female_04.mdl'},
{ name = 'female05',mdl='models/player/Group01/female_05.mdl'},
{ name = 'female06',mdl='models/player/Group01/female_06.mdl'},
{ name = 'female07',mdl='models/player/Group03/female_01.mdl'},
{ name = 'female08',mdl='models/player/Group03/female_02.mdl'},
{ name = 'female09',mdl='models/player/Group03/female_03.mdl'},
{ name = 'female10',mdl='models/player/Group03/female_04.mdl'},
{ name = 'female11',mdl='models/player/Group03/female_05.mdl'},
{ name = 'female12',mdl='models/player/Group03/female_06.mdl'},
{ name = 'gman',mdl='models/player/gman_high.mdl'},
{ name = 'hostage01',mdl='models/player/hostage/hostage_01.mdl'},
{ name = 'hostage02',mdl='models/player/hostage/hostage_02.mdl'},
{ name = 'hostage03',mdl='models/player/hostage/hostage_03.mdl'},
{ name = 'hostage04',mdl='models/player/hostage/hostage_04.mdl'},
{ name = 'kleiner',mdl='models/player/kleiner.mdl'},
{ name = 'magnusson',mdl='models/player/magnusson.mdl'},
{ name = 'male01',mdl='models/player/Group01/male_01.mdl'},
{ name = 'male02',mdl='models/player/Group01/male_02.mdl'},
{ name = 'male03',mdl='models/player/Group01/male_03.mdl'},
{ name = 'male04',mdl='models/player/Group01/male_04.mdl'},
{ name = 'male05',mdl='models/player/Group01/male_05.mdl'},
{ name = 'male06',mdl='models/player/Group01/male_06.mdl'},
{ name = 'male07',mdl='models/player/Group01/male_07.mdl'},
{ name = 'male08',mdl='models/player/Group01/male_08.mdl'},
{ name = 'male09',mdl='models/player/Group01/male_09.mdl'},
{ name = 'male10',mdl='models/player/Group03/male_01.mdl'},
{ name = 'male11',mdl='models/player/Group03/male_02.mdl'},
{ name = 'male12',mdl='models/player/Group03/male_03.mdl'},
{ name = 'male13',mdl='models/player/Group03/male_04.mdl'},
{ name = 'male14',mdl='models/player/Group03/male_05.mdl'},
{ name = 'male15',mdl='models/player/Group03/male_06.mdl'},
{ name = 'male16',mdl='models/player/Group03/male_07.mdl'},
{ name = 'male17',mdl='models/player/Group03/male_08.mdl'},
{ name = 'male18',mdl='models/player/Group03/male_09.mdl'},
{ name = 'medic01',mdl='models/player/Group03m/male_01.mdl'},
{ name = 'medic02',mdl='models/player/Group03m/male_02.mdl'},
{ name = 'medic03',mdl='models/player/Group03m/male_03.mdl'},
{ name = 'medic04',mdl='models/player/Group03m/male_04.mdl'},
{ name = 'medic05',mdl='models/player/Group03m/male_05.mdl'},
{ name = 'medic06',mdl='models/player/Group03m/male_06.mdl'},
{ name = 'medic07',mdl='models/player/Group03m/male_07.mdl'},
{ name = 'medic08',mdl='models/player/Group03m/male_08.mdl'},
{ name = 'medic09',mdl='models/player/Group03m/male_09.mdl'},
{ name = 'medic10',mdl='models/player/Group03m/female_01.mdl'},
{ name = 'medic11',mdl='models/player/Group03m/female_02.mdl'},
{ name = 'medic12',mdl='models/player/Group03m/female_03.mdl'},
{ name = 'medic13',mdl='models/player/Group03m/female_04.mdl'},
{ name = 'medic14',mdl='models/player/Group03m/female_05.mdl'},
{ name = 'medic15',mdl='models/player/Group03m/female_06.mdl'},
{ name = 'monk',mdl='models/player/monk.mdl'},
{ name = 'mossman',mdl='models/player/mossman.mdl'},
{ name = 'mossmanarctic',mdl='models/player/mossman_arctic.mdl'},
{ name = 'odessa',mdl='models/player/odessa.mdl'},
{ name = 'police',mdl='models/player/police.mdl'},
{ name = 'policefem',mdl='models/player/police_fem.mdl'},
{ name = 'refugee01',mdl='models/player/Group02/male_02.mdl'},
{ name = 'refugee02',mdl='models/player/Group02/male_04.mdl'},
{ name = 'refugee03',mdl='models/player/Group02/male_06.mdl'},
{ name = 'refugee04',mdl='models/player/Group02/male_08.mdl'},
{ name = 'skeleton',mdl='models/player/skeleton.mdl'},
{ name = 'stripped',mdl='models/player/soldier_stripped.mdl'},
{ name = 'triss_tw3',mdl='models/player/ratedr4ryan/triss_tw3.mdl'},
{ name = 'yennefer_tw3',mdl='models/player/ratedr4ryan/yennefer_tw3.mdl'},
{ name = 'zombie',mdl='models/player/zombie_classic.mdl'},
{ name = 'zombiefast',mdl='models/player/zombie_fast.mdl'},
{ name = 'zombine',mdl='models/player/zombie_soldier.mdl'},
{ name = 'frankwest' , mdl='models/deadrising/frankwest.mdl'},
{ name = 'nikobelic' , mdl='models/gtaiv/characters/niko.mdl'},
{ name = 'kaibare', mdl='models/player/tfa_vi_kai_bare.mdl'},
{ name = 'vckaiclothed' , mdl = 'models/player/tfa_vi_kai_explorer.mdl' },{name = 'hospitalfemale_1' , mdl = 'models/vlrpgaming/hospitalfemale01.mdl'};
{name = 'hospitalfemale_2' , mdl = 'models/vlrpgaming/hospitalfemale02.mdl'};
{name = 'hospitalfemale_3' , mdl = 'models/vlrpgaming/hospitalfemale03.mdl'};
{name = 'hospitalfemale_4' , mdl = 'models/vlrpgaming/hospitalfemale04.mdl'};
{name = 'hospitalfemale_5' , mdl = 'models/vlrpgaming/hospitalfemale05.mdl'};
{name = 'hospitalfemale_6' , mdl = 'models/vlrpgaming/hospitalfemale06.mdl'};
{name = 'hospitalfemale_7' , mdl = 'models/vlrpgaming/hospitalfemale07.mdl'};
{name = 'hospitalfemale_8' , mdl = 'models/vlrpgaming/hospitalfemale08.mdl'};
{name = 'hospitalfemale_9' , mdl = 'models/vlrpgaming/hospitalfemale09.mdl'};
{name = 'hospitalfemale_10' , mdl = 'models/vlrpgaming/hospitalfemale10.mdl'};
{name = 'hospitalfemale_11' , mdl = 'models/vlrpgaming/hospitalfemale11.mdl'};

			{ name = "hospitalmale_1" ;  mdl = "models/vlrpgaming/hospitalmale01.mdl"};
			{ name = "hospitalmale_2";  mdl = "models/vlrpgaming/hospitalmale02.mdl"};
			{ name = "hospitalmale_3";  mdl = "models/vlrpgaming/hospitalmale03.mdl"};
			{ name = "hospitalmale_4";  mdl = "models/vlrpgaming/hospitalmale04.mdl"};
			{ name = "hospitalmale_5";  mdl = "models/vlrpgaming/hospitalmale05.mdl"};
			{ name = "hospitalmale_6";  mdl = "models/vlrpgaming/hospitalmale06.mdl"};
			{ name = "hospitalmale_7";  mdl = "models/vlrpgaming/hospitalmale07.mdl"};
			{ name = "hospitalmale_8";  mdl = "models/vlrpgaming/hospitalmale08.mdl"};
			{ name = "hospitalmale_9";  mdl = "models/vlrpgaming/hospitalmale09.mdl"};
			{ name = "hospitalmale_10";  mdl = "models/vlrpgaming/hospitalmale10.mdl"};
			{ name = "hospitalmale_11";  mdl = "models/vlrpgaming/hospitalmale11.mdl"};
			{ name = "hospitalmale_12";  mdl = "models/vlrpgaming/hospitalmale12.mdl"};
			{ name = "hospitalmale_13";  mdl = "models/vlrpgaming/hospitalmale13.mdl"};
			{ name = "hospitalmale_14";  mdl = "models/vlrpgaming/hospitalmale14.mdl"};
			{ name = "hospitalmale_15";  mdl = "models/vlrpgaming/hospitalmale15.mdl"};
			{ name = "hospitalmale_16";  mdl = "models/vlrpgaming/hospitalmale16.mdl"};
			{ name = "hospitalmale_17";  mdl = "models/vlrpgaming/hospitalmale17.mdl"};
			{ name = "hospitalmale_18";  mdl = "models/vlrpgaming/hospitalmale18.mdl"};
}
/*
function refreshModelTable()


	for k , v in pairs( includeMdls ) do
		player_manager.AddValidModel( v.name , v.mdl );
		list.Set( "PlayerOptionsModel", v.name,  v.mdl );
		if v.hands then
		
			player_manager.AddValidHands( v.name , v.mdl, 0, "00000000" )
			
		end
	end
	return true;
end

timer.Create("refreshmodels", 30, 0 , function()

	refreshModelTable()
end)
*/
//lua_run for k , v in pairs( mdlTable[2] ) do for x, y in pairs( player_manager.AllValidModels() ) do if y == v.path then Entity(1):PrintMessage(HUD_PRINTCONSOLE, x ) end end end

fsrp.devprint( "[WC-RP] - Accquired Model Library" )