
if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag MySQL Saving File.")

end

 
require( "mysqloo" )
local _targetRealm = "70.68.172.60:27015";

hook.Add("Initialize", "StartupMySQLConnection", function()

	local _SaveMode = ObjectTags.config.SaveMode;

end)
ObjectTags = ObjectTags || {};
ObjectTags.system = ObjectTags.system || {};

local DBInfo = {
	Site 	 = "";
	UserName = "";
	Password = "";
	DB_Name	 = "";
}

local IPsToRetrieveFrom = {
	game.GetIPAddress()..":27015"
}

// Name: GetIPAddressIncludeString()
// Purpose: Makes a string of all IP addresses we should consider while loading (allows you to combine multiple server's tags)
// Arguments: /
// Returns: str (string)
local function GetIPAddressIncludeString()

	local str = "WHERE `IP`='"..game.GetIPAddress() .. "'";

	for k , v in pairs( IPsToRetrieveFrom ) do
		
		str = str .. " OR `IP`='" .. v .. "'"; 

	end

	return str;

end

ObjectTags.Database = mysqloo.connect( DBInfo.Site , DBInfo.UserName , DBInfo.Password , DBInfo.DB_Name, 3306 )

function ObjectTags.Database:onConnected()

    local q = self:query( "SELECT 5+5" )
    function q:onSuccess( data )

        //print( "DB Has connected!" )
        //PrintTable( data )

    end

    function q:onError( err, sql )

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )

    end

    q:start()

end

function ObjectTags.Database:onConnectionFailed( err )
 
    print( "Connection to database failed!" )
    print( "Error:", err )

end

ObjectTags.Database:connect()

// Name: ObjectTags.system.RetrieveMySQLTags()
// Purpose: Retrieves the players tags from the MySQL database. It considers all ip's in the serverside config above
// Arguments: ID (string)
// Returns: /
function ObjectTags.system.RetrieveMySQLTags( ID )

	local _Q = ObjectTags.Database:query( "SELECT * FROM `data` WHERE `IP`='" .. game.GetIPAddress() .. "' AND `SteamID`='" .. ID .."';" );
	local _Data = nil;

	function _Q:onSuccess( rows )
		
		local _PrvTags , _PubTags = {} , {} ;
		if rows[1] then
			
			_PrvTags = util.JSONToTable(rows[1].PrvData);
			_PubTags = util.JSONToTable(rows[1].PubData);

		end
		/* //Merge two servers 
		for index , row in pairs( rows ) do 

			if row.IP == game.GetIPAddress() then
								
				local _RowPrv, _RowPub = util.JSONToTable(row.PrvData), util.JSONToTable(row.PubData);

				for k , v in pairs( _RowPrv ) do
					
					_PrvTags[k] = v;

				end

				for k , v in pairs( _RowPub ) do
					
					_PubTags[k] = v;
					
				end

			end
			
		end

		*/

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
			
			_p:SetDataTags( (_PrvTags != nil && _PrvTags || {}) , (_PubTags != nil && _PubTags || {})  )
		
		end
		

	end
	
    function _Q:onError( err, sql )

        print( "Query:", sql )
        print( "Error:", err )

    end 
	
	_Q:start();

end

// Name: ObjectTags.system.SaveMySQLTags( )
// Purpose: Saves your tags to MySQL. 
// Arguments: ID (string)
// Returns: /
function ObjectTags.system.SaveMySQLTags( ID )

	if istable( ID ) then

		for k , v in pairs( ID ) do	

			local MainQuery = ObjectTags.Database:query( "SELECT * FROM `data` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. v .."';" );
			local _Data = nil;

			function MainQuery:onSuccess( rows )
				//PrintTable( rows )
					
				if !rows[1] then 
						
						local _p = player.GetBySteamID( v );

						if _p && IsValid( _p ) && _p:IsPlayer() then
							
							local _Q = ObjectTags.Database:prepare( "INSERT INTO `data` (`SteamID`,`IP`,`PrvData`,`PubData`) VALUES (?, ?, ? , ?);" )

							_Q:setString( 1, v)
							_Q:setString( 2, game.GetIPAddress() )
							_Q:setString( 3, util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ))
							_Q:setString( 4, util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ))
							function _Q:onSuccess( data )
								ObjectTags.system.QueryIPSave(v,_targetRealm )

							end
							
						    function _Q:onError( err, sql )

						        print( "Query:", sql )
						        print( "Error:", err )

						    end
							
							_Q:start();					


						end

					
				else

					local _Q = ObjectTags.Database:query( "UPDATE data SET PrvData='".. util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ).. "', PubData='" .. util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ) .. "' WHERE SteamID = '" .. v .."';")

					function _Q:onSuccess( data )
						ObjectTags.system.QueryIPSave(v,_targetRealm )

					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

				    end
							
					_Q:start();	
				
				end

			end
							

		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )

		    end
			
			MainQuery:start()

		end
	
	else

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
						
			local MainQuery = ObjectTags.Database:query( "SELECT * FROM `data` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. ID .."';" );

			function MainQuery:onSuccess( rows )
				//PrintTable( rows )
				
				if !rows[1] then 
					
					local _Q = ObjectTags.Database:prepare( "INSERT INTO `data` (`SteamID`,`IP`,`PrvData`,`PubData`) VALUES (?, ?, ? , ?);" )
									
					_Q:setString( 1, ID)
					_Q:setString( 2, game.GetIPAddress() )
					_Q:setString( 3, util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ))
					_Q:setString( 4, util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ))
				
					function _Q:onSuccess( data )
						ObjectTags.system.QueryIPSave(ID, _targetRealm )

					end
					
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

				    end
					
					_Q:start();					

				else

					local _Q = ObjectTags.Database:query( "UPDATE data SET PrvData='".. util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ).. "', PubData='" .. util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ) .. "' WHERE SteamID = '" .. ID .."' AND IP='".. game.GetIPAddress() .. "';")

					function _Q:onSuccess( data )
						// Send to other Servers
						ObjectTags.system.QueryIPSave(ID,_targetRealm )
					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

				    end
							
					_Q:start();	

				end
				
			end
			
		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )

		    end

			MainQuery:start();

		end
		
	end

	return false;
end
// DELETE FROM `data` WHERE SteamID='STEAM_0:1:115732266';

function ObjectTags.system.QueryIPSave(ID,ip,func )

		local _add = "WHERE `IP`= '".. ip  .. "'";

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
						
			local MainQuery = ObjectTags.Database:query( "SELECT * FROM `data` " .. _add .. " AND `SteamID`='" .. ID .."';" );

			function MainQuery:onSuccess( rows )

				if !rows[1] then 

					local _Q = ObjectTags.Database:prepare( "INSERT INTO `data` (`SteamID`,`IP`,`PrvData`,`PubData`) VALUES (?, ?, ? , ?);" )
									
					_Q:setString( 1, ID)
					_Q:setString( 2, ip )
					_Q:setString( 3, util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ))
					_Q:setString( 4, util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ))
				
					function _Q:onSuccess( data )

						if func then
							func(rows,data, true)
						end

					end
					
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

				    end
					
					_Q:start();

				else
					/*
					local _foundrows = {};

					for k , v in pairs( rows ) do
						print(v)
						if v.SteamID == _p:SteamID() then
							table.insert(_foundrows, v)
						end

					end

					local _pubS,_privS = {}, {};

					for k , v in pairs( _foundrows ) do 

						for x, y in pairs( util.JSONToTable(v.PrvData) ) do

							table.insert(_privS,y)

						end

						for x, y in pairs( util.JSONToTable(v.PubData) ) do

							table.insert(_pubS,y)

						end
						
					end
					for k , v in pairs( _pubS ) do end
					*/
					
					local _Q = ObjectTags.Database:query( "UPDATE data SET PrvData='".. util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ).. "', PubData='" .. util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ) .. "' WHERE SteamID = '" .. ID .."' AND IP='".. ip .. "';")

					function _Q:onSuccess( data )

						if func then
							func(rows,data, false)
						end

					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

				    end
							
					_Q:start();	
					

				end
				
			end
			
		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )

		    end

			MainQuery:start();

		end
end
