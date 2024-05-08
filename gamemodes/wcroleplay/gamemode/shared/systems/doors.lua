
fsrp.PropertyTable = fsrp.PropertyTable || {}

fsrp.I_BusinessPropertyTable = fsrp.I_BusinessPropertyTable || {};
fsrp.ClubhousePropertyTable = fsrp.ClubhousePropertyTable || {};
fsrp.PropertyPackages = fsrp.PropertyPackages || {};
//fsrp.I_BusinessPropertyTable =  {}; 

	for k , v in pairs( player.GetAll() ) do
	
		v:setFlag("propertiesBought", 0 )
		
	end

local _entsToConsiderForProperties = {
	"wcrp_ibusinessprop",
	"fsrpcomputer",
	"fsrpmonitor",
}

 function SetupBusinessProperty(PropertyTable, notonmap)

 	fsrp.I_BusinessPropertyTable[PropertyTable.ID] = PropertyTable;
 	
 	if notonmap then
 		fsrp.I_BusinessPropertyTable[PropertyTable.ID].DifferentMap = true; 	 		
 	end

 	if SERVER then
 		/* 
 		for k , v in pairs( PropertyTable.BusinessInformation.DisplayProps ) do
 				
 		end
		*/
		if !notonmap then
			
	 		for k , v in pairs( PropertyTable.BusinessInformation.DisplayProps ) do
	 			
	 			//{"EntityClass", Vector(Position), Angle(Angle), model,Nocollide};
	 			local _Class = v[1] || "";
	 			local _Pos = v[2] || Vector(0,0,0);
	 			local _Ang = v[3] || Angle(0,0,0);
	 			local _Mod = v[4] || nil;
	 			local _ShouldNocollide = v[5] || false; 

	 			local _createdDisplayEnt = ents.Create(_Class);

	 			_createdDisplayEnt:SetPos( _Pos );
	 			_createdDisplayEnt:SetAngles(_Ang);
	 		
	 			if _Mod && _Mod != nil then
	 				_createdDisplayEnt:SetModel(_Mod);
	 			end
	 			if _ShouldNocollide && _ShouldNocollide == true then
	 				_createdDisplayEnt:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	 			end 
	 			_createdDisplayEnt:Spawn() 		 
	 			//table.insert(dispProps, _createdDisplayEnt)
	 			_createdDisplayEnt:setFlag("propertyDisplayProp", true);
	 			_createdDisplayEnt:setFlag("propertyPropID", PropertyTable.ID );
	 			_createdDisplayEnt:SetMoveType(MOVETYPE_NONE);
	 			_createdDisplayEnt.MarkAsDisplayProp = true;
	 		end

	 		for k , v in pairs( PropertyTable.Doors ) do
	 		
	 			local x = ents.GetMapCreatedEntity( v.Index )

				if x && IsValid(x) then
					x:Fire( "lock", "", 0 )
					x:setFlag( "doorID", nil )
					x:setFlag( "clubhouseDoor", nil )
					x:setFlag( "businessDoor", tonumber(PropertyTable.ID) )

					if v.RemoveDoor == true then
					
						x:Remove()

					end

				end
				
			end
		
		end
		
 	end

 end
	 
 function SetupClubHouseProperty(PropertyTable, notonmap)
 
 	fsrp.ClubhousePropertyTable[PropertyTable.ID] = PropertyTable;
 
 	if notonmap then
 		fsrp.ClubhousePropertyTable[PropertyTable.ID].DifferentMap = true; 	 		
 	end

 	if SERVER then

 		if !notonmap then

	 		for k , v in pairs( PropertyTable.ClubHouseInformation.DisplayProps ) do
	 			
	 			//{"EntityClass", Vector(Position), Angle(Angle), model,Nocollide};
	 			local _Class = v[1] || "";
	 			local _Pos = v[2] || Vector(0,0,0);
	 			local _Ang = v[3] || Angle(0,0,0);
	 			local _Mod = v[4] || nil;
	 			local _ShouldNocollide = v[5] || false; 

	 			local _createdDisplayEnt = ents.Create(_Class);
	 			if !IsValid(_createdDisplayEnt) then return end
	 			_createdDisplayEnt:SetPos( _Pos );
	 			_createdDisplayEnt:SetAngles(_Ang);
	 		
	 		
	 			if _Mod && _Mod != nil then
	 				_createdDisplayEnt:SetModel(_Mod);
	 			end

	 			if _ShouldNocollide && _ShouldNocollide == true then
	 				_createdDisplayEnt:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	 			end 
 
	 			_createdDisplayEnt:Spawn() 		
 
	 			//table.insert(dispProps, _createdDisplayEnt)
	 			_createdDisplayEnt:setFlag("propertyDisplayProp", true);
	 			_createdDisplayEnt:setFlag("propertyPropID", PropertyTable.ID );
	 			_createdDisplayEnt:SetMoveType(MOVETYPE_NONE);
	 			_createdDisplayEnt.MarkAsDisplayProp = true;

	 		end
 
	 		for k , v in pairs( PropertyTable.Doors ) do
	 		
	 			local x = ents.GetMapCreatedEntity( v.Index )

				if x && IsValid(x) then
					x:Fire( "lock", "", 0 )
					x:setFlag( "doorID", nil )
					x:setFlag( "businessDoor", nil )
					x:setFlag( "clubhouseDoor", tonumber(PropertyTable.ID) )

					if v.RemoveDoor == true then
					
						x:Remove()

					end

				end
				
			end
		
		end
		
 	end

 end

function SetupOtherMapProperties( PropertyTable, Map )

	if !fsrp.PropertyPackages[Map] then
		fsrp.PropertyPackages[Map] = {}
	end
	
	if PropertyTable.Type then
		
		if PropertyTable.Type == 1 then
			SetupBusinessProperty(PropertyTable,true)						
		elseif PropertyTable.Type == 2 then
			SetupClubHouseProperty(PropertyTable,true)
		else
			fsrp.PropertyPackages[Map][PropertyTable.ID] = PropertyTable;
		end

	else
		fsrp.PropertyPackages[Map][PropertyTable.ID] = PropertyTable;

	end
end 

function SetupProperty (PropertyTable, ConsumedByBusiness)
 
	local _oldOwner = nil 

	if ConsumedByBusiness && ConsumedByBusiness == 1 then 
		
		return SetupBusinessProperty(PropertyTable)
	
	end

	if ConsumedByBusiness && ConsumedByBusiness == 2 then 
		
		return SetupClubHouseProperty(PropertyTable)
	
	end

	if !PropertyTable.ID then return end
	if SERVER and fsrp.PropertyTable[PropertyTable.ID] then 
		
		if fsrp.PropertyTable[PropertyTable.ID].PrimaryOwner then
		
			local _prevOwner = player.GetBySteamID(fsrp.PropertyTable[PropertyTable.ID].PrimaryOwner[2])
			_prevOwner:setFlag("propertiesBought", _prevOwner:getFlag("propertiesBought", 0 ) );
		
		end
		
		fsrp.PropertyTable[PropertyTable.ID] = nil;
		 
	end  
	 
	for k , v in pairs( PropertyTable.Doors ) do
		
		if SERVER then
				local x = ents.GetMapCreatedEntity( v.Index )
				if fsrp && !fsrp.LoadedEnts then return end

				//if !IsValid(x) then return end
				//if !x:IsDoor() then return end
				x:setFlag( "businessDoor", nil )
				x:setFlag( "clubhouseDoor", nil )
				x:setFlag( "doorID", tonumber(PropertyTable.ID) )
				//print( "set" .. v.Index )  
				//print('{Index= ' .. EntIndexFromGetID( x:EntIndex() ) .. ' ,ID=' .. PropertyTable.ID ..  ',Model= ' .. tostring(x:GetModel()) .. ',Pos= ' .. tostring(v[1]) .. '}')
				//print( x.__doorID )		
	 
				x:Fire( "lock", "", 0 )
					
		end
	end
	//print( "Setup " .. PropertyTable.Name ) 
	if !fsrp.PropertyPackages["rp_downtown_tits_v2"] then
		fsrp.PropertyPackages["rp_downtown_tits_v2"] = {};
	end  
	fsrp.PropertyPackages["rp_downtown_tits_v2"][PropertyTable.ID] = PropertyTable;
	fsrp.PropertyTable[PropertyTable.ID] = PropertyTable;

end
	
function AssignPropertyOwner( _id , _p , _isBank, voucher )
 
	local propertyCache = fsrp.PropertyTable[_id];
	
	local _toOwn = propertyCache.PrimaryOwner

	if _toOwn != nil then 
	
		if _toOwn[2] == _p:SteamID() then
		
			fsrp.PropertyTable[_id].PrimaryOwner = nil;
			
		end
		
		//fsrp.config.PropertyMinPricePerc = 25 // percent of the property worth to return per upgrade level
		//fsrp.config.SalePerLevel = 10 // percent of the property worth to return per upgrade level
		local _inv = _p:GetPropertyInvestments();
		local _mod = 0;
		if _inv[game.GetMap()] and _inv[game.GetMap()][_id] then
			_mod = (_inv[game.GetMap()][_id]*fsrp.config.SalePerLevel)/100
		end
		local _propcost = propertyCache.Cost * 0.4;
		_propcost = _propcost-_mod*_propcost;
		_p:addBank( _propcost );
		updatePropertyOwner( _p , _id )
		
		_p:setFlag( "propertiesBought", (_p:getFlag("propertiesBought", 1) - 1))
		_p:Notify("You have sold your property")
		return
	end
	
	if _p:getFlag("propertiesBought", 1)+1 >3 then
		
		return _p:Notify("You may not purchase another property! (<=3MAX)");
		
	end 
	
	if !voucher || voucher != true then

		if _isBank then
			
			local _cost = propertyCache.Cost;
			if _p:IsDonator() then 
			
				_cost = _cost * 0.8 
			
			end
			local _inv = _p:GetPropertyInvestments();
			local _mod = 0;
			if _inv[game.GetMap()] and _inv[game.GetMap()][_id] then
				_mod = (_inv[game.GetMap()][_id]*fsrp.config.SalePerLevel)/100
			end
			_cost = _cost-_mod*_cost;
			if _p:canAfford( _cost) then
			
				_p:addMoney( -_cost );
				
				_p:Notify("You have paid with cash for this transaction")
			
			elseif _p:canAffordBank( _cost ) then
			
				_p:addBank( -_cost );
				
				_p:Notify("You have paid with your bank account for this transaction")
				
			else
				
				if propertyCache.PostCantBuy then
				
					propertyCache.PostCantBuy(propertyCache ,  _p, false )
				
				end
				
				return _p:Notify("You can not afford this transaction with bank or cash, go make some money!");
				
			end
			
		else
			
			if _p:canAffordBank( propertyCache.Cost*1.5 ) then
			
				_p:addBank( -propertyCache.Cost*1.5 );
				
				_p:Notify("You have paid with your bank account for this transaction")
			
			else
			
			
				if propertyCache.PostCantBuy then
				
					propertyCache.PostCantBuy(propertyCache ,  _p, false )
				
				end
				
					return _p:Notify("You can not afford this transaction with your bank account, deposit some money or get some cash!");
			
			end
		
		
		end
	
	end

	if voucher && voucher == true then
		local _rewardTable = _p:GetDailyRewardTable();
		if _rewardTable[2] > 0 then
			_p:UseVoucher();
		else
			return _p:Notify("You do not have enough vouchers.")
		end
	end

	if propertyCache.CanBuy then
	
		local _b = propertyCache.CanBuy( propertyCache , _p ) 
		
	end
	
	fsrp.PropertyTable[_id].PrimaryOwner = { _p:getRPName(), _p:SteamID() }
	
	updatePropertyOwner( _p , _id )
	
	_p:setFlag( "propertiesBought", (_p:getFlag("propertiesBought", 0) + 1))
	
	if propertyCache.PostCantBuy then
		
		propertyCache.PostCantBuy( propertyCache , _p, true )
		
	end
	
	if propertyCache.OnBought then
		
		propertyCache.OnBought( propertyCache , _p )
		
	end
	
	return 
	
end

if SERVER then

	// sv_player
 
 else
 
	 net.Receive( "updateClientPropertyOwner", function( _len, _p )
		local _propID = net.ReadInt(8)
		local _b = net.ReadBool()
		local _ownerTbl;
		
		if _b then
		
			_ownerTbl = net.ReadTable();
	  
		end
		fsrp.PropertyTable[_propID].PrimaryOwner = _ownerTbl || nil ;
		
	 end )
 
 end
 
function printPropertyTableIndex()
for k , v in pairs( fsrp.PropertyTable ) do
	//print(v.ID)
	for _ , y in pairs (v.Doors) do
	
		for _ , x in pairs( ents.FindInSphere(y[1],50)) do
		
			if x:GetModel() == y[2] then
				//print( "oi")
				print('{Index= ' .. EntIndexFromGetID( x:EntIndex() ) .. ' ,ID=' .. v.ID ..  ',Model= ' .. y[2] .. ',Pos= ' .. y[1] .. '}')
				
			end
			
		end
		
	end
	
end
end

function CanManipulateDoor( id , _p )
	if !fsrp.PropertyTable[id] then return Error("Property not found") end
	if !IsValid(_p) then return Error("Argument #2 is not a player") end
 	local _pOwn = fsrp.PropertyTable[id].PrimaryOwner[2];
	
	if _pOwn then
	
		if _p:SteamID() == _pOwn then
		
			return true
		
		else
		
			for k , v in pairs( player.GetAll( ) ) do

				if _pOwn == v:SteamID()  && v != _p then
				
					return v:HasBuddy( _p )
					
				end
				
			end
			
		end
		
	end
	
	return false

end

local _pMeta = FindMetaTable( 'Player' )
local _eMeta = FindMetaTable( 'Entity' )

function _eMeta:GetPropertyTable()

	return fsrp.PropertyTable[self:getFlag("doorID", 0)];

end
function _eMeta:GetPrimaryOwnerName()

	return fsrp.PropertyTable[self:getFlag("doorID", 0)].PrimaryOwner[1] || nil ;

end
function _eMeta:GetDoorOwner()
	if !fsrp.PropertyTable[self:getFlag("doorID", 0)] then return nil end
	if !fsrp.PropertyTable[self:getFlag("doorID", 0)].PrimaryOwner then return nil end
	
	return fsrp.PropertyTable[self:getFlag("doorID", 0)].PrimaryOwner[2] || nil;

end
POLICE_DOOR_TABLE = {

	["rp_downtown_tits_v2"] = {

		{ Index = 2967 ,Vector(-1480, 53, -106), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1657 ,Vector(-1480, 147, -106), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1665 ,Vector(-1671, 139, -106), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2593 ,Vector(-1671, 45, -106), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3226 ,Vector(-1832, -106, 30), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3225 ,Vector(-1832, -12, 30), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1666 ,Vector(-1669, 369, -106), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3120 ,Vector(-1921, 14, -106), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 3119 ,Vector(-1827, 14, -106), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 3121 ,Vector(-1827, -134, -143), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 3122 ,Vector(-1921, -134, -143), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 2596 ,Vector(-1996, 41, -106), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 2595 ,Vector(-1996, 135, -106), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 2588 ,Vector(-2501, 376, -105.75), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 1938 ,Vector(-2501, 888, -105.75), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 2585 ,Vector(-2278, 595, -105.75), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 2584 ,Vector(-2111, 595, -105.75), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 1936 ,Vector(-2167, 888, -106), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 1937 ,Vector(-2334, 888, -105.75), 'models/props_doors/door03_slotted_left.mdl', '' },
		{ Index = 2616 ,Vector(-2009, 382, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2615 ,Vector(-2103, 382, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2634 ,Vector(-1865, 232, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2589 ,Vector(-1975, 382, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2590 ,Vector(-1881, 382, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2582 ,Vector(-1996, 110, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2583 ,Vector(-1902, 110, 74), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3225 ,Vector(-1832, -12, 30), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3226 ,Vector(-1832, -106, 30), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2591 ,Vector(-1881, 772, 66), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 2592 ,Vector(-1975, 772, 66), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3359 ,Vector(-1316, 1023, 66), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3358 ,Vector(-1316, 1117, 66), 'models/props_c17/door01_left.mdl', '' },

	}


}

-- obsolete --
Business_DOOR_TABLE = {		
	["rp_downtown_2017"] = {
		{id = 1, pos = Vector( ) , mdl = ""},
	};
}
NEUTRAL_DOOR_TABLE = {	
	["rp_downtown_tits_v2"] = {

	}
}
-- obsolete --

UNLOCKEDDOORSTART = {		
	["rp_downtown_tits_v2"] = {
		{ Index = 2967 ,Vector(-1480, 53, -106), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3295 ,Vector(-1952, -5836, -138), '*261', '' },
{ Index = 3294 ,Vector(-1952, -6492, -138), '*260', '' },
{ Index = 3284 ,Vector(-2204, -5937, -140), 'models/props_c17/door01_left.mdl', '' },
{ Index = 3285 ,Vector(-2204, -6031, -140), 'models/props_c17/door01_left.mdl', '' },

		{ Index = 1657 ,Vector(-1480, 147, -106), 'models/props_c17/door01_left.mdl', '' },
	}
};
UNPICKABLELOCKS = {		
	["rp_downtown_tits_v2"] = {
		{ Index = 3070 ,Vector(36, -2.5, 126), '*234', '' },
{ Index = 1962 ,Vector(-1275, 968, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
{ Index = 1963 ,Vector(-1181, 968, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },

	}
}
LOCKEDDOORSTART = {		
	["rp_downtown_tits_v2"] = {
		{ Index = 3079 ,Vector(-3318, -1873, -142), 'models/props_c17/door01_left.mdl', 'Bank of America - Employee Entrance' },
		{ Index = 3080 ,Vector(-3318, -1967, -142), 'models/props_c17/door01_left.mdl', 'Bank of America - Employee Entrance' },
		{ Index = 1600 ,Vector(-190, 402.90899658203, -138), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1962 ,Vector(-1275, 968, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1963 ,Vector(-1181, 968, -141.71899414063), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1476 ,Vector(-819, -1516, 378), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1500 ,Vector(-889.75, -2081, -77), '*44', '' },
		{ Index = 1499 ,Vector(-889.75, -1949.0100097656, -77), '*43', '' },
		{ Index = 1478 ,Vector(-1046, -1662, -142), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 1479 ,Vector(-872, -1614, -142), 'models/props_c17/door01_left.mdl', '' },
		{ Index = 3070 ,Vector(36, -2.5, 126), '*234', '' },

	}
}
CUSTOMNAMEDOOR = {
	["rp_downtown_tits_v2"] = {
		{ Index = 3098 ,Vector(-2948, -1545, -142), 'models/props_c17/door01_left.mdl', 'Bank of America' },
		{ Index = 3099 ,Vector(-2948, -1639, -142), 'models/props_c17/door01_left.mdl', 'Bank of America' },
		{ Index = 3096 ,Vector(-2948, -1689, -142), 'models/props_c17/door01_left.mdl', 'Bank of America' },
		{ Index = 3097 ,Vector(-2948, -1783, -142), 'models/props_c17/door01_left.mdl', 'Bank of America' },
		{ Index = 3079 ,Vector(-3318, -1873, -142), 'models/props_c17/door01_left.mdl', 'Bank of America - Employee Entrance' },
		{ Index = 3080 ,Vector(-3318, -1967, -142), 'models/props_c17/door01_left.mdl', 'Bank of America - Employee Entrance' },
		{ Index = 1905 ,Vector(-1136, -7636, -140), 'models/props_c17/door01_left.mdl', 'Gas Station' },
		{ Index = 1919 ,Vector(38, -7901, -139), 'models/props_c17/door01_left.mdl', 'Suburb Back Apartments' },
		{ Index = 1918 ,Vector(-60, -7901, -139), 'models/props_c17/door01_left.mdl', 'Suburb Back Apartments' },
		{ Index = 1962 ,Vector(-1275, 968, -141.71899414063), 'models/props_c17/door01_left.mdl', 'Theatre' },
		{ Index = 1963 ,Vector(-1181, 968, -141.71899414063), 'models/props_c17/door01_left.mdl', 'Theatre' },
		{ Index = 1801 ,Vector(3305, 4334, -82), 'models/props_c17/door01_left.mdl', 'Ghetto Apartments' },
		{ Index = 1477 ,Vector(-1046, -2242, -142), 'models/props_c17/door01_left.mdl', 'Clinic & Fountain Apartments' },
		{ Index = 1467 ,Vector(-1037, -1163, -142), '*32', 'Downtown Apartments' },
		{ Index = 1466 ,Vector(-1037, -1063, -142), '*31', 'Downtown Apartments' },
		{ Index = 1476 ,Vector(-819, -1516, 378), 'models/props_c17/door01_left.mdl', 'Downtown Apartments - Roof' },
		{ Index = 2858 ,Vector(-16.999799728394, 7098, -138), 'models/props_c17/door01_left.mdl', 'Outskirt Apartments' },
		{ Index = 2859 ,Vector(-17, 6518, -138), 'models/props_c17/door01_left.mdl', 'Outskirt Apartments' },
		{ Index = 2372 ,Vector(1233, 7596, -141.71899414063), 'models/props_c17/door01_left.mdl', 'Brick Apartments' },
		{ Index = 2373 ,Vector(1327, 7596, -141.71899414063), 'models/props_c17/door01_left.mdl', 'Brick Apartments' },

		{ Index = 3295 ,Vector(-1952, -5836, -138), '*261', 'Car Dealer' },
{ Index = 3294 ,Vector(-1952, -6492, -138), '*260', 'Car Dealer' },
{ Index = 3284 ,Vector(-2204, -5937, -140), 'models/props_c17/door01_left.mdl', 'Car Dealer' },
{ Index = 3285 ,Vector(-2204, -6031, -140), 'models/props_c17/door01_left.mdl', 'Car Dealer' },
	}
}
local _eMeta = FindMetaTable("Entity");

function _eMeta:IsDoor( )

	return self:GetClass() != "item_doorbuster" and string.find(self:GetClass(), "door");

end 
if SERVER then

	hook.Add("InitPostEntity", "findDoorsToLock", function()

		for y , x in pairs( ents.GetAll() ) do

			if x:IsDoor() then

				if x:IsLockedDoorAtStartup() || (x:IsPoliceDoor() and !x:IsUnlockedDoorAtStartup()) then

					x:Fire('lock', '', 0);
					x:Fire('close', '', .5);
				
				else

					x:Fire('unlock', '', 0);
					if x:IsUnlockedDoorAtStartup() then
						
						x:Fire('open', '', .5);

					end
					
				end

			end

		end

	end)

end

 //
function EntIndexFromGetID( _id )
	local _index = _id - ( 128 - game.MaxPlayers( ) );

	// If accidentally used on player, make sure the right index is returned..
	if ( game.MaxPlayers( ) - _id > 0 ) then
		_index = _id;
	end

	return _index;
end

function _eMeta:IsUnPickable()

	if !self:IsDoor() then return false end
	
	if (self.__customDoor) then return true end
	
	if UNPICKABLELOCKS[game.GetMap()] then
		for k , v in pairs( UNPICKABLELOCKS[game.GetMap()] ) do
			
			if !v[1] || !v[2] then return false end
		
			if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
							
				return (!v[4] && true || false);
				
			end
			
		end
		
	end
end
function _eMeta:IsUnlockedDoorAtStartup()

	if !self:IsDoor() then return false end
	
	if (self.__customDoor) then return true end
	
	if UNLOCKEDDOORSTART[game.GetMap()] then
		for k , v in pairs( UNLOCKEDDOORSTART[game.GetMap()] ) do
			
			if !v[1] || !v[2] then return false end
		
			if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
							
				return (!v[4] && true || false);
				
			end
			
		end
		
	end
end
function _eMeta:IsLockedDoorAtStartup(  )
	if !self:IsDoor() then return false end
	
	if (self.__customDoor) then return true end
	
	if LOCKEDDOORSTART[game.GetMap()] then
		for k , v in pairs( LOCKEDDOORSTART[game.GetMap()] ) do
			
			if !v[1] || !v[2] then return false end
		
			if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
							
				return (!v[4] && true || false);
				
			end
			
		end
	end

	return false;

end
function _eMeta:IsCustomNameDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__customDoor) then return true end
	
	if !CUSTOMNAMEDOOR[game.GetMap()] then return false end;
	for k , v in pairs( CUSTOMNAMEDOOR[game.GetMap()] ) do
		
		if !v[1] || !v[2] then return false end
	
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
			self.__customDoor = true;
			
			return true;
			
		end
		
	end
	
	return false;

end
function _eMeta:GetCustomName()
	if !self:IsDoor() then return "" end
	
	if !CUSTOMNAMEDOOR[game.GetMap()] then return false end;
	for k , v in pairs( CUSTOMNAMEDOOR[game.GetMap()] ) do
		
		if !v[1] || !v[2] || !v[3] then return false end
	
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
		
			
			return v[3];
			
		end
		
	end

	return ""
end
function _eMeta:IsPoliceDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__policeDoor) then return true end
	if !POLICE_DOOR_TABLE[game.GetMap()] then return false end;
	
	for k , v in pairs( POLICE_DOOR_TABLE[game.GetMap()] ) do
		
		if !v[1] || !v[2] then return false end
	
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
			self.__policeDoor = true;
			
			return true;
			
		end
		
	end
	
	return false;

end

function _eMeta:IsNeutralDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__neutralDoor) then return true end
	if !NEUTRAL_DOOR_TABLE[game.GetMap()] then return false end;
	for k , v in pairs( NEUTRAL_DOOR_TABLE[game.GetMap()]  ) do
	
		if !v[1] || !v[2] then return false end
		
		if v[1]:Distance( self:GetPos( ) ) < 50 && v[2] == self:GetModel( ) then
			
			self.__neutralDoor = true;
			
			return true;
			
		end
		
	end
	
	return false;
end

function _eMeta:IsBusinessDoor(  )
	if !self:IsDoor() then return false end
	
	if (self.__BusinessDoor) then return true end
	
	for k , v in pairs( Business_DOOR_TABLE ) do
	
		if v[2]:Distance( self:GetPos( ) ) < 50 && v[3] == self:GetModel( ) then
			
			self.__BusinessDoor = true;
			
			return true;
			
		end
		  
	end
	
	return false;

end

function _eMeta:IsDoor()

	return string.find( self:GetClass() , "door" );
 
end

function  _pMeta:IsLookingAtProperty()
	if !IsValid(self) then return end
	local _tr = self:GetEyeTrace().Entity;
	local _trEnt  = ( _tr:IsValid() ) && _tr || nil ;
	local _isDoor = _trEnt:IsDoor();	
	print( string.find( _tr:GetClass(), "door" ))
	local _doorID =  _trEnt:getFlag("doorID", 0 ) || 0;
		
	local _IsProperty = ( _trEnt && _isDoor && _trEnt == true && PROPERTY:GetID(_doorID) != nil ) && ( true ) || ( false );
	
	return _IsProperty , _doorID || 0;
	
end
