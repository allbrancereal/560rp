
fsrp = fsrp || {}
DeadPlayers = {};
local _pMeta = FindMetaTable( 'Player' )

	
util.AddNetworkString( "slotAdjustment" )
util.AddNetworkString( "getBanInformation" )
util.AddNetworkString( "bankATMExchange" )
util.AddNetworkString( "sendSong" )
util.AddNetworkString( "inventorySync" )
util.AddNetworkString( "EnteredVehicleCustomization" )
util.AddNetworkString( "SendClientVehicleCustomizer" )
util.AddNetworkString( "ExitVehicleCustomization" )
util.AddNetworkString( "depositCarToGarage" )
util.AddNetworkString( "InviteToOrg" )
util.AddNetworkString( "kickFromOrg" )
util.AddNetworkString( "updateClientOrgDefinitions" )
util.AddNetworkString( "RatePlayer" )
util.AddNetworkString( "sendOrgChange" )
util.AddNetworkString( "tryExecution" )
util.AddNetworkString( "PurchaseVehicleCustomization" )
util.AddNetworkString( "SendClientVehicleCustomizerUpdate" )
util.AddNetworkString( "banPlayer" )
util.AddNetworkString("updateInventory")
util.AddNetworkString("sendClientPermData")

function _pMeta:UpdateClientInventoryVGUI()
	net.Start("updateInventory");
	net.Send(self);
end

function _pMeta:FindMovementSpeed()
	
	if self:getFlag("loadedIN",false) == true then
		local _cuffed = self:getFlag("cuffed", false);

		if _cuffed || self.Crippled && self.Crippled == true then			
			return fsrp.config.CrippleSpeed, fsrp.config.CrippleSpeed
		else	
			if self:GetRotoLevel(1) && self:GetRotoLevel(1)[1] && self:GetRotoLevel(1)[1] > 1 then
				local _lv = 1;
				if self:GetRotoLevel(1) then
					_lv = self:GetRotoLevel(1)[1]
				end
				return  fsrp.config.RunSpeed+(_lv*1), fsrp.config.WalkSpeed+(_lv*1) 
			end
		end
	end
	
	return fsrp.config.RunSpeed,fsrp.config.WalkSpeed;
end
CustomizableWeaponry.callbacks:addNew("bulletCallback", "bulletcallbackDeathImp", function( self , _p, trace , dmg  )

	if trace.Hit then

		for k ,v in pairs(DeadPlayers ) do
			local _foundP = player.GetByUniqueID( k );
			local _pos = v[1];

			if _foundP then
				if (_foundP:GetRagdollEntity() && IsValid(_foundP:GetRagdollEntity()) && IsValid(_foundP) && _foundP && _pos && isvector(_pos) && _pos:Distance(_foundP:GetRagdollEntity():GetPos()) < 5) && v[2]+1 < os.time() then
					
					DeadPlayers[_foundP:UniqueID()] = nil;
					_foundP:Spawn()
					_foundP:Notify("You have been finished off by a bullet.")
				end

			end
		
		end
		
	end
end)

function fsrp.LoadPermanentData( _p ) 

	if _p && IsValid( _p ) && _p:IsPlayer() then

		fsdb:Query( "SELECT * FROM `fsdb_characterdata` WHERE `id` ='".._p:SteamID().."' " , function( _,result )

			if result[1] then

				local _resultRow = result[1]["PermData"];
				local _DailyLoginData = result[1]["LoginReward"];
				if _DailyLoginData then
					_p:setFlag("rotodailyreward", _DailyLoginData);
					_p:CheckDailyReward(true)
				
				else
					_p:SetupDailyRewardTable()
					_p:CheckDailyReward(true)
				end
				
				local _PermanentDataRows = string.Explode(";", _resultRow)

				local _permTable = {};

				for k , v in pairs( _PermanentDataRows ) do
					
					local _KeyValueSplit = string.Explode(">", v );
					
					_permTable[_KeyValueSplit[1]] = _KeyValueSplit[2];


				end

				_p:setFlag("PermanentData", _permTable);
				_p:LoadWarehouse()

				hook.Run("InitializePermanentData",_p,_permTable);
				/*
				net.Start("sendClientPermData")
				net.WriteString(_p:SteamID())
				net.WriteString(_resultRow)
				net.Broadcast()
				*/


			end


		end )

	end

end

net.Receive( "banPlayer" , function( _l, _p )

	local _steamID = net.ReadString()
	local _length = net.ReadString()
	local _reason = net.ReadString()
	local _ipBan = net.ReadBool()

	local _isPlayerOnline = player.GetBySteamID( _steamID )
	local ToBanLength = tonumber( _length ) || 3600;

	if !_p:IsAdmin() then return end
	
	if _isPlayerOnline then
		
		_isPlayerOnline:BanPlayer( _p:getRPName() , ToBanLength , _reason , _ipBan )

	else

		OfflineSteamIDBan( _steamID, _p:getRPName() , ToBanLength, _reason, _ipBan )

	end
end )

local _Ratings = {
	{Name = "Winner"};
	{Name = "Friendly"};
	{Name = "Dumb"};
	{Name = "Funny"};
	{Name = "Zing"};
	{Name = "Rich"};
	{Name = "Agree"};
	{Name = "Disagree"};
	{Name = "Useful"};
	{Name = "Late"};
	{Name = "Optimistic"};
	{Name = "Magical"};
	{Name = "Informative"};

}


/* Permanent / Global Data */

function fsrp.SavePermanentData( _p ) 
	
	if _p && IsValid( _p ) && _p:IsPlayer() then
		if _p:getFlag("loadedIN",false) == false then return end
		
		fsdb:Query( "UPDATE `fsdb_characterdata` SET `PermData` = '" .. _p:GetJSONPermdata() .. "' WHERE `id` = '" .. _p:SteamID() .. "'; ")

	else

		fsdb:Query( "DELETE FROM `fsdb_globalvars`;" ,function( result )

			for k , v in pairs( fsrp.GetPermanentData() ) do

				local _content = v;
				local _category = k;
				if istable( v ) then

					_content = util.TableToJSON( v );
					_category = "2_" .. _category; 
 
				else
  
					_category = "1_" .. _category;

				end

				fsdb:Query( "SELECT * FROM `fsdb_globalvars` WHERE `category` = '" .. _category .. "' ;", function ( result ) 
					
					if result[1] && result[1]["category"] then return end 

					fsdb:Query( "INSERT INTO `fsdb_globalvars` ( `category`, `content`) VALUES ('" .. _category .. "' , '".. _content .. "' ) ;" )
				
				end)
 
			end

			//fsdb:Query( "UPDATE `fsdb_globalvars` SET `main` = '" .. util.TableToJSON() .. "';")
				
			end)
		
		end

end

function fsrp.RetrievePermanentData( _p )

	fsdb:Query( "SELECT * FROM `fsdb_globalvars` " , function( _,result )

		if result[1] then

			//PrintTable( result )
			local rows = result;

			for k , v in pairs( rows ) do

				local _category = v["category"];
				local _content = v["content"];

				//print( "Row #" .. k .. ": " .. _category .. _content )

				local _splitCat = string.Explode( "_" , _category );

				if _splitCat["category"] == "2" then

					_content = util.JSONToTable( _content );

				end

				_category = _splitCat["content"];

				fsrp.PermDataTbl[_category] = _content;

			end

		end


	end )

end

/* Player Rating */
function fsrp.RetrieveRatings( _Player )


	fsdb:Query( "SELECT `rating` FROM `fsdb_characterdata` WHERE `id` ='".. _Player .. "';", function ( _,result )
		
		if result then
		
			if result[1] && result[1][1] then
			
				if player.GetBySteamID( _Player ) then
				
					player.GetBySteamID( _Player ):setFlag( "ratings" , result[1]["rating"] );
				
				end
		
			end

		end
		
	end )
	
end
local _lastRating = {}
 
net.Receive( "RatePlayer" , function( _l , _p )
	  
	local _Rate = net.ReadInt( 8 )
	local _Player = net.ReadString() 
	if _Player == _p:SteamID() then
	
		return _p:Notify( "You may not rate yourself!" )
		
	end
	
	if _lastRating[_p:SteamID()] then
	
		if _lastRating[_p:SteamID()] > CurTime() then
		
			return _p:Notify( "You may not rate another player while on cooldown" );
			
		end
		_lastRating[_p:SteamID()] = CurTime() + 300 
	
	else
	
		_lastRating[_p:SteamID()] = CurTime() + 300 
	
	end
	local _torate = player.GetBySteamID( _Player ) 
	  
	if !_torate then return end 
	local _defaultRatings = "";
	_p:Notify( "Rated " .. _torate:getRPName() .. " (x1 " .. _Ratings[_Rate].Name .. ")" );
	_torate:Notify( "You have been rated by " .. _p:getRPName() .. " (x1 " .. _Ratings[_Rate].Name .. ")" );
	PrintAdmin( "[ADMIN] [RATING] " .. _p:Nick() .. " rated " .. _torate:Nick() .. " (x1 " .. _Ratings[_Rate].Name .. ")" ) ;
	for k , v in pairs( _Ratings ) do
		
		if k != #_Ratings then
		
			_com = ","
			
		else 
		
			_com = ""
			
		end
		
		_defaultRatings = _defaultRatings .. "0" .. _com 
	
	end
	
	local _prevRatings = _torate:getFlag("ratings", _defaultRatings );
	if #_prevRatings <= 0 then
		_prevRatings = _defaultRatings;
	end
	local _splitRatings = string.Explode( "," , _prevRatings )

	
	if #_splitRatings != #_Ratings then return end
	
	_splitRatings[_Rate] = tostring( tonumber( _splitRatings[_Rate] ) + 1 )

	local _newRating = table.concat(_splitRatings, "," );
	
	fsdb:Query( "UPDATE `fsdb_characterdata` SET `rating` = '" .. _newRating .. "' WHERE `id` = '" .. _Player .. "';" );
	_torate:setFlag( "ratings", _newRating );
	
end ) 

net.Receive( "depositCarToGarage" , function ( _l , _p )

	_p:SendCarToGarage( false, false )

end )

function fsrp.IsValidBdg ( name )
	if (string.len(name) < 3) then return false; end
	if (string.len(name) >= 16) then return false; end
	
	local name = string.lower(name);
	
	local numDashes = 0;
	for i = 1, string.len(name) do
		local validLetter = false;
		local curChar = string.sub(name, i, i);
		
		if (curChar == "-") then
			numDashes = numDashes + 1;
			
			if (numDashes > 1) then
				return false;
			end
		end
		
		for k, v in pairs(fsrp.config.ValidNameCharacters) do
			if (curChar == v) then
				validLetter = true;
				break;
			end
		end
		
		if (!validLetter) then
			Msg("bad char")
			return false;
		end
	end
	
	return true;
end
net.Receive( "PurchaseVehicleCustomization", function( _l , _p )

	local _vehicleID = net.ReadString()
	local _bdg = net.ReadString()
	local _skin = net.ReadInt( 8 )
	local _color = net.ReadColor()
	/*

	if !fsrp.IsValidBdg( _vehicleID ) || !fsrp.IsValidBdg( _bdg ) then
	
		PrintAdmin( "Illegal characters found in vehicle customization: " .. _p:Nick() )
		PrintAdmin( _vehicleID )
		PrintAdmin( _bdg )
		
		return _p:Notify( "Information did not match up with the server, please remove & retry your masterpiece.")
	end
	*/
	
	if !_p:canAffordBank( fsrp.config.VehicleCustomizationCost ) then
	
		return _p:Notify( "You can not afford this vehicle job! You need: $" .. (fsrp.config.VehicleCustomizationCost - _p:getBank() ) )

	end
	
	_p:addBank( -fsrp.config.VehicleCustomizationCost );
	
	for x , y in pairs( ents.GetAll() ) do 

		if y:getFlag("carOwner","") == _p:SteamID() then
				
			local groups = _bdg
				
			if ( groups == nil ) then groups = "" end
				
			local groups = string.Explode( ",", groups )
				
			for k = 0, y:GetNumBodyGroups() - 1 do
			
				y:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
					
			end	
			
			y:SetColor( _color )
			y:SetSkin( _skin )
				
			
			_p:EnterVehicle( y ) 
			
			break;
			
		end
				
	end
	//_p:Notify("Adding Customization to Database. " .. _vehicleID )
	//print( _vehicleID)
	AddVehicleToDB( _p:SteamID(), _vehicleID, _bdg, _skin, _color.r .. "," .. _color.g .. "," .. _color.b )
	//UpdateVehicleInDB(_p:SteamID(), _vehicleID, _bdg, _skin, _color.r .. "," .. _color.g .. "," .. _color.b )
	
end )
local function UpdateClientVehicleCustomization( mdl , v )
	
		net.Start("SendClientVehicleCustomizerUpdate")
			net.WriteString( mdl )
		net.Send( v )
	
end
net.Receive( "EnteredVehicleCustomization" , function( _l , _p )

	hook.Run( "PlayerEnteredVehicleCustomization" , _p )
		
	local lastAction = _p:getFlag("lastAction", 0 ) 
	if lastAction > CurTime() then return end
	_p:setFlag("lastAction", CurTime() + 1 )
	local foundCar = false;
	local carModel = nil;
	local foundcarEntindex = nil
	
	for k , v in pairs( ents.FindInSphere( _p:GetPos() , 500 ) ) do 

		if v:getFlag("carOwner","") == _p:SteamID() then
				
			carModel = v:GetModel()
			foundcarEnt = v
			foundcarEntindex = v:getFlag("carID", "vwbeetleconvtdm")
			
			foundCar = true;
			
		end
				
	end
	
	if foundCar then

		net.Start("SendClientVehicleCustomizer")
			net.WriteString( foundcarEntindex )
			net.WriteString( foundcarEnt:getFlag("bdg", "" ) )
			net.WriteInt( foundcarEnt:GetSkin() ,8 )
			net.WriteColor( Color(foundcarEnt:GetColor().r,foundcarEnt:GetColor().g,foundcarEnt:GetColor().b) ) 
		net.Send( _p )
		
		UpdateClientVehicleCustomization( carModel , _p )


	else
		
		_p:Notify( "Couldn't detect your vehicle, make sure it's within 5 meters reach!" )
	
	end
			
end )

net.Receive( "ExitVehicleCustomization" , function( _l , _p )

	local _RefreshModel = nil;
	
	for k , v in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
		
		if v:getFlag("vehicleCustomizer", false ) == true then
			
			local _RefreshModel = v:GetModel()
		
		end
		
	end
	
	
	if _RefreshModel then
	
		hook.Run( "PlayerFinishedVehicleCustomization" , _p )
		
		UpdateClientVehicleCustomization( _RefreshModel , _p )
	
	end
	
end )

	
// vehicles ayyee

	util.AddNetworkString("sendClientCloseVehicle")
	util.AddNetworkString("sendClientVehicleShop")
	util.AddNetworkString("retrieveVehicleFromGarage")
	util.AddNetworkString("resetMainDisplayModel")
	util.AddNetworkString("PurchaseVehicle")

	net.Receive( "PurchaseVehicle", function (_l , _p )
	
			for k , v in pairs( ents.GetAll() ) do 

				if v:getFlag("carOwner","") == _p:SteamID() then
				
					v:Remove()
					
				end
				
			end
			_p:setFlag("ownedCar" , nil )
			
		local _VehicleID = net.ReadInt( 16 ) 
		local _colr = net.ReadInt(12)
		local _colg = net.ReadInt(12)
		local _colb = net.ReadInt(12)
		local _col = Color(_colr,_colg,_colb,255)

		local _ColorToBuyString = _col.r .. "," .. _col.g .. "," .. _col.b;
			
		local _vehiclesToShow = {};
		local _in = LoadStringToInventory(_p:getFlag("inventory" , "" ))

		for k , v in pairs(fsrp.VehicleDatabase ) do
			
			//if v.RestrictSale then return end
				local _found = false;
			for x, y in pairs( _in ) do 

				if v.Key == y.ID then 
					_found = true;
				end
				
			end
				if !_found then
					
					table.insert( _vehiclesToShow, v )

				end
			
		end
		local _found = false;
		
		for k , v in pairs( _vehiclesToShow ) do
			
			if v.Key == _VehicleID then
				
				_found = true;

			end

		end

		if !_found then return _p:Notify("You can't buy the same car twice")  end

		if !_p:canAfford( ITEMLIST[_VehicleID].Cost  ) then
		
			return _p:Notify( "You can not afford $" .. math.Round(ITEMLIST[_VehicleID].Cost,2) .. "!" )
			
		end
		
		local _gmodVehicleTable = false
		
		for k , v in pairs( list.Get("Vehicles") ) do
			if k ==  ITEMLIST[_VehicleID].CarIndex then
				
				_gmodVehicleTable = v;
				
				break
				
			end
			
		end
		
		if !_gmodVehicleTable then
		
			return Error( "Couldn't find vehicle in garry's mod assets" )
			
		end
		local _hasCar = false;
		
		if !_hasCar then
		
			_p:addMoney( -ITEMLIST[_VehicleID].Cost );
			_p:AddItemByID( _VehicleID )
			
			AddVehicleToDB( _p:SteamID() , ITEMLIST[_VehicleID].ListVehicle, "", 0, _ColorToBuyString )
			
			
			local _spawnPoint = selectVehicleSpawn( _p , ITEMLIST[_VehicleID].CarIndex );
		
			SpawnVehicleFromID( ITEMLIST[_VehicleID].CarIndex,_gmodVehicleTable, _spawnPoint[2], _col, _p , _spawnPoint[3] ) 
		
		end
		
	end )
	
	function _pMeta:HandVehicleInformationOver( playerVehicle , receivingSteamID )
		
		local _player = player.GetBySteamID( receivingSteamID )
		
		self:SendCarToGarage(false,true)
		
		fsdb:Query( "SELECT * FROM `fs_vehicles` WHERE (  `id`='" .. self:SteamID() .. "' AND `entname` = '".. playerVehicle .. "') ;", function( _,result )
			
			if result then
				
				if result[1] then
					AddVehicleToDB( receivingSteamID, playerVehicle, result[1]["bodygroups"], tonumber(result[1]["skins"]), result[1]["color"] )
				
				else
				
					AddVehicleToDB( receivingSteamID,  playerVehicle, "", 0,"255,255,255" )
				
				end
			
			end
		
		end )
		
		//fsdb:Query( "UPDATE `fs_vehicles` SET `id` = '" .. receivingSteamID .. "' WHERE (  `id`='" .. self:SteamID() .. "' AND `entname` = '".. playerVehicle .. "') ;" , function( res, err, stat )
			
		//end );

		AddVehicleToDB( self:SteamID(), playerVehicle, "", 0, "255,255,255" )
	
	end 
	
	function SpawnVehicleFromID( id , _gmodVehicleTable, spawnlocation, _col, _p  , spawnAng  ) 

		if _p:Team() == TEAM_POLICE then
			local count = 0;
			for k , v in pairs(ents.GetAll()) do
				if v:getFlag("policevehicle", false) == true then
					
					count = count +1;
				end
			end
			if count+1 > fsrp.mayorgovernment.carlimits.policecruiser then
				return _p:Notify("The maximum number of police cruisers has been reached.")
			end
		end
		if _p:Team() == TEAM_PARAMEDIC then
			local count = 0;
			for k , v in pairs(ents.GetAll()) do
				if v:getFlag("paramedicvehicle", false) == true then
					
					count = count +1;
				end
			end
			if count+1 > fsrp.mayorgovernment.carlimits.ambulance then
				return _p:Notify("The maximum number of ambulances has been reached.")
			end
		end
		if _p:getFlag("ownedCar", nil) != nil then
			

			local _cangarage = _p:SendCarToGarage( false, false )

			if !_cangarage then return end

		end

		local _spawnedVehicle = ents.Create( _gmodVehicleTable.Class )
		
		_spawnedVehicle:SetModel( _gmodVehicleTable.Model )
		_spawnedVehicle:SetPos( spawnlocation )
		_spawnedVehicle:SetColor( _col )
		spawnAng = spawnAng || Angle( 0,0,0 );
		_spawnedVehicle:SetAngles( spawnAng )
		_spawnedVehicle:SetKeyValue("vehiclescript", _gmodVehicleTable.KeyValues.vehiclescript );
		_spawnedVehicle:Spawn()
		if _p:Team() == TEAM_POLICE then
			_spawnedVehicle:setFlag("policevehicle",true)
			

		elseif _p:Team() == TEAM_PARAMEDIC then
			_spawnedVehicle:setFlag("paramedicvehicle",true)
		
		end
		_spawnedVehicle:setFlag( "carOwner", _p:SteamID() )
		_spawnedVehicle:setFlag( "carID", id )
		_p:setFlag("ownedCar" , _spawnedVehicle:EntIndex() );
		
		if _p then
		
			_p:EnterVehicle( _spawnedVehicle )
				

		end
		timer.Simple(1,function()
			GetCarInformation( _p:SteamID() , id, _p ,  _spawnedVehicle )
		end)
	end

	
	function AddVehicleToDB( id, entname, bodygroups, skins, color )
		//print( "INSERT INTO `fs_vehicles` ( `id` , `entname`, `bodygroups`, `skins`, `color` ) VALUES( '" .. id .."', '" .. entname .."', '" .. bodygroups .. "'," .. skins .. ",'" .. color .. "' );" )
		local _s0 = "DELETE FROM `fs_vehicles` WHERE ( `id`='" .. id .. "' AND `entname` = '".. entname .. "' );";

		fsdb:Query( _s0,function(_,result) PrintTable(result) end);
		
		local _s =  "INSERT INTO `fs_vehicles` ( `id` , `entname`, `bodygroups`, `skins`, `color` ) VALUES( '" .. id .."', '" .. entname .."', '" .. bodygroups .. "'," .. skins .. ",'" .. color .. "' );" ;

		fsdb:Query(_s,function(_,result) PrintTable(result) end);
		
	end
	
	function UpdateVehicleInDB( id, entname,bodygroups, skins, color )
	
		fsdb:Query( "UPDATE `fs_vehicles` SET `bodygroups` = '" .. bodygroups .. "', `skins` ='" .. skins .. "',`color` = '" .. color .. "' WHERE `id`='" .. id .. "' AND `entname` ='" .. entname .. "';" );
			
	end
	
	function GetCarInformation( id , ent, _p , _vehicle  )
	
		fsdb:Query( "SELECT * FROM `fs_vehicles` WHERE (`id`='" .. id .. "' AND `entname` = '".. ent .. "');", function( _,result )
			//PrintTable(result)
			local _res = result;
			if _res[1] then
				//PrintTable( result ) 
				local _foundIndex = _res[1];
				

						local _ColorSplit = string.Explode( "," , _foundIndex["color"] )
							
						local _skin = tonumber( _foundIndex["skins"] )
						local _color = Color( tonumber(_ColorSplit[1]),tonumber(_ColorSplit[2]),tonumber(_ColorSplit[3]) );
						local _bdg = _foundIndex["bodygroups"]
						
						local groups = _bdg
						if ( groups == nil ) then groups = "" end
							
						local groups = string.Explode( ",", groups )
							
						for x = 0, _vehicle:GetNumBodyGroups() - 1 do
							
							_vehicle:SetBodygroup( x, tonumber( groups[ x + 1 ] ) or 0 )
							
						end
						
						_vehicle:setFlag("bdg", _foundIndex["bodygroups"] )
						_vehicle:setFlag("skin", _foundIndex["skins"] )
						_vehicle:setFlag("clr", _foundIndex["color"] )
						_vehicle:SetColor( _color ) 
						_vehicle:SetSkin( _skin )
						
						
						_p:Notify("Database has retrieved your car information.") 
						
				
				if _foundIndex then
				
					
				end
				
			end
		
		end )

	end
	
	function _pMeta:SendCarToGarage( remote, override )
		
			if !remote then remote = false end
		
			if self:getFlag("ownedCar",nil) == nil then return true end
			

			if self:canAffordBank( fsrp.config.CarRetrievalCost ) then
				
				if remote == true then
				
					self:addMoney( -fsrp.config.CarRetrievalCost )
					
					self:Notify( "You have paid $" .. fsrp.config.CarRetrievalCost .. " to tow your car." )
				end
				
			else
				if self:Team() != TEAM_CIVILLIAN then return false end
				
				if !override && remote then
						
					self:Notify( "You can not afford to tow your car to the garage." )
					
					return false

				end
				
			end
			
			if !remote && !self:NearNPC( "normcarret" ) && ( !self:NearNPC( "govtcarret" ) && !self:NearNPC("paramcarret") ) then
				
				if !override then

						self:Notify( "You may not send your car to the garage when not around a garage NPC" )
				
					return false

				end
				
			end
				
			for k , v in pairs( ents.GetAll() ) do 

				if v:getFlag("carOwner","") == self:SteamID() then
					
					if v:GetPos():Distance( self:GetPos() ) > 500 && !override then
						self:Notify( "Too far away to quick-send your car to the garage" )
						
						return false

					end
					
					v:Remove()
					
					self:setFlag("ownedCar" , nil )

					return true
				end
				
			end
			
		return false
	
	end 
	
	net.Receive( "retrieveVehicleFromGarage", function ( _l , _p )
		
		local _vehicle = net.ReadString();
		local _check = false;
		local _spawnPoint = selectVehicleSpawn( _p , _vehicle );
		local _toFar = false;
		if _p:getFlag("ownedCar" , nil ) then
			
			for k , v in pairs( ents.GetAll() ) do 

				if v:getFlag("carOwner","") == _p:SteamID() then
					
					if v:GetPos():Distance( _p:GetPos( ) ) > 1500 then 
					
						_toFar = true;

						break;
						
					end
						
				end
					
			end
			
			if _toFar == true && _p:Team() == TEAM_CIVLLIAN then
			
				return _p:Notify( "Your vehicle is too far away from the garage person" )
				
			end
				
			_p:SendCarToGarage( false, true  )
			
		end
		
		if _p:Team() == TEAM_CIVILLIAN then
			local _inv = _p:getFlag( "inventory", LoadStringToInventory("") );
			
			for k , v in pairs( LoadStringToInventory(_inv ) ) do
	
				if ITEMLIST[v.ID].Vehicle then
					
					local _Item = ITEMLIST[v.ID];
					
					if _Item.ListVehicle == _vehicle then
					
						_check = true;
					
					end
				
				end
			
				
			end
			
		else
		
			if fsrp.VehicleDatabase[_vehicle].AvaliableTeam then
			
				local _Vehicle = fsrp.VehicleDatabase[_vehicle]
				
				local _foundTeam = false;
				
				
				for k , v in pairs( _Vehicle.AvaliableTeam ) do
				
					if v == _p:Team() then
					
						_foundTeam = true;
						
						break;
						
					end					
				
				end
				
				if _foundTeam == true then
				
					_check = true;
					
				end				
				
			end
			
		end
		
		if _check == true then
				
			local _list = list.Get("Vehicles")
			
			SpawnVehicleFromID( _vehicle,_list[_vehicle] , _spawnPoint[2] , Color(255, 255 ,255 ,255 ), _p, _spawnPoint[3]   ) 
			
			_p:Notify( "Spawning vehicle. ")		
			
		end
		
		
	end )
	
	net.Receive( "sendClientCloseVehicle", function( _l, _p )
	
		_p:EndVehicleShop( )
		
		_model = nil;
		_ent = nil;
		
		for k , v in pairs( ents.FindByClass( "cardisplay" ) ) do
				
			if v:getFlag( "mainCarDisplay", false ) == true then
					
				_model = v:GetModel()
				_ent = v:EntIndex()
				
				if !IsValid( v ) then
				
					if SERVER then
					
						makePropDisplayFromTable()
						
					end
				
				end
						
				break;
						
			end
					
		end
		
		if _model && _ent then
		
			net.Start( "resetMainDisplayModel" )
				net.WriteString( _model )
				net.WriteInt( _ent, 16 )
			net.Send( _p ) 
		
		end
		
	end )
	
// equip primary, secondary and hat after joining

function _pMeta:EquipLastWeapons( _p, _s , _h )
	timer.Simple(0.1,function()
	if _p != 0 then

		if ITEMLIST[_p].WeaponClass then 
		
			//local _RemovedItem = self:RemoveItemByID( _p ) ;
			
			//	if _RemovedItem then
					
			self:setFlag("itemSlot_1", _p )
					
			self:Give( ITEMLIST[_p].WeaponClass );
			
			//	end
				
		end
		
	end
	
	if _s != 0 then
	
		if ITEMLIST[_s].WeaponClass then
	
			//local _RemovedItem = self:RemoveItemByID( _s ) ;
			
			//	if _RemovedItem then
				
					self:setFlag("itemSlot_2", _s )
					
					self:Give( ITEMLIST[_s].WeaponClass );
			
			//	end
				
		end
		
	end
	
	if _h != 0 then
	
		if ITEMLIST[_h].Hat then 
			
			//local _RemovedItem = self:RemoveItemByID( _h ) ;
			
			//	if _RemovedItem then
					
					self:EquipHat( _h )
			
			//	end
				
		end
		
	end

	end)

end

// hat equiped

function _pMeta:EquipHat( itemID )
	local _itemFromID = ITEMLIST[itemID];
	local _isItemHat = _itemFromID.Hat;
	
	if _isItemHat && _itemFromID.Hat then
	
	    if self.hat then
		    self:setFlag("HatEquiped", true)
			self.hat:SetModel(_itemFromID.Model)
			self.hat:setFlag( "hatID", itemID )
			self:setFlag("itemSlot_3", itemID )
		else
			self.hat = ents.Create( 'hat' )
	
			self.hat:SetOwner( self )
			self.hat:SetParent( self )
			self.hat:SetModel(_itemFromID.Model)
			//self.hat:SetContents(itemID.ID, self)
			self.hat:setFlag( "hatOwner", self:SteamID() )
			self.hat:setFlag( "hatID", itemID )
			
			self.hat:Spawn( )
			self.hat:Activate( )
			self.hat:SetPos(self:GetPos())
	
			self.hat:SetMoveType( MOVETYPE_NONE )
			self.hat:SetSolid( SOLID_NONE )
			self.hat:SetCollisionGroup( COLLISION_GROUP_NONE )
			self.hat:DrawShadow( false )
	    
		    self:setFlag("HatEquiped", true)
		
			self:setFlag("itemSlot_3", itemID )
		end
		
	end
	
end

function _pMeta:RemoveHat(  )

	if self:getFlag("HatEquiped", false ) then 
	
		self:setFlag( "HatEquiped", false )
		
	end	
	
end

// execution

net.Receive("tryExecution", function( _l, _p )

	if !IsValid( _p ) then return end
	if _p:Team() != TEAM_CIVILLIAN then return end
	
	local _theirID = net.ReadInt( 32 ) 
	
	local toHeal;
	
	local t = player.GetAll()
	
	for k =1 , #t do
	
		local v = t[k];
		
		if v:UniqueID() == theirUniqueID then
		
			toHeal = v;
		
		end
		
	end
	
	if !toHeal then return end
	if toHeal:Alive() then return end
	if _p:GetPos():Distance( toHeal:GetPos() ) > 500 then return end
	 
	timer.Simple( 0.5, function() 
		
		if (  !IsValid( toHeal ) ) then return end		
		
		DeadPlayers[toHeal:UniqueID()] = nil
		toHeal:Spawn()
			
	end )

end )
// bank top

	util.AddNetworkString("SendLeaderboardData")
 
	function GetValidation(  )
		
			local db = GetSVDB();
			if !db then return end;
			local preparedQuery = db:prepare("SELECT bankcash, first_name, last_name FROM `fsdb_user` WHERE adminrank > 7 ORDER BY bankcash DESC LIMIT 6;")
			function preparedQuery:onSuccess(FetchData)
				
				if !FetchData then DebugMessage('No MySQL results. Abandoning load proccess.'); return false; end
					
				TableOfPlayers = {}
				for k , v in pairs( FetchData ) do
					
					table.insert( TableOfPlayers ,{ name = FetchData[k]["first_name"] .. " " .. FetchData[k]["last_name"], bank =tonumber(FetchData[k]["bankcash"]) }) 

						
				end
				
				for k , v in pairs( player.GetAll() ) do
				
					v:setFlag("leaderboardTable_Money", TableOfPlayers )
					
				end
			
			end
						
			function preparedQuery:onError(err)
				print("An error occured while executing the query: " .. err)
			end
			preparedQuery:start()
				
	end
			 
	
	 
	function PlayerFirstSpawn_Leaderboard( _p, isclient)
		


		if #player.GetAll() <= 1 then
		
			for k , v in pairs( fsrp.PropertyTable ) do

				SetupProperty( v )
				
			end
		
		end
		
		fsrp.RetrieveRatings( _p:SteamID() );
		
		GetValidation()
		
	end
	
	hook.Add("PlayerFullyConnected", "PlayerFirstSpawn_Leaderboard", PlayerFirstSpawn_Leaderboard)
	// chat meta
	
function GM:PlayerCanHearPlayersVoice ( PlayerListening, PlayerSpeaking )
	local _,_hasTag = PlayerListening:HasTag("globalvc")
	local _,_hasTag2 = PlayerSpeaking:HasTag("globalvc")

	local _dist =	(PlayerListening:GetPos():Distance(PlayerSpeaking:GetPos()) <= chatBox.Radius.Local) 
	return _dist == true or (_hasTag == true and _hasTag2 == true)
end 

function PrintAdmin(text)
	for k, v in pairs(player.GetAll()) do
		if v:IsModerator() then
			v:PrintMessage(HUD_PRINTCONSOLE, text);
		end
	end
end 

chatBox.chatPatterns = {};
chatBox.History = {};
util.AddNetworkString("localchat");
util.AddNetworkString("allchat");
util.AddNetworkString("fakechat");

	hook.Add("PlayerSay", "doserversideChat", function( Player, Text, TeamChat )

		local DeadPlayer = (!Player:Alive());
		if (TeamChat and !string.match(Text, "^[ \t]*/")) then Text = "/ooc" .. Text; end
		if (!TeamChat and !string.match(Text, "^[ \t]*/")) then Text = "/local" .. Text; end
		
		if (DeadPlayer) then
			if string.Left( string.Trim(Text), 6 ) != "/spawn" && string.Left( string.Trim(Text), 4 ) != "/ooc" and string.Left( string.Trim(Text),  1 ) != "a"  and string.Left( string.Trim(Text),  2 ) != "//"  and string.Left( string.Trim(Text), 3 ) != "///" and string.Left( string.Trim(Text), 5 ) != "/looc" and string.Left( string.Trim(Text), 7 ) != "/report" then
				Player:Notify("You can't chat while you're unconcious.");
				return "";
			end
		end
		if !chatBox.chatPatterns then return end;
		
		for k, v in pairs(chatBox.chatPatterns) do
		
			if (string.match(string.lower(Text), "^[ \t]*[/!]" .. string.lower(k))) then
			
				
				// can use chat v[4]
				if (!v[4] || v[4](Player, Text)) then
				
					// v[1] chat type
					/*
					if (v[2] != 2 || v[2] != 3 || v[2] != 13) then
						local lowerText = string.lower(Text)
						for filter, response in pairs(chatBox.textFilter) do
							if (string.find(lowerText, filter)) then
								Player:Notify(response);
							
								return "";
							end
						end
					end*/
					
					// v[1] type isnt fake
					if (v[1] != "fakechat") then
						//umsg.Entity(Player);
						// when its not fake we send the player
					end
					
					local cText = string.Trim(string.sub(string.Trim(Text), string.len(k) + 2));

					// v[5] text edit
					if (v[5]) then
						cText = v[5](Player, string.Trim(cText));
					end

						// v[2] = id
						// ctext = chattext
						//umsg.String(cText);					
						//umsg.Short(v[2]);
						// send
					//umsg.End();
					
					
					if !v[3] then
								
					
						net.Start( v[1] )
							net.WriteString( cText )
							net.WriteInt( v[2] , 8 )
							net.WriteInt( Player:Team(),8 )
							net.WriteString( Player:Nick() )
							net.WriteString( Player:getRPName() )
							
						if v[1] == "allchat" then
							
							if  v[2] == 2 || v[2] == 13  then
							
								local pl = Player;
								local glowType = Color( 0, 0, 0 );
								if (pl:IsCouncilMember() && pl:IsDisguised()  != true) then
									glowType = Color(255, 0, 0)
								elseif (pl:IsDev() && pl:IsDisguised()  != true) then
									glowType = Color(255, 0, 255)	
								elseif (pl:IsSuperAdmin() && pl:IsDisguised()  != true) then
									glowType = Color(128, 0, 128)
								elseif (pl:IsAdmin() && pl:IsDisguised()  != true) then
									glowType = Color(0, 204,0 )
								elseif (pl:IsModerator() && pl:IsDisguised()  != true) then
									glowType = Color(255, 128,0 )
								elseif (pl:IsPremium() && pl:IsDisguised()  != true) then
									glowType = Color(255,215,0)
								end
								net.WriteColor( glowType )
								
							end										
													
						end
						
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
					else
					
						for x, y in pairs(player.GetAll()) do
						
							if (v[3](Player, y, Text) == true) then
							
								net.Start( v[1] )
									net.WriteString( cText )
									net.WriteInt( v[2] , 8 )
									net.WriteInt( Player:Team(),8 )
									net.WriteString( Player:Nick() )
									net.WriteString( Player:getRPName() )
									
								if v[1] == "allchat" then
									
									if  v[2] == 2 || v[2] == 13  then
									
										local pl = Player;
										local glowType = Color( 0, 0, 0 );
										if (pl:IsCouncilMember() && pl:IsDisguised()  != true) then
											glowType = Color(255, 0, 0)
										elseif (pl:IsDev() && pl:IsDisguised()  != true) then
											glowType = Color(255, 0, 255)	
										elseif (pl:IsSuperAdmin() && pl:IsDisguised()  != true) then
											glowType = Color(128, 0, 128)
										elseif (pl:IsAdmin() && pl:IsDisguised()  != true) then
											glowType = Color(0, 204,0 )
										elseif (pl:IsModerator() && pl:IsDisguised()  != true) then
											glowType = Color(255, 128,0 )
										elseif (pl:IsPremium() && pl:IsDisguised()  != true) then
											glowType = Color(255,215,0)
										end
										net.WriteColor( glowType )
										
									end										
									

								
								end
								net.Send( y )
								
							end
							
						end
						
					end
					// v[3] canchat
					/*
					if (!v[3]) then
					
						net.Start( v[1] )
							net.WriteString( cText )
							net.WriteInt( v[2] , 8 )
							net.WriteInt( Player:Team() , 8 )
							net.WriteString( Player:Nick() )
							net.WriteString( Player:getRPName() )
							if v[1] == "allchat" then
								local pl = Player;
								local glowType = Color( 0, 0, 0 );
								if (pl:IsCouncilMember() && pl:IsDisguised()  != true) then
									glowType = Color(255, 0, 0)
								elseif (pl:IsDev() && pl:IsDisguised()  != true) then
									glowType = Color(255, 0, 255)	
								elseif (pl:IsSuperAdmin() && pl:IsDisguised()  != true) then
									glowType = Color(128, 0, 128)
								elseif (pl:IsAdmin() && pl:IsDisguised()  != true) then
									glowType = Color(0, 204,0 )
								elseif (pl:IsModerator() && pl:IsDisguised()  != true) then
									glowType = Color(255, 128,0 )
								elseif (pl:IsPremium() && pl:IsDisguised()  != true) then
									glowType = Color(255,215,0)
								end
								net.WriteColor( glowType )
																	
							end
									
							
						net.Broadcast( )

					else

						for _, pl in pairs(player.GetAll()) do
							if (v[3](Player, pl, Text)) then
								net.Start( v[1] )
								
									net.WriteString( cText )
									net.WriteInt( v[2] , 8 )
									net.WriteInt( Player:Team() , 8 )
									net.WriteString( Player:Nick() )
									net.WriteString( Player:getRPName() )
									if v[1] == "allchat" then
										local pl = Player;
										local glowType = Color( 0, 0, 0 );
										if (pl:IsCouncilMember() && pl:IsDisguised()  != true) then
											glowType = Color(255, 0, 0)
										elseif (pl:IsDev() && pl:IsDisguised()  != true) then
											glowType = Color(255, 0, 255)	
										elseif (pl:IsSuperAdmin() && pl:IsDisguised()  != true) then
											glowType = Color(128, 0, 128)
										elseif (pl:IsAdmin() && pl:IsDisguised()  != true) then
											glowType = Color(0, 204,0 )
										elseif (pl:IsModerator() && pl:IsDisguised()  != true) then
											glowType = Color(255, 128,0 )
										elseif (pl:IsPremium() && pl:IsDisguised()  != true) then
											glowType = Color(255,215,0)
										end
										net.WriteColor( glowType )
																	
									end
									
								net.Send( pl )

							end
						end
						
						// send chat to client with recipientfilter
						//umsg.Start(v[1], RF);
					end
					*/
				
					
					local toSend = "[" .. chatBox.ColorIDNames[v[2]] .. "] " .. Player:Nick() .. " [" .. Player:getRPName() .. " - " .. Player:SteamID() .. "]: " .. cText .. "\n";
					if (k != "a") then chatBox.AddChatLog(toSend); end
					
					PrintAdmin("[CHAT] " .. toSend)
				end
				
				break;
			end
		end
		
		return "";
	end)

	function chatBox.AddChatLog ( text )
		if (#chatBox.History != 0) then
			local num = #chatBox.History;
			for i = 0, (num - 1) do
				chatBox.History[(num - i) + 1] = chatBox.History[num - i];
			end
		end
							
		if (chatBox.History[101]) then chatBox.History[101] = nil; end
							
		chatBox.History[1] = "(" .. os.date("%H:%M:%S") .. ") " .. string.gsub(string.gsub(text, ">", "&#62;"), "<", "&#60;");
	end

// ochat = ooc
// fchat = fake chat
// chat = local chat

	chatBox.chatPatterns["local"] = {"allchat", 1, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Local end, 
							nil, 
							nil
						};

	chatBox.chatPatterns["ooc"] = {"allchat", 2, 
							function ( from, to ) return true end, 
							nil, 
							nil
						};
	chatBox.chatPatterns["/"] = chatBox.chatPatterns["ooc"];

	chatBox.chatPatterns["a"] = {"allchat", 13, 
							function ( from, to ) return to:IsModerator(); end, 
							function ( pl )
								if (!pl:IsModerator()) then
									pl:ChatPrint("You cannot use administrator chat.");
									return false;
								end
								
								return true;
							end, 
							nil,
						};

	chatBox.chatPatterns["advert"] = {"fakechat", 12, 
							nil, 
							function ( pl )
								if pl:getBank() >= 200 then
									pl:addBank(-200, true)
									pl:Notify("$200 has been withdrawn from your bank to cover advertisement costs");
									return true;
								else
									pl:Notify("You do not have enough money in your bank");
									return false;
								end;
							end,
							nil
						};

	chatBox.chatPatterns["stall"] = {"fakechat", 12, 
							nil, 
							function ( pl )
								local _foundStall = false;
								for k , v in pairs(ents.FindByClass('cashregister') ) do
									if v:getFlag("ownedBy","") == pl:SteamID() then
										_foundStall = true;
									end
								end
								if _foundStall == true then return pl:Notify("You already own a stall!") end
								if pl.Stall then return pl:Notify("You already own a stall!") end
								local _Stall = ents.Create("cashregister")
								_Stall:SetPos(pl:GetPos())
								_Stall:SetAngles(pl:GetAngles())
								_Stall:setFlag("ownedBy", pl:SteamID())
								_Stall:Spawn()
								_Stall:GetPhysicsObject():Sleep()
								_Stall:GetPhysicsObject():EnableMotion(false)
								timer.Simple(1,function()
									pl.Stall = _Stall;
									_Stall:SetStallManager( pl )
								end)
							end,
							function ( tx ) return "" end;
						};
	chatBox.chatPatterns["spawn"] = {"fakechat", 12, 
							nil, 
							function ( pl )
								if !pl:Alive() then
									pl:Spawn();
								end
							end,
							function ( tx ) return "" end;
						};

	chatBox.chatPatterns["looc"] = {"allchat", 3, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Local end, 
							nil, 
							nil
						};
	chatBox.chatPatterns["//"] = chatBox.chatPatterns["looc"];

	chatBox.chatPatterns["w"] = {"localchat", 4, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Whisper end, 
							nil, 
							nil
						};

	chatBox.chatPatterns["y"] = {"localchat", 5, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Yell end, 
							nil, 
							nil
						};

	chatBox.chatPatterns["me"] = {"fakechat", 7, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Local end, 
							nil, 
							function ( Player, text ) return "** " .. Player:getFirstName() .. " " .. text; end
						};
	chatBox.chatPatterns['action'] = chatBox.chatPatterns['me'];

	chatBox.chatPatterns["event"] = {"fakechat", 16, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Local end, 
							nil, 
							function ( Player, text ) return "** " .. text; end
						};
						
	chatBox.chatPatterns['it'] = chatBox.chatPatterns['event'];

	chatBox.chatPatterns["roll"] = {"fakechat", 17, 
							function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= chatBox.Radius.Local  end, 
							nil, 
							function ( Player ) return "** " .. Player:getFirstName() .. " rolls: " .. math.random(1,100); end
						};

	chatBox.chatPatterns["broadcast"] = {"fakechat", 8, 
							function ( from, to ) return true end, 
							function ( pl )
								if (pl:Team() != TEAM_MAYOR) then
									pl:ChatMessage("You are not authorized to use the public broadcasting system.");
									return false;
								end
								
								return true;
							end,
							function ( Player, txt ) return "(BROADCAST) " .. txt; end
						};
						
	chatBox.chatPatterns["addtag"] = {"fakechat", 8, 
							function ( from, to ) return false end, 
							function ( pl )
								if (!pl:IsDev()) then
									pl:ChatMessage("You are not authorized to add or remove tags.");
									return false;
								end
								
								return true;
							end,
							function ( ply, txt ) 

							local _Sentence = string.Explode( " " , string.lower( txt ) );
							local IsPrivate = false;

							if _Sentence[1] && _Sentence[2] then

								local _p = RetrievePlayerByName( _Sentence[1])

								if _p && _p:IsPlayer() then
									
									_p:AddTag( _Sentence[2] )
									
									ply:ChatPrint( "Added the tag of " .. _Sentence[2] .. " to " .. _p:Nick() )
									_p:ChatPrint( ply:Nick() .. " has added the following tag to your account: " .. _Sentence[2] )
								end


								return "";
							
							end


								return "" end
						}; 
					
		
	chatBox.chatPatterns["remtag"] = {"fakechat", 8, 
							function ( from, to ) return false end, 
							function ( pl )
								if (!pl:IsDev()) then
									pl:ChatMessage("You are not authorized to add or remove tags.");
									return false;
								end
								
								return true;
							end,
							function ( ply, txt ) 
							
							local _Sentence = string.Explode( " " , string.lower( txt ) );
							local IsPrivate = false;

							if ( _Sentence[1] && _Sentence[2] ) then
								
								local _p = RetrievePlayerByName( _Sentence[1])

								if _p && _p:IsPlayer() then

									_p:RemoveTag( _Sentence[2] )

									ply:ChatPrint( "Removed the tag of " .. _Sentence[2] .. " to " .. _p:Nick() )
									_p:ChatPrint( ply:Nick() .. " has removed the following tag to your account: " .. _Sentence[2] )

								end
								
								return "";
							end

							return "" end
						};


	chatBox.chatPatterns["911"] = {"localchat", 8, 
							function ( from, to ) return (to:IsGovernmentOfficial() && to:Team() != TEAM_MAYOR) || from == to end, 
							function ( pl )
								if (pl:IsGovernmentOfficial()) then
									pl:ChatMessage("Please use /radio to communicate with your fellow government employees.");
									return false;
								end
								
								return true;
							end,
							function ( Player, txt ) return "[911] " .. txt; end
						};
	chatBox.chatPatterns["999"] = chatBox.chatPatterns["911"];
	chatBox.chatPatterns["112"] = chatBox.chatPatterns["911"];

	chatBox.chatPatterns["org"] = {"fakechat", 10, 
						function ( from, to ) return (from:getFlag("organization", 0) == to:getFlag("organization", 0) && to:GetTotalAmountInv()[95]) && true || false end, 
						function ( pl )
							if (pl:getFlag("organization", 0) == 0) then
								pl:ChatMessage("You must be in an organization to use this command.");
								return false;
							elseif (!pl:GetTotalAmountInv()[95]) then
								pl:ChatMessage("You must have a phone to use this command.");
								return false;
							end
							
							return true;
						end,
						function( _p , tx )
							local _orgID = _p:getFlag("organization", nil);
							if fsrp.orgs[_orgID] then
								
								_txAdd = fsrp.orgs[_orgID][4] == _p:SteamID() && "LEADER" || "MEMBER"

							end
							return "[ORG-" .. _txAdd .. "][" .. _p:getRPName() .. "]: " .. tx; 
						end ,
					};
					
	chatBox.chatPatterns["radio"] = {"localchat", 9, 
							function ( from, to ) return to:IsGovernmentOfficial() end, 
							function ( pl )
								if (!pl:IsGovernmentOfficial()) then
									pl:ChatMessage("You are not authorized to use the government radio.");
									return false;
								end
								
								return true;
							end,
							nil
							
						};
						
	chatBox.chatPatterns["pm"] = {"localchat", 6, 
							function ( from, to, txt )
								if (from == to) then return true; end
								local _SubMsgFromCommand = string.gsub(txt, "/pm", "");
								local _PlayerFromCommand = string.Trim( _SubMsgFromCommand );
								
								local exp = string.Explode(" ", _PlayerFromCommand);
								
								if #exp <= 1 then return end
								
								if (!exp[2]) then return false; end
								
								local lookingFor = string.lower(exp[1]);
								
								return string.find(string.lower(to:getRPName()), lookingFor);
								
							end, 
							function ( pl, txt )
								if (!pl:GetTotalAmountInv()[95] ) then
									pl:Notify("You must have a phone to use this command.");
									return false;
								end
								
								local foundChar = 0;
								local _SubMsgFromCommand = string.gsub(txt, "/pm", "");
								local _PlayerFromCommand = string.Explode(" ", string.Trim( _SubMsgFromCommand ))[1];
								
								if #_PlayerFromCommand <= 0 then return end
								
								local lookingFor = string.lower( _PlayerFromCommand );

								for k, v in pairs(player.GetAll()) do
									if (string.Left(lookingFor, 1) != "[" && v != pl && string.find(string.lower(v:getRPName()), lookingFor)) then
										foundChar = foundChar + 1;
										
										if (foundChar > 1) then break; end
									end
								end
								
								if (foundChar == 0) then
									pl:PrintMessage(HUD_PRINTTALK, "No player found with '" .. lookingFor .. "' in their name.");
									return false;
								elseif (foundChar > 1) then
									pl:PrintMessage(HUD_PRINTTALK, "Multiple players found with '" .. lookingFor .. "' in their name.");
									return false;
								end
								
								return true;
							end,
							function ( pl, txt )
								local w = string.Explode(" ", txt);
								local lookingFor = string.lower(w[1]);
								w[1] = "";
								
								for k, v in pairs(player.GetAll()) do
									if (string.find(string.lower(v:getRPName()), lookingFor)) then
										foundChar = v;
										
										break;
									end
								end
								
								return "To " .. foundChar:getRPName() .. ": " .. string.Implode(" ", w);
							end
							
						};

								
								
	chatBox.chatPatterns["report"] = {"fakechat", 15,
							function ( from, to ) return ( to:IsModerator() ) end, 
							function ( pl )
								AssignTicketNumber = math.random( 1000, 9999 );
								pl:ChatMessage("Your report has been sent. The ticket assigned to you was #" .. AssignTicketNumber);
								return true;
							end,
							function ( Player, txt ) return "Report (#" .. AssignTicketNumber .. ") [Roleplay: " .. Player:getRPName() .. "][Steam: " .. Player:Name() .. "][" .. Player:SteamID() .. "][Report: " .. txt .. "]" end

						};
// bank account data
				
function _pMeta:setBankAccount( int )
	if !IsValid(self) then return end
	
	self:setFlag("bankaccountlevel", int  );
	
	if SERVER then
		
		fsdb:Query( "UPDATE `fsdb_user` SET `bank_level`=" .. int .. " WHERE `id`='" .. self:SteamID() .. "';" );

	end	
	
end

// business meta

hook.Add("PlayerConnect", "ConnectAPI", function( name , ip )
	
	
	http.Fetch( "http://ip-api.com/json/" .. string.gsub( ip, ":27005", "" ) , function( tbl )

		local info = util.JSONToTable( tbl )
		
		for k , v in pairs( player.GetAll() ) do
			if !info.country then return end
			
			v:ChatMessage( name .. " has connected to the session from: " .. info.country ) 
		
		end
	
	end )
	
end)



function fsrp.business.functions.RetrievePlayerBusinessSQL( _p )
	local _ReturnTable = {};
	
	fsdb:Query("SELECT 'business' FROM `fsdb_characterdata` WHERE `id`='" .. _p:SteamID() .. "';", function ( _,data )
		
		if data && data[1] && data[1]["business"] && data[1]["business"] != "" then
			
			//PrintTable( data )
			
		end
		
	end)
end 


	//util.AddNetworkString( "sendToWork" )
/*
	net.Receive("sendToWork" , function( len , _p )

		local _BusinessID = net.ReadInt(8)

		if _p:getFlag( "businessCD_" .. _BusinessID , 0 ) < CurTime() then
		local _skew = CurTime() + ( fsrp.business.config.WorkTime+math.random(fsrp.business.config.WorkTimeSkew) );
		
		_p:getFlag( "businessCD_" .. _BusinessID , _skew )

		_p:getFlag( "businessWork_" .. _BusinessID , 1 + _p:getFlag( "businessWork_" .. _BusinessID , 0 ) )
		_p:Notify( "You have started work on business ID#" .. _skew .. " cur " .. CurTime()		);
		
		else
		
			_p:Notify("Currently working")
			
		end
		

	end )
*/

util.AddNetworkString( "business_ReplicateCache" )

function fsrp.business.functions.ReplicateCache( _p )

	if !IsValid( _p ) || !_p:IsPlayer() then return end

	net.Start( "business_ReplicateCache" )
		net.WriteString( util.TableToJSON( fsrp.business.cache )  )
	net.Send( _p )

end

function fsrp.business.functions.UpdatePlayerCache( )
	
	net.Start( "business_ReplicateCache" )
		net.WriteString( util.TableToJSON( fsrp.business.cache ) )
	
				if #player.GetAll() > 0 then
					net.Broadcast()
				end

end

function fsrp.business.functions.SavePlayerBusinessSQL( _p )
	
	local _playerBusinessTable = _p:getFlag( 'business_PlayerTable', {} );
	
	local _ReturnString = "";
	
	local _sep = "";
	
	for k , v in pairs( _playerBusinessTable ) do
	
		_ReturnString = _ReturnString .. _sep .. k .. "," .. v.SharesOwned;
			
		if _ReturnString != "" then
		
			_sep = ";";
		
		end
		 
	end
	
	if _ReturnString != "" then
	
		fsdb:Query("UPDATE `fsdb_characterdata` SET `business`='" .. _ReturnString .."' WHERE `id`='" .. _p:SteamID() .. "';");		

	end
	
end 
// door meta
util.AddNetworkString("updateClientPropertyOwner")
	function networkAllPropertyOwnersToClient()
		local _propsToNW = {};

		for k , v in pairs( fsrp.PropertyTable ) do
			
			if v.PrimaryOwner then
				_owner = v.PrimaryOwner;

				if v.PrimaryOwner[1] then
					table.insert( _propsToNW , v.ID );
				end
			end
		end

		for k , v in pairs( _propsToNW ) do 
			local _PropTB = fsrp.PropertyTable[v];

			local _ownerTbl = _PropTB.PrimaryOwner;

			net.Start("updateClientPropertyOwner")
				net.WriteInt( _PropTB.ID, 8 )
				
				if _ownerTbl then
					net.WriteBool( true )
					net.WriteTable( _ownerTbl )
				else
					net.WriteBool(false )
				end
				
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
		end

	end
	
	function updatePropertyOwner( _p ,id )
		
		if fsrp.PropertyTable[id] then
			
			local _ownerTbl = fsrp.PropertyTable[id].PrimaryOwner;
			
			net.Start("updateClientPropertyOwner")
				net.WriteInt( id, 8 )
				
				if _ownerTbl then
					net.WriteBool( true )
					net.WriteTable( _ownerTbl )
				else
					net.WriteBool(false )
				end
				
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
			
		end
		
	end
	
// song fetching

function FetchSong( _p, url )
	local _link = ( IsValid( url ) ) && url || "https://www.youtube.com/watch?v=8avMLHvLwRQ";
	
	http.Fetch(	"http://www.youtubeinmp3.com/fetch/?format=JSON&video=" .. _link , 
		function( body, len, header , code )
			
			net.Start("sendSong")
				net.WriteString(util.JSONToTable( body ).link)
			net.Send( _p )
		end,
		function( error )
			
			print(error)
			// railed
						
		end)
		
end
// inventory meta

	util.AddNetworkString("dropItemAtIndex")
	util.AddNetworkString("useItemAtIndex")
	
	net.Receive("useItemAtIndex", function( len, _p )
	
	
		local _in = net.ReadInt( 8)
		local _id = net.ReadInt( 32 )
		if _p:getFlag("cuffed", false) then return _p:Notify( "You may not use an item while arrested." ) end
		if !_p:Alive() then return _p:Notify("You can't use items while dead.") end
		local _Am = 0;
		for k , v in pairs( ents.GetAll() ) do

			if v:getFlag( "ownedBy" ,"" ) == _p:SteamID() then

				_Am = _Am +1;

			end

		end

		if tonumber(_p:getFlag( "rank", 10  ))  > 3 then
			if _Am >= _p:GetMaxEnts() then return _p:Notify("You have reached the entity limit! (".. _p:GetMaxEnts()..")") end;
		end
		_p:UseItemFromInventory( _id ,_in  );
		
	end )
 

net.Receive("dropItemAtIndex", function( len ,_p )
	local _ind = net.ReadInt( 8 );
	local _id = net.ReadInt( 32 )
	//if _p:getFlag("propsOut", 0 ) >= 50 then return end
	if !_p:Alive() then return _p:Notify("You can't drop items while dead.") end

	
	timer.Simple(.1,function() 
		local _Am = 0;
		for k , v in pairs( ents.GetAll() ) do

			if v:getFlag( "ownedBy" ,"" ) == _p:SteamID() then

				_Am = _Am +1;

			end

		end


		if tonumber(_p:getFlag( "rank", 10  ))  > 3 then
			if _Am >= _p:GetMaxEnts() then return _p:Notify("You have reached the entity limit! (".. _p:GetMaxEnts()..")") end;
		end
				//print(_Am)
		//_p:Notify( _ind .. " id " .. _id )
		_p:DropItemFromInventory( _id, _ind)
		//_p:setFlag("propsOut", (_p:getFlag("propsOut", 0 )+1) )
	end)
end) 
util.AddNetworkString("swapinventoryitem")
net.Receive("swapinventoryitem",function(_l,_p)

	local _targetslot = net.ReadInt(8)
	local _fromslot = net.ReadInt(8)

	local _inv = LoadStringToInventory(_p:getFlag( "inventory", LoadStringToInventory("") ))	
	if !_inv[_fromslot].Amount then return _p:Notify("Couldn't find items to swap.") end

	// Actual swap
	local _targetSlotContent = _inv[_targetslot];
	local _fromSlotContent = _inv[_fromslot];
	_inv[_targetslot] = _fromSlotContent;

	if _inv[_fromslot] == nil then
		_inv[_fromslot] = {};
	end
	_inv[_fromslot] = _targetSlotContent;

	_p:setFlag("inventory", CompileInventoryToString(_inv) )
	net.Start( "inventorySync" )		
		net.WriteTable( _inv )
	net.Send( _p )
	fsdb_saveClient( _p );
	local _n = ""
	if _inv[_fromslot] and _inv[_fromslot].ID and ITEMLIST[_inv[_fromslot].ID] then
		_n = ITEMLIST[_inv[_fromslot].ID].Name;
	end
	_p:Notify("Swapped slot #".._fromslot.." containing " ..  _n.. " to slot #" .. _targetslot ..".")

end)

function _pMeta:UseItemFromInventory( id , index )
	
	local _inv = LoadStringToInventory(self:getFlag( "inventory", LoadStringToInventory("") ))	

	local indexFound = index;
	
	if !_inv[index] then 
	
	
		self:setFlag("inventory", CompileInventoryToString(_inv) )
		net.Start( "inventorySync" )
			
			net.WriteTable( _inv )
		net.Send( self )
		
		return self:Notify("Inventory Slot does not contain an item") 
		
	end
	/*
	if _inv[index].ID != id then 
	
	
		self:setFlag("inventory", CompileInventoryToString(_inv) )
		net.Start( "inventorySync" )
			
			net.WriteTable( _inv )
		net.Send( self )
			
		return self:Notify("Inventory slot has a different id than client, aborting.") 
		
	end
	*/
	if (_inv[index].Amount <= 0) then

		_inv[index] = nil
	
		return self:Notify("Did not find the item")
		
	end
	
	local _item = ITEMLIST[_inv[index].ID];
	
	if _item.CanUse then 
	
		if !_item.CanUse( self ) then
				
			return 	self:Notify( "This item may not be dropped or you have reached its spawn limit." )
			
		end
		
	end
	local _p = self;
	
	
	
	
		local trace = {};
			trace.start = self:GetShootPos();
			trace.endpos = self:GetShootPos() + self:GetAimVector() * 50;
			trace.filter = self;
		local tRes = util.TraceLine(trace);
		
	if !_item.Class then
					
		if _item.Category == "Craftable" then
			//self:EmitSound("items/ammocrate_close.wav")
					
			local craftAble = ents.Create("fsrp_craftable");
			craftAble:SetModel(_item.Model);
			craftAble.Owner = self;
			craftAble:SetPos(tRes.HitPos );
			craftAble:Spawn()
			craftAble:SetupID( id, self:SteamID() )
			craftAble:setFlag("ownedBy", _p:SteamID() )
			

				if _item.Skin then
					craftAble:SetSkin(_item.Skin);
				end
			craftAble:setFlag("itemID", id)
			craftAble:setFlag("savedInvEntity", true)
			if _item.Scale then
				craftAble:SetModelScale(_item.Scale)
				craftAble:Activate()
			end
		elseif _item.Category == "Furniture" then
			//self:EmitSound("items/ammocrate_close.wav")
		
			local itemDrop = ents.Create("fsrp_propitem");
			itemDrop:SetModel(_item.Model);
			itemDrop.Owner = self;
			itemDrop:SetupID( id, self:SteamID() )
			itemDrop:SetPos(tRes.HitPos );
			itemDrop:Spawn()
			itemDrop:setFlag("ownedBy", _p:SteamID() )
		

				if _item.Skin then
					itemDrop:SetSkin(_item.Skin);
				end
			itemDrop:setFlag("itemID", id)
			itemDrop:setFlag("savedInvEntity", true)
			if _item.Scale then
				itemDrop:SetModelScale(_item.Scale)
				itemDrop:Activate()
			end
		elseif _item.Category == "Weapon" then
			if _item.Attatchment then
				
				self:EmitSound("items/ammocrate_close.wav")
			
			end
			
			local _pronoun = "her";
			if _p:getGender() != 1 then
			
				_pronoun = "his";
				
			end
				
			_p:ConCommand( "say /me has equiped " .. _pronoun .. " " .. _item.Name );
						
									
			if _item.WeaponClass then
			
				
				if !_item.SlotType then 
				
					self:EmitSound( "items/ammo_pickup.wav" )
					self:Give( _item.WeaponClass )
				
				else
				
					local _weaponSlot = self:getFlag( "itemSlot_" .. _item.SlotType , nil );
				
					if !_weaponSlot then
					
						self:EmitSound( "items/ammo_pickup.wav" )
						self:setFlag( "itemSlot_" .. _item.SlotType, _item.ID )
						
						self:Give( _item.WeaponClass )
						self:SelectWeapon( _item.WeaponClass )
						
						fsdb_saveClient( self )
					else
					
						return self:Notify( "You already have something equiped in this slot!" )
					
					end
				
				end
				
			end
		
		
		elseif _item.Category == "Hat" then
			
			local _pronoun = "her";
			if _p:getGender() != 1 then
			
				_pronoun = "his";
				
			end
				
			_p:ConCommand( "say /me has equiped " .. _pronoun .. " " .. _item.Name );
						
									
			if _item.Hat then
			
				local _slot = self:getFlag( "itemSlot_3" , nil );
				
				if !_slot then
					
					//self:EmitSound( "items/ammo_pickup.wav" )
					self:setFlag( "itemSlot_3" , _item.ID )
						
					self:EquipHat( _item.ID )
						
					fsdb_saveClient( self )
				else
					
					return self:Notify( "You already have something equiped in this slot!" )
					
				end
				
			end
				
		end
	
	else
			self:EmitSound("items/ammocrate_close.wav")
			//print(_item.Class)
			local entityItem = ents.Create( _item.Class );
			entityItem.Owner = self;
			entityItem:SetPos(tRes.HitPos );
			entityItem:Spawn()
			//function entityItem:SetupID( id, self:SteamID() )
			//entityItem:SetupID(id,self:SteamID() )
			entityItem.ID = id;
			entityItem:setFlag("ownedBy", self:SteamID() );
			entityItem:setFlag("itemID", id)
			if _item.Scale then
				entityItem:SetModelScale(_item.Scale)
				entityItem:Activate()
			end

			if _item.Skin then
				entityItem:SetSkin(_item.Skin);
			end
			entityItem:setFlag("savedInvEntity", true)
			if _item.EntityOnUse then
			
				_item.EntityOnUse( self, entityItem )
				
			
			end
	
			fsdb_saveClient( self )
	end
	
	if _inv[indexFound].Amount && _inv[indexFound].Amount - 1 != 0 then
	
		_inv[indexFound].Amount = _inv[indexFound].Amount - 1;
		
	else
	
		_inv[indexFound] = nil;
	
	end
		self:setFlag("inventory", CompileInventoryToString(_inv) )
		net.Start( "inventorySync" )
			
			net.WriteTable( _inv )
		net.Send( self )
			
		fsdb_saveClient( self );


	if _item.OnUsed then
	
		_item.OnUsed( self, item )

	end
	timer.Simple(1,function() if self && IsValid(self) then
		self:UpdateClientInventoryVGUI();
	end end )
end
	
function _pMeta:DropItemFromInventory( id , index )
	
	
	local _inv = LoadStringToInventory(self:getFlag( "inventory", LoadStringToInventory("") ))	
	//self:EmitSound("items/ammocrate_close.wav")
	local indexFound = index;
	
	if !_inv[indexFound] then  
		self:Notify("Inventory Slot does not contain an item")
		net.Start( "inventorySync" )
			
			net.WriteTable( _inv )
		net.Send( self )
		return
	end
	
	if _inv[indexFound]  && !_inv[indexFound].ID || _inv[indexFound].Amount == 0 then
	
		_inv[indexFound] = nil;
		
		net.Start( "inventorySync" )
			
			net.WriteTable( _inv )
		net.Send( self )
		return
	end
	
	local _item = ITEMLIST[_inv[index].ID];
	
	if _inv[indexFound].Amount && _inv[indexFound].Amount - 1 != 0 then
	
		_inv[indexFound].Amount = _inv[indexFound].Amount - 1;
		
	else
	
		_inv[indexFound] = nil;
	
	end
	
	local _shouldDrop = true;
	
	if _item.OnDropped then
	
		_shouldDrop = _item.OnDropped( self )
	
	end
	
	if !_shouldDrop then return self:Notify( "You may not drop this item" ) end
	
	
		local itemTable = ITEMLIST[id].Model;

		
		local trace = {};
			trace.start = self:GetShootPos();
			trace.endpos = self:GetShootPos() + self:GetAimVector() * 50;
			trace.filter = self;
		local tRes = util.TraceLine(trace);
				
		local itemDrop = ents.Create("fsrp_item");
			//itemDrop.ID = id;
			itemDrop:SetPos(tRes.HitPos+Vector(0,0,20) );
		itemDrop:Spawn()
			itemDrop:setFlag("ownedBy", self:SteamID() )
			itemDrop:setFlag("itemID", id )
			itemDrop.ID = id;
			itemDrop:SetModel(_item.Model)
			if ITEMLIST[id].Scale then
				itemDrop:SetModelScale(ITEMLIST[id].Scale)
			end

			if ITEMLIST[id].Skin then
				itemDrop:SetSkin(ITEMLIST[id].Skin);
			end
			itemDrop:PhysicsInit( SOLID_VPHYSICS )
			itemDrop:GetPhysicsObject( ):Wake()

			
		self:setFlag("inventory", CompileInventoryToString(_inv) )
	
		net.Start( "inventorySync" )
			
			net.WriteTable( _inv )
		net.Send( self )
		fsdb_saveClient( self );
end 

// mayor meta
function fsrp.config.MayorVoting:AddCandidate( _steamID ) 
	
	table.insert(fsrp.config.MayorVoting.CandidateCache, { votes = 0, id = _steamID })
	
end 

function fsrp.config.MayorVoting:VoteForCandidate( _steamID )

	local _candidates = fsrp.config.MayorVoting.CandidateCache;
	
	if !_candidates[_steamID] then return ErrorNoHalt( "Received the wrong steam ID, cannot find candidate") end
	
	_candidates[_steamID].votes = _candidates[_steamID].votes + 1;

	fsrp.config.MayorVoting.CandidateCache  = _candidates;
	
end

function fsrp.config.MayorVoting:FindMayorFromCandidates( )

	local _candidates = fsrp.config.MayorVoting.CandidateCache;

	local num = 0;
	local numind = 1;

	for k , v in pairs( _candidates ) do
	
		if v.votes  >= num then
			numind = k;
		end
	
	end
	
	return _candidates[numind].id || nil;

end  

function fsrp.config.MayorVoting:GetCandidates()

	return fsrp.config.MayorVoting.CandidateCache;
	
end

/*

fsrp.config.MayorVoting = {};

*/
local _pMeta = FindMetaTable( 'Player' )
util.AddNetworkString("makeVote");

util.AddNetworkString("castElectionoVote");

net.Receive("makeVote", function(_l,_p)

	_p:VoteFor(net.ReadString());

end)

function _pMeta:VoteFor(steamID)
	if !player.GetBySteamID(steamID) then return self:Notify("Couldn't find that player.") end;
	if !fsrp.config.MayorVoting.Election then return end
	if self:getFlag("votedFor", true) then return self:Notify("You already voted in this election.") end;	
	local _candidates = fsrp.config.MayorVoting.CandidateCache;

	fsrp.config.MayorVoting:VoteForCandidate( steamID )
end

function StartElection( )
	
	if #fsrp.config.MayorVoting.CandidateCache < 2 then return end
	
	net.Start( "castElectionoVote" )
		net.WriteTable( fsrp.config.MayorVoting.CandidateCache )
	net.Broadcast( )
	
	fsrp.config.MayorVoting.Election 			= CurTime() + 30
	fsrp.config.MayorVoting.TotalVotesCounted 	= 0
	fsrp.config.MayorVoting.VotesNeeded 		= table.Count(player.GetAll())
	
	timer.Create("MonitorElection", 1, 0, function() fsrp.config.MayorVoting.MonitorElection() end)
end 

function fsrp.config.MayorVoting.MonitorElection()

	if !fsrp.config.MayorVoting.Election || #fsrp.config.MayorVoting.CandidateCache <= 0 then
	
		timer.Remove( "MonitorElection" )
		
		return
	
	end

	if (fsrp.config.MayorVoting.TotalVotesCounted < fsrp.config.MayorVoting.VotesNeeded && fsrp.config.MayorVoting.Election > CurTime()) then return end
	
	fsrp.config.MayorVoting.Election 			= nil
	fsrp.config.MayorVoting.TotalVotesCounted	= nil
	fsrp.config.MayorVoting.VotesNeeded 		= nil
	
	local _candidate = player.GetBySteamID( fsrp.config.MayorVoting:FindMayorFromCandidates( ) )
	
	if _candidate then
	
		_candidate:RemoveFromSlot( 1 ,false )
		_candidate:RemoveFromSlot( 2 ,false )

		_candidate:EnterJob( TEAM_MAYOR );
		_candidate:Notify( "You have been made a mayor from your achievements!" )
	
	end
		
	for k , v in pairs( player.GetAll() ) do
	
		if v!=_candidate then
		
			v:Notify( _candidate:getRPName() .. " has been elected Mayor." );

		end
		 
		v:setFlag("votedFor", nil);
		v:setFlag("MayoralCandidate", nil);
	end

	fsrp.config.MayorVoting.CandidateCache ={};

end

function _pMeta:SignUpForMayor( )
	
	if self:Team() != TEAM_CIVILLIAN then return self:Notify( "You may not sign up for mayor while taking up a job slot." ) end
	
	if fsrp.config.MayorVoting.Election then return end
	
	//if fsrp.config.MayorVoting.CandidateCache[self:SteamID()] then return self:Notify("You are a candidate.") end;
	for k , v in pairs( fsrp.config.MayorVoting.CandidateCache ) do
			if v.id == self:SteamID() then 

			fsrp.config.MayorVoting.CandidateCache[k] = nil;
			//table.remove(k)
			self:Notify("You have withdrawn your mayoral sign-up")
			
			return

		end
	end
	fsrp.config.MayorVoting:AddCandidate( self:SteamID() ) 
	self:setFlag("MayoralCandidate", true);
	//print(#fsrp.config.MayorVoting.CandidateCache )
	if #fsrp.config.MayorVoting.CandidateCache >= math.Clamp(math.Round(table.Count(player.GetAll()) / 3), 2, 5) then
	
		StartElection()
	
	end
	
end 

net.Receive( "bankATMExchange" , function( _l , _p )

	local _exchange = net.ReadInt( 32 )
	//if !_p:IsDev() then return _p:Notify("Because Fried Rice sucks at coding he has no idea how to let you do this, proceed to the bank instead!"); end
	//print(_p:getBankAccount())
	if !_p:getBankAccount() then return _p:Notify("You can't deposit money to a nonexistant bank account! Go to the bank!") end
	local _interestMult = fsrp.config.atmfeesurcharge

				
	local _deposit = false;
	if _exchange < 0 then
		_exchange = _exchange * -1;
		_deposit = true;
	end 
	local _Index = _deposit == true && 1 || 2;

	local _toPay = _exchange;
	local _toRec = _exchange 

	if _deposit == false then
		_toRec = _exchange - (_exchange* _interestMult[_p:getBankAccount()][2])	
	end
	
	if !_deposit then
		_p:addBank( -_toPay )
		_p:addMoney( _toRec )
	else
		_p:addBank( _toRec )
		_p:addMoney(  -_toPay ) 

	end
	
	
	local _text = _deposit == true  && " to the bank." || " to your wallet.";
		
	_p:Notify( "Sucessfully " .. (_deposit == true && "deposited" || "withdrawn").." $" .. _toPay .. _text .. (_deposit == false &&" (".. (( _interestMult[_p:getBankAccount()][_Index])*100).."% Fee Surcharge, $" ..  (_exchange* _interestMult[_p:getBankAccount()][_Index])	 .. ")"||"") );
	
end )
// job meta
hook.Add("VC_spikeStripPlaced", "SpikeStripPoliceRemoval", function(_e,_p)

	_e:setFlag("ownedBy", _p:SteamID());
	_p:setFlag("deployedStrip", true )

end)

hook.Add("VC_canToggleSpikestrip", "SpikeStripPoliceRemoval", function(_p, _e) 

	return _p:IsAdmin() && true || _p == TEAM_POLICE || false;

end)

hook.Add("VC_canPlaceSpikestrip", "SpikeStripPoliceRemoval", function(_p, _e) 

	return _p:IsAdmin() && true || _p == TEAM_POLICE && _p:getFlag("deployedStrip", false) != true || false;

end)


hook.Add("VC_canPickupSpikestrip", "SpikeStripPoliceRemoval", function(_p, _e) 

	return _p:IsAdmin() && true || _p == TEAM_POLICE && _p:getFlag("deployedStrip", false) == true || false;

end)

hook.Add("VC_spikeStripRetracted", "SpikeStripPoliceRemoval", function(_e)

	if _e:getFlag("ownedBy","") != "" then
		local _p = player.GetBySteamID(_e:getFlag("ownedBy",""));

		if _p then
			
			_p:setFlag("deployedStrip", false);

		end
		
	end
end)

function _pMeta:LeaveJob(nowep)
	if self:Team() == TEAM_CIVILLIAN then return end
	
	if self:Team() == TEAM_POLICE then
		local consideringSpikes = {
			"vc_spikestrip_pointyend_extended",
			"vc_spikestrip_pointyend",
			"vc_spikestrip",
		}

		for k , v in pairs( ents.GetAll() ) do
			if table.HasValue( consideringSpikes,v:GetClass() ) then
				if v:getFlag("ownedBy", "") == self:SteamID() then
					v:Remove();
				end
			end
		end
	end
	self:StripWeapons()
	self:StripAmmo()
	if !nowep then
		self:RestorePreJobWeapons();
	end
	
	local _p = self;
	
	local _civillian_model		= _p:getFlag( "playerinfo_model", "Vindictus-Vella" )
	local _civillian_bdg		= _p:getFlag( "playerinfo_bodygroups", "" )
	local _civillian_skin		= _p:getFlag( "playerinfo_skin", 0 )
	local _isparam = self:Team() == TEAM_PARAMEDIC;
	self:SetTeam( TEAM_CIVILLIAN )
	local _params = team.NumPlayers(TEAM_PARAMEDIC);
	for k, v in pairs(player.GetAll()) do

		if _params == 0 and _isparam then
			v:Notify("Because there are no more paramedics, spawn delays have been disabled.")
		end

	end
	if SERVER then
	
		self:SendCarToGarage( true, true )
		
	end
	//print( _m[4] )
	self:SetModel( player_manager.TranslatePlayerModel(_civillian_model ) )
		
	
			local groups = _civillian_bdg
			if ( groups == nil ) then groups = "" end
			local groups = string.Explode( " ", groups )
			for k = 0, self:GetNumBodyGroups() - 1 do
				self:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
			end
			
			timer.Simple( 0.2, function()
				local hands = self:GetHands()
				if ( IsValid( hands ) ) then 
					-- Which hands should we use?
					local info = player_manager.TranslatePlayerHands( mdl )
					if ( info ) then
						hands:SetModel( info.model )
						hands:SetSkin( _civillian_skin )
						hands:SetBodyGroups( info.body )
					end
					-- Attach them to the viewmodel
					local vm = self:GetViewModel( 0 )
					hands:AttachToViewmodel( vm )
					vm:DeleteOnRemove( hands )
					self:DeleteOnRemove( hands )
				end
			end )
			
	
	
		self:SetSkin( _civillian_skin )
	
	
	
	
	self:EmitSound("items/ammo_pickup.wav")
	self:Notify("You have left your workplace, your work items have been stripped from you.")
	
	
	net.Start("UpdateHUD")
	net.Send( self )
	
end

function _pMeta:DefaultLoadout()
	
	self:EquipUserGroupWeapons()
	
	self:Give("keys")
	self:Give("weapon_physgun")

end


function _pMeta:RemovePreJobWeapons()
		if !IsValid( self ) then return end
		
		local info = {}
		local ammo = {}
		local weapon = self:GetActiveWeapon()

		self:setFlag("cachedPreJobWeapons", table.Merge({weapons = info, ammo = ammo, lastWep = IsValid(weapon) and weapon:GetClass()}, self:getFlag("cachedPreJobWeapons" , {} ) || {} ) )

		for k, v in ipairs(self:GetWeapons()) do
            
			info[v:GetClass()] = v:Clip1()

			local ammoType = v:GetPrimaryAmmoType()

			if (!ammo[ammoType]) then
				ammo[ammoType] = self:GetAmmoCount(ammoType)
			end

            self:StripWeapon(v:GetClass())
			
		end
		
		
end

function _pMeta:RestorePreJobWeapons()
		self:StripAmmo()
		local _oldWeps = self:getFlag("cachedPreJobWeapons" , {} );
		//PrintTable( _oldWeps )
		if !_oldWeps || !_oldWeps.weapons then
			self:DefaultLoadout()
		end

		for class, clip in pairs(_oldWeps.weapons) do
			local weapon = self:Give(class)

			if (IsValid(weapon)) then
				weapon:SetClip1(clip)
			end
		end

		for class, amount in pairs(_oldWeps.ammo) do
			self:SetAmmo(amount, class)
		end

		if (_oldWeps.lastWep) then
			self:SelectWeapon(_oldWeps.lastWep)
		end

		self:setFlag("cachedPreJobWeapons", {} )
		
end

function _pMeta:EnterJob( _j )
	
	if SERVER then
		if self:GetStars() >1 then return self:Notify("You may not get a job while wanted by the police!") end
		
			local consideringSpikes = {
				"vc_spikestrip_pointyend_extended",
				"vc_spikestrip_pointyend",
				"vc_spikestrip",
			}

			for k , v in pairs( ents.GetAll() ) do
				if table.HasValue( consideringSpikes,v:GetClass() ) then
					if v:getFlag("ownedBy", "") == self:SteamID() then
						v:Remove();
					end
				end
			end
		self:SendCarToGarage( true, true )
		self:LoadJobTimes()
	
		local timePlayed = 0;
		local _indexAtTime = 1;
		
			
		local timePlayed = self:GetJobTimePlayed(_j);
			
		if !timePlayed then return ErrorNoHalt( timePlayed ) end
		
		for k , v in pairs( fsrp.JobRanks[_j] ) do
				
			if v.time > timePlayed then
					
				break
									
			end
				
			_indexAtTime = v.Rank || 1;
				
				
				
		end
			
		
			
			
			
		self:Notify( "Rank: " .. fsrp.JobRanks[_j][_indexAtTime].name);
		
	end
	
	
	if jobInfoTable[_j].PreReqQuests then
	
		local _b , v = self:FinishedQuestLine(jobInfoTable[_j].PreReqQuests)
		
		if !_b then
			
			return self:Notify("You must complete prerequisite quests before joining this job")
		
		end
		
	end
	
	if !self:Team() == TEAM_CIVILLIAN then self:Notify( "You must first leave your current workplace to work at this job." ) end
	
	if _j != TEAM_MAYOR && IsJobFull( _j ) then return self:Notify("This job is full, you may not enter it until there are more players or someone leaves it." ) end
	
	local _p = self;
	
	local _row = jobInfoTable[_j]
	
	
	if !self:IsDonator() then
		if self:GetTimePlayed() < _row.TimeReq then
		return self:Notify( "You need to play for " .. _row.TimeReq .." minutes to get this job." )
			
		end
	end
	local _Default = ( _j == TEAM_POLICE ) &&  "Police_4" || ( _j == TEAM_PARAMEDIC ) && "hospitalfemale_1" || "";
	local _Name = ( _j == TEAM_POLICE ) &&  "police" || ( _j == TEAM_PARAMEDIC ) && "paramedic" || ( _j == TEAM_MAYOR ) && "mayor" || "";
	
	local _model				= _p:getFlag( "playerinfo_job_" .. _Name .. "_model", _Default )
	local _bdg					= _p:getFlag( "playerinfo_job_" .. _Name .. "_bodygroups", "" )
	local _skin					= _p:getFlag( "playerinfo_job_" .. _Name .. "_skin", 0 )
	self:RemovePreJobWeapons()
	self:DefaultLoadout();

	if _j == TEAM_MAYOR then
		self:setFlag("MayorPaydays",8);
	end
	
	self:SetTeam( _j )

	local _params = team.NumPlayers(TEAM_PARAMEDIC);
	for k, v in pairs(player.GetAll()) do

		if _params == 1 and _j == TEAM_PARAMEDIC then
			v:Notify("A Paramedic has joined the force. Respawn delays have now been enabled.")
		end

	end

	self:SetModel( player_manager.TranslatePlayerModel( _model ) )
	
			local groups = _bdg
			if ( groups == nil ) then groups = "" end
			local groups = string.Explode( " ", groups )
			for k = 0, self:GetNumBodyGroups() - 1 do
				self:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
			end
			
			timer.Simple( 0.2, function()
				local hands = self:GetHands()
				if ( IsValid( hands ) ) then 
					-- Which hands should we use?
					local info = player_manager.TranslatePlayerHands( mdl )
					if ( info ) then
						hands:SetModel( info.model )
						hands:SetSkin( _skin )
						hands:SetBodyGroups( info.body )
					end
					-- Attach them to the viewmodel
					local vm = self:GetViewModel( 0 )
					hands:AttachToViewmodel( vm )
					vm:DeleteOnRemove( hands )
					self:DeleteOnRemove( hands )
				end
			end )
			
			
	self:SetSkin( _skin ) 
	if _row.Equipment then
	
		for k, v in pairs( _row.Equipment ) do
		
			self:Give( v )
			
		end
		
	end
	
	self:EmitSound("items/ammo_pickup.wav")
	
	
	net.Start("UpdateHUD")
	net.Send( self )
	self:StripAmmo()

	self:Notify( _row.JoinNotification )

end	
function _pMeta:GetJobTimeInfo(_j)
	
	if (!self:getFlag( "jobPlaytimes", {} )[_j]) then return nil end

	return  self:getFlag( "jobPlaytimes", {} )[_j];

end
function _pMeta:GetJobTimePlayed(_j)
	
	if (!self:getFlag( "jobPlaytimes", {} )[_j]) || !tonumber(self:getFlag( "jobPlaytimes", {} )[_j].Played) then return 0 end

	return  tonumber(self:getFlag( "jobPlaytimes", {} )[_j].Played);

end
function _pMeta:GetTimePlayed()

	return tonumber(self:getFlag("playTime", 0  ))
	
end

function _pMeta:SetTimePlayed( seconds )
	
	self:setFlag( "playTime", tonumber(seconds) )
		
end

function _pMeta:TimeSinceJoin()

	return RealTime() - self:getFlag( "joinTime" , 0 );
	
end

local ply = nil
 
local t = {start=nil,endpos=nil,mask=MASK_PLAYERSOLID,filter=nil}

local function PlayerNotStuck( ply )
 
    t.start = ply:GetPos()
	
    t.endpos = t.start
	
    t.filter = ply
     
    return util.TraceEntity(t,ply).StartSolid == false
     
end
 
local NewPos = nil

local function FindPassableSpace( direction, step )
 
    local i = 0
	
    while ( i < 100 ) do
	
        local origin = ply:GetPos()
 
        origin = origin + step * direction
         
        ply:SetPos( origin )
		
        if ( PlayerNotStuck( ply ) ) then
		
            NewPos = ply:GetPos()
			
            return true
			
        end
		
        i = i + 1
		
    end
	
    return false
end
 
local function UnstuckPlayer( pl )
	if(!pl or pl:InVehicle()) then return false end
    ply = pl
 
    NewPos = ply:GetPos()
    local OldPos = NewPos
     
    if ( !PlayerNotStuck( ply ) ) then
     
        local angle = ply:GetAngles()
         
        local forward = angle:Forward()
        local right = angle:Right()
        local up = angle:Up()
         
        local SearchScale = 1-- Increase and it will unstuck you from even harder places but with lost accuracy. Please, don't try higher values than 12
       
        if ( !FindPassableSpace(  forward, SearchScale ) ) then
		
            if ( !FindPassableSpace(  right, SearchScale ) ) then
			
                if ( !FindPassableSpace(  right, -SearchScale ) ) then
				
                    if ( !FindPassableSpace(  up, SearchScale ) ) then
					
                        if ( !FindPassableSpace(  up, -SearchScale ) )	then
						
                            if ( !FindPassableSpace(  forward, -SearchScale ) ) then
							
                                return false
                                 
                            end
							
                        end
						
                    end
					
                end
				
            end
			
        end
         
        if OldPos == NewPos then
		
            return true -- Not stuck?
			
        else
            ply:SetPos( NewPos )
			
            if SERVER and ply and ply:IsValid() and ply:GetPhysicsObject():IsValid() then
			
                if ply:IsPlayer() then
				
                    ply:SetVelocity(vector_origin)
					
                end
				
                ply:GetPhysicsObject():SetVelocity(vector_origin)
				
            end
         
            return true
			
        end
      
    end
     
end
 
function _pMeta:GetUnStuck( )

    return UnstuckPlayer( self )
	
end

function _pMeta:NearNPC ( NPCID )
	
	for k, v in pairs(ents.FindByClass("cn_npc")) do
	
			local uniqueID = v:GetQuest()
			
			if (uniqueID == NPCID) then
			
				if (self:GetPos():Distance(v:GetPos()) < 500) then
				
					return true;
					
				end
				
			end
			
		end
		
		return false;
		
end

function _pMeta:Arrest( byWho )

	if (self:Team() != TEAM_CIVILLIAN) then return end
	
	if ( !self:getFlag("cuffed", false) ) then
	
		if SERVER then
			
			self:StripWeapons()
			UpdatePlayerArrest( self , byWho, true )
			self:SetRunSpeed( 75 )
			self:SetWalkSpeed( 50 )
		end
		
		self:setFlag("cuffed", true)
		self:setFlag("currentlyRestrained", true)
		self:setFlag("arrestingOfficer", byWho)
		
	else
	
		if SERVER then
			
			GAMEMODE:PlayerLoadout(self)
			UpdatePlayerArrest( self , byWho, false )
		
		end
		
		self:setFlag("cuffed", false)
		self:setFlag("currentlyRestrained", false)
		self:setFlag("arrestingOfficer", nil)

		local _runSpeed, _walkSpeed = self:FindMovementSpeed();
		self:SetWalkSpeed(_walkSpeed)
		self:SetRunSpeed( _runSpeed )
	
	end
	

	
end
if SERVER then

	util.AddNetworkString("UpdateClientArrest")
	
	function UpdatePlayerArrest( self, byWho , b)

		net.Start("UpdateClientArrest")
			net.WriteString( self:SteamID() )
			
			if byWho != nil then
			
				net.WriteString( byWho )
				
			end
			
			net.WriteBool( b )
	
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
		
	end
	
else
	
	net.Receive( "UpdateClientArrest", function( _len , _p )
	
		local _toArrest = net.ReadString()
		local _Officer = net.ReadString()
		local _isArresting = net.ReadBool()
		_p = LocalPlayer();
		
		if _p:SteamID() == _toArrest then
		
			_p:setFlag("cuffed", _isArresting)
			_p:setFlag("currentlyRestrained", _isArresting)
			_p:setFlag("arrestingOfficer", _Officer)	
			
			return
		end
		
		for k , v in pairs( player.GetAll() ) do
			if v != LocalPlayer() && v:SteamID() == _toArrest then
					
				
				v:setFlag("cuffed", _isArresting)
				v:setFlag("currentlyRestrained", _isArresting)
				v:setFlag("arrestingOfficer", _Officer)					
				
			end
			
		end
		
	end )
	
end

function _pMeta:DefibPlayer( otherPlayerID )
	if CLIENT then return end
	
	local theirUniqueID = otherPlayerID
	local toHeal	
	//print(theirUniqueID)
	for k, v in pairs(player.GetAll()) do
		if (v:SteamID() == theirUniqueID) then
			toHeal = v
		end
	end
	
	if (!toHeal) then return end
	if (toHeal:Alive()) then return end
	if (self:GetPos():Distance(toHeal.__DeathPos) > 500) then return end
		
	toHeal.RequiredDefib = toHeal.RequiredDefib - 1
	
	if (toHeal.RequiredDefib > 0) then return end
	
	DeadPlayers[toHeal:UniqueID()] = nil
	
	toHeal:Spawn()
	toHeal:Notify("You have been revived by a medic.")
	//haxx
	for i=1, 4 do
		timer.Simple(i / 10, function()
			toHeal:SetPos(toHeal.__DeathPos)
			toHeal:GetUnStuck()
		end)
	end
	
	local _lv = 1;
	if self:GetRotoLevel(3) then
		_lv = self:GetRotoLevel(3)[1]
	end
	
	self:AddRotoXP(3,RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel	*_lv))
	self:addMoney(50)
	self:Notify("You have earned $50 for reviving a player.")


end


// skill points

	/* 
		// Name: fsrp.skills.helper.GetSaveString( _p )
		// Desc: Returns a safe string we can put the table in
		// Return: String
	*/
	function fsrp.skills.helper.GetHashedTable( _p )
		
		local _PlayerSkills = _p:GetSkillTable( )
	
		local _SaveString = "";
	
		for k , v in pairs( _PlayerSkills ) do
		
			if v > 0 then
			
				_SaveString = _SaveString .. k .. "." .. v .. ";";
	
			end
			
		end
		
		_SaveString = _SaveString .. "free." .. _p:GetFreeSkillPoints() .. ";";
		
		return _SaveString
		
	end
	
	/*
		// Name: fsrp.skills.helper.UnhashSaveString( string )
		// Desc: Returns the unhashed version in a table of this string
		// Returns: Table
	*/
	function fsrp.skills.helper.UnhashSaveString( _String )
		
		local _SkillTableSplit = string.Explode( ";" , _String );
		
		local _ReturnTable = {};
		
		for k , v in pairs( _SkillTableSplit ) do
		
			_Skill = string.Explode( "." , _SkillTableSplit[k] )
			
			if fsrp.skills.config.SkillTypes[ _Skill[1] ] then
			
				_ReturnTable[_Skill[1]] = _Skill[2];
			
			elseif _Skill[1] == "free" then
			
				_ReturnTable["free"] = _Skill[2];
				
			end
			
		end
		
		for k , v in pairs( fsrp.skills.config.SkillTypes ) do
		
			if !_ReturnTable[k] then
			
				_ReturnTable[k] = 0;
				
			end
			
		end
		
		return _ReturnTable;
		
	end
	
	
	util.AddNetworkString( "skills_SpendPoint" )
	net.Receive( "skills_SpendPoint", function( _l , _p )
	
		fsrp.skills.helper.AddSkillPoint( _p , net.ReadString() )
	
	end )
	
	/*
		// Name: fsrp.skills.AddSkillPoint( Entity Player, String Skill Type )
		// Desc: Adds a skill point to the player if he has unspent points
		// Returns: /
	*/
	function fsrp.skills.helper.AddSkillPoint( _p , skillType )

		if !fsrp.skills.config.SkillTypes[skillType] then return end
		
		if skillpoint_Helper_GetSkillPoint( _p , skillType ) + 1 > fsrp.skills.config.SkillTypes[skillType].MaxPoints then
		
			return _p:Notify( "You have already maximized this skill!" );
			
		end
		
		if _p:GetFreeSkillPoints() <= 0 then
		
			return _p:Notify( "You do not have enough free skill point for this" )
			
		end
		
		_p:DectrementFreeSkillPoint( )
		
		_p:setFlag( "skillPoints_" .. skillType , skillpoint_Helper_GetSkillPoint( _p , skillType ) + 1 );
		
		fsrp.skills.helper.SaveSQLSkills( _p )
		
	end
	
	/*
		// Name: fsrp.skills.helper.RetrieveSQLSkills( _p )
		// Desc: Retrieves the data from the database then loads it for the player
		// Return: /
	*/
	function fsrp.skills.helper.RetrieveSQLSkills( _p )
		 
		fsdb:Query (  "SELECT skills FROM fsdb_characterdata WHERE `id`='" .. _p:SteamID() .. "' ;", function ( _,result, status , err )
			
			local _data = result;
			
			if !_data || (_data && !_data[1]) then
			
				fsdb:Query( "INSERT INTO `fsdb_characterdata` ( `id`, `business`, `skills`, `knownrecipes` , `computer`, `hatcoords`,`rating`,`PermData`,`LoginReward`) VALUES ('" .. _p:SteamID() .. "' , '','','free.5;','','','','','') ;" )
				fsrp.LoadPermanentData(_p)
			else

				if _data && _data[1] && _data[1]["skills"] != "" then
				
					_p:StringToPlayerSkills( _data[1]["skills"] );
				
				end
				
			end
			
		end )
		
	end
	
	/*
		// Name: fsrp.skills.helper.SaveSQLSkills( _p )
		// Desc: Saves the players skill data
		// Return: /
	*/
	function fsrp.skills.helper.SaveSQLSkills( _p )
		if !IsValid( _p ) then return end
		if _p:getFlag("loadedIN", false ) == false then return end
		fsdb:Query("UPDATE `fsdb_characterdata` SET `skills` ='" .. _p:GetHashedSkillpoints() .. "' WHERE `id`='" .. _p:SteamID() .. "';")
	
	end

	/*
		// Name: Player:SetFreeSkillPoints( integer )
		// Desc: Sets the amount of free points
		// Returns: /
	*/
	function _pMeta:SetFreeSkillPoints( int )

		self:setFlag( "skillPoints_Free", tonumber(int) )
		
		if SERVER  then

				fsrp.skills.helper.SaveSQLSkills( self )
		
		end
		
	end
	
	/*
		// Name: Player:GetHashedSkillpoints( )
		// Desc: Ease of acess with this function. Returns the hash string of the players skills
		// Returns: String Hash
	*/
	function _pMeta:GetHashedSkillpoints( )

		return fsrp.skills.helper.GetHashedTable( self )
		
	end
	
	/*
		// Name: Player:StringToPlayerSkills( string )
		// Desc: Turns the string in to the players skill points.
		// Returns: /
	*/
	function _pMeta:StringToPlayerSkills( _String )

		local _UnhashedString = fsrp.skills.helper.UnhashSaveString( _String )
		
		for k , v in pairs( _UnhashedString ) do
		
			if k != "free" then
			
				self:setFlag( "skillPoints_" .. k , v )
			
			else
				
				self:setFlag( "skillPoints_Free", v )
				//self:SetFreeSkillPoints( v )
				
			end
			
		end
		
	end

	/*
		// Name: Player:DectrementFreeSkillPoint( integer )
		// Desc: Decrements a free skill point
		// Returns: /
	*/
	function _pMeta:DectrementFreeSkillPoint( int )

		local _toset = ( self:GetFreeSkillPoints() - 1 ) 
		
		if _toset <= 0 then
		
			self:SetFreeSkillPoints( 0 );
		
		else
		
			self:SetFreeSkillPoints( _toset );
		
		end
		
		if SERVER then
		
			fsrp.skills.helper.SaveSQLSkills( self )
		
		end

	end
	
	/*
		// Name: Player:AddFreeSkillPoints( integer )
		// Desc: Adds free skill points to spend
		// Returns: /
	*/
	function _pMeta:AddFreeSkillPoints( int )
		
		if !self:CanBuySkillPoint() then return end
		
		self:SetFreeSkillPoints( int + self:GetFreeSkillPoints() )

		if SERVER then
		
			fsrp.skills.helper.SaveSQLSkills( self )
		
		end
	end

	/*
		// Name: Player:AddSkillPoint( string skillType )
		// Desc: Adds skill points to given skills
		// Returns: /
	*/
	function _pMeta:AddSkillPoint( skillType )

		fsrp.skills.AddSkillPoint( self , skillType )
		
		if SERVER then
		
			fsrp.skills.helper.SaveSQLSkills( self )
			
		end
		
	end

	/*
		// Name: fsrp.skills.helper.PurchaseSkillPoint( _p )
		// Desc: Helper function to purchase skill points
		// Return: /
	*/
	function fsrp.skills.helper.BuyFreePoint( _p )
		
		local _cost = skillpoint_Helper_GetSkillpointCost( _p );
		
		if !_p:CanBuySkillPoint() then return _p:Notify( "You have reached the skillpoint limit" ); end
		
		if _p:canAfford( _cost ) then
		
			_p:addMoney( -_cost )
			
			_p:AddFreeSkillPoints( 1 )
			
			_p:Notify( "You have spent $" .. _cost .. " for a skill point. (Paid with Cash)" )
			
		elseif _p:canAffordBank( _cost ) then
		
			_p:addBank( -_cost )
			
			_p:AddFreeSkillPoints( 1 )
			
			_p:Notify( "You have spent $" .. _cost .. " for a skill point. (Paid with Bank)" )
			
		else
		
			_p:Notify( "You can not afford this skill point.")
		
		end
		
		fsdb_saveClient( _p )
		
		if SERVER then 
		
			fsrp.skills.helper.SaveSQLSkills( _p )
		
		end
		
	end
	
	/*
		Name: Player:PurchaseSkillPoint()
		Desc: Gets a free skillpoint for the player wohoo
		Return: /
	*/
	function _pMeta:PurchaseSkillPoint()
	
		fsrp.skills.helper.BuyFreePoint( self )
	
		if SERVER then
		
			fsrp.skills.helper.SaveSQLSkills( self )
		
		end
	end
	
	// store
	
function GM:PlayerSwitchFlashlight( _p , _bool )
	
	local _Totals = _p:GetTotalAmountInv()
	//PrintTable( _Totals )
	if _Totals[52] && _Totals[52].Amount > 0 then
		return true
	end
		
	return false	
	
end 

util.AddNetworkString("sendSellRequestToServer" )
util.AddNetworkString("sendBuyRequestToServer" )
util.AddNetworkString("sendIllegalBuyRequestToServer" )
util.AddNetworkString("sendIllegalSellRequestToServer" )

net.Receive("sendIllegalSellRequestToServer", function( _l, _p )

	if _p:getFlag("lastAction", 0 ) > CurTime() then return end
	_p:setFlag("lastAction", CurTime() + .25 )
	local _ID = net.ReadInt( 16 )
	local _Slot = net.ReadInt( 8 );
	local _amount = net.ReadBool()
	local _Inventory = LoadStringToInventory(_p:getFlag("inventory", nil ))
	local _ItemTable = ITEMLIST[_ID];
	if _ItemTable.RestrictBlackMarketSale then return _p:Notify("You may not sell this item to the Black Market") end

	if !_p:IsNearCNPC( "druggo" , 150 ) then return _p:Notify("Move closer to the Dealer to trade with him") end;
	
	if _ItemTable.Illegal == false then return _p:Notify("The Dealer doesn't want that.") end
	
	local _ActiveQuests = _p:getFlag("questTable", nil )
	local _WeBuy = fsrp.blackmarket.cache.Buying;
	
	if !table.HasValue( _WeBuy, _ID ) and (_ActiveQuests[8] and _ActiveQuests[8].Completed == true and _ActiveQuests[8].Step == 3) then
	
		return _p:Notify( "The Dealer is not buying this right now." );
	
	end
	local _trueAmount = _amount && _Inventory[_Slot].Amount || 1;
	
	local _AmountInSlot = _Inventory[_Slot].Amount;
	
	if _AmountInSlot - _trueAmount <= 0 then
		
		if _trueAmount == _Inventory[_Slot].Amount && _trueAmount - _AmountInSlot > 0 then
			
				_Inventory[_Slot] =  _trueAmount - _AmountInSlot;
			
				if _Inventory[_Slot] < 0 then
				
					_Inventory[_Slot] = nil
				
				end
				
		else
		
			_Inventory[_Slot] = nil
		
		end
		
	else
	
		_Inventory[_Slot].Amount = _AmountInSlot - _trueAmount;
	
	end

	if _ID && 54 && LastGlobalWeedBoost+3600 > os.time() then
		_trueAmount = _trueAmount*2
	end
	if _ItemTable.OnIllegalSale then
		_ItemTable.OnIllegalSale(_p);
	end
	_p:setFlag("inventory", CompileInventoryToString( _Inventory ) )
	net.Start( "inventorySync" )
		net.WriteTable( _Inventory )
	net.Send( _p )
	_p:EmitSound("items/ammocrate_close.wav")
	_p:addMoney( _ItemTable.Cost * _trueAmount )
	_p:Notify("Successfully sold " .. _ItemTable.Name .. " for $".. (_ItemTable.Cost*_trueAmount) .."!")
end )
 hook.Add("OnEntityCreated", "RemoveAmbientGeneric", function(ent)
 	if ent:GetClass() == "ambient_generic" then
 	print("Removing ambient_generic")
		ent:Remove()
		
	end
end)
 
net.Receive("sendIllegalBuyRequestToServer", function( _l , _p )

	if _p:getFlag("lastAction", 0 ) > CurTime()  then return end
	_p:setFlag("lastAction", CurTime() + .25)
	local _Item = net.ReadInt( 16 )
	local _Amount = net.ReadBool( )

	if !_p:IsNearCNPC( "druggo" , 150 ) then return _p:Notify("Move closer to the Dealer trade with him") end;
	
	
	local _ItemTable = ITEMLIST[ _Item ];
	if !_ItemTable then return _p:Notify("Could not find item in slot!") end
	local _Charge = _ItemTable.Cost
	if _Amount then _Charge = _Charge * 5 end
	local _lv = 1;
	if _p:GetRotoLevel(14) then
		_lv = _p:GetRotoLevel(14)[1]
	end
	_Charge = _Charge - math.min(_Charge*(0.005*_lv),_Charge*0.1);
	local _text = " from your wallet."
	if _p:canAfford( _Charge ) then
	
		_p:addMoney( -_Charge )
		
		_text = " from your bank account."
		
	else
	
		return _p:Notify( "You do not have enough money to pay for this! ($" .. ( _Charge - _p:getMoney() ) .. ")" );
	
	end
	
	_p:Notify("You have been charged $" .. _Charge .. _text );
	
	if _Amount then
	
		for i = 1, 5 do
		
			_p:AddItemByID( _Item )
			
		end
	
	else
	
		_p:AddItemByID( _Item );
	
	end
	
end )




net.Receive("sendSellRequestToServer", function( _l, _p )

	if _p:getFlag("lastAction", 0 ) > CurTime()  then return end
	_p:setFlag("lastAction", CurTime() + .25 )
	local _Slot = net.ReadInt( 16 )
	local _amount = net.ReadBool()
	//local _typeShop = fsrp.stores.cache[net.ReadInt(8)];

	//if !_p:IsNearCNPC( _typeShop.CName , 350 ) then return _p:Notify("Move closer to the clerk trade with them") end;
	
	local _Inventory = LoadStringToInventory(_p:getFlag("inventory", nil ))
	
	local _InvSlot = _Inventory[_Slot]
	if !_InvSlot || !_InvSlot.ID then return end
	local _ItemID = _InvSlot.ID
	local _ItemTable = ITEMLIST[_ItemID];
	
	if _ItemTable.Tradeable == false || _ItemTable.Illegal == true then return _p:Notify("You may not sell illegal or untradable items.") end

	if !_Inventory[_Slot] then 
	
		return _p:Notify("Could not find slot in inventory.")
		
	end
	
	if !_Inventory[_Slot].ID  then
	
		return _p:Notify("Could not find item in slot.")
		
	end

	local _trueAmount = _amount && 10 || 1;
	
	local _AmountInSlot = _Inventory[_Slot].Amount;
	
	if _AmountInSlot - _trueAmount <= 0 then
		
		if _trueAmount == 10 && _trueAmount - _AmountInSlot > 0 then
			
				_Inventory[_Slot] =  _trueAmount - _AmountInSlot;
			
				if _Inventory[_Slot] < 0 then
				
					_Inventory[_Slot] = nil
				
				end
				
		else
		
			_Inventory[_Slot] = nil
		
		end
		
	else
	
		_Inventory[_Slot].Amount = _AmountInSlot - _trueAmount;
	
	end
	
	
	
	
	
	
	
	local _lv = 1;
	if _p:GetRotoLevel(14) then
		_lv = _p:GetRotoLevel(14)[1]
	end
	
	local _skill = skillpoint_Helper_GetSkillPoint( _p , "influence" );
	_lv = _skill+_lv;

	_p:setFlag("inventory", CompileInventoryToString( _Inventory ) )
	net.Start( "inventorySync" )
		net.WriteTable( _Inventory )
	net.Send( _p )
	_p:EmitSound("items/ammocrate_close.wav")
	_p:addMoney( _ItemTable.Cost * math.min((0.3+(_lv*0.01)),0.6) )
	
end )

net.Receive("sendBuyRequestToServer", function( _l , _p )

	if _p:getFlag("lastAction", 0 ) > CurTime()  then return end
	_p:setFlag("lastAction", CurTime() + .25 )
	local _Item = net.ReadInt( 16 )
	local _Amount = net.ReadBool( )

	local _nnum = net.ReadInt(8);
	local _typeShop = fsrp.stores.cache[_nnum];
	//print( _typeShop.CName )
	//if !_p:IsNearCNPC( _typeShop.CName , 350 ) then return _p:Notify("Move closer to the clerk trade with them") end;
	local _foundnpc = false;
	local _tax = fsrp.mayorgovernment.tax.sales/100
	for k , v in pairs( ents.FindByClass("cn_npc") ) do

		if IsValid(v) && v && v:GetPos():Distance(_p:GetPos()) < 500 then
	
			if _typeShop.CName == v:GetQuest() then
				_foundnpc = true;	
			end
		end

	end

	if _foundnpc == false then return _p:Notify("Please move closer to the vendor.") end;

	local _ItemTable = ITEMLIST[ _Item ];
	if !_ItemTable then return _p:Notify("Could not find item in slot!") end
	local _Charge = _ItemTable.Cost+(_ItemTable.Cost*_tax)
	local _itemtax= _ItemTable.Cost*_tax
	if _Amount then 
		_Charge = _Charge * 5 
		//print((_ItemTable.Cost*_tax)*5)

		_itemtax = _itemtax * 5
		fsrp.config.mayorgovernment.functions.AddGovtMoney(_itemtax)
	else

		//print(_ItemTable.Cost*_tax)
		fsrp.config.mayorgovernment.functions.AddGovtMoney(_itemtax)
	end
	local _lv = 1;
	if _p:GetRotoLevel(14) then
		_lv = _p:GetRotoLevel(14)[1]
	end
	_Charge = _Charge - math.min(_Charge*(0.005*_lv),_Charge*0.1);
	
	
	_p:AddRotoXP(14,RotoLevelSystem.config.RewardXP+((RotoLevelSystem.config.RewardXPPerLevel/2)	*_lv))
	local _text = " from your wallet."
	if _p:canAfford( _Charge ) then
	
		_p:addMoney( -_Charge )
		
	elseif _p:canAffordBank( _Charge ) then
	
		_p:addBank( -_Charge )
		
		_text = " from your bank account."
		
	else
	
		_p:Notify( "You do not have enough money to pay for this! ($" .. ( math.Round(_Charge,2) - _p:getMoney() ) .. ")" );
	
	end
	
	_p:Notify("You have been charged $" ..  math.Round(_Charge,2)  .. "($".._itemtax.." Tax)".. _text );
	
	if _Amount then
	
		for i = 1, 5 do
		
			_p:AddItemByID( _Item )
			
		end
	
	else
	
		_p:AddItemByID( _Item );
	
	end
	
end )





net.Receive("slotAdjustment", function( len , _p )
	
	local _slot = net.ReadInt( 4 )
	//_p:Notify( _slot )
	if _p:getFlag("itemSlot_" .. _slot ) then
	
		_p:RemoveFromSlot( _slot )
		
	end
	
end )

// slot 1 = primary , slot 2 = secondary , slot 3 = hat;
function _pMeta:RemoveFromSlot( slotNumber, dontadd )

	local _SlotInName = self:getFlag("itemSlot_" .. slotNumber, nil );
	
	if !_SlotInName then return end
	
	local _itemFromSlot = ITEMLIST[_SlotInName];
	
	local _pronoun = "her";
	if self:getGender() != 1 then
			
		_pronoun = "his";
				
	end
	
	if !dontadd then 
	
		self:AddItemByID( _itemFromSlot.ID )
				
		self:ConCommand( "say /me has placed " .. _pronoun .. " " .. _itemFromSlot.Name .. " back in to " .. _pronoun .. " inventory.");
		
	end
	
					
	if slotNumber != 3 then
	
		self:StripWeapon( _itemFromSlot.WeaponClass )
	
	else
		
		self:RemoveHat( )
	
	end
	
	self:setFlag( "itemSlot_" .. slotNumber , nil )
	fsdb_saveClient( self )
	
end


/*
net.Receive( "buyPropertyFromClient", function( len, _p )

	local _id = net.ReadInt( 8 ) 
	local _prop = fsrp.PropertyTable[_id];
	
	if _p:canAffordBank( (_prop.Cost*1.5) ) then
		
		if _p:getFlag("propertiesBought", 0) < fsrp.config.MaxProperties then
		
			AssignPropertyOwner( _id, _p, false  );
		
		end
	
	end
	
end )
*/
function _pMeta:BuyProperty(_id)

	local _prop = fsrp.PropertyTable[_id];
	
	if self:canAffordBank( (_prop.Cost) ) then
		
		if self:getFlag("propertiesBought", 0) < fsrp.config.MaxProperties then
		
			AssignPropertyOwner( _id, self, true  );
		
		end
	else
		self:Notify("You cannot afford the price of this property! ($" .. (_prop.Cost*1.5)..")" )
	end
	
end

net.Receive("BuyWeedPlant", function( len , _p )
	local _PlantAmount = _p:getFlag( "maxcannabisplants", 0 );
	if CurTime() > _p:getFlag("weedBuyDelay", 0 ) then 
		
		if _PlantAmount <=  _p:GetCannabisPlantLimit() then
			
			if _PlantAmount == 0 then
			
				_p:Notify("You can use your gravity gun to make the plant stand upright (Left Mouse Button)");
				
			end
			
			if _p:canAffordBank( 2500 ) then
			
				_p:addBank( -2500 )
				
			elseif _p:canAfford( 2500 ) then
			
				_p:addMoney( -2500 )
			else
			
				return _p:Notify("You cannot afford this.")
				
			end
			
			_p:setFlag("maxcannabisplants", _PlantAmount + 1 )
			
			_p:Notify("This is not the final version of making marijuana.")
				
			local trace = {};
			trace.start = _p:GetShootPos();
			trace.endpos = _p:GetShootPos() + _p:GetAimVector() * 50;
			trace.filter = _p;
			local tRes = util.TraceLine(trace);
			
			local _pos = tRes.HitPos
			
			local _newPlant = ents.Create("cannabis_plant")
			_newPlant:SetPos( _pos );
			_newPlant:setFlag("ownedBy", _p:SteamID() , false )
			
			_newPlant:Spawn()
			
		else
		
			_p:Notify("You have reached the limit of maximum marijuana plants.")
		
		end
		
		_p:setFlag("weedBuyDelay", CurTime()+.25 )  
	end
end)

function GM:InitPostEntity()

	if game.GetMap() == "rp_downtown_2017" then
	
	ents.GetByIndex(1007):Fire('lock', '', 0);
	ents.GetByIndex(1007):Fire('close', '', .5);
	ents.GetByIndex(965):Fire('lock', '', 0);
	ents.GetByIndex(965):Fire('close', '', .5);
	
	end
		
	
	makePropDisplayFromTable()
	retrievePermSigns()
	/*
	local data = cnQuests["bu_start"]

	local entity = ents.Create("cn_npc")
	entity:SetPos(client:GetEyeTrace().HitPos)
	entity:SetAngles(angles)
	entity:Spawn()
	entity:SetModel(data.model)
	entity:SetQuest(uniqueID)
	entity:setAnim()

	saveQuests()
	*/
	
	
end
net.Receive( "buypropertyFromBank", function( len , _p )
	local pid = net.ReadInt(8)
	local selling = false;
	local _useVoucher = net.ReadBool();

	local _rewardTable = _p:GetDailyRewardTable();

	if _useVoucher && _useVoucher == true then
		if _rewardTable[2] <= 0 then
			return _p:Notify("You do not have enough vouchers to use!")
		end
	end

	if fsrp.PropertyTable[pid].PrimaryOwner && _p:SteamID() == fsrp.PropertyTable[pid].PrimaryOwner[2] then
	
		if _p:getFlag("propertiesBought", 0) < fsrp.config.MaxProperties then
		selling = true;
		AssignPropertyOwner( pid , _p , true,_useVoucher );
		else
			_p:Notify("You have bought the maximum amount of properties allowed already.");
		end
	end

	if !selling then
		
		AssignPropertyOwner( pid , _p , true,_useVoucher );
	
	end
	
	
end )

function fsrp.IsValidName ( first, last, skipFirstLast )
	local first = string.lower(first);
	local last = string.lower(last);

	if (!skipFirstLast) then
		if (!fsrp.IsValidPartialName(first)) then return false; end
		if (!fsrp.IsValidPartialName(last)) then return false; end
	end
	
	if (first == "john" && last == "doe") then return false end
	
	
	for k, v in pairs(fsrp.config.InvalidRPNames) do 
		if (#v > 1) then
			if (first == v[1] && last == v[2]) then
				return false;
			end
		end
	end
	
	
	return true;
end



if SERVER then

	util.AddNetworkString( "createacharacter_Receive" )
	util.AddNetworkString( "createacharacter_Finish" )
	util.AddNetworkString( "createacharacter_CloseMenuFromClient" )
	util.AddNetworkString( "createacharacter_UpdateSkin" )
	util.AddNetworkString( "createacharacter_UpdateBodygroups" )
	util.AddNetworkString( "createacharacterr_updatePlayerModel" )
	util.AddNetworkString( "createacharacter_sendCharacterInfo" )

	local _pMeta = FindMetaTable( 'Player' )

	net.Receive( "createacharacter_CloseMenuFromClient", function( _l, _p )
	
		_p:SendFinishCreateACharacter( )
	
	end )
	
	function _pMeta:SendCreateACharacter()

		self:setFlag( "creatingCharacter", true )
	
		net.Start( "createacharacter_Receive" )

		net.Send( self )

		local eyeang = self:EyeAngles()
		
		self:SetEyeAngles( Angle( 0, eyeang.y  ,eyeang.r ) )
	
	end

	function _pMeta:SendFinishCreateACharacter()

		self:setFlag( "creatingCharacter", false )
		
		net.Start( "createacharacter_Finish" )
		
		net.Send( self )


	end
	
	net.Receive( "createacharacterr_updatePlayerModel" , function ( _len , _p )
	
		local _model = net.ReadString()
		
		_p:SetModel( player_manager.TranslatePlayerModel( _model ) )
		
		_p:SetSkin( 0 )
			
		for k = 0, _p:GetNumBodyGroups() - 1 do
				
			_p:SetBodygroup( k, 0 )
			
		end
		
		_p:getFlag("createacharacter_playerModel_cart", "Vindictus-Vella" )
		_p:getFlag("createacharacter_bodygroups_cart", "" ) 
		_p:getFlag("createacharacter_bodySkin_cart", 0 )	
		
	end ) 
	
	net.Receive( "createacharacter_sendCharacterInfo" , function( _len , _p )
		
			local _name = net.ReadString( )
			local _skin = net.ReadInt( 8 )
			local _bdg = net.ReadString( )
			
			//_p:Notify( player_manager.TranslatePlayerModel( _name ) )
			//_p:Notify( _bdg )
			//_p:Notify( _skin )
			
			_p:SetModel( player_manager.TranslatePlayerModel( _name ) )
			local groups = _bdg
			if ( groups == nil ) then groups = "" end
			local groups = string.Explode( " ", groups )
			for k = 0, _p:GetNumBodyGroups() - 1 do
				_p:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
			end
			
			_p:SetSkin( _skin )
			timer.Simple( 0.2, function()
				local hands = _p:GetHands()
				if ( IsValid( hands ) ) then 
					-- Which hands should we use?
					local info = player_manager.TranslatePlayerHands( mdl )
					if ( info ) then
						hands:SetModel( info.model )
						hands:SetSkin( _skin )
						hands:SetBodyGroups( info.body )
					end
					-- Attach them to the viewmodel
					local vm = _p:GetViewModel( 0 )
					hands:AttachToViewmodel( vm )
					vm:DeleteOnRemove( hands )
					_p:DeleteOnRemove( hands )
				end
			end )
			
			_p:setFlag("playerinfo_model", _name )
			_p:setFlag("playerinfo_bodygroups", _bdg )
			_p:setFlag("playerinfo_skin", _skin )
		
			
			local modelInfo = ExplodeModelInfo( player_manager.TranslatePlayerModel(_name) ) or {}; 
			local _foundSex = 1;
			for k , v in pairs( mdlTable[2] ) do
			
				if v.path == player_manager.TranslatePlayerModel( _name ) then
				
					_foundSex = 2;
					
				end
				
			end
			
				_p:setFlag("playerinfo_job_police_model", "Police_" .. math.random( 4, 7 ) )
				_p:setFlag("playerinfo_job_police_bodygroups",  ""  )
				_p:setFlag("playerinfo_job_police_skin",  0  )
			local Default = "hospitalfemale_" .. math.random( 9 );
			
			local DefaultMayor = "Liz(11 Noire)";
			
			if _foundSex == 2 then
			
				Default = "hospitalmale_" .. math.random( 9 )
				DefaultMayor = "breen"
				
			end
			
			_p:setClientGender( _foundSex );
			
			_p:setFlag("playerinfo_job_paramedic_model",  Default  )
			_p:setFlag("playerinfo_job_paramedic_bodygroups",  ""  )
			_p:setFlag("playerinfo_job_paramedic_skin",  0 )
			_p:setFlag("playerinfo_job_mayor_model",  DefaultMayor  )
			_p:setFlag("playerinfo_job_mayor_bodygroups",  ""  )
			_p:setFlag("playerinfo_job_mayor_skin",  0 )
			
			fsdb:Query( "UPDATE `fsdb_user` SET `model` = '" .. _foundSex .. "' WHERE `id`='" .. _p:SteamID() .. "';" );
			
			_p:ShowNameChangeMenu()
			_p:SaveGMModels()
	
			net.Start("UpdateHUD")
			net.Send( _p )
					
	end )
	
	net.Receive( "createacharacter_UpdateBodygroups", function( _len , _p )
	
		local _Value =  net.ReadInt( 8 )
		local _TypeBody = net.ReadInt( 8 )
		
		_p:SetBodygroup( _TypeBody , _Value )
	
	end )
	
	net.Receive( "createacharacter_UpdateSkin", function( _len, _p )
	
		local _skin = net.ReadInt(8)
		
		_p:SetSkin( _skin );	
	
	end )
	
end

util.AddNetworkString( "showNameChangeMenu" );

	
function _pMeta:ShowNameChangeMenu( isPaid )
		
	local shouldPay = isPaid || false;
		
	net.Start( "showNameChangeMenu" )
		
		net.WriteBool( shouldPay )
		
	net.Send( self )

end

net.Receive( "fsrp.sendUsYourName" , function( len, _p )

	local firstName, lastName = net.ReadString( ) , net.ReadString( )
	local shouldPay = net.ReadBool( ) || false;
		
	if shouldPay then
		local _whoPaid = "Bank Account.";
		if _p:canAffordBank( fsrp.config.NameChangeCost ) then

			_whoPaid = "Bank Account.";

		elseif _p:canAfford( fsrp.config.NameChangeCost ) then
			
			_whoPaid = "Wallet."
			
		else
		
			return _p:Notify( "You can not afford this payment right now." ); 
			
		end
		
		_p:Notify( "You have been charged $" .. fsrp.config.NameChangeCost  .. " for a legal name change from your "  )
			
	end	
	
	if _p:getFirstName() == firstToUpper(firstName) then
	
		_p:ShowNameChangeMenu()
		return
		
	end
	
	if _p:getLastName() == firstToUpper(lastName) then
	
		_p:ShowNameChangeMenu()
		return
		
	end
	
	if fsrp.IsValidName( firstName, lastName ) then
	
		local _oldfirst, _oldlast = _p:getFirstName(), _p:getLastName();
		
		_p:setFirstName( firstToUpper(firstName) )
		_p:setLastName( firstToUpper(lastName) )
		
		fsdbUpdateName( _p, _oldfirst, _oldlast )
		
		fsdb:Query("SELECT `id` FROM `fsdb_user` WHERE `first_name`='" .. firstName .. "' AND `last_name`='" .. lastName .. "' LIMIT 1", function ( _,someoneElseHas )
		if (!_p or !IsValid(_p) or !_p:IsValid()) then return; end
		
		if (someoneElseHas && someoneElseHas[1] && someoneElseHas[1]['id'] != _p:SteamID() ) then
			_p:Notify("That name is already taken.\n");
			_p:ShowNameChangeMenu();
			return; 
		end
		end)
		
		if (!fsrp.IsValidName(firstName, lastName)) then 
			_p:ShowNameChangeMenu();
			_p:Notify("This name is unavailable");
			return; 
		end
		
	end
 
	net.Start("UpdateHUD")
	net.Send( _p )
					
end)

local function spiralGrid(rings)
	local grid = {}
	local col, row

	for ring=1, rings do -- For each ring...
		row = ring
		for col=1-ring, ring do -- Walk right across top row
			table.insert( grid, {col, row} )
		end

		col = ring
		for row=ring-1, -ring, -1 do -- Walk down right-most column
			table.insert( grid, {col, row} )
		end

		row = -ring
		for col=ring-1, -ring, -1 do -- Walk left across bottom row
			table.insert( grid, {col, row} )
		end

		col = -ring
		for row=1-ring, ring do -- Walk up left-most column
			table.insert( grid, {col, row} )
		end
	end

	return grid
end
local tpGrid = spiralGrid( 24 )

-- Utility function for bring, goto, and send
local function playerSend( from, to, force )
	if not to:IsInWorld() and not force then return false end -- No way we can do this one

	local yawForward = to:EyeAngles().yaw
	local directions = { -- Directions to try
		math.NormalizeAngle( yawForward - 180 ), -- Behind first
		math.NormalizeAngle( yawForward + 90 ), -- Right
		math.NormalizeAngle( yawForward - 90 ), -- Left
		yawForward,
	}

	local t = {}
	t.start = to:GetPos() + Vector( 0, 0, 32 ) -- Move them up a bit so they can travel across the ground
	t.filter = { to, from }

	local i = 1
	t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
	local tr = util.TraceEntity( t, from )
	while tr.Hit do -- While it's hitting something, check other angles
		i = i + 1
		if i > #directions then	 -- No place found
			if force then
				return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
			else
				return false
			end
		end

		t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47

		tr = util.TraceEntity( t, from )
	end
	
	return tr.HitPos
end

function bring( calling_ply, target_plys )
	local cell_size = 50 -- Constance spacing value

  if not calling_ply:IsValid() then
    Msg( "If you brought someone to you, they would instantly be destroyed by the awesomeness that is console.\n" )
    return
  end

  if not calling_ply:Alive() then
     calling_ply:Notify( "You are dead!" )
    return
  end

  if calling_ply:InVehicle() then
	calling_ply:ExitVehicle();
     calling_ply:Notify( "Please leave the vehicle first!" )
    return
  end

	local t = {
		start = calling_ply:GetPos(),
		filter = { calling_ply },
		endpos = calling_ply:GetPos(),
	}
	local tr = util.TraceEntity( t, calling_ply )

  if tr.Hit then
    calling_ply:Notify( "Can't teleport when you're inside the world!" )
    return
  end

  local teleportable_plys = {}

  for i=1, #target_plys do
    local v = target_plys[ i ]
    if not v:Alive() then
      calling_ply:Notify( v:Nick() .. " is dead!" )
    else
      table.insert( teleportable_plys, v )
    end
  end
	local players_involved = table.Copy( teleportable_plys )
	table.insert( players_involved, calling_ply )

  local affected_plys = {}

  for i=1, #tpGrid do
		local c = tpGrid[i][1]
		local r = tpGrid[i][2]
    local target = table.remove( teleportable_plys )
		if not target then break end

		local yawForward = calling_ply:EyeAngles().yaw
		local offset = Vector( r * cell_size, c * cell_size, 0 )
		offset:Rotate( Angle( 0, yawForward, 0 ) )

		local t = {}
		t.start = calling_ply:GetPos() + Vector( 0, 0, 32 ) -- Move them up a bit so they can travel across the ground
		t.filter = players_involved
		t.endpos = t.start + offset
		local tr = util.TraceEntity( t, target )

    if tr.Hit then
      table.insert( teleportable_plys, target )
    else
      if target:InVehicle() then target:ExitVehicle() end
	  
      target:SetPos( t.endpos )
      target:SetEyeAngles( (calling_ply:GetPos() - t.endpos):Angle() )
      target:SetLocalVelocity( Vector( 0, 0, 0 ) )
      table.insert( affected_plys, target )
    end
  end

  if #teleportable_plys > 0 then
   calling_ply:Notify("Not enough free space to bring everyone!" )
  end

end

function goto( calling_ply, target_ply )
	if not calling_ply:IsValid() then
		Msg( "You may not step down into the mortal world from console.\n" )
		return
	end

	if not target_ply:Alive() then
		calling_ply:Notify( target_ply:Nick() .. " is dead!"  )
		return
	end

	if not calling_ply:Alive() then
		calling_ply:Notify( "You are dead!" )
		return
	end

	if target_ply:InVehicle() and calling_ply:GetMoveType() ~= MOVETYPE_NOCLIP then
		calling_ply:Notify( "Target is in a vehicle! Noclip and use this command to force a goto." )
		return
	end

	local newpos = playerSend( calling_ply, target_ply, calling_ply:GetMoveType() == MOVETYPE_NOCLIP )
	if not newpos then
			calling_ply:Notify("Can't find a place to put you, noclip and go again")
		return
	end

	if calling_ply:InVehicle() then
		calling_ply:ExitVehicle()
	end

	local newang = (target_ply:GetPos() - newpos):Angle()

	calling_ply:SetPos( newpos )
	calling_ply:SetEyeAngles( newang )
	calling_ply:SetLocalVelocity( Vector( 0, 0, 0 ) ) -- Stop!
	
end


net.Receive( "adminItemReq", function( len , _p )

	local id = net.ReadInt(12 )
	
	_p:AddItemByID( id )
	
end )

net.Receive( "buyInitialShare", function ( len , _p ) 

	local _bID = net.ReadInt( 8 )
	local tbl = _p:getFlag( "businesstable", {}, true );
	
	if !_p:IsOnQuest(3) then
	
		_p:RewardQuest( 3 )
		
	end
	
	if tbl && tbl[_bid] && tbl[_bID].shares && tbl[_bID].shares > 0 then
		
		return _p:Notify("Go to the Business to buy shares!")
			
	else
	
		if _p:getBankAccount() == 3 then
			
			_p:setShares( _bID , 1,1, 0)
			
			_p:Notify( "You have bought your initial stock, go to the Business to get more!" )
			
			_p:setFlag("businesstable", _p.__BusinessTable , true );
			
			saveBusinesses( _p )
			
		else
			
			_p:Notify("You need a Business account to initialize a stock")
			
		end
		
	end
		
end )

net.Receive( "fsrp.changemodel", function( len, _p )

	local _mdlTable = net.ReadTable();
	
	if _p:canAfford( fsrp.config.FacialCost ) then
	
		_p:SetModel( _mdlTable[2] );
		_p:setClientGender( _mdlTable[1] );
		_p.__oModel = ExplodeModelInfo( _mdlTable[3] )
		fsdb:Query( "UPDATE `fsdb_user` SET `model` = '" .. _mdlTable[3] .."' WHERE `id`='" .. _p:SteamID() .. "';" );
		_p:ChatPrint( "You have changed your model" )
		
	else
	
		_p:ChatPrint( "You can not afford this" )
	
	end

end )

local _pMeta = FindMetaTable("Player")

function _pMeta:SetPlayerTeam( int )

	if !IsValid(self) then return end
	if int > 4 || int < 0 then return false end
	
	self:SetTeam( int )
	
	return true

end

util.AddNetworkString("turnThirdpersonOff")


function GM:PlayerDeath( _p , _i, _k )
	
	local _kt = tostring(_k)
	_p.RequiredDefib = math.random(1,4);
	net.Start("turnThirdpersonOff")
	net.Send( _p )
	if _p:getFlag("robbingBank", false) == true then
		
		_p:Notify("You died during your robbery.")

	end

	_p:setFlag("robbingBank", nil)

	if _k && IsValid( _k ) && _k:IsPlayer() then
	
		_kt = _k:Nick()
		
	end
	if _p:IsWanted() then
		_p:SetWanted(false)
		_p:SetStars(0)
	end
	if _k:IsPlayer() and _k:IsGovernmentOfficial() != true then 
		local _kStars = _k:GetStars();
		_k:SetStars(math.min(_kStars+3,5));
	end


	if _k:IsVehicle() && IsValid( _k:GetDriver( ) ) then
	
		_kt = _k:GetDriver():Nick() .. " (Withing a Vehicle)";
		
	end
	
	if _k != _p then
		
		print( "[WC-RP] " .. _kt .. " has killed " .. _p:Nick() .. "." )
		
	end
	
	_p.__DeathPos = _p:GetPos()

	if _p:GetTotalAmountInv()[157] then
			
				
		_p:BroadcastLifeAlert()
		
	
	
	end


	DeadPlayers[ _p:UniqueID() ] = { _p.__DeathPos ,os.time()};
	local _devi = 10;
	local _teamam = team.NumPlayers(TEAM_PARAMEDIC)	
	if _teamam <= 0 then
		_p.__RespawnTime =CurTime()+1 
		//_p:Notify( "Paramedics did not have enough time to save you." )
	else 
		if _i && _i:IsVehicle( ) then			

			_devi = math.random( 10 , 30 )
			_p.__RespawnTime = CurTime() + _devi
			_p:Notify( "You have been rammed by a vehicle. Paramedics will be able to revive you once called out" )

		elseif _p:WaterLevel() >= 3 then
		
			_devi = math.random( 40 , 120 )			
			_p.__RespawnTime = CurTime() + _devi			
			_p:Notify('You have been knocked unconcious underwater. Paramedics will probably not arrive in time to save you!');

		else

			_devi =  math.random( 20 , 60 );
			_p:Notify('You have been knocked unconcious, you must wait for the paramedics to arrive in time to save you!');
			_p.__RespawnTime = CurTime() + _devi
			
		end
	end

	if _p:Team() != TEAM_MAYOR and _teamam>0 then
		if _p:IsDonator() then 
		
			_p.__RespawnTime = math.max(0,(_p.__RespawnTime - 10));
			_p:Notify( "Respawning in " .. math.ceil((_devi - 10)) ) 
		end
	local _TheirMoney = _p:getMoney() *0.95;
	if _TheirMoney > 1 then
	
		_p:Notify( "You have dropped $" .. ((_TheirMoney*1.05)-_TheirMoney) );
		_p:setMoney( _TheirMoney )
		
		local _cash = ents.Create('cash');
		_cash:SetPos(_p:GetPos() + _p:GetForward() * 15)
		_cash:Spawn()
		_cash:setFlag( "money_Worth", ((_TheirMoney*1.05)-_TheirMoney) );
	
	end
	
	local _slotsToFindPrimary = _p:getFlag("itemSlot_1", nil )
	local _slotsToFindSecondary = _p:getFlag("itemSlot_2", nil )
	local _dropItem = false;
	local _itemsToDrop = nil;
	
	if _slotsToFindPrimary then
	
		_p:RemoveFromSlot( 1 , true )
		_dropItem = true
		_itemsToDrop = _slotsToFindPrimary;
		
	end
	if _slotsToFindSecondary then
	
		_p:RemoveFromSlot( 2 , true )
		_dropItem = true;
		
		if _itemsToDrop then
		
			local _newItems = {};
			_newItems = { _itemsToDrop , _slotsToFindSecondary };
			_itemsToDrop = _newItems;
			
		end
		
	end
					

	_p:setFlag("itemSlot_2", nil )
	_p:setFlag("itemSlot_1", nil )
	if _dropItem then
		
		
		local itemDrop = ents.Create("fsrp_item");
		if istable(_itemsToDrop) then
			local _item = ITEMLIST[_itemsToDrop[1]];
			itemDrop:SetModel(_item.Model)
		else
			local _item = ITEMLIST[_itemsToDrop];
			itemDrop:SetModel(_item.Model)
		end
		
			itemDrop.ID = _itemsToDrop;
			itemDrop:setFlag("ownedBy", _p:SteamID() )
			itemDrop:setFlag("itemID", _itemsToDrop )
			itemDrop.ID = _itemsToDrop;
			itemDrop:SetPos( _p:GetPos() + Vector( 0,0, 100 ) );
			itemDrop:PhysicsInit( SOLID_VPHYSICS )
			itemDrop:GetPhysicsObject( ):Wake()
			
		itemDrop:Spawn()
	
	
	end
	end

end
net.Receive("networkRemClient" , function( len , _p ) 

	local id = net.ReadString()
	
		for k, v in pairs(_p.__Buddies) do
			if (id == v[2]) then
				_p.__Buddies[k] = nil;
			end
		end
	
	






end)
net.Receive("clientBuddyTable" , function( len , _p ) 

	_p.__Buddies = net.ReadTable()






end)
net.Receive("networkClientBuddy" , function( len , _p ) 
	local id = net.ReadString();
	
	if _p.__Buddies[ id ] then return end;
	
	
	for k , v in pairs( player.GetAll() ) do 
	
		if tostring(v:UniqueID()) == id then
				
				
			_p.__Buddies[id] = { v:Nick() ,  id  }

		end

	end

end)
	
	
function GM:PlayerDeathThink ( _p )


	if !DeadPlayers then
		
		DeadPlayers = {}
			
	end
		
	if !DeadPlayers[ _p:UniqueID() ] then
	
		DeadPlayers[ _p:UniqueID() ] = { (_p.__DeathPos||_p:GetPos()),os.time() };
		
	end
	
	//_p.__RespawnTime = _p.__RespawnTime;
	local _toSpawnTime = CurTime() - (_p.__RespawnTime||0);
	
	if _p.__RespawnTime  && _p.__RespawnTime < CurTime( ) then
		_p:setFlag("cuffed",false);
		_p.__Crippled = false;
		_p:Spawn()
		
		local _runSpeed, _walkSpeed = _p:FindMovementSpeed();
		_p:SetWalkSpeed(_walkSpeed)
		_p:SetRunSpeed( _runSpeed )
		
		_p:Notify( "You have died, sadly the paramedics were not able to restore you to a concious state." )
	//else
		//_p:Spawn()
		//_p.__Crippled = false;
	
	end
	
end

function GM:CanPlayerSuicide( _p )

	if !_p:IsSuperAdmin() then return end
	
end


function GM:GetFallDamage( _p , speed )

	return math.Clamp( speed / 10 , 5, 100 )
	
end

// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade,6-PIst
local _wepTypeToLevel = {
	[1] = 9,
	[2] = 7,
	[3] = 8,
	[4] = 10,
	[5] = 6,
}

function GM:ScalePlayerDamage( _p , _hg , _di )
	 
	local _a = _di:GetAttacker( )
	local _ds = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
	local _hardiness = 1
	if _p:GetRotoLevel(4) then
		_hardiness=_p:GetRotoLevel(4)[1];
	end
	local _dscale = 1;
	_dscale = 1-math.min((_hardiness*0.01),0.8);
	local _weaponType = 6;
	for k,v in pairs(ITEMLIST) do
		if v.WeaponClass ==  _a:GetActiveWeapon():GetClass() then
			_weaponType = v.WepType;
			break;
		end
	end
  

	if _a && IsValid( _a ) && _a:IsPlayer() then
	
		if ( !self:PlayerShouldTakeDamage( _p , _a ) ) then
		
			return _di
			
		end
		
	end

	if _p:Alive() then
	
		if _hg == HITGROUP_HEAD then
			_dscale = _dscale+.5
		end
		local _rand = math.random(100);
		if _rand > 95 then
		if _hg == HITGROUP_HEAD then
			
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_CHEST || _hg == HITGROUP_GENERIC then
		
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/hitingut0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/hitingut0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_LEFTARM || _hg == HITGROUP_RIGHTARM then
		
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/myarm0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/myarm0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_GEAR then

			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/startle0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/startle0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_RIGHTLEG || _hg == HITGROUP_LEFTLEG && !_p.__Crippled then
		
			_p.__Crippled = true;
			_p:SetWalkSpeed( fsrp.config.CrippleSpeed )
			_p:SetRunSpeed( fsrp.config.CrippleSpeed )
			_a:Notify("legged him ya shagger")
			_p:Notify( "Your legs have been broken! You should seek a medic!" )
			
			
			if _p:getGender() == 1 then
			
				_ds = Sound('vo/npc/female01/myleg0' .. math.random(1, 2) .. '.wav');
				
			else
			
				_ds = Sound('vo/npc/male01/myleg0' .. math.random(1, 2) .. '.wav');
			
			end
			
		else
		
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/pain0"..math.random(1, 9)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/pain0"..math.random(1, 9)..".wav");
			
			end
			
		end // Hitgroup
		end
		sound.Play( _ds , _p:GetPos() , 100 , 100 );
		
	end // IsAlive()


	// 1-AR,2-Sub,3-Shotgun,4-Sniper,5-Grenade
	local _RotoLevelType = _wepTypeToLevel[_weaponType];
	local _wl = 1;
	if _RotoLevelType and _a:GetRotoLevel(_RotoLevelType) then
		_wl = _a:GetRotoLevel(_RotoLevelType)[1];
	end
	_dscale = _dscale + (_wl*0.01);
	_a:AddRotoXP(_RotoLevelType,(RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_wl))/4)		
	_p:AddRotoXP(4,(RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_wl))/4)
	
	if _p:Team() == TEAM_POLICE then
	
		_dscale=_dscale-.1;
		
	end
	_di:ScaleDamage( _dscale )
	
	return _di;
end	// Function

local spawnPoints = {}
spawnPoints[TEAM_POLICE] = {
	["rp_downtown_tits_v2"] = {
		{pos=Vector(-1858.7957763672,229.21594238281,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1858.7957763672,129.21594238281,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1858.7957763672,29.215942382813,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1934.1904296875,231.69378662109,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1934.1904296875,131.69378662109,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1934.1904296875,31.693786621094,-159.96875),ang=Angle(0,-1.882374048233,0)};
	};
};
							
spawnPoints[TEAM_SWAT] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_PARAMEDIC] = spawnPoints[TEAM_POLICE]
								
							
spawnPoints[TEAM_MAYOR] = spawnPoints[TEAM_POLICE]

spawnPoints[TEAM_CIVILLIAN] =	{
	["rp_downtown_tits_v2"] = {
		{pos=Vector(-1613.76171875,-1261.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1361.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1461.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1561.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1661.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1761.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1861.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1961.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-2061.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-2161.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1705.2409667969,-1258.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1358.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1458.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1558.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1658.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1758.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1858.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1958.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-2058.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-2158.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};

		{pos=Vector(-2081.873046875,-1342.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1442.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1542.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1642.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1742.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1842.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1942.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-2042.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-2142.951171875,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-2242.951171875,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2222.7177734375,-1340.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1440.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1540.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1640.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1740.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1840.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1940.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-2040.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-2140.4755859375,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-2240.4755859375,-195.96875),ang=Angle(0,178.9934387207,0)};
	};
}
/*
for i=1,50  do

	table.insert( spawnPoints[TEAM_CIVILLIAN] , {pos = Vector(-6965.151855, -10876.811523, 240), ang = Angle(0.000, 90.000, -0.000)} )
	Player(5):PrintMessage( HUD_PRINTCONSOLE , "{pos = Vector( " .. -3000 - (i*75) + 25 .." , -10876.811523, 240), ang = Angle(0.000, 90.000, -0.000)}," )
end*/

local otherServerSpawns = {}
otherServerSpawns[TEAM_CIVILLIAN] = {

	["rp_downtown_tits_v2"] = {
		{pos=Vector(-1613.76171875,-1261.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1361.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1461.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1561.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1661.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1761.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1861.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-1961.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-2061.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1613.76171875,-2161.2446289063,-195.96875),ang=Angle(0,-3.202565908432,0)};
		{pos=Vector(-1705.2409667969,-1258.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1358.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1458.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1558.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1658.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1758.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1858.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-1958.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-2058.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};
		{pos=Vector(-1705.2409667969,-2158.4753417969,-195.96875),ang=Angle(0,1.2854335308075,0)};

		{pos=Vector(-2081.873046875,-1342.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1442.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1542.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1642.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1742.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1842.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-1942.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-2042.9510498047,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-2142.951171875,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2081.873046875,-2242.951171875,-195.96875),ang=Angle(0,178.59750366211,0)};
		{pos=Vector(-2222.7177734375,-1340.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1440.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1540.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1640.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1740.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1840.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-1940.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-2040.4757080078,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-2140.4755859375,-195.96875),ang=Angle(0,178.9934387207,0)};
		{pos=Vector(-2222.7177734375,-2240.4755859375,-195.96875),ang=Angle(0,178.9934387207,0)};
	};
} 
otherServerSpawns[TEAM_POLICE] = {

	["rp_downtown_tits_v2"] = {
		{pos=Vector(-1858.7957763672,229.21594238281,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1858.7957763672,129.21594238281,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1858.7957763672,29.215942382813,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1934.1904296875,231.69378662109,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1934.1904296875,131.69378662109,-159.96875),ang=Angle(0,-1.882374048233,0)};
		{pos=Vector(-1934.1904296875,31.693786621094,-159.96875),ang=Angle(0,-1.882374048233,0)};
	};
}
function ReturnSpawnPointForUser( user )

		local _JoinedFromOtherServer = user:HasPublicTag("JoinedFromOtherServer") ||nil;
		local _toFind = spawnPoints;
		if _JoinedFromOtherServer then
			_toFind = otherServerSpawns
		end
		if !IsValid(user) then return end
		if !_toFind[user:Team()] then return end
		if !_toFind[user:Team()][game.GetMap()] then return end
		
		local SafeSpawnArea = _toFind[user:Team()][game.GetMap()][math.random(1, #_toFind[user:Team()])];
		
		for _, each in pairs(_toFind[user:Team()][game.GetMap()]) do
			local nearbyEnts = ents.FindInSphere(each.pos, 75)
			
			local nearbyPlayer = false
			for _, ent in pairs(nearbyEnts) do
				if (ent && IsValid(ent) && ent:IsPlayer() && ent != user) then
					nearbyPlayer = true
				end
			end
			
			if (!nearbyPlayer) then
				SafeSpawnArea = each
				break
			end 
		end

		local MobileSpawn = ents.FindByClass('info_spawnpoint')[1];
		
		if !IsValid(MobileSpawn) then
			MobileSpawn = ents.Create('info_spawnpoint');
			MobileSpawn:SetPos(Vector(0, 0, 0));
			MobileSpawn:SetColor(Color(0, 0, 0, 0))
			MobileSpawn:Spawn();
		end
		
		MobileSpawn:SetPos(SafeSpawnArea.pos);
		MobileSpawn:SetAngles(SafeSpawnArea.ang);
		//print( "Selected position: " .. util.TypeToString(SafeSpawnArea.pos) )

			user:RemoveTag("JoinedFromOtherServer")

			ObjectTags.system.QueryIPSave( user:SteamID() , "192.223.31.168:27015" , function( rows,data, new )

				if new then
					
				else

				end
				
			end)
		return MobileSpawn;
		
end
chatcommands = {};

function GM:PlayerSay(ply, text, teamc, alive)
	
	
	return text
end

function GM:PlayerSelectSpawn ( user )
	
	return ReturnSpawnPointForUser( user )
end
