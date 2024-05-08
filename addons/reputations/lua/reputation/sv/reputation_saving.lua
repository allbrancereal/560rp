
if PlayerReputations.ShowDebugPrints then

	print( "Including Filesystem Implementation.")

end

require("mysqloo");

local DBInfo = {
	Site 	 = "";
	UserName = "";
	Password = "";
	DB_Name	 = "";
}

// Retrieves from this IP & the following tables IP's!
local RelevantIPs = {
}

// Name: GetIPAddressIncludeString()
// Purpose: Makes a string of all IP addresses we should consider while loading (allows you to combine multiple server's tags)
// Arguments: /
// Returns: str (string)
local function GetIPAddressIncludeString()

	local str = "WHERE `IP`='0.0.0.0'";

	for k , v in pairs( RelevantIPs ) do
		
		str = str .. " OR `IP`='" .. v .. "'"; 

	end

	return str;

end

local DB = mysqloo.connect( DBInfo.Site , DBInfo.UserName , DBInfo.Password , DBInfo.DB_Name, 3306 )

function DB:onConnected()

    local q = self:query( "SELECT 5+5" )
    function q:onSuccess( data )

        //print( "DB Has connected!" )
        //PrintTable( data )
        PlayerReputations.Database = DB;

    end

    function q:onError( err, sql )

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )
        PlayerReputations.Database = nil;
    end

    q:start()

end

function DB:onConnectionFailed( err )
 
    print( "Connection to database failed!" )
    print( "Error:", err )

end

function DB:RetrievePlayerData( ID  )

	local tb = "Reputation"
	local _Q = PlayerReputations.Database:query( "SELECT * FROM `" .. tb .. "` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. ID .."';" );
	local _Data = nil;

	function _Q:onSuccess( rows )
		
		hook.Run( "Reputation_Retrieval" ,  {true ,rows, ID} );
		
	end
	
    function _Q:onError( err, sql )

        print( "Query:", sql )
        print( "Error:", err )

		hook.Run( "Reputation_Retrieval", {false ,rows, ID} );

    end 
	
	_Q:start();

end

function DB:SavePlayerData( ID  )

	local tbName = ("Reputation")
	local rwName = ("ReputationData")
	local flgName = ("knownReputations")

	if istable( ID ) then

		for k , v in pairs( ID ) do	

			local MainQuery = DB:query( "SELECT * FROM `" .. tbName .. "` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. v .."';" );
			local _Data = nil;

			function MainQuery:onSuccess( rows )
				//PrintTable( rows )
					
				if !rows[1] then 
						
						local _p = player.GetBySteamID( v );

						if _p && IsValid( _p ) && _p:IsPlayer() then
							
							local _Q = DB:prepare( "INSERT INTO `" .. tbName .. "` (`IP`,`SteamID`,`" .. rwName .."`) VALUES (?, ?, ? );" )

							_Q:setString( 1, game.GetIPAddress() )
							_Q:setString( 2, v)
							_Q:setString( 3, util.TableToJSON( _p:getFlag( flgName , {}, true) ))
							function _Q:onSuccess( data )
								
								hook.Run( "Saved_" .. tbName , v ,true, true )

							end
							
						    function _Q:onError( err, sql )

						        print( "Query:", sql )
						        print( "Error:", err )
								hook.Run( "Saved_" .. tbName , ID ,false, false,false )

						    end
							
							_Q:start();					


						end
					
					
				else

					local _Q = DB:query( "UPDATE " .. tbName .. " SET " .. rwName .. "='".. util.TableToJSON( _p:getFlag(flgName, {}, true) ).. "' WHERE SteamID = '" .. v .."' AND IP='".. game.GetIPAddress() .. "';")

					function _Q:onSuccess( data )

						hook.Run( "Saved_Reputation" , v ,true, false )

					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )				        
						hook.Run(  "Saved_Reputation"  , ID ,false, false, false )

				    end
							
					_Q:start();	
				
				end

			end
							

		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )
				hook.Run(  "Saved_Reputation"  , ID ,false, false, true )

		    end
			
			MainQuery:start()

		end
	
	else

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
						
			local MainQuery = DB:query( "SELECT * FROM `" .. tbName .. "` " .. GetIPAddressIncludeString() .. " AND `SteamID`='" .. ID .."';" );

			function MainQuery:onSuccess( rows )
				//PrintTable( rows )
				
				if !rows[1] then 
					
					local _Q = DB:prepare( "INSERT INTO `" .. tbName .. "` (`IP`,`SteamID`,`" .. rwName .."`) VALUES (?, ?, ? );" )
									
				
					_Q:setString( 1, game.GetIPAddress() )
					_Q:setString( 2, ID)
					_Q:setString( 3, util.TableToJSON( _p:getFlag( flgName , {}, true) ))
					function _Q:onSuccess( data )

						hook.Run(  "Saved_Reputation"  , ID ,true, true )

					end
					
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )
						hook.Run(  "Saved_Reputation"  , ID ,false, false, false )

				    end
					
					_Q:start();					

				else

					local _Q = DB:query("UPDATE " .. tbName .. " SET " .. rwName .. "='".. util.TableToJSON( _p:getFlag(flgName, {}, true) ).. "' WHERE SteamID = '" .. ID .."' AND IP='".. game.GetIPAddress() .. "';" )

					function _Q:onSuccess( data )

						hook.Run( "Saved_" .. tbName , ID ,true, false )
					end
							
				    function _Q:onError( err, sql )

				        print( "Query:", sql )
				        print( "Error:", err )

						hook.Run(  "Saved_Reputation"  , ID ,false, false, false )
				    end
							
					_Q:start();	

				end
				
			end
			
		    function MainQuery:onError( err, sql )

		        print( "Query:", sql )
		        print( "Error:", err )
				hook.Run(  "Saved_Reputation"  , ID ,false, false, true )

		    end

			MainQuery:start();

		end
		
	end

	return false;
end

DB:connect()