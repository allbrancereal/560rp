
//include("shared/items/dev/test.lua")
//AddCSLuaFile("shared/items/dev/test.lua")
fsrp = fsrp || {};
DarkRP = nil;



GM.Name		= "560Roleplay";

GM.Author	= "Fried Rice";

GM.Email	= "support@560roleplay.com";

GM.Website	= "www.560rp.com";

GM_MODE		= 1;

VALID_CHARACTERS 			= 	{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
								"1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ",", "-", "_", "=", "+", "0"};

VALID_NAME_CHARACTERS		=	{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
								"-"};
MODEL_AVAILABLE = {};
						

INVENTORY_WIDTH 			= 13;
INVENTORY_HEIGHT 			= 6;

EQUIP_WEAPON_MAIN 			= 1;
EQUIP_MAIN 					= 1;
EQUIP_WEAPON_SIDE 			= 2;
EQUIP_SIDE 					= 2;
EQUIP_HAT = 3;
EQUIP_HAT_SIDE = 3;

SEX_CHANGE_COST = 25000;
FACIAL_COST = 1000;
HEALTH_RESET_COST = 1000;

PAYDAY_TIME = 600;
PAYDAY_AMOUNT = 55;

BUISINESS_LEVEL_CAP = 3; 

MAX_AIRPORT_SHARES	= 30;
MAX_BANK_SHARES		= 30;
MAX_CINEMA_SHARES	= 30;
MAX_FARMER_SHARES	= 30;
MAX_GAS_SHARES		= 30;
MAX_HARBOR_SHARES	= 30;
MAX_LAB_SHARES		= 30;
MAX_LUMBER_SHARES	= 30;
MAX_MINING_SHARES	= 30;
MAX_RES_SHARES		= 30;
MAX_STRIP_SHARES	= 30;
MAX_WEAP_SHARES		= 30;
_adviceTable = {
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

function fsrp.devprint( t )
	
	if CLIENT then
	
		if GM_MODE != 0 then
		
			print( t )
			
		end
	
	end
	
end
	
function fsrp.devprintTable( t )
	
	if CLIENT then
	
		if GM_MODE != 0 then
		
			PrintTable( t )
			
		end
	 
	end
	
end			
fsrp.devprint("[560Roleplay] - Fetching Shared Files" )		


fsrp.devprint("[560Roleplay] - Fetched Shared Files" )

fsrp.devprint("[560Roleplay] - Fetching Teams" )

TEAM_UNCONNECTED = 0;
TEAM_CIVILLIAN = 1;
TEAM_POLICE = 2;
TEAM_PARAMEDIC = 3;
TEAM_MAYOR = 4;

team.SetUp(TEAM_UNCONNECTED, "Unconnected" , Color( 56, 56, 56 ) )
team.SetUp(TEAM_CIVILLIAN , "Civillian" , Color( 102, 178, 255 ) )
team.SetUp(TEAM_POLICE , "Police Officer", Color( 95, 228, 47 ) )
team.SetUp(TEAM_PARAMEDIC , "Paramedic", Color( 255, 41,41 ) )
team.SetUp(TEAM_MAYOR , "Mayor", Color( 188, 255, 0 ) )

fsrp.devprint("[560Roleplay] - Teams Loaded" )

function GM:Initialize()
end
fsrp.devprint("[560Roleplay] - Sharedside Initialized" )

