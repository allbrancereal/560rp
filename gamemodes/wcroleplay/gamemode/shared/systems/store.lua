

/* Item List, update when updating stores pls 
1 , Low Quality Wood , 25
2 , Upper Class Wood , 75
3 , High Quality Wood , 100
4 , Steel , 75
5 , Gold , 80
6 , Platinum , 100
7 , Bronze , 50
8 , Frag Grenade Recipe , 2500
9 , Copper , 30
10 , Electrical Board , 125
11 , Gold Bar , 100000
12 , Oil Drum , 100
13 , Wrench , 10
14 , Alcohol Bottle , 5
15 , Gas Can , 25
16 , Lever , 5
17 , Gear , 10
18 , Wheel , 50
19 , Paint Bucket , 25
20 , Propane Tank , 100
21 , Hard Drive , 25
22 , Graphics Card , 250
23 , Ram , 300
24 , Granite Rock , 45
25 , Iron Ore , 30
26 , Silicon Ore , 25
27 , Aluminum Ore , 35
28 , Sodium Ore , 45
29 , Pickaxe , 25
30 , AK74 , 25
31 , AR-15 , 25
32 , Flashbang , 25
33 , Frag Grenade , 25
34 , G3A3 , 25
35 , MP5-K , 25
36 , Desert Eagle , 25
37 , L115 , 25
38 , MR 96 , 25
39 , Smoke Grenade , 25
40 , Small Ammo Kit , 25
41 , Medium Ammo Kit , 25
42 , Large Ammo Kit , 25
43 , Ammo Stockpile , 25
44 , Cannabis Plant , 25
45 , Camera , 25
46 , Med-Kit , 25
47 , Health Vial , 25
48 , Kevlar , 25
49 , Selfie-Cam , 25
50 , Physics Gun , 25
51 , Steel , 25
52 , Flash Light , 25
56 , Hover Rings , 25
57 , Dimebag of Weed , 80
58 , Carving , 25
59 , Soapstone , 25
1001 , Tin , 40

*/

function printItemListByID()

	for k , v in pairs( ITEMLIST ) do
	
		print( v.ID .. " , " .. v.Name .. " , " .. v.Cost ); 
	
	end
	
end

local _pMeta = FindMetaTable( 'Player' );

function _pMeta:IsNearCNPC( npcString, dist  )

	for k , v in pairs( ents.FindInSphere( self:GetPos() , dist ) ) do
		
		if v:GetClass() == "cn_npc" then 
			
			local uniqueID = v:GetQuest()
				
			if uniqueID == npcString then
				
				return true , v;
				
			end	
			
		end
		
	end
	
	return false;
	
end
fsrp.blackmarket = fsrp.blackmarket or {};
fsrp.blackmarket.help = fsrp.blackmarket.help or {};
function fsrp.blackmarket.help.Randomize()
		
	table.Empty ( fsrp.blackmarket.cache.Selling )
	table.Empty ( fsrp.blackmarket.cache.Buying )
	
	if SERVER then
		
		local _NewLocations = fsrp.blackmarket.help.PotentialLocations[ math.random(#fsrp.blackmarket.help.PotentialLocations) ];
		
		for k , v in pairs( ents.FindByClass("cn_npc") ) do
		
			local _quest = v:GetQuest();
			
			if _quest == "druggo" then
			
				v:SetPos( _NewLocations.Location )
				v:SetAngles( _NewLocations.Angles )
				
			end
				v:setAnim()	
		end
		
		for k , v in pairs( player.GetAll() ) do
			
			if v:IsGovernmentOfficial() then return end
			
			if v:IsDev() then
			
				v:Notify( "(Developer) The dealer has been moved to " .. _NewLocations.Name )
				
			elseif v:getFlag("notifyDealerChange", false ) == true then
			
				v:ChatPrint( "[Dealer]: Hey! I've changed spots, it's got too heated. You can find me " .. _NewLocations.Text );
			
			end
			
		end
	
	end
	
	for k , v in pairs( fsrp.blackmarket.help.PermanentlySell ) do
	
		table.insert( fsrp.blackmarket.cache.Selling , v )
	
	end
	
	for k , v in pairs( fsrp.blackmarket.help.PotentialSelling ) do
	
		local _chance = math.random( 0, 100 )
		
		if _chance < fsrp.blackmarket.help.ChanceToSell then
		
			table.insert( fsrp.blackmarket.cache.Selling , v )
			
		end
		
	end
	
	for k , v in pairs( fsrp.blackmarket.help.PermanentlyBuy ) do
	
		table.insert( fsrp.blackmarket.cache.Buying , v )
	
	end
	
	for k , v in pairs( fsrp.blackmarket.help.PotentialBuying ) do
	
		local _chance = math.random( 0, 100 )
		
		if _chance < fsrp.blackmarket.help.ChanceToBuy then
		
			table.insert( fsrp.blackmarket.cache.Buying , v )
			
		end
		
	end
	
	fsrp.blackmarket.PercentagePaying = math.random( 80, 120 );
	fsrp.blackmarket.PercentageSelling = math.random( 80, 120 );

	fsrp.blackmarket.help.Network()
	
end

if SERVER then
	// moved to sv_player

end


