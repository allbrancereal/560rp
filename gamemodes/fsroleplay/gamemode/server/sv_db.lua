

fsrp.devprint("[560Roleplay] - Loading Database File" )
require( "mysqloo" )
//require( "tmysql" )

fsdb = {}
require("tmysql");
	
SQL_INFO_1 = "560rp.com";
SQL_INFO_2 = "master";
SQL_INFO_3 = "CvA8bAoXiF";
SQL_INFO_4 = "master_fsroleplay";

function initializeConnection()
	tmysql.initialize(SQL_INFO_1, SQL_INFO_2, SQL_INFO_3, SQL_INFO_4, 3306);	
	fsrp.devprint( "Database has connected!" )
end
hook.Add("Initialize", "connectDB", initializeConnection )

function fsdb:Query(query, Callback) 
			tmysql.query(query, function(result, status, error)
				if (type(Callback) == "function" and status == QUERY_SUCCESS) then
					Callback(result)
				elseif(status == QUERY_FAIL) then
					if (type(error) == "string" and error != "") then
						ErrorNoHalt("MySQL Query Failed: "..error);
					else
						
						ErrorNoHalt("MySQL Query Failed: "..query .. "\n".. error);
					end;
				end
			end)
		end
		
function createPlayer( _p )


	//setupClientBuisinessData( _p )
			//fsdb:Query( "UPDATE `fsdb_user` SET `model` = '1_1' WHERE `id`='" .. _p:SteamID() .. "'")	
			//fsdb:Query( "UPDATE `fsdb_user` SET `items` = '0,1,1;' WHERE `id`='" .. _p:SteamID() .. "'")
	local q = "INSERT INTO `fsdb_user` (`id`, `uid`, `steamid`, `first_name`, `last_name`,   `cash`,`bankcash`, `model`, `ammo_pistol`, `ammo_rifle`, `ammo_shotgun`,`ammo_sniper`, `bank_level` ) VALUES ('" .. _p:SteamID() .. "', '" .. _p:UniqueID() .. "', '" .. _p:Nick() .. "', 'John', 'Doe', '15000','5000', '1_1','0','0','0','0','0');";
	tmysql.query( q , function( result, status, error)
			
			//print( result )
			//print( error )
		if status == QUERY_FAIL then
			LoadPlayer( _p )
				if (type(error) == "string" and error != "") then
					ErrorNoHalt("MySQL Query Failed: "..error);
				else
					
					ErrorNoHalt("MySQL Query Failed: "..q .. "\n".. error);
				end;
				
		else
		
			LoadPlayer ( _p )
			
		end
	end)

end

function updateClientID( _p )
	
	fsdb:Query("UPDATE `fsdb_user` SET `steamid`='" .. _p:Nick() .. "' WHERE `id`='" .. _p:SteamID() .. "';");

end

function LoadPlayer( _p )
	local steamID = _p:SteamID()
	_p:Freeze( true )
	timer.Create( "SteamIDCheckTimer", 2, 1, function( )
	
		if !_p || !_p:IsValid() || !IsValid( _p ) then return end;
		_p.__Loaded = false;
		tmysql.query( "SELECT `id`, `first_name`, `last_name`, `cash`,`bankcash`, `model`, `ammo_pistol`, `ammo_rifle`, `ammo_shotgun`, `ammo_sniper`, `bank_level` FROM `fsdb_user` WHERE  `id`='" .. _p:SteamID( ) .. "';" , function ( result, status , err )
			 
			local data = result;
			if (!data && status == QUERY_FAIL || !data[1]) then
				
				
						
				createPlayer( _p )
					
					  
			else
		
					
					
			if (data[1][2] == "John" && data[1][3] == "Doe") then 
					
				_p.__SetUpData = true;

			end
			_p:SetPlayerTeam( 1 );
			if _p.__SetUpData then
					
				net.Start("fsrp.startUser")
				net.Send( _p )
				
			end
				
			--if !_p.__BuisinessTable then
			
				--_p.__BuisinessTable = {};
			
			--end
				//loadBuisinesses( _p )
			//fsrp.devprint( data[1][1])
			//fsrp.devprint( data[1][2])
			//fsrp.devprint( data[1][3])
			//fsrp.devprint( data[1][4])
			//fsrp.devprintTable( data[1][5])
			//fsrp.devprint( data[1][6])
			//fsrp.devprint( data[1][7])
			//fsrp.devprint( data[1][8])
			//fsrp.devprint( data[1][9])
			
			local modelInfo = ExplodeModelInfo(data[1][6]) or {};
			
			local theirNewModel = iterateModelTable(modelInfo.sex, tonumber(modelInfo.id) or 1);
			
			fsrp.devprint( theirNewModel.mdl .. " is what we are getting")
			_p:SetModel( theirNewModel.mdl ); 
			_p.__oModel = modelInfo;
			_p.__mSex = modelInfo.sex;
			_p:setClientGender(modelInfo.sex);
			
			_p.joinTime = CurTime();
			
			_p:setFirstName( data[1][2] )
			_p:setLastName( data[1][3] )
			_p:setMoney( tonumber( data[1][4] ) )
			_p:setBank( tonumber( data[1][5] ) )
			// data[1][5] = model?
			--saveBuisinesses( _p )
			//loadBuisinesses( _p )
			//saveBuisinesses( _p )
			_p:GiveAmmo( tonumber( data[1][7] ), 'pistol');
			_p:GiveAmmo( tonumber( data[1][8] ), 'smg1');
			_p:GiveAmmo( tonumber( data[1][9] ), 'buckshot');
			_p:GiveAmmo( tonumber( data[1][10] ), 'sniper');
			_p:setBankAccount( tonumber( data[1][11] ) )
			
			LoadBodygroups( _p )
			_p.__Loaded = true;	
			
			--if data[1][10] != "" then
			
				--_p:parseSaveString(data[1][10]);
				
			--end
			--net.Start("fsrp_init_items")
				--net.WriteString(tostring(data[1][10]))
			--net.Send( _p )
			//fsrp.devprint( _p:getFirstName() )
			//fsrp.devprint( _p:getLastName() )
			//fsrp.devprint( _p:getMoney() )
			//fsrp.devprint( _p.__Loaded )
					
			if steamID != data[1][0]  then
				updateClientID( _p )
			end
			
			fsdb_saveClient( _p )
			loadQuests( _p );
			end
			
		end )
		
	end )
	
end 
hook.Add( "PlayerInitialSpawn", "loadPlayer", LoadPlayer )

hook.Add( "PlayerDisconnected", "fsdb_savePlayerOnDC", function( _p )
		
		
		fsrp.devprint("[560Roleplay] - (1/2) Someone has disconnected. Saving player.")
		fsdb_saveClient( _p );
		saveBuisinesses( _p )
		fsrp.devprint("[560Roleplay] - (2/2) Saved player.")
	
end );


	//
	// Save on x interval..
	//
timer.Create( "saveInterval", 60 * 30, 0, function( )

	fsrp.devprint("[560Roleplay] - (1/2) 30 Minutes has passed, saving.")
	fsdb.saveWeather()
	for k, _p in pairs( player.GetAll( ) ) do
		
		if ( !IsValid( _p ) ) then continue; end
		
		fsdb_saveClient( _p );
		saveBuisinesses( _p )
	
	end
	
	fsrp.devprint("[560Roleplay] - (1/2) Saved every player.")

	
end );



hook.Add( "ShutDown", "fsdb_saveGameOnShutdown", function( )
	
	fsrp.devprint("[560Roleplay] - (1/2) Shutting Down - Attempting to save every player.")
	fsdb.saveWeather()
	for k, _p in pairs( player.GetAll( ) ) do
	if ( !IsValid( _p ) ) then continue; end
		fsdb_saveClient( _p );
		saveBuisinesses( _p )

	end
	
	fsrp.devprint("[560Roleplay] - (2/2) Saved every player.")

end );

function fsdb_saveClient( _p )
	local _pM = math.ceil( _p:getMoney()) || 15000;
	local _pBM = math.ceil( _p:getBank()) || 5000;

	//saveBuisinesses( _p )
	//local compiledItems = _p:CompileItems() || "";
	//fsdb:Query("UPDATE `fsdb_user` - WHERE `id`='" .. _p:SteamID() .. "';");
	fsdb:Query("UPDATE `fsdb_user` SET `steamid` ='" .. _p:Nick() .. "' , `first_name` = '" .. _p:getFirstName() .. "' , `last_name` = '" .. _p:getLastName( ) .. "' ,`cash` = '" .. _pM .. "' , `bankcash` = '" .. _pBM .. "',`ammo_pistol` = '" .. _p:GetAmmoCount("pistol")  .. "' ,`ammo_rifle` = '" ..  _p:GetAmmoCount("smg1") .. "' ,`ammo_shotgun` = '" ..  _p:GetAmmoCount("buckshot")  .. "' ,`ammo_sniper` = '" ..  _p:GetAmmoCount("sniper")  .. "', `bank_level` = '" .. _p:getBankAccount() .."' WHERE `id`='" .. _p:SteamID() .. "';");

end

function fsdb_changeSex( _p )
	if !_p then return end
		
		// Model Stuff
		local newSex = "m";
		if (_p:getGender() == 2) then newSex = "f"; end
		
		local modelInt = 2;
		if (newSex == "f") then modelInt = 1; end

		local theirNewModel = iterateModelTable(modelInt or 1, math.random(1,4));
		//print( newSex );

		_p:SetModel(theirNewModel.mdl);
		_p.__oModel = theirNewModel;
		tmysql.query("UPDATE `fsdb_user` SET `model`='" .. modelInt .. "_1' WHERE `id`='" .. _p:SteamID() .. "'", function( result, status, error)
			if status == QUERY_FAIL then
				
				if (type(error) == "string" and error != "") then
					ErrorNoHalt("MySQL Query Failed: "..error);
				else
					ErrorNoHalt("MySQL Query Failed: (Update - Player - Sex) \n".. error);
				end;	
				
			end
		
		end)
		_p:setClientGender( modelInt);
		_p.__mSex = modelInt
		fsrp.UpdateClientGender( _p , modelInt )


end

function fsdb_changeModel( _p, str )
	if !_p then return end
	
	//if !str then return end;	
	fsrp.devprint( str )
	
	// Model Stuff
	local modelInfo = ExplodeModelInfo(str);
	//PrintTable(modelInfo)
	if (!modelInfo) then return; end
	local newSex = 2;
	if (modelInfo.sex == 1) then newSex = 1; end
	if (tonumber(modelInfo.sex) == 2) then newSex = 2; end
	if (_p:getGender() != newSex) then return false; end
	if (_p.__mClothes == modelInfo.id) then return; end
		
	local theirNewModel = _p:GetModelPath(modelInfo.sex or 1,  tonumber(modelInfo.id) or 1);
	fsrp.devprint( theirNewModel )
	_p:SetModel(theirNewModel.mdl);
	_p.__oModel = theirNewModel;
	
	tmysql.query("UPDATE `fsdb_user` SET `model`='" .. modelInfo.sex .. "_" .. modelInfo.id.. "' WHERE `id`='" .. _p:SteamID() .. "'", function( result, status, error )
		if status == QUERY_FAIL then
				
			if (type(error) == "string" and error != "") then
				ErrorNoHalt("MySQL Query Failed: "..error);
			else
				ErrorNoHalt("MySQL Query Failed: (Update - Player - Sex) \n".. error);
			end;	
				
		end
	end)
	
	_p:setClientGender( modelInfo.sex or 1)
	//_p.__mClothes = modelInfo.clothes;
	//_p.__mFace = tonumber(modelInfo.face) or 1;
	return true;
end

function fsdb.saveWeather()
	if !SW then return end
	
	fsdb:Query("UPDATE `fsrptime` SET `time`='" .. math.Round(SW.Time, 2) .."';");		
	print("[560Roleplay] - Saving Weather, Value: " .. math.Round(SW.Time, 2 ) )


end

function fsdb.loadWeather()
	if !SW then return end
	
	print("[560Roleplay] - Fetching Weather")
	fsdb:Query("SELECT * FROM `fsrptime`;", function ( data )
		
		if data && data[1] && data[1][1] then

			SW.SetTime( tonumber(data[1][1]) )
			
		else
		
			fsdb:Query("INSERT INTO `fsrptime` (`time`) VALUES(" .. math.Round( SW.Time, 2 ) .. ")");
			
		end
		
	end)
	print("[560Roleplay] - Initialized Weather")

end
fsrp.devprint("[560Roleplay] - Initialized Database" )


		