

//require( "mysqloo" ) 
//require( "tmysql" )

fsdb = {}
require("mysqloo"); 
	
SQL_INFO_1 = ""; -- ip
SQL_INFO_2 = ""; -- user 
SQL_INFO_3 = ""; -- pass
SQL_INFO_4 = ""; -- database
function fsdb:Query(query, Callback) 
	tmysqlReroute(query,Callback)
end
local _db
_db = mysqloo.connect( SQL_INFO_1,SQL_INFO_2,SQL_INFO_3,SQL_INFO_4, 3306 )
function _db:onConnected()

    print( "GM:Database has connected!" )

    local q = self:query( "SELECT 5+5" )
    function q:onSuccess( data )

        print( "GM:DB:Query successful!" )
        PrintTable( data )

    end

    function q:onError( err, sql )

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )

    end

    q:start()

end

function _db:onConnectionFailed( err )

    print( "Connection to database failed!" )
    print( "Error:", err )

end

_db:connect()
/*
fsdb:Query( "SELECT version()" , function( result ) 

	fsrp.RetrievePermanentData()

	
end ) 

hook.Add("Initialize", "connectDB", initializeConnection )
*/
function tmysqlReroute(q,Callback)
	
	local query = _db:query(q)


	query.onSuccess = Callback

	function query:onError(err)
		print("An error occured while executing the query: " .. err)
	end

	query:start()
end
function GetSVDB()
	return _db
end
// Ban listener

gameevent.Listen( "player_connect" )
hook.Add( "player_connect", "player_connect_example", function( data )
	local name = data.name			// Same as Player:Nick()
	local steamid = data.networkid	// Same as Player:SteamID()
	local ip = data.address			// Same as Player:IPAddress()
	local id = data.userid			// Same as Player:UserID()
	local bot = data.bot			// Same as Player:IsBot()
	local index = data.index		// Same as Player:EntIndex()
	local _pre = "";
	
	// Player has connected; this happens instantly after they join -- do something..
	fsdb:Query( "SELECT * FROM `fs_bans` WHERE `steamid`='" .. steamid .. "';" , function( _,data , status, error )
		local result = data;
		
		if result && result[1]  then
			
			if tonumber( result[1]["expireddate"] ) != tonumber( result[1]["dateof"] ) && tonumber( result[1]["expireddate"] ) < os.time( ) &&  tobool(result[1]["restrictip"]) != true then
				
				//UnbanPlayer( steamid )
				//PrintAdmin( "Unbanned " .. name .. " ( " .. steamid .. " , " .. ip .. " ) from the game." )
				//PrintAdmin( "Ban Reason:" .. result[1][4] )
				PrintAdmin( "Detected bans for player: " .. name .. " ( " .. steamid .. " , " .. ip .. " ) ( Length: " .. ( tonumber( result[1][3] ) - tonumber( result[1][5] ) ) .. " ,Reason: " .. result[1][4] .. " )" )
				print( "Detected bans for player: " .. name .. " ( " .. steamid .. " , " .. ip .. " ) ( Length: " .. ( tonumber( result[1][3] ) - tonumber( result[1][5] ) ) .. " ,Reason: " .. result[1][4] .. " )" )
			else 
			 	
				if tonumber( result[1]["expireddate"] ) == tonumber( result[1]["dateof"] ) ||  tobool(result[1]["restrictip"]) == true  then
				
					_pre = "Permanently ";
				
				end
				local _banType = tobool(result[1]["restrictip"]) == true && "Banned By IP:" || "Banned:"
				
				game.KickID( steamid , _pre .. _banType .. " (" ..  result[1]["reason"] .. ") Appeal at the steam group." )		
			
			end
			
		else
		
			fsdb:Query( "SELECT * FROM `fs_bans` WHERE `ip`='" .. ip .. "';" , function( _,data, status, error )
					result = data;
					
					if result then
						
						if !result[1] then return end
					
						if result[1]["steamid"] == steamid  then return end
						
						if tonumber( result[1]["expireddate"] ) != tonumber( result[1]["dateof"] ) && tonumber( result[1]["expireddate"] ) < os.time( )  &&  tobool(result[1]["restrictip"]) != true then
				
							//UnbanPlayer( steamid )
							//PrintAdmin( "Unbanned " .. name .. " ( " .. steamid .. " , " .. ip .. " ) from the game." )
							//PrintAdmin( "Ban Reason:" .. result[1][4] )

							PrintAdmin( "Detected bans for player: " .. name .. " ( " .. steamid .. " , " .. ip .. " ) ( Length: " .. ( tonumber( result[1]["expireddate"] ) - tonumber( result[1]["dateof"] ) ) .. " ,Reason: " .. result[1]["reason"] .. " )" )
							print( "Detected bans for player: " .. name .. " ( " .. steamid .. " , " .. ip .. " ) ( Length: " .. ( tonumber( result[1]["expireddate"] ) - tonumber( result[1]["dateof"] ) ) .. " ,Reason: " .. result[1]["reason"] .. " )" )

						elseif tobool(result[1]["restrictip"]) == true || tonumber( result[1]["steamid"] ) == "" then
						
							if tonumber( result[1]["expireddate"] ) == tonumber( result[1]["dateof"] ) then
							
								_pre = "Permanently ";
							
							end
							local _banType = tobool(result[1]["restrictip"]) == true && "Banned By IP:" || "Banned:"
				
							
							game.KickID( steamid ,_banType .. " (" ..  result[1]["reason"].. ") Appeal at the steam group."  )		
						
						end
						
							
			
					end
				
			end )
				
		end
	
		
	end )
	
end )
function UnbanPlayer( steamid ) 

	fsdb:Query( "DELETE FROM `fs_bans` WHERE `steamid`='" .. steamid .. "'; " );
	
end
local _pMeta = FindMetaTable( 'Player' )
function _pMeta:SaveDailyReward()
	local _rewardTable = self:getFlag("rotodailyreward","")
	if isstring(_rewardTable) then
		fsdb:Query("UPDATE `fsdb_characterdata` SET `LoginReward`='" .. _rewardTable .. "' WHERE `id`='".. self:SteamID() .."'")
	end
end

function OfflineIPBan( _ip, administrator , length, reason, permaIP )
	
	
	local _timeStamp = os.time() ;
	local _expiryDate = _timeStamp+length
	
	local _banReason = "Banned by: " .. administrator .. "\nNo given reason";
	if reason then 
	
		_banReason = reason
	
	else
	
		for k , v in pairs( player.GetAll() ) do
		
			if v:IsSuperAdmin() then
			
				v:Notify( administrator .. " banned " .. _ip .. " without a reason!" );
				
			end
			
		end
		
	end
	local banIP = "0";
	if permaIP then
		
		banIP = "1"
		_expiryDate = 0
	
	end
	
	fsdb:Query( "INSERT INTO `fs_bans` ( `steamid`, `ip`,  `expireddate`, `reason`, `dateof`, `restrictip` ) VALUES( '' , '" .. _ip .. "' , '" .. _expiryDate .. "' , '" .. _banReason .. "' , '" .. _timeStamp .. "' , " .. banIP .. " );" );
	
end
function OfflineFullBan( _steamid, _ip , administrator , length, reason, permaIP )
	
	
	local _timeStamp = os.time() ;
	local _expiryDate = _timeStamp+length
	
	local _banReason = "Banned by: " .. administrator .. "\nNo given reason";
	if reason then 
	
		_banReason = reason
	
	else
	
		for k , v in pairs( player.GetAll() ) do
		
			if v:IsSuperAdmin() then
			
				v:Notify( administrator .. " banned " .. _steamid .. " without a reason!" );
				
			end
			
		end
		
	end
	local banIP = "0";
	if permaIP then
		
		banIP = "1"
		_expiryDate = 0
	
	end
	
	fsdb:Query( "INSERT INTO `fs_bans` ( `steamid`, `ip`,  `expireddate`, `reason`, `dateof`, `restrictip` ) VALUES( '" .. _steamid .. "' , '" .. _ip .. "' , '" .. _expiryDate .. "' , '" .. _banReason .. "' , '" .. _timeStamp .. "' , " .. banIP .. " );" );
	
end
function OfflineSteamIDBan( _steamid, administrator , length, reason, permaIP )
	
	
	local _timeStamp = os.time() ;
	local _expiryDate = _timeStamp+length
	
	local _banReason = "Banned by: " .. administrator .. "\nNo given reason";
	if reason then 
	
		_banReason = reason
	
	else
	
		for k , v in pairs( player.GetAll() ) do
		
			if v:IsSuperAdmin() then
			
				v:Notify( administrator .. " banned " .. _steamid .. " without a reason!" );
				
			end
			
		end
		
	end
	local banIP = "0";
	if permaIP then
		
		banIP = "1"
		_expiryDate = 0
	
	end
	
	fsdb:Query( "INSERT INTO `fs_bans` ( `steamid`, `ip`,  `expireddate`, `reason`, `dateof`, `restrictip` ) VALUES( '" .. _steamid .. "' , '' , '" .. _expiryDate .. "' , '" .. _banReason .. "' , '" .. _timeStamp .. "' , " .. banIP .. " );" );
	
end

function _pMeta:BanPlayer( administrator, length, reason, permaIP )
	local _steamid = self:SteamID()
	local _ip = self:IPAddress( );
	local _timeStamp = os.time() ;
	local _expiryDate = _timeStamp+length
	
	local _banReason = "Banned by: " .. administrator .. "\nNo given reason";
	if reason then 
		local _bool = "False"
		if tobool(permaIP) then 

			_bool = "True"

		end
		
		_banReason = "Banned by: " .. administrator .. " (" .. reason .. ") (IP:" .. _bool  .. ")"
	
	else
	
		for k , v in pairs( player.GetAll() ) do
		
			if v:IsSuperAdmin() && v != self then
			
				v:Notify( administrator .. " banned " .. self:Nick() .. " (" .. _steamid .. ") without a reason!" );
				
			end
			
		end
		
	end
	local banIP = "0";
	if permaIP then
		
		banIP = "1"
		_expiryDate = 0
	
	end
	self:Kick( _banReason )
	fsdb:Query( "INSERT INTO `fs_bans` ( `steamid`, `ip`,  `expireddate`, `reason`, `dateof`, `restrictip` ) VALUES( '" .. _steamid .. "' , '" .. _ip .. "' , '" .. _expiryDate .. "' , '" .. _banReason .. "' , '" .. _timeStamp .. "' , " .. banIP .. " );" );
	
end
function GiveStarterPackage(_p)
	_p:AddItemByID( 44 )
	_p:AddItemByID( 44 )
	_p:AddItemByID( 95 )
	_p:AddItemByID( 36 )
	_p:AddItemByID( 79 )
	_p:AddItemByID( 137 )
	_p:SetFreeSkillPoints(5)
	_p:SetRank(10)
end
function createPlayer( _p )


	//setupClientBusinessData( _p )
			//fsdb:Query( "UPDATE `fsdb_user` SET `model` = '1_1' WHERE `id`='" .. _p:SteamID() .. "'")	
			//fsdb:Query( "UPDATE `fsdb_user` SET `items` = '0,1,1;' WHERE `id`='" .. _p:SteamID() .. "'")
			
	if !IsValid(_p) then return end
	local q = "INSERT INTO `fsdb_user` (`id`, `uid`, `steamid`, `first_name`, `last_name`, `time_played`,  `cash`,`bankcash`, `model`, `ammo_pistol`, `ammo_rifle`, `ammo_shotgun`,`ammo_sniper`, `ammo_submachine`,`bank_level` , `adminrank`, `LastPrimary`, `LastSecondary`, `LastHat`, `org`,`inv` ) VALUES ('" .. _p:SteamID() .. "', " .. _p:UniqueID() .. ", 'XYZ', 'John', 'Doe', 0,50000,25000, '1',0,0,0,0,0,0,'10', 0,0,0,0,'' );";
	//fsdb:Query( "INSERT INTO `fsdb_characterdata` ( `id`, `business`, `skills`, `knownrecipes` ) VALUES ('" .. _p:SteamID() .. "' , '','','') ;" )
	tmysqlReroute( q , function( result )
			
		LoadPlayer ( _p )
			timer.Simple(1, function()
					_p:AddItemByID( 44 )
					_p:AddItemByID( 44 )
					_p:AddItemByID( 95 )
					_p:AddItemByID( 36 )
					_p:AddItemByID( 79 )
					_p:AddItemByID( 137 )
					_p:SetFreeSkillPoints(5)
					_p:SetRank(10)

			end )

	end)
	
end

function updateClientID( _p )
	
	fsdb:Query("UPDATE `fsdb_user` SET `steamid`='" .. _p:Nick() .. "' WHERE `id`='" .. _p:SteamID() .. "';");

end
function reloadInvFromDB( _p ) 

		if !_p || !_p:IsValid() || !IsValid( _p ) then return end;
		
		tmysqlReroute( "SELECT `inv` FROM `fsdb_user` WHERE  `id`='" .. _p:SteamID( ) .. "';" , function ( _,data, status , err )
			 
			
			if !data[1]["inv"] then return false; end
			
				_p:LoadStringToInventory( data[1]["inv"] )
			
			return
		end)
		
		
		
end

function fsrp.LoadOrganization( orgID )

	if !fsrp.orgs then
	
		fsrp.orgs = {}
		
	end
	
	if !fsrp.orgs[orgID] then
	
		fsrp.orgs[orgID] = true;
		
	end

end

function fsrp.RemoveOrganizationFromCache( orgID )

	if fsrp.orgs then
	
		fsrp.orgs[orgID] = nil;
	
	end

end

function fsrp.NetworkOrganizations()
	
	if !fsrp.orgs then
	
		fsrp.orgs = {}
		
	end
	
	if #player.GetAll() > 0 then
		net.Start("updateClientOrgDefinitions")
		net.WriteTable( fsrp.orgs )
		net.Broadcast()
	end
end

net.Receive( "sendOrgChange" , function ( _l , _p )

	local _id = _p:getFlag("organization" , nil)
	local _name = net.ReadString()
	local _newEntry = net.ReadString()
	
	if !fsrp.IsValidOrgName( _name ) then return _p:Notify( "Your name has illegal characters in it." ) end
	if !fsrp.IsValidOrgName( _newEntry ) then return _p:Notify( "Your MOTD has illegal characters in it." ) end
	
	if !_id then return end
	
	if !fsrp.orgs[_id] then return end
	
	local _org = fsrp.orgs[_id]

	if _org[4] != _p:SteamID() then return _p:Notify( "You may not change the organization." ) end
	
	local _newMotd = _newEntry
	local _newName = _name
	
	_p:SetOrganizationStatus( _newName , _newMotd )
	fsrp.NetworkOrganizations()
end )


net.Receive( "kickFromOrg" , function( _l , _p )

	local _id = _p:getFlag("organization",nil)
	local _name = net.ReadString()
	
	local _owner = player.GetBySteamID(fsrp.orgs[_id][4])
	
	if _p != _owner then return _p:Notify( "You are not the owner of this organization, you may not kick them." ) end
	
	
	if _owner then
	
		_owner:Notify( _name .. " has been removed from the organization." )
	
	end
	
	for k , v in pairs( fsrp.orgs[_id][6] ) do
	
		if v == _name then
		
			table.remove( fsrp.orgs[_id][6] ,k )
				
			break
			
		end
	
	end

	for k , v in pairs( player.GetAll() ) do
		
		if v:getRPName() == _name then
			
			v:Notify( "You have been kicked from your organization by " .. _owner:getRPName() );
			v:setFlag("organization",nil)

			break

		end

	end

	fsdb:Query( "UPDATE `fsdb_user` SET `org`=0 WHERE `last_name` = '" .. string.Explode( " " , _name )[2] .."' and `first_name` = '" .. string.Explode( " " , _name )[1] .. "';" );
		
	fsrp.NetworkOrganizations()
	
end )

util.AddNetworkString( "ReInviteToOrg" )
net.Receive( "ReInviteToOrg" , function( _l , _p ) 

	local _orgID =  _p:getFlag("orgToJoin", nil);
	local _orgFromClient = net.ReadInt( 32 )
	local _acceptance = net.ReadBool()

	_p:setFlag("orgToJoin" , nil)
	if _orgID == nil || _orgID == 0 then
		
		return _p:Notify( "Our server lost track of your organization to join. Try getting another invite!")

	end

	
	local _org = fsrp.orgs[_orgID];
	_org[1] = _orgID;

	if !_org then
		
		return _p:Notify( "This organization has been disbanded while you got the invite." )

	end


	if !_acceptance && player.GetBySteamID( _org[4] ) then 

		fsrp.NetworkOrganizations()
		return player.GetBySteamID( _org[4] ):Notify( _p:getRPName() .. " has declined your invite.");

	end

	table.insert( _org[6], _p:getRPName() );
	
	
	_p:SetMemberOrganization( _org[1] );
	_p:Notify( "You have been added to the organization called: " .. _org[2] .. " by the leader, " .. _org[5] .. ".");
	for k , v in pairs( player.GetAll( ) ) do
		
		local _porg = v:getFlag("organization", nil )

		if _porg && _porg != 0 && fsrp.orgs[_porg] && _porg == _orgID && v != _p then
			
			v:Notify( _p:getRPName() .. " has joined the organization." )

		end

	end

	fsrp.orgs[_orgID] = _org;

	fsrp.NetworkOrganizations()

end )
util.AddNetworkString( "OrganizationInvite" )
net.Receive( "InviteToOrg" , function( _l , _p ) 

	local _orgInv = net.ReadString()
	local _orgID = _p:getFlag("organization" , nil )
	local _org = fsrp.orgs[_orgID];


	if !_org then
		
		return _p:Notify( "You must be in an organization to invite someone." )

	end

	if _org[4] != _p:SteamID() then
		
		return _p:Notify( "You must own the current organization that your are in to invite someone." )

	end

	local _playerFromID = player.GetBySteamID( _orgInv );

	if _playerFromID:getFlag("orgToJoin",nil) then 

		return _p:Notify( "This player is already being invited to an organization" ) 

	end

	if !_playerFromID then
		
		return _p:Notify( "The player you selected is invalid, they may have gone offline!" );

	end

	local _playerFromIDOrg = _playerFromID:getFlag("organization", nil )

	if _playerFromIDOrg != nil && _playerFromIDOrg != 0 then
		
		return _p:Notify( "This person is in an organization already, you may not invite them." )

	end

	local _orgMembers = _org[6];

	if table.HasValue( _orgMembers , _playerFromID:getRPName( ) ) then
		
		return _p:Notify( "This person is already in your organization." );

	end
	_playerFromID:setFlag("orgToJoin", _orgID )

	net.Start("OrganizationInvite")
		net.WriteInt(_orgID , 32 )
		net.WriteTable(_org);

	net.Send( _playerFromID )
	_p:Notify("You have invited " .. _playerFromID:getRPName() .. " successfully.")


end )

function CleanupOrgs ()

	local _orgs = {};

	print( "Cleaning up organizations.")

	for k , v in pairs( player.GetAll() ) do
		
		if v:getFlag("organization", nil) != nil && v:getFlag("organization", nil) != 0 then
			
			if !_orgs[v:getFlag("organization", nil)] then
				
				_orgs[v:getFlag("organization", nil)] = v:getFlag("organization", nil );

			end


		end

	end

	fsrp.orgs = {};

	i = 0;
	for k , v in pairs( _orgs ) do
		
		fsrp.LoadOrg( v )
		
		i = i + 1;

	end

	print( "Cleaned up organizations, #" .. i .. " survived." )

	fsrp.NetworkOrganizations()

end
	

function _pMeta:SetOrganizationStatus( name , motd )
	
	local _id = self:getFlag("organization",nil)
	local foundName = nil
	local foundID = nil;
	for k ,v in pairs( fsrp.orgs ) do
		
		if v[2] == name then
			foundID = v[1];
			foundName = true;

		end

	end
	
	if foundName then
		
		if foundID != _id then
			
			return self:Notify( "You may not imitate a organization." )

		end

	end
	fsrp.SetOrganizationStatus( _id , name , motd ) 
	
end 

function fsrp.SetOrganizationStatus( id , name , motd )
	
	if !id then return end
	
	fsrp.orgs[id][2] = name
	fsrp.orgs[id][3] = motd
		
	fsdb:Query( "UPDATE `fs_orgs` SET `name` = '" .. name .. "', `motd` = '" .. motd .. "'WHERE `id` = '" .. id ..  "';" ); 

	if player.GetBySteamID( fsrp.orgs[id][4] ) then
		
		player.GetBySteamID( fsrp.orgs[id][4] ):Notify( "Your Organization has been updated." )	
	
	end
	
	fsrp.NetworkOrganizations()
	
end

function fsrp.LoadOrg( orgID )

	if !fsrp.orgs then
	
		fsrp.orgs = {}
		
	end
	
	local _orgInfo = nil;

	if fsrp.orgs and !fsrp.orgs[orgID] then
	
			fsdb:Query( "SELECT * FROM `fs_orgs` WHERE `id` = '" .. orgID .. "';" , function( _,result )

				if result && result[1] then
					
					_orgInfo = result[1];
					
				end
				
				if _orgInfo then 
					
					fsdb:Query( "SELECT `first_name`, `last_name` FROM `fsdb_user` WHERE `id` = '" .. _orgInfo["owner"] .. "';", function(_, results )
						
						if results[1] && results[1]["first_name"] then
						
							fsdb:Query( "SELECT `first_name`, `last_name` FROM `fsdb_user` WHERE `org` = '" .. tonumber(_orgInfo["id"]) .. "';" , function( _,_orgMembers )
							/*
								if _orgMembers[1] then
									
									for
								*/
									local _orgMemberNametable = {}
									
									for k , v in pairs( _orgMembers ) do
											
										if v[1] != results[1]["first_name"] then
									
											table.insert( _orgMemberNametable, v["first_name"] .. " " .. v["last_name"] );
										
										end
										
									end
									
									fsrp.orgs[orgID] = { tonumber( _orgInfo["id"] ), _orgInfo['name'] , _orgInfo["motd"] , _orgInfo["owner"] , results[1]["first_name"].. " " .. results[1]["last_name"], _orgMemberNametable} 
									
									fsrp.NetworkOrganizations()
								
								end)
							
						end
							
						end) 
						
					 
					
				else
				
					ErrorNoHalt( "No organization by ID #" .. orgID .. " has been found, aborting." )
					
				end
					

			end );		
	
	else

		fsrp.NetworkOrganizations()	
		
	end
	
end

for k , v in pairs( player.GetAll() ) do 
	if v and IsValid(v) then
		v:FullNWSync()
	end
end

function _pMeta:DisbandOrganization( )
	local _orgId = nil
	
	local _org = self:getFlag("organization", nil)

	if _org == nil || _org == 0 then return self:Notify( "You must be in an organization to disband it." ) end
	
	fsdb:Query( "SELECT * FROM `fs_orgs` WHERE `owner` = '" .. self:SteamID() .. "';" , function( _,result )

		if result && result[1] then
			
			_orgId = result[1]["id"];
			fsrp.orgs[_orgId] = nil;
						
			fsrp.NetworkOrganizations()
			fsdb:Query( "UPDATE `fsdb_user` SET `org`=0 WHERE `org` = " .. _orgId ..";" );
			
			fsdb:Query( "DELETE FROM `fs_orgs` WHERE `owner` = '" .. self:SteamID() .. "';" , function( result )


			end );
			
			self:SetRotoLevel(19,1)
			self:SetMemberOrganization( 0 )
			
			self:Notify( "Your Organization has been disbanded." )	
			self:setFlag("organization", nil )
		
		end
		
	
	end );
	
	
	
end
function _pMeta:LeaveOrganization( )

	if self:getFlag("organization",nil) == nil || self:getFlag("organization",nil) == 0 then return self:Notify("You must be in an organization to leave it.") end
	
	if self:getFlag("organization",nil) && fsrp.orgs[self:getFlag("organization",nil)][4] == self:SteamID() then return self:Notify("You must disband the organization to leave.") end
	
	for k , v in pairs( fsrp.orgs[self:getFlag("organization",nil)][6] ) do
	
		if v == self:getRPName() then
		
			table.remove( fsrp.orgs[self:getFlag("organization",nil)][6] ,k )
				
			break
			
		end
	
	end
	
	self:SetRotoLevel(19,1)	
	self:SetMemberOrganization( 0 )
	self:Notify( "You have left your organization.")
	fsrp.NetworkOrganizations()
	
end

function _pMeta:SetMemberOrganization( ID )

	fsdb:Query( "UPDATE `fsdb_user` SET `org` = " .. ID .. " WHERE `id` = '" .. self:SteamID() ..  "';" ); 
	self:setFlag( "organization" , ID ) 
	
end 

local function UpdateOrganization( name , self ,_foundOrg )
		
	if _foundOrg then 
		
		return self:Notify( "You may not create a organization when you own one already, disband it!")
			
	end
		
	fsdb:Query( "INSERT INTO `fs_orgs`  ( `name` , `motd` , `owner` ) VALUES( '" .. name .. "' , 'This is your MOTD! Change it to let everyone know the latest news!', '" .. self:SteamID() .. "' ) ; " )
	
	local _orgId = nil;
	timer.Simple( 1, function() 
		
		fsdb:Query( "SELECT * FROM `fs_orgs` WHERE `owner` = '" .. self:SteamID() .. "';" , function( _,result )

			if result && result[1] then
				
				_orgId = result[1]["id"];
				fsrp.orgs[_orgId] = { _orgId , name , "This is your MOTD! Change it to let everyone know the latest news!", self:SteamID(), self:getRPName(), {} };
				
				self:SetMemberOrganization( _orgId )
				
				fsrp.NetworkOrganizations()
				
		
				self:Notify( "Organization has been updated." )
			end

		end );

	end )
	
end
hook.Add( "VerifiedOrganization", "ChangePlayerOrg", UpdateOrganization )

function _pMeta:MakeOrganization( name )
	local _foundOrg = nil;
	
	if self:getFlag("organization",nil ) != nil && self:getFlag("organization",nil ) != 0 then 
		
		return self:Notify( "You may not start a organization when you are already within one" ) 
		
	end
	
	fsdb:Query( "SELECT * FROM `fs_orgs` WHERE `owner` = '" .. self:SteamID() .. "';" , function( _,result )

		if result && result[1] && result[1]["id"] then 
		
			_foundOrg = true;
			
		end
		
		
		hook.Run( "VerifiedOrganization", name , self , _foundOrg )
		
	end );
	
end 
function FetchAllOrgs()
	for k , v in pairs(player.GetAll()) do
		tmysqlReroute( "SELECT `org` FROM `fsdb_user` WHERE  `id`='" .. v:SteamID( ) .. "';",function(_ ,result)

			if result and result[1] then
				v:setFlag( "organization" , tonumber( result[1]['org'] ) )
				fsrp.LoadOrg(tonumber( result[1]['org'] ))
			end
			
		end)
	end
end
FetchAllOrgs()
function LoadPlayer( _p )

		if !_p || !_p:IsValid() || !IsValid( _p ) then return print("Player is not valid") end;
		local steamID = _p:SteamID()
		_p.__Loaded = false;

		tmysqlReroute( "SELECT  `id`, `first_name`, `last_name`, `cash`,`bankcash`, `model`, `ammo_pistol`, `ammo_rifle`, `ammo_shotgun`, `ammo_submachine`, `bank_level` , `inv`, `time_played`, `adminrank`, `ammo_sniper`, `LastPrimary`, `LastSecondary`, `LastHat`,`org` FROM `fsdb_user` WHERE  `id`='" .. _p:SteamID( ) .. "';",function(_ ,result)
		
			if (!result || !result[1] && !result[1] ) then
				PrintTable(result)
				createPlayer( _p ) 
							  
			else
			networkAllPropertyOwnersToClient();
			local data = {
				[1] = {
					[1] = result[1]["id"];
					[2] = result[1]["first_name"];
					[3] = result[1]["last_name"];
					[4] = result[1]["cash"];
					[5] = result[1]["bankcash"];
					[6] = result[1]["model"];
					[7] = result[1]["ammo_pistol"];
					[8] = result[1]["ammo_rifle"];
					[9] = result[1]["ammo_shotgun"];
					[10] = result[1]["ammo_submachine"];
					[11] = result[1]["bank_level"];
					[12] = result[1]["inv"];
					[13] = result[1]["time_played"];
					[14] = result[1]["adminrank"];
					[15] = result[1]["ammo_sniper"];
					[16] = result[1]["LastPrimary"];
					[17] = result[1]["LastSecondary"];
					[18] = result[1]["LastHat"];
					[19] = result[1]["org"];
				}
			}
			local _p = player.GetBySteamID(data[1][1]);
			if (data[1][2] == "John" && data[1][3] == "Doe") then 
					
				_p.__SetUpData = true;

			end
			_p:SetPlayerTeam( 1 );
			if _p.__SetUpData then
				print(_p:Nick().. " is creating a new character.")
				net.Start("fsrp.startUser")
				net.Send( _p )
				
			end
				
			--if !_p:GetBusinessTable() then
			
				--_p:GetBusinessTable() = {};
			
			--end
				//loadBusinesses( _p )
			//fsrp.devprint( data[1][1])
			//fsrp.devprint( data[1][2])
			//fsrp.devprint( data[1][3])
			//fsrp.devprint( data[1][4])
			//fsrp.devprintTable( data[1][5])
			//fsrp.devprint( data[1][6])
			//fsrp.devprint( data[1][7])
			//fsrp.devprint( data[1][8])
			//fsrp.devprint( data[1][9])
			
			//fsrp.devprint( theirNewModel.mdl .. " is what we are getting")
			//_p:SetModel( theirNewModel.mdl ); 
			_p.__oModel = modelInfo;
			
			_p:setClientGender( data[1][6] )
			_p.joinTime = CurTime();
				
			_p:setFirstName( data[1][2] )
			_p:setLastName( data[1][3] )
			_p:setMoney( tonumber( data[1][4] ) )
			_p:setBank( tonumber( data[1][5] ) )
			// data[1][5] = model?
			--saveBusinesses( _p )
			//loadBusinesses( _p )
			//saveBusinesses( _p )
			_p:SetAmmo( tonumber( data[1][7] ), 'pistol');
			_p:SetAmmo( tonumber( data[1][8] ), 'ar2');
			_p:SetAmmo( tonumber( data[1][9] ), 'buckshot');
			_p:SetAmmo( tonumber( data[1][10] ), 'smg1');
			_p:setBankAccount( tonumber( data[1][11] ));
			_p:setFlag( "inventory" , data[1][12] )
			_p:SetTimePlayed( tonumber(data[1][13]) )
			_p:SetRank( tonumber(data[1][14]) )
			_p:SetAmmo( tonumber( data[1][15] ), 'sniper');
			//_p:SetPlayTime( data[1][13] );
		
			_p:EquipLastWeapons( tonumber(data[1][16] ),tonumber(data[1][17] ),tonumber(data[1][18] ))
			_p:setFlag( "organization" , tonumber( data[1][19] ) )
			fsrp.LoadOrg( tonumber(data[1][19] ) )
			
			//_p:setFlag("orgID", 
			if _p:IsCouncilMember() then
			
				_p:Give("god_stick")
				
			end
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
			_p:setFlag("loadedIN", true )
			//fsrp.skills.helper.RetrieveSQLSkills( _p )
			print("x")
			fsdb_saveClient( _p )
			_p:LoadRPComputer()
			_p:LoadHatCoordinates()
			end
			
			if UserGroupTable().DisguiseOnJoin[ _p:getFlag('rank', 10 ) ] && UserGroupTable().DisguiseOnJoin[ _p:getFlag('rank', 10 ) ] == true then
			
				_p:ToggleDisguise()
				
			end
			hook.Run("LoadedPlayer",_p);
		end )
end 
//hook.Add( "PlayerInitialSpawn", "loadPlayer", LoadPlayer )

function _pMeta:SaveHatCoordinateEntry( )
	//if self:getFlag("loadedIn", false) == false then return end
	local _hatXYZString;
	local _hatXYZ = self:getFlag("hatXYZ",Vector(0,0,0));
	local _hatPYRString;
	local _hatPYR = self:getFlag("hatPYR",Angle(0,0,0));
	local _SQLStringReturn = "";
	
	_hatXYZString =  _hatXYZ.x .. "," .. _hatXYZ.y .. "," .. _hatXYZ.z
	_hatPYRString =  _hatPYR.p .. "," .. _hatPYR.y .. "," .. _hatPYR.r
	_SQLStringReturn = _hatXYZString .. ";" .. _hatPYRString;
	
	fsdb:Query("UPDATE `fsdb_characterdata` SET `hatcoords`='" .. _SQLStringReturn .. "' WHERE `id`='" .. self:SteamID() .. "';");

end
function _pMeta:CreateHatCoordinateEntry()
	//if self:getFlag("loadedIn", false) == false then return end

	fsdb:Query( "SELECT * FROM `fsdb_characterdata` WHERE `id`='" .. self:SteamID() .. "';" , function( _,result, status, error ) 
		
		
		if !result then
			
			// Set it up already
			fsdb:Query( "INSERT INTO `fsdb_characterdata` ( `id`, `business`, `skills`, `knownrecipes` , `computer`, `hatcoords`,`rating`,`PermData`,`LoginReward`) VALUES ('" .. _p:SteamID() .. "' , '','','free.5;','','','','','') ;" )
			fsrp.LoadPermanentData(_p)
			self:SaveHatCoordinateEntry()			
			
		end

	end)

end
function _pMeta:LoadHatCoordinates()
	// random key -10.28125,-13.8125,-0.28125;140.59375,0,0
	
	//if self:getFlag("loadedIn", false) == false then return end
	local _p = self;
	fsdb:Query( "SELECT `hatcoords` FROM `fsdb_characterdata` WHERE `id`='" .. self:SteamID() .. "';" , function( _,result, status, error ) 
		
		if result then

			if result[1] && result[1]["hatcoords"] != "" then
				
				local _hatString =  result[1]["hatcoords"];
				
				local _SplitCoordFromAngle = string.Explode( ';' , _hatString )
				local i = 1;
					
					
					local _splitPos = string.Explode( ',', _SplitCoordFromAngle[1] ) ;
					local _splitAngle = string.Explode( ',', _SplitCoordFromAngle[2] ) ;
					
					_p:setFlag("hatXYZ",Vector( tonumber(_splitPos[1]), tonumber(_splitPos[2]), tonumber(_splitPos[3]) ) );
					_p:setFlag("hatPYR",Angle( tonumber(_splitAngle[1]),tonumber( _splitAngle[2] ) , tonumber(_splitAngle[3] ) ) );
							
							
					
			end
			
		else
			
			self:CreateHatCoordinateEntry()
			
		end
		
	end );

end

function fsrp.SavePlayerItems( steamid )
	local idsToSave = {};

	for k , v in pairs( ents.GetAll() ) do
			
		if v:getFlag("ownedBy", "") == steamid then
			
			if v:getFlag("savedInvEntity", false ) == true  then
				
				local _id = v:getFlag("itemID", nil );
				if !idsToSave[_id] then
				
					idsToSave[_id] = 1;	
				
				else
					
					idsToSave[_id] = idsToSave[_id] + 1 ;

				end
				
			end
			
			v:Remove()

		end
				
	end
	fsdb:Query( "SELECT `inv` FROM `fsdb_user` WHERE `id` = '" .. steamid .. "';", function( _,result , status , err )

		if result && result[1] && result[1]["inv"] then

				local _p = player.GetBySteamID( steamid );

				local _inv = result[1]["inv"];
				local _in = !_p && LoadStringToInventory( _inv ) || LoadStringToInventory( _p:GetInventoryTable() );

			for _id , amount in pairs( idsToSave ) do 

				local foundItemSlot = false;
				local _maxStack = ITEMLIST[_id].MaxStack;
				local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots;

				if #_in > MAX_SLOTS then

					return;

				end

				local _remainder = 0;

				if #_in > 0 then
								
					for k , v in pairs( _in ) do
									
										
						if v.ID == _id  then
										
							if v.Amount+amount <= ITEMLIST[v.ID].MaxStack then
								
								_remainder = _in[k].Amount+amount - ITEMLIST[v.ID].MaxStack

								_in[k].Amount = ITEMLIST[v.ID].MaxStack;
								table.insert(_in, {ID = _id , Amount = _remainder})		
							else

								_in[k].Amount = _in[k].Amount+amount;
								
							end
													
							foundItemSlot = true;
											
							break
											
						end
									
					end
									
				end 
								
				if !foundItemSlot then

					table.insert( _in , { ID = _id , Amount = 1 } )								
									
				end

			end
			
			local _Saveinv = CompileInventoryToString( _in );

			//print( _Saveinv)

			fsdb:Query( "update `fsdb_user` set `inv` = '" .. _Saveinv .. "' WHERE `id` = '" .. steamid .. "';")

			if _p then
				
				timer.Simple( 1, function()
				
					LoadPlayer( _p ) 
					_p:setFlag( "computerEntityIndex" , nil );
					_p:setFlag( "computerStatus", nil );
				
				end )

			end

		end

	end )
	

end

gameevent.Listen( "player_disconnect" )
hook.Add( "player_disconnect", "player_disconnect_example", function( data )
	local name = data.name			// Same as Player:Nick()
	local steamid = data.networkid		// Same as Player:SteamID()
	local id = data.userid			// Same as Player:UserID()
	local bot = data.bot			// Same as Player:IsBot()
	local reason = data.reason		// Text reason for disconnected such as "Kicked by console!", "Timed out!", etc...

	// Player has disconnected - this is more reliable than PlayerDisconnect

			for k , v in pairs( ents.GetAll() ) do 

				if v:getFlag("carOwner","") == steamid then
					
					v:Remove()
					
				end
				
			end
	
		fsrp.SavePlayerItems( steamid )

		for k ,	v in pairs(fsrp.PropertyTable) do
			local _ownerTb = v.PrimaryOwner || nil;
			
			if _ownerTb then 
				if _ownerTb[2] == steamid then
			
					fsrp.PropertyTable[v.ID].PrimaryOwner = nil;
					
					updatePropertyOwner(  v.ID )
			
					
				end
			end
			
		end
			
end )
hook.Add( "PlayerDisconnected", "fsdb_savePlayerOnDC", function( _p )
		
		//saveBusinesses( _p )
		_p:SendCarToGarage()
		fsdb_saveClient( _p  );
		_p:SaveRPComputer( _p:GetRPComputer() )
		saveQuests( _p )
		local _time = _p:getFlag("playTime", 0  ) + (RealTime() - _p:getFlag( "joinTime" , 0 ));
	
		fsdb:Query("UPDATE `fsdb_user` SET  `time_played` = '" .. _time .. "' WHERE `id`='" .. _p:SteamID() .. "';");
	
		for k , v in pairs( ents.GetAll() ) do
			
			if v:getFlag("savedInvEntity", false ) == true && v:getFlag("ownedBy", "") == _p:SteamID() then
			
				local _id = v:getFlag("itemID", nil );
			
				if ITEMLIST[_id] && _id != 44 then
				
					_p:AddItemByID( _id )
					
					v:Remove()
				
				end
				
			elseif util.TypeToString( v:getFlag("ownedBy", "" ) ) == _p:SteamID() then
			
				v:Remove()
			
			end
			
		end
		for k ,	v in pairs(fsrp.PropertyTable) do
			local _ownerTb = v.PrimaryOwner || nil;
			
			if _ownerTb then 
				if _ownerTb[2] == _p:SteamID() then
			
					fsrp.PropertyTable[v.ID].PrimaryOwner = nil;
					
					updatePropertyOwner(  v.ID )
			
					
				end
			end
			
		end
		
end );


	//
	// Save on x interval..
	//
timer.Create( "saveInterval", 60 * 30, 0, function( )

	fsdb.saveWeather()
	for k, _p in pairs( player.GetAll( ) ) do
		
		if ( !IsValid( _p ) ) then continue; end
		
		fsdb_saveClient( _p );
		//saveBusinesses( _p )
	
	end
	

	
end );



hook.Add( "ShutDown", "fsdb_saveGameOnShutdown", function( )
	
	fsdb.saveWeather()
	for k, _p in pairs( player.GetAll( ) ) do
	
	
		fsdb_saveClient( _p  );
		//saveBusinesses( _p )

	end
	

end );

function fsdb_saveClient( _p , removeslots)
	if !_p then print( 'Did not save' .. _p:Nick() .. ' because he was not valid' ) end
	local _pM = math.ceil( _p:getMoney()) || 15000;
	local _pBM = math.ceil( _p:getBank()) || 5000;
	
	if _p:getFlag("loadedIN", false ) != true then return print("Postponed loading in " .. tostring(_p)) end
	
	if (removeslots) then
	
		//_p:RemoveFromSlot( 1 )
		//_p:RemoveFromSlot( 2 )
		//_p:RemoveFromSlot( 3 )
		
	end

	 _Primary 		= _p:getFlag("itemSlot_1", 0 )
	 _Secondary 	= _p:getFlag("itemSlot_2", 0 )
	 _Hat 			= _p:getFlag("itemSlot_3", 0 )
	 
	
	//_p:SendCarToGarage()
	_p:SaveRPComputer( _p:GetRPComputer() )
	_p:SaveWarehouse()
	
	//fsrp.skills.helper.SaveSQLSkills( _p )
	//saveBusinesses( _p )
	//local compiledItems = _p:CompileItems() || "";
	//fsdb:Query("UPDATE `fsdb_user` - WHERE `id`='" .. _p:SteamID() .. "';");
	local _nameToGive =  "x";

	fsdb:Query("UPDATE `fsdb_user` SET `steamid` ='" .. _nameToGive .. "',`cash` = '" .. _pM .. "' , `bankcash` = '" .. _pBM .. "',`ammo_sniper` = '" .. _p:GetAmmoCount("sniper")  .. "' ,`ammo_pistol` = '" .. _p:GetAmmoCount("pistol")  .. "' ,`ammo_rifle` = '" ..  _p:GetAmmoCount("ar2") .. "' ,`ammo_shotgun` = '" ..  _p:GetAmmoCount("buckshot")  .. "' ,   `ammo_submachine` = '" .. _p:GetAmmoCount("smg1") .. "', `bank_level` = '" .. _p:getBankAccount() .."' , `LastPrimary`= " .. _Primary .. ",`LastSecondary`= " .. _Secondary .. ",`LastHat`= " .. _Hat .. "  WHERE `id`='" .. _p:SteamID() .. "';");
	local _time = _p:getFlag("playTime", 0  ) + (RealTime() - _p:getFlag( "joinTime" , 0 ));
	//_p:setFlag("playTime" , _time )
	if _time != 0 then
		_p:SetTimePlayed( _time )
		fsdb:Query("UPDATE `fsdb_user` SET  `time_played` = '" .. _time .. "' WHERE `id`='" .. _p:SteamID() .. "';");
		if  _p:getFlag( "inventory" , "" ) == "" then
		
			return 
			
		end	
	end
	
	fsdb:Query("UPDATE `fsdb_user` SET  `inv` = '" .. _p:getFlag( "inventory" , "" ).. "' WHERE `id`='" .. _p:SteamID() .. "';");


end

function fsdbUpdateName( _p, oldfirst, oldlast )
	local _fullName = oldfirst .. " " .. oldlast;
	local _newName =  _p:getFirstName() .. " " .. _p:getLastName();
	
	
	fsdb:Query( "UPDATE `fsdb_user` set `first_name` = '" .. _p:getFirstName() .. "' , `last_name` = '" .. _p:getLastName( ) .. "' where `id` = '" .. _p:SteamID() .. "';" );
	
	
	
	//fsdb:Query( "UPDATE `fsdb_messenger` set `name` = '" .._newName.. "' where `steamid` = '" .. _p:SteamID() .. "';" )
	
	/*
	for k , v in pairs( ents.FindByClass( "soapstonewriting" ) ) do
	
		if v.PublicInfo.userName == _fullName then
			
			v.PublicInfo.userName = _p:getFirstName() .. " " .. _p:getLastName()
		
		end
	
	end
	*/
	
end
function fsdbUpdateAdminStatus( _p )

	fsdb:Query( "UPDATE `fsdb_user` set `adminrank` ='".. _p:GetUserGroupRank() .. "' where `id` = '" .. _p:SteamID() .. "';" );

end

function fsdb_changeSex( _p )
	if !_p then return end
		local modelInt = 1
		if (_p:getGender() == 1) then modelInt = 2; end
		

		local theirNewModel = iterateModelTable(modelInt, math.random(1,4));
		//print( newSex );

		_p:SetModel(theirNewModel.mdl);
		//SaveBodygroups(_p ,  player_manager.TranslateToPlayerModelName( _p:GetModel() ) , "0", "0", _p:GetModel() );
		//updateParamedicJobModel( _p , modelInt .. "_" .. math.random(1,2) )
		//updatePoliceJobModel( _p , "2_" .. math.random(1,2))
		//_p.__oModel = theirNewModel;
		

			
			local Default = "hospitalfemale_" .. math.random( 9 );
			local DefaultMayor = "Liz(11 Noire)";
			if modelInt == 2 then
			
				Default = "hospitalmale_" .. math.random( 9 )
				DefaultMayor = "breen"
				
			end
			
			_p:setFlag("playerinfo_model", theirNewModel.name )
			_p:setFlag("playerinfo_bodygroups", "" )
			_p:setFlag("playerinfo_skin", 0 )
			_p:setFlag("playerinfo_job_police_model", "Police_" .. math.random( 4, 7 ) )
			_p:setFlag("playerinfo_job_police_bodygroups",  ""  )
			_p:setFlag("playerinfo_job_police_skin",  0  )
			_p:setFlag("playerinfo_job_paramedic_model",  Default  )
			_p:setFlag("playerinfo_job_paramedic_bodygroups",  ""  )
			_p:setFlag("playerinfo_job_paramedic_skin",  0 )
			_p:setFlag("playerinfo_job_mayor_model",  DefaultMayor  )
			_p:setFlag("playerinfo_job_mayor_bodygroups",  ""  )
			_p:setFlag("playerinfo_job_mayor_skin",  0 )
			
		tmysqlReroute("UPDATE `fsdb_user` SET `model`='" .. modelInt .. "' WHERE `id`='" .. _p:SteamID() .. "'", function( _,result, status, error)
			if status == QUERY_FAIL then
				
				if (type(error) == "string" and error != "") then
					ErrorNoHalt("MySQL Query Failed: "..error);
				else
					ErrorNoHalt("MySQL Query Failed: (Update - Player - Sex) \n".. error);
				end;	
				
			end
		
		end)
		_p:setClientGender( modelInt);
	net.Start("UpdateHUD")
	net.Send( _p )
end

function fsdb.saveWeather()
	if !SW then return end
	
	fsdb:Query("UPDATE `fsrp_global` SET `time`='" .. math.Round(SW.Time, 2) .."';");		
	print("[WC-RP] - Saving Weather, Value: " .. math.Round(SW.Time, 2 ) )


end

function fsdb.loadWeather()
	if !SW then return end
	
	fsdb:Query("SELECT * FROM `fsrp_global`;", function ( _,data )
		
		if data && data[1] && data[1]["time"] then

			//SW.SetTime( tonumber(data[1][1]) )
			
		else
		
			fsdb:Query("INSERT INTO `fsrp_global` (`time`) VALUES(" .. math.Round( SW.Time, 2 ) .. ")");
			
		end
		
	end)

end
fsrp.devprint("[WC-RP] - Initialized Database" )


		
local modelsToReset = {
	"whk_tv",
	"whk_radio",
	"cannabis_plant",
	"furniture_lamp",
	"traffic_barrier",
	"traffic_cone",
}
function GM:GravGunPunt ( Player, Target ) 
	if table.HasValue( modelsToReset,Target:GetClass()) && Target:GetPos():Distance( Player:GetPos() ) < 250 then
		Target:SetAngles( Angle(0, Player:GetAngles().y ,0) ) //This should help some people out
		Target:SetPos( Target:GetPos() + Vector( 0, 0, 15 ) )
		Target:DropToFloor()
		return false
    end
	return false; 
end
 

hook.Add("GravGunPunt", "PreventGravGunSpam", function( ply, tgt )
	ply:DropObject( tgt )
end)

function GM:GravGunPickupAllowed ( Player, Target ) 
    if(not IsValid(Target)) then return false end
	Player:setFlag("pickedUpEntityIndex", Target:EntIndex() );
	return Target && ( Player:CanManipulateEnt(Target, true) )
end
function GM:PhysgunDrop( Player, Target )
	Player:setFlag("pickedUpEntityIndex", 1 );

	if Player:IsSuperAdmin() && Target:IsPlayer() then
			
		if util.IsInWorld( Target:GetPos()) then
			Target:SetMoveType( MOVETYPE_WALK )
			Target:SetCollisionGroup( COLLISION_GROUP_PLAYER )
			
			return true;
		
		end
	end

end
function GM:PhysgunPickup ( Player, Target ) 
	Player:setFlag("pickedUpEntityIndex", Target:EntIndex() );
	
	if (Player:IsSuperAdmin() && Target:IsPlayer() && !Target:IsSuperAdmin()) then
		
		Target:SetMoveType( MOVETYPE_FLY )
		Target:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
		
		return true
	end

	return Player:CanManipulateEnt(Target, false )
end

function GM:OnPhysgunFreeze( weapon, phys, ent, ply )
	
	ply:setFlag("pickedUpEntityIndex", 1 );
	
	if ent:GetClass() == "cannabis_plant" then
	
		return false
		
	end
	
	if !phys:IsMoveable() || ent:GetClass() == "fsrp_item" then return false end
	
		phys:EnableMotion(false);
	
	return true;
end
local _PhysGunAllowed = {
	"fsrp_propitem",
	"traffic_barrier",
	"vc_fuel_nozzle",
	"traffic_cone",
	"editable_sign",
	"furniture_lamp",
	"whk_pictureframe",
	"whk_squarepictureframe",
	"whk_sticker",
	"whk_tablepicframe",
	"whk_widepictureframe",
	"whk_radio",
	"fsrpcomputer",
	"fsrpmonitor",
	"cashregister",
	"fsrp_craftable",
	"whk_tv",
	"methstove",
	"mp_bag",
	"mp_supply",
	"moneyprinter",
	"meth_wet",
}
local _GravGunAllowed = {
	"cash",
	"fsrpcomputer",
	"fsrpmonitor",
	"furniture_lamp",
	"cannabis_plant",
	"fsrp_propitem",
	"fsrp_craftable",
	"fsrp_item",
	"vc_fuel_nozzle",
	"vc_pickup_fuel_diesel",
	"vc_pickup_fuel_electricity",
	"vc_pickup_fuel_petrol",
	"vc_pickup_light",
	"vc_pickup_tire",
	"vc_pickup_exhaust",
	"vc_pickup_engine",
	"whk_pictureframe",
	"whk_squarepictureframe",
	"whk_sticker",
	"whk_tablepicframe",
	"whk_widepictureframe",
	"whk_radio",
	"whk_tv",
	"traffic_barrier",
	"cw_ammo_kit_small" ,
	"cw_ammo_kit_small",
	"cw_ammo_kit_regular",
	"cw_ammo_crate_regular",
	"cw_ammo_crate_small",
	"traffic_cone",
	"editable_sign",
	"cashregister",
	"sent_soccerball",
	"meth_ingredient_a",
	"meth_ingredient_b",
	"meth_ingredient_c",
	"meth_wet",
	"mp_bag",
	"mp_supply",
	"moneyprinter",
	"cooling_water",
	//"",
}

local _DevEnts = {
	"rm_car_dealer",
	"rm_car_dealer_bay",
	"vc_fuel_nozzle",
	"vc_fuel_station_diesel",
	"vc_fuel_station_petrol",
	"vc_fuel_station_electricity",
	"cw_ammo_kit_small" ,
	"cw_ammo_kit_small",
	"cw_ammo_kit_regular",
	"cw_ammo_crate_regular",
	"cw_ammo_crate_small",
	"cn_npc",
	"heistpointer",
	"heistplanningpanel",
	"heistitem",
	"fsrp_rock",
	"cashregister",
}
function _pMeta:CanManipulateEnt ( Target, b )
	todo = false
	if b && b == true then
	
		todo = true
		
	end

	if !self or !self:IsValid() or !self:IsPlayer() then return false; end
	if !Target or !Target:IsValid() then return false; end
	if self:IsDev() && table.HasValue( _DevEnts , Target:GetClass() ) then return true; end
	if self:IsSuperAdmin() and Target:IsVehicle() then return true; end
	
	if Target:GetClass() == "fsrp_item" then
	
		return Target:getFlag("drawModel", false) == false && todo || true;
		
	end
	
	if table.HasValue( _GravGunAllowed, Target:GetClass() ) && todo then
	
		return self:IsSuperAdmin() && true || Target:getFlag( "ownedBy" ,"" ) == "" && true || Target:getFlag( "ownedBy" ,"" ) == self:SteamID() && true || player.GetBySteamID(Target:getFlag( "ownedBy" ,"" ) ):HasBuddy( self ) && true || false;
	
	end
	
	if table.HasValue( _PhysGunAllowed, Target:GetClass() ) && !todo then

		return self:IsSuperAdmin() && true || Target:getFlag( "ownedBy" ,"" ) == "" && true || Target:getFlag( "ownedBy" ,"" ) == self:SteamID() && true || player.GetBySteamID(Target:getFlag( "ownedBy" ,"" ) ) &&player.GetBySteamID(Target:getFlag( "ownedBy" ,"" ) ):HasBuddy( self ) && true || false;
	 
	end
	
	if (Target:GetClass() == 'prop_vehicle_prisoner_pod') and Target.pickupPlayer && (!Target:GetDriver() || !IsValid(Target:GetDriver())) then
		if Target.pickupPlayer == self or Target.pickupPlayer:HasBuddy(self) then
			return true;
		end
	end
	

	return false;
end

function retrieveJobModelFromDB( _p )

	local steamID = _p:SteamID()
	
	if !_p || !_p:IsValid() || !IsValid( _p ) then return end;
	tmysqlReroute( "SELECT `id`, `police`, `paramedic` FROM `fsdb_models` WHERE  `id`='" .. _p:SteamID( ) .. "';" , function ( _,result, status , err )

		local data = result;
		if (!result || !result[1] || !result[1][1]) then
				local rMod =math.random( 1, 2);
				print( rMod )
				//fsdb:Query( "INSERT INTO `fsdb_models` ( `id`, `police`, `paramedic` ) VALUES ('" .. _p:SteamID() .. "',  '2_" .. tostring(rMod * 3) .."', '1_" .. tostring(rMod) .. "' );" );
		
			
			_p:LoadGMModels()
		else
			local data = {
				[1] = {
					[1] = result[1]["id"];
					[2] = result[1]["police"];
					[3] = result[1]["paramedic"];
				}
			}
			if _p:SteamID() != data[1][1] then return _p:Notify("nah") end
			
			local jobTbl = {}
			
			jobTbl.Police		= data[1][2]
			jobTbl.Paramedic	= data[1][3]
			
			_p.__JobModels = jobTbl;
			_p:setFlag( "jobmodels", jobTbl  )
			
			updateClientJobModels( _p )
		
		end
		
	end)


end

util.AddNetworkString("sendClientJobModels")
function updateClientJobModels( v )

		net.Start("sendClientJobModels")
			net.WriteTable( v:getFlag("jobmodels", v.__JobModels ) )
			net.WriteString( v:SteamID() )
				if #player.GetAll() > 0 then
					net.Broadcast()
				end
		
end
function updatePoliceJobModel( _p, str )
	if !_p || !IsValid( _p ) then return end;
	fsdb:Query("UPDATE `fsdb_models` SET `police` ='" .. str .. "' WHERE `id`='" .. _p:SteamID() .. "';")
	
	

	retrieveJobModelFromDB( _p )

	
end
function updateParamedicJobModel( _p ,str )

	if !_p || !IsValid( _p ) then return end;
	
	fsdb:Query("UPDATE `fsdb_models` SET `paramedic` ='" .. str .. "' WHERE `id`='" .. _p:SteamID() .. "';");
	
	
	retrieveJobModelFromDB( _p )
end