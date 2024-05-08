
fsrp.devprint( "[560Roleplay] - Fetching Model Library" )

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


mdlTable = {

	[1] = { 
	
		[1] = { 
			path	= "models/player/tfa_vi_arisha.mdl",
			name	= "Arisha", 
			desc	= "She's cute.",
			beginner = true,
		},
		[2] = { 
			path	= "models/player/tfa_vi_dwyn.mdl",
			name	= "Dwyn", 
			desc	= "She's cute.",
			beginner = true,
		},
		[3] = { 
			path	= "models/player/tfa_vi_lynn.mdl",
			name	= "Lynn", 
			desc	= "She's got a couple tails.",
			beginner = true,
		},
		[4] = { 
			path	= "models/player/tfa_vi_vella.mdl",
			name	= "Vella", 
			desc	= "She's cute.",
			beginner = true,
		},
		[5] = { 
			path	= "models/farcry/villagers/villager_female.mdl",
			name	= "Female Citizen", 
			desc	= "She's quite old.",
		},
		[6] = { 
			path	= "models/player/tfa_vi_arisha_mgo.mdl",
			name	= "Arisha (Clothed)", 
			desc	= "Looks kinda cute with all those sweaters.",
		},
		[7] = { 
			path	= "models/player/tfa_vi_dwyn_mgo.mdl",
			name	= "Dwyn (Clothed)", 
			desc	= "With more stuff on ",
		},
		[8] = { 
			path	= "models/player/tfa_vi_lynn_mgo.mdl",
			name	= "Lynn (Clothed)", 
			desc	= "You are a pervert.",
		},
		[9] = { 
			path	= "models/player/tfa_vi_vella_mgo.mdl",
			name	= "Vella (Clothed)", 
			desc	= "Stunning at least.",
		},
		[10] = {
		
			path	= "models/player/ratedr4ryan/triss_tw3.mdl",
			name	= "Triss",
			desc	= "She's got jiggly bobs.",
		
		},
		[11] = {
		
			path	= "models/player/ratedr4ryan/yennefer_tw3.mdl",
			name	= "Yennefer",
			desc	= "She's also got jiggly bobs.",
		
		},
		[12] = {
		
			path	= "models/player/asia_heleana.mdl",
			name	= "Aisa Heleana",
			desc	= "Quite the adventurer.",
		
		},
		[13] = {
		
			path	= "models/characters/tfa_seds_ow_dva.mdl",
			name	= "D.va",
			desc	= "You're a fanboy!",
		
		},
		[14] = {
		
			path	= "models/player/ow_tracer.mdl",
			name	= "Tracer",
			desc	= "Her butt is kinda cute in that overall",
		
		},
		[15] = {
		
			path	= "models/lightningplayer/lightningplayer.mdl",
			name	= "Lightning",
			desc	= "You always wanted to be her!",
		
		},
		[16] = {
		
			path	= "models/player/ratedr4ryan/ciri_tw3.mdl",
			name	= "Ciri",
			desc	= "Cirilla is her full name.",
		
		},
		
		[17] = {
			path	= "models/player/dewobedil/mikan_tsumiki/default_p.mdl",
			name	= "Mikan Tsumiki",
			desc	= "She was an anime",
		
		},
		[18] = {
			path	= "models/player/dewobedil/kyouko_kirigiri/default_p.mdl",
			name	= "Kyouko Kirigiri",
			desc	= "Her last name is as hard to spell as my dick.",		
		},
		
		[19] = {
			path	= "models/player/dewobedil/dw8/xiaoqiao/dw6dlc.mdl",
			name	= "Xiao Qiao",
			desc	= "Some chinese girl.",
		
		},
		
		[20] = {
			path	= "models/player/dewobedil/dreadout/shelly/shelly.mdl",
			name	= "Shelly",
			desc	= "Tits.",
		
		},
		
		[21] = {
			path	= "models/player/doa5/honoka/honoka.mdl",
			name	= "Honoka",
			desc	= "Bigger tits",
		
		},
		
		
		[22] = {
			path = "models/player/wdm_carol_player.mdl",
			name = "Carol",
			desc = "She's such a backwards bitch.",
		},
		
		[23] = {
			path = "models/player/wdm_maggie_player.mdl",
			name = "Maggie",
			desc = "Fuck glen dead (literally)",
		},
		
		[24] = {
			path = "models/player/wdm_michonne_player.mdl",
			name = "Michonne",
			desc = "Standard black character",
		},
		
		[25] = {
			path = "models/player/wdm_rosita_s4_player.mdl",
			name = "Rosita",
			desc = "She was cute",
		},
		
		--[26] = {
			--path = "",
			--name = "",
			--desc = "",
		--},
		
	},

	[2] = { 
	
		[1] = { 
			path	= "models/farcry/villagers/villager_male_old.mdl",
			name	= "Old Citizen", 
			desc	= "Looks quite sad.",
			beginner = true,
		},
		
	
		[2] = { 
			path	= "models/farcry/villagers/villager_male.mdl",
			name	= "Young Citizen", 
			desc	= "Failed to see why this guy hasn't made money yet.",
			beginner = true,
		},
		
	
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
		},
		
		[6] = {
			path = "models/player/bully/principal.mdl",
			name = "Crabblesnitch",
			desc = "Quite the rude folk",
		
		},
		
		[7] = {
			path	=	"models/deadrising/frankwest.mdl",
			name	= "Frank West",
			desc	= "He was always a fucking orange.",
		
		},
		
		[8] = {
			path	= "models/player/if2_colemacgrath.mdl",
			name	= "Cole MacGrath",
			desc	= "Some kyke.",
		
		},
		
		[9]	= {
			path = "models/player/tfa_vi_kai_explorer.mdl",
			name = "Kai The Explorer",
			desc = "More polys than the female ones",		
		},
		
		[9] = {
			path = "models/player/wdm_abraham_player.mdl",
			name = "Abraham",
			desc = "He's ginger.",			
		},
		
		[10] = {
			path = "models/player/wdm_carl_player.mdl",
			name = "Carl Grimes",
			desc = "He's a pussy but ends up maturing",		
		},
		
		[11] = {
			path = "models/player/wdm_daryl_player.mdl",
			name = "Daryl",
			desc = "He's cool",
		},
		
		[12] = {
			path = "models/player/wdm_glenn_player.mdl",
			name = "Glen",
			desc = "He had to die",
		},
		
		[13] = {
			path = "models/player/wdm_jesus_player.mdl",
			name = "Jesus (TWD)",
			desc = "He's not the real jesus",
		},
		
		[14] = {
			path = "models/player/wdm_morgan_player.mdl",
			name = "Morgan",
			desc = "Atheism and black people dont mix",
		},
		
		[15] = {
			path = "models/player/wdm_negan_player.mdl",
			name = "Negan",
			desc = "Niggronomous jones #5",
		},
		
		[16] = {
			path = "models/player/wdm_rick_player.mdl",
			name = "Rick",
			desc = "Rick the man",
		},
		
		[17] = {
			path = "models/obese_male.mdl",
			name = "Bruno",
			desc = "He's gay on the inside!",
			beginner = true,
		},
		
		[18] = {
			path = "models/player/lulsec.mdl",
			name = "Anon",
			beginner = true,
			desc = "from 4chan",		
		},
		
		[19] = {
			path = "models/player/tfa_vi_kai_bare.mdl",
			name = "Kai Bare",
			desc = "For the ladies?",
		},
	}
}

function ExplodeModelInfo ( path )
	local split = string.Explode("_", path);
	
	local newTable = {};
	
	newTable.sex = 1;
	if (split[1] == "1") then newTable.sex = 1; end
	if (tonumber(split[1]) == 2) then newTable.sex = 2; end
	
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
	fsrp.devprintTable(Models)
end

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
{ name = 'Overwatch-D.Va',mdl='models/player/tfa_seds_ow_dva.mdl'},
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
{ name = 'vckaiclothed' , mdl = 'models/player/tfa_vi_kai_explorer.mdl' },
}
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
//lua_run for k , v in pairs( mdlTable[2] ) do for x, y in pairs( player_manager.AllValidModels() ) do if y == v.path then Entity(1):PrintMessage(HUD_PRINTCONSOLE, x ) end end end

fsrp.devprint( "[560Roleplay] - Accquired Model Library" )