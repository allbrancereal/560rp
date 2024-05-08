
//include("shared/items/dev/test.lua")
//AddCSLuaFile("shared/items/dev/test.lua")
fsrp = fsrp || {};
fsrp.functions = {}
fsrp.cache = {}
DarkRP = nil;



GM.Name		= "CrimeLife Network";

GM.Author	= "Tibba";

GM.Email	= "";

GM.Website	= "";

GM_MODE		= 1;

LastGlobalWeedBoost = os.time();
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



TEAM_UNCONNECTED = 0;
TEAM_CIVILLIAN = 1;
TEAM_POLICE = 2;
TEAM_PARAMEDIC = 3;
TEAM_MAYOR = 4;
TEAM_SWAT = 5;


team.SetUp(TEAM_UNCONNECTED, "Unconnected" , Color( 56, 56, 56 ) )
team.SetUp(TEAM_CIVILLIAN , "Civillian" , Color( 102, 178, 255 ) )
team.SetUp(TEAM_POLICE , "Police Officer", Color( 95, 228, 47 ) )
team.SetUp(TEAM_SWAT , "SWAT", Color( 25, 228, 47 ) )
team.SetUp(TEAM_PARAMEDIC , "Paramedic", Color( 255, 41,41 ) )
team.SetUp(TEAM_MAYOR , "Mayor", Color( 188, 255, 0 ) )


function GM:Initialize()
end 


local function IncludeProperties()

	include("wcroleplay/gamemode/shared/properties/id_1.lua")
	include("wcroleplay/gamemode/shared/properties/rp_evo.lua")

end
hook.Add("InitPostEntity", "MakeVehicleListPostEntity",function()

	IncludeProperties()
   
end ) 


hook.Add("PlayerFullyConnected", "ReloadPropertiesSV",function(_p, _isclient)

	if !fsrp.LoadedEnts || fsrp.LoadedEnts == nil then

		fsrp.LoadedEnts = true;
		IncludeProperties()

	end
	/*
	local tb = getmetatable(_p)
    local g_oldes = tb.MetaBaseClass.EmitSound;

	     tb.MetaBaseClass.EmitSound = function( a , b, c, d , e )
	        hook.Run("EmitSound_EV", _p, a,b,c,d,e )
	        //if(c == nil) then 
	        	//c = 100 
	        //end 
	        //if(d == nil) then 
	        	//d = 100
	        //end
	           g_oldes(a, b, c, d,e)
	    end
	*/

    

end ) 
 
hook.Add("EmitSound_EV","EmitSound_EV_Implementation", function( _p,a, b, c, d,e )
	local name=a;
	local lv=b;
	local pitchperc=c;
	local vol=d;
	local chan=e;
	hook.Run("EmitSound_Call", _p ,a,b,c,d,e)
end)
 
local sound = sound;

local _oldf = sound.Play;

sound.Play = function( a,b,c,d,e )
	hook.Run("SoundPlay_EV", a,b,c,d,e )
	_oldf(a,b,c,d,e );

end

hook.Add("SoundPlay_EV","SoundPlay_EV_Implementation", function( a,b )
	local name=a;
	local pos=b;
	hook.Run("SoundPlay_Call", name, pos )
end)

local _eMeta = FindMetaTable( "Entity" )

 
local LifeAlert = 	{
	/*
	{"", Vector(, 400.582397), Vector( ,-600.22523)};
 	*/
 	// Industrial
	["rp_downtown_tits_v2"] = {
		{ 'Uptown' , Vector(-946.25592,387.03125,211.33817), Vector(941.25342,941.90558,-195.96875)}; 
		{ 'Downtown' , Vector(-1418.96875,952.14886,229.59842), Vector(-1060.26953,-744.12494,-195.96875)}; 
		{ 'Fountain' , Vector(-2927.95996,-787.61542,371.97769), Vector(-1060.89868,-2431.96875,-195.66292)}; 
		{ "Mario's Warehouse" , Vector(-767.96875,959.55774,-34.68239), Vector(-1150.90967,1356.85132,-195.96875)}; 
		{ 'Marr. Freight Company' , Vector(-7.55695,1991.96875,-195.24332), Vector(-704.03125,968.49988,59.66284)}; 
{ 'Overlook Shop' , Vector(-1549.10278,-463.8512,-196.96875), Vector(-2032.85828,-757.71857,-85.03125)}; 
{ 'The Overlook' , Vector(-2051.34399,-767.04333,-79.96377), Vector(-1445.10645,-135.03125,348.15634)}; 
{ 'Behind the Police Dept.' , Vector(-2036.60876,-454.23282,-69.49139), Vector(-1434.84277,-171.10773,-195.96875)}; 
{ 'Overlook Staircase' , Vector(-2035.00244,-204.78716,-196.96875), Vector(-2195.76172,-430.74124,143.96875)}; 
{ 'Police Department' , Vector(-2507.96875,1108.80786,231.87099), Vector(-1489.41345,-3.47973,-148.93192)}; 
{ 'Police Department' , Vector(-1485.25281,7.50313,138.96875), Vector(-1921.50916,-132.23987,-196.25113)}; 
{ 'Police Department' , Vector(-1485.58752,8.49828,-24.03125), Vector(-1665.96875,373.03616,-158.87079)}; 
{ 'Police Department' , Vector(-1151.13049,1133.95422,187.96875), Vector(-1454.62488,956.27539,12.03125)}; 
{ 'Theatre' , Vector(-1156.03125,973.31207,-74.81866), Vector(-2014.96875,1753.20117,-195.13828)}; 
{ 'Theatre' , Vector(-2014.96875,1658.84204,101.72433), Vector(-1589.73108,999.86597,-195.96875)}; 
{ 'Theatre' , Vector(-2013.39526,2122.96875,15.45826), Vector(-1569.50427,1424.03125,-195.19302)}; 
{ 'Sketchy Alley' , Vector(-1151.71729,1992.03125,347.94043), Vector(-704.21436,2143.18921,-195.96875)}; 
{ 'Sketchy Alley' , Vector(-704.03125,968.58423,58.6946), Vector(-761.05591,2143.96875,-193.10529)}; 
{ 'Back Alley Condo' , Vector(-776.09192,1983.96875,-84.45974), Vector(-1150.74536,1447.38708,-195.96875)}; 
{ 'Safe-X Change' , Vector(496.03952,951.96875,63.72517), Vector(943.96875,1280.26599,-195.65479)}; 
{ 'Bar' , Vector(943.57727,1375.96875,-195.64291), Vector(495.96875,1887.84619,91.7747)}; 
{ 'Bar Alley' , Vector(496.36353,1888.03125,91.86197), Vector(940.17798,1990.59534,-195.96875)}; 
{ 'Safe-X Change Alley' , Vector(495.96875,1279.63049,62.34544), Vector(939.3407,1375.96875,-193.33734)}; 
{ 'Uptown' , Vector(-16.58167,1991.96875,151.06143), Vector(442.1507,413.60834,-195.96875)}; 
{ 'Small Industrial' , Vector(1526.6355,2640.3606,167.96875), Vector(-15.65748,4238.93994,-195.96875)}; 
{ 'Small Industrial Shop - Downstairs' , Vector(512.07861,3689.65576,-48.03125), Vector(1518.96875,2880.17896,-195.61836)}; 
{ 'Small Industrial Shop - Back Alley' , Vector(503.85553,2871.96875,165.34352), Vector(1519.96875,2648.85718,-195.9671)}; 
{ 'Small Industrial Shop - Upstairs' , Vector(512.00446,2880.03125,106.78561), Vector(1518.42432,3690.96875,-38.98756)}; 
{ 'Outskirt Warehouse' , Vector(2568.09229,5888.03125,45.7417), Vector(3519.71704,6424.03125,-195.01321)}; 
{ 'Strip Club Alley' , Vector(3519.71045,6424.56836,-195.96875), Vector(3264.03125,7585.70752,156.87703)}; 
{ 'Strip Club Alley' , Vector(3263.41382,6560.03125,193.89174), Vector(2562.66968,6719.40527,-195.96875)}; 
{ 'Outskirts' , Vector(2559.96875,5888.0625,168.25246), Vector(18.98953,7543.96875,-164.09814)}; 
{ 'Outskirts - Hidden Cranny' , Vector(-311.79703,8390.39648,299.96875), Vector(479.09137,8112.03125,-195.1716)}; 
{ 'Outskirts - Hidden Cranny' , Vector(215.9075,8112.12109,-75.96875), Vector(-310.97144,7593.44971,299.96875)}; 
{ 'Outskirt Apt. 2F' , Vector(-481.03125,7472.89307,71.96434), Vector(-622.54462,6146.46045,-55.96875)}; 
{ 'Outskirt Apt. Stairs' , Vector(-481.09134,6856.9458,71.96875), Vector(-280.06268,6771.08447,-191.96875)}; 
{ 'Outskirt Apt. Lobby' , Vector(-24.03125,6465.15674,-72.40614), Vector(-279.49432,7152.96875,-191.39104)}; 
{ 'Outskirt Shop' , Vector(488.56226,6919.91553,84.03125), Vector(1007.60706,6399.96875,-195.79141)}; 
{ 'Outskirt Storage Space' , Vector(1312.03125,6416.2124,-76.09257), Vector(2046.24841,6895.96875,-195.4185)}; 
{ 'Outskirt Townhouse' , Vector(2096.89258,5888.03125,56.61507), Vector(1585.03125,5168.06934,-195.93135)}; 
{ 'Playground Townhouse' , Vector(1039.87988,5888.03125,68.08591), Vector(456.03125,5338.41016,-195.84448)}; 
{ 'Church Playground' , Vector(1694.0625,5888.03125,-195.18344), Vector(1040.03125,5176.28076,166.18794)}; 
{ 'Church Grass Area' , Vector(448.78952,4272.03125,167.18423), Vector(1111.60144,5158.77051,-195.60201)}; 
{ 'Church Grass Area' , Vector(1904.92358,5157.96875,167.57014), Vector(1494.68433,4272.03125,-179.74164)}; 
{ 'Church' , Vector(1111.60144,5158.77051,-195.60201), Vector(1487.74817,4272.03125,166.35551)}; 
{ 'Church Grass Area' , Vector(1100.15405,4472.89063,-196), Vector(1905.96875,4272.36328,168.00368)}; 
{ 'Small Industrial - Outskirt Tunnel' , Vector(-15.96875,4238.58936,37.75385), Vector(447.77609,5889.03076,-195.96875)}; 
{ 'Small Industrial - Ghetto Tunnel' , Vector(1526.86682,4239.96875,24.65912), Vector(2094.25391,3699.2644,-195.96875)}; 
{ 'Small Industrial - Uptown Tunnel' , Vector(415.51501,2640.03125,35.15282), Vector(-3.66332,1990.63757,-195.96875)}; 
{ 'Brick Apt. 2F-6' , Vector(1944.03125,7943.521,71.21921), Vector(2343.13281,7600.62207,-55.96875)}; 
{ 'Brick Apt. 2F-5' , Vector(1935.96875,7943.5332,70.97183), Vector(1640.03125,7600.78711,-55.40679)}; 
{ 'Brick Apt. 2F-4' , Vector(1631.96875,7600.90918,70.96542), Vector(1336.03125,7943.69678,-55.11596)}; 
{ 'Brick Apt. 2F-3' , Vector(1223.96875,7601.06738,70.60471), Vector(928.75745,7943.96875,-55.19497)}; 
{ 'Brick Apt. 2F-2' , Vector(918.73291,7943.96875,70.68658), Vector(624.48303,7600.03125,-55.36959)}; 	
{ 'Brick Apt. 2F-1' , Vector(615.72516,7600.03125,-55.27075), Vector(216.03125,7943.92822,71.79467)}; 
{ 'Brick Apt. 2F' , Vector(225.70064,7960.03125,71.51636), Vector(2335.96875,8103.47852,-55.54903)}; 
{ 'Brick Apt Entrance' , Vector(1327.42175,7961.03857,71.96875), Vector(1232.03125,7597.09033,-195.74121)}; 
{ 'Outskirt Apt. 2F-5' , Vector(-24.71827,6153.03125,71.49339), Vector(-464.8291,6448.875,-55.96875)}; 
{ 'Outskirt Apt. 2F-7' , Vector(-464.96875,6457.25391,71.77989), Vector(-25.01035,6752.77588,-55.96875)}; 
{ 'Outskirt Apt. 2F-3' , Vector(-24.03125,6866.22461,71.97142), Vector(-464.32709,7160.96875,-55.73327)}; 
{ 'Outskirt Apt. 2F-1' , Vector(-463.77612,7464.96875,71.42255), Vector(-25.71596,7169.03125,-55.54977)}; 
{ 'Outskirt Apt. 2F-2' , Vector(-642.43494,7416.96875,71.00185), Vector(-982.76898,7121.03125,-55.38368)}; 
{ 'Outskirt Apt. 2F-4' , Vector(-640.03125,7111.60596,71.90489), Vector(-983.12445,6817.03125,-54.99586)}; 
{ 'Outskirt Apt. 2F-8' , Vector(-640.70471,6800.96875,71.71264), Vector(-983.96875,6505.16699,-55.94901)}; 
{ 'Outskirt Apt. 2F-6' , Vector(-641.0437,6201.03125,71.15346), Vector(-983.96875,6496.79248,-55.11214)}; 
{ 'Small Industrial Warehouse' , Vector(-16.16007,3168.03125,167.6832), Vector(-1464.21179,4407.96875,-194.989)}; 
{ 'Ghetto Apt. 2F-1' , Vector(2552.03125,4341.98242,123.4052), Vector(3099.67334,4980.34229,0.03125)}; 
{ 'Ghetto Apt. 2F' , Vector(3108.03125,4979.79688,123.93654), Vector(3539.96875,4576.22559,1.03689)}; 
{ 'Ghetto Apt. Balcony' , Vector(3547.96875,4567.34766,0.26106), Vector(3120.24438,4320.85107,166.53568)}; 
{ 'Ghetto Apt. 1F' , Vector(3399.61548,4341.03125,-12.50627), Vector(3256.05518,4664.53516,-135.96875)}; 
{ 'Ghetto Apt. 1F' , Vector(2552.17798,4664.43604,-12.03125), Vector(3475.90527,4783.37646,-135.96875)}; 
{ 'Ghetto Apt. Stairs' , Vector(3539.49585,4980.96875,123.89066), Vector(3471.69043,4341.87158,-271.96875)}; 
{ 'Ghetto Apt. -1F' , Vector(3008.89819,4341.19824,-148.03125), Vector(3475.37695,4599.06104,-271.96875)}; 
{ 'Ghetto Apt. -1F' , Vector(3008.29199,4980.96875,-148.62135), Vector(3209.92261,4341.03125,-271.56436)}; 
{ 'Ghetto Apt. -1F-1' , Vector(3224.6543,4608.23438,-148.03125), Vector(3538.77539,4980.96875,-271.29443)}; 
{ 'Ghetto Apt. -1F-2' , Vector(2999.94922,4342.2085,-148.03125), Vector(2552.03125,4655.51514,-271.13721)}; 
{ 'Ghetto Apt -1F-3' , Vector(2998.79761,4665.38135,-148.03125), Vector(2552.03125,4980.81641,-271.64038)}; 
{ 'Ghetto Shop' , Vector(2320.03125,3240.62036,-64.86374), Vector(1770.24597,3758.96875,-195.88237)}; 
{ 'Ghetto Townhouse Alley' , Vector(2319.80078,3096.03125,67.99435), Vector(1762.5083,3239.96875,-195.22963)}; 
{ 'Ghetto Townhouse Alley' , Vector(1887.96875,3095.94751,67.16407), Vector(1762.31616,2808.77026,-195.96875)}; 
{ 'Ghetto Townhouse' , Vector(1770.23071,2799.96875,-194.30045), Vector(2311.96875,2512.10547,59.96278)}; 
{ 'Ghetto Townhouse' , Vector(2311.68286,2512.03125,59.66702), Vector(1897.49487,3086.32227,-195.96875)}; 
{ 'Ghetto Parking Lot' , Vector(2817.37207,3777.28101,-195.96875), Vector(3672.62134,3010.96875,73.89367)}; 
{ 'Central Ghetto Townhouse' , Vector(3672.62134,3010.96875,73.89367), Vector(4105.26318,3698.86548,-195.96875)}; 
{ 'Ghetto Alleyway' , Vector(4090.90991,2510.10449,167.96875), Vector(3784.87964,1984.52966,-195.96875)}; 
{ 'Alleyway Ghetto Townhouse' , Vector(3782.24878,2486.44189,-195.96875), Vector(3225.05786,1992.03125,58.66518)}; 
{ 'Northern Petrol Warehouse' , Vector(4614.20313,3678.26538,167.96875), Vector(6143.96875,2714.83765,-195.8452)}; 
{ 'Park' , Vector(3663.96875,1397.82776,162.78397), Vector(2890.89307,466.6694,-195.96875)}; 
{ 'Park District' , Vector(3663.0957,183.57086,167.96875), Vector(1984.03125,1974.40027,-200.14999)}; 
{ 'Park District Condo' , Vector(1967.84521,1411.03125,-75.04098), Vector(1286.03125,1880.56775,-199.74884)}; 
{ 'Park Shop' , Vector(2856.78271,1992.62402,-66.01976), Vector(3211.58594,2461.39453,-195.96875)}; 
{ 'Clubhouse' , Vector(2392.03125,391.40295,54.61897), Vector(1883.46118,-337.48169,-195.96875)}; 
{ 'Uptown Shop' , Vector(943.96875,410.93896,-67.71082), Vector(448.03125,226.10394,-195.32262)}; 
{ 'Uptown Condo' , Vector(670.79108,207.96875,-70.95944), Vector(82.30151,-574.0896,-199.96875)}; 
{ 'Uptown Condo' , Vector(-291.96875,-59.11294,-70.33582), Vector(73.32074,-396.96875,-199.15555)}; 
{ 'Uptown Condo Entrance' , Vector(439.96875,407.40106,54.95861), Vector(56.41283,216.64392,-199.96875)}; 
{ 'Facial Store' , Vector(40.57702,207.21603,185.96875), Vector(438.76599,-35.77624,64.03125)}; 
{ 'Uptown Lookout' , Vector(31.96875,-35.55689,185.28731), Vector(-303.4191,391.80124,-191.96875)}; 
{ 'Uptown Lookout' , Vector(-312.20538,135.96875,-63.57063), Vector(-575.5235,-109.25671,185.96875)}; 
{ 'Cafe Baltic' , Vector(-720.03125,39.58809,187.75626), Vector(-1038.64185,398.29718,-195.96875)}; 
{ 'Cafe Baltic Roof' , Vector(-592.53491,387.03125,210.63879), Vector(-1037.43286,32.03125,322.73929)}; 
{ 'Downtown Apt. Roof' , Vector(-1038.22058,32.03125,323.16138), Vector(-719.64789,-918.96875,581.22534)}; 
{ 'Downtown Apt. 5F-1' , Vector(-1055.03125,-1343.62244,317.47894), Vector(-719.03125,-915.96869,570.64563)}; 
{ 'Downtown Apt. Roof' , Vector(-1055.03125,-1600.1217,316.87253), Vector(-840.26471,-1344.03125,562.89948)}; 
{ 'Fountain-side Apt. Roof' , Vector(-1061.95386,-1603.85791,204.03125), Vector(-704.35388,-2312.03125,501.51605)}; 
{ 'Parker Warehouse' , Vector(-1433.96875,374.92331,0.0902), Vector(-1991.96875,953.69073,-195.84734)}; 
{ 'J&M Glass Co. Shop' , Vector(-1022.1427,25.96875,-195.94075), Vector(-588.21436,-369.74344,307.96875)}; 
{ 'J&M Glass Co. Shop' , Vector(-588.03125,-352.82712,-59.52289), Vector(-1022.61542,-893.96875,307.42581)}; 
{ 'J&M Glass Co. Warehouse' , Vector(-1021.72357,-893.96875,-40.18894), Vector(-511.9205,-917.04114,-195.96875)}; 
{ 'J&M Glass Co. Warehouse' , Vector(-497.91315,-838.96875,-192.95735), Vector(-248.47751,-583.03125,-41.97695)}; 
{ 'Overlook Alley' , Vector(-2047.83484,-434.6571,-203.96875), Vector(-2444.17651,-784.03125,-32.25859)}; 
{ 'Overlook Alley' , Vector(-2443.37354,7.96876,174.81317), Vector(-2202.22339,-432.06314,-203.96875)}; 
{ 'Sewer Entrance' , Vector(-2202.43213,-134.64459,-203.96875), Vector(-2091.66748,7.96875,-88.12327)}; 
{ 'Downtown Apt. Stairwell - Falling' , Vector(-636.91425,-1475.96875,-66.66154), Vector(-494.73785,-1382.57629,435.96875)}; 

{ 'Downtown Apt. Stairwell 2F' , Vector(-433.75464,-1321.15027,-195.96875), Vector(-636.86298,-1527.96875,-65.45136)}; 
{ 'Downtown Apt. Stairwell 3F' , Vector(-639.73773,-1320.1626,-59.96875), Vector(-493.85971,-1371.16223,111.03125)}; 
{ 'Downtown Apt. Stairwell 3F' , Vector(-433.42215,-1320.03125,68.12322), Vector(-499.68814,-1527.96875,121.33216)}; 
{ 'Downtown Apt. Stairwell 3F' , Vector(-643.03125,-1477.10474,110.53503), Vector(-435.66217,-1527.96875,72.24837)}; 
{ 'Downtown Apt. Stairwell 4F' , Vector(-434.09863,-1527.96875,186.14894), Vector(-643.53223,-1320.16284,314.96875)}; 
{ 'Downtown Apt. Stairwell 4F' , Vector(-493.52921,-1371.64331,239.03125), Vector(-701.96228,-1304.30908,68.8353)}; 
{ 'Downtown Apt. Stairwell 5F' , Vector(-643.53223,-1320.16284,314.96875), Vector(-433.03125,-1527.94275,435.95755)}; 

{ 'Downtown Apt. 5F' , Vector(-814.91614,-1304.46814,324.03125), Vector(-641.94104,-1526.93201,435.96875)}; 
{ 'Downtown Apt. 4F' , Vector(-639.12549,-1320.41248,314.96875), Vector(-814.35376,-1583.96875,196.73288)}; 
{ 'Downtown Apt. 4F' , Vector(-643.51398,-1319.89514,186.84334), Vector(-702.11206,-1527.96875,314.27615)}; 
{ 'Downtown Apt. 3F' , Vector(-640.84979,-1320.03125,58.48074), Vector(-702.92535,-1526.7804,186.96875)}; 
{ 'Downtown Apt. 2F' , Vector(-814.73022,-1583.96875,51.41071), Vector(-641.04596,-1320.03125,-62.9366)}; 
{ 'Downtown Apt. Lobby' , Vector(-1037.27551,-936.03125,-193.6391), Vector(-719.03125,-1266.88818,-79.22941)}; 
{ 'Downtown Apt. Lobby' , Vector(-719.03125,-1266.88818,-79.22941), Vector(-814.96875,-1580.02869,-194.32687)}; 
{ 'Downtown Apt. Janitor Closet' , Vector(-831.41986,-1582.76721,-79.03125), Vector(-1037.90088,-1312.5321,-195.96875)}; 
{ 'Fountain-side Storage Locker' , Vector(-1646.26929,-3072.28198,-84.03125), Vector(-2414.28979,-3325.50806,-195.96875)}; 
{ 'Fountain-side Storage Locker' , Vector(-1903.42822,-2832.03125,-84.22262), Vector(-1777.48035,-3057.33057,-195.96875)}; 
{ 'Fountain-side Shop' , Vector(-1135.64001,-2440.03125,-38.34789), Vector(-1673.19324,-3059.0686,-195.96875)}; 
{ 'Fountain-side Shop' , Vector(-686.03125,-3326.68213,-36.93568), Vector(-1673.96875,-2797.34985,-36.04493)}; 
{ 'Fountain-side Shop Alley' , Vector(-1678.04492,-2431.96875,-35.43707), Vector(-1873.87866,-2815.96875,-195.6861)}; 

{ 'Suburbs Tunnel' , Vector(-2405.5813,-2431.96875,24.81329), Vector(-2951.41577,-4343.95996,-195.96875)}; 
{ 'Train Yard' , Vector(-4671.62891,-7290.96875,282.90686), Vector(-3636.32764,-4420.22559,-178.70551)}; 
{ 'Train Yard' , Vector(-3766.54419,-5007.96875,86.97762), Vector(-2952.89185,-4342.03125,-195.67349)}; 
{ 'Train Yard' , Vector(-3040.50659,-7226.03125,87.36124), Vector(-3967.04883,-7440.95752,-181.55843)}; 
{ 'Train Yard' , Vector(-3766.26489,-7224.80762,-72.39163), Vector(-3642.33521,-5008.17725,-190.65179)}; 
{ 'Suburb Side Condo 2F-4' , Vector(-3120.75,-5013.03125,65.22124), Vector(-3759.22192,-5554.88184,-60.96875)}; 
{ 'Suburb Side Condo 2F-3' , Vector(-3120.03125,-5565.04199,66.29755), Vector(-3758.40063,-6112.75049,-60.96875)}; 
{ 'Suburb Side Condo 2F-2' , Vector(-3759.96875,-6121.50439,64.89611), Vector(-3120.03125,-6664.84766,-60.70766)}; 
{ 'Suburb Side Condo 2F-1' , Vector(-3121.01953,-6674.03125,66.70933), Vector(-3759.15869,-7223.58984,-60.96875)}; 
{ 'Suburb Side Condo 1F-1' , Vector(-3120.03125,-7223.61621,-69.97381), Vector(-3631.5498,-6674.43994,-196.96875)}; 
{ 'Suburb Side Condo 1F-2' , Vector(-3120.03125,-6665.11377,-70.29216), Vector(-3631.91357,-6121.03125,-196.66559)}; 
{ 'Suburb Side Condo 1F-3' , Vector(-3120.03125,-6111.82373,-70.28312), Vector(-3631.96875,-5565.96094,-196.07793)}; 
{ 'Suburb Side Condo 1F-4' , Vector(-3121.30908,-5556.17334,-69.03125), Vector(-3631.96875,-5015.91797,-194.58598)}; 
{ 'Dealership Parking Lot' , Vector(-1624.71606,-4605.66553,-195.96875), Vector(-2351.83667,-5841.58691,-149.96875)}; 
{ 'Dealership' , Vector(-1194.58276,-5840.03125,-46.7739), Vector(-2199.96875,-6487.59229,-192.98581)}; 
{ 'Gas Station' , Vector(-727.03125,-8080.80078,-195.73547), Vector(-1580.03906,-7313.62988,177.56331)}; 
{ 'Suburbs Condo 2F-2' , Vector(-28.96875,-7440.57812,69.83897), Vector(332.77502,-7897.96875,-58.10568)}; 
{ 'Suburbs Condo 2F-1' , Vector(-406.49609,-7896.43066,70.96875), Vector(-40.90817,-7447.96875,-58.49911)}; 
{ 'Suburbs Condo 3F-1' , Vector(-39.03125,-7440.75,206.48885), Vector(-406.54651,-7897.96875,76.83452)}; 
{ 'Suburbs Condo 3F-2' , Vector(-28.96875,-7442.21631,205.54953), Vector(332.9678,-7897.96875,76.97123)}; 
{ 'Flooded Warehouse' , Vector(547.36737,-5975.96875,-195.55598), Vector(1072.34241,-5280.03125,127.64696)}; 
{ 'Suburbs Condominium' , Vector(-413.03125,-8125.79199,281.46146), Vector(599.96875,-7934.10986,-327.77704)}; 
{ 'Suburbs Bungalow #1' , Vector(-291.96875,-6560.39941,-66.87445), Vector(-821.50183,-6312.97461,-198.96875)}; 
{ 'Suburbs Bungalow #2' , Vector(-302.32397,-6307.96875,-72.04639), Vector(-821.07312,-6022.52295,-198.96875)}; 
{ 'Suburbs Bungalow #3' , Vector(-302.03125,-5677.25342,-72.35188), Vector(-821.94556,-6017.96875,-197.66451)}; 
{ 'Suburbs House' , Vector(-328.50677,-5330.65625,-196.96875), Vector(-723.96875,-4972.13477,56.77961)}; 
{ 'Suburbs House Garden' , Vector(-435.03125,-4966.90283,-199.67632), Vector(-730.59998,-4881.03125,-99.78381)}; 
{ 'Suburbs House Garden' , Vector(-727.69281,-5335.03125,-87.58797), Vector(-426.37668,-5393.96875,-199.61195)}; 
{ 'Suburbs House Garden' , Vector(-1328.96875,-5393.96045,-98.75478), Vector(-739.8349,-4882.85107,-199.96875)}; 
{ 'Suburbs Jungle Apt. Staircase' , Vector(-2078.61182,-4071.23633,-195.96875), Vector(-1776.56372,-3344.03125,57.9524)}; 
{ 'Suburbs Jungle Apt. Staircase' , Vector(-1776.4231,-3344.03125,57.8767), Vector(-2079.71045,-3847.96875,193.36917)}; 
{ 'Suburbs Jungle Apt. Staircase' , Vector(-2078.93311,-3344.03125,334.84988), Vector(-1941.40015,-3846.92529,74.03125)}; 
{ 'Suburbs Jungle Apt. 4' , Vector(-1922.75085,-3344.48047,335.96875), Vector(-453.77765,-4076.93604,202.03125)}; 
{ 'Suburbs Jungle Apt. 4' , Vector(-2076.95435,-3703.94727,335.96875), Vector(-1862.40234,-4075.93237,202.03125)}; 
{ 'Suburbs Jungle Apt. 4 Monkey Entrance' , Vector(-1249.4823,-4076.96875,320.06982), Vector(-1327.96875,-4231.79004,212.16324)}; 
{ 'Suburbs Jungle Apt. Elevator' , Vector(-2078.40137,-4232.03125,-59.76611), Vector(-1841.83215,-4080.03125,206.47691)}; 
{ 'Suburbs Jungle Apt. 3F' , Vector(-1826.96875,-4081.97485,207.92172), Vector(-1252.80688,-4223.45703,74.03125)}; 
{ 'Suburbs Jungle Apt. Entrance' , Vector(-449.97189,-4080.07202,65.68797), Vector(-1806.26733,-4235.53125,-195.96875)}; 
{ 'Suburbs Jungle Apt. 2' , Vector(-2079.96875,-4071.7854,65.93233), Vector(-453.64636,-3953.63501,-53.96875)}; 
{ 'Suburbs Jungle Apt. 2' , Vector(-453.82852,-3950.83228,-53.96875), Vector(-1770.96875,-3345.22754,65.62589)}; 
{ 'Suburbs Jungle Apt. 1' , Vector(-164.03125,-4202.05078,-71.46626), Vector(-1212.31189,-3347.15454,-195.96875)}; 
{ 'Suburbs Jungle Apt. 1' , Vector(-1212.66565,-3345.18262,-195.96875), Vector(-1766.51123,-4071.53296,-62.03125)}; 
{ 'Industrial Tunnel' , Vector(-2915.48828,-784.03125,35.11105), Vector(-2448.57397,1126.03125,-190.89966)}; 
{ 'Container Warehouse' , Vector(-3274.87695,1715.03125,410.62744), Vector(-2262.84082,2655.68555,-203.96875)}; 
{ 'Long Warehouse' , Vector(-3276.53931,2664.03125,51.7836), Vector(-1536.70654,3415.7168,-203.96875)}; 
{ 'Grow Op' , Vector(-2775.03125,4176.92529,53.98808), Vector(-3275.80664,3593.55273,-195.96875)}; 
{ 'Grow Op' , Vector(-3093.03125,3426.16211,55.36604), Vector(-3273.96875,3586.27612,-46.8571)}; 
{ 'Grow Op' , Vector(-3154.77246,3521.88818,55.96875), Vector(-3093.03125,3675.17847,-70.16871)}; 

{ 'Garage' , Vector(-3257.0708,5592.96875,157.25182), Vector(-3996.30664,4195.03125,-203.85947)}; 
{ 'Industrial Corner Garage' , Vector(-6172.23682,4515.96875,122.60005), Vector(-5645.14795,3776.85229,-203.96875)}; 
{ 'Bank' , Vector(-2943.96875,-1163.0918,50.02013), Vector(-4472.05371,-2144.95361,-187.96875)}; 
{ 'Suburbs Corner House' , Vector(-3581.53247,-7484.06396,-196.96875), Vector(-2265.80981,-8084.25391,-36.03125)}; 
{ 'Suburbs Workshop' , Vector(-2235.96875,-7317.13574,62.69562), Vector(-1766.01648,-8094.67432,-196.96875)}; 









{ 'Industrial' , Vector(-6145.70215,4506.80762,157.96875), Vector(-2436.72485,1127.50952,-195.96875)}; 
{ 'Industrial' , Vector(-3139.83057,1127.3739,-203.96875), Vector(-5018.44629,632.03125,175.04651)}; 

{ 'Suburbs' , Vector(-3043.18481,-4342.48926,282.96875), Vector(535.96875,-7859.88428,-195.65814)}; 

	};

};

hook.Add( "InitPostEntity", "some_unique_name", function()
if timer.Exists("KillBox") then
	timer.Destroy("KillBox")
	timer.Create("KillBox",1,0,function()
		for k , v in pairs(player.GetAll()) do 
			if v:GetZoneName() == "Killbox" then v:Kill() end end
	end)
end
end )
function _eMeta:GetZoneName ( )
	local lifeAlertZone;
	local pPos = self:GetPos();
	if !LifeAlert or !LifeAlert[game.GetMap()] then return end
	local _l = LifeAlert[game.GetMap()];
	for k, v in pairs(_l) do
		local minVec = Vector(math.Min(v[2].x, v[3].x), math.Min(v[2].y, v[3].y), math.Min(v[2].z, v[3].z));
		local maxVec = Vector(math.Max(v[2].x, v[3].x), math.Max(v[2].y, v[3].y), math.Max(v[2].z, v[3].z));
		
		if (pPos.x >= minVec.x && pPos.y >= minVec.y && pPos.z >= minVec.z && pPos.x <= maxVec.x && pPos.y <= maxVec.y && pPos.z <= maxVec.z) then
			lifeAlertZone = v;
			break;
		end
	end
	
	if (!lifeAlertZone) then end
	
	return lifeAlertZone;
end
