
if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag SQL Saving File.")

end
ObjectTags = ObjectTags || {};
ObjectTags.system = ObjectTags.system || {};


// Name: DoesTagTableExist()
// Arguments: /
// Purpose: Returns a true or false whether the table exists in the local SQL database.
// Returns: Exists (bool)
local function DoesTagTableExist()
	
	if sql.TableExists( ObjectTags.config.SQLTableName ) then

		return true;

	end

	return false;

end

// Name: CreateTagTable()
// Arguments: /
// Purpose: Finds out if the table exists and if not creates the table. Returns true if a new table was created.
// Returns: Success (bool)
local function CreateTagTable()

	if !DoesTagTableExist() then
		
		sql.Query( "CREATE TABLE " .. ObjectTags.config.SQLTableName .. "( SteamID TEXT, PrvTags TEXT, PubTags TEXT )" )

		return true;
	end
	
	return false;
end

// Name: ObjectTags.system.SaveSQLTags()
// Arguments:  ID (string)
// Purpose: Saves the player or table of players strings by steam id to the local database.
// Returns: Success (bool)
function ObjectTags.system.SaveSQLTags( ID )
	
	CreateTagTable()

	if istable(ID) then
			
		if #ID > 50 then
			
			sql.Begin()

		end

		for k , v in pairs( ID ) do
			
			_p = player.GetBySteamID( v );

			if _p && IsValid( _p ) && _p:IsPlayer() then
			
				local _oldData = sql.Query( "SELECT * FROM `" .. ObjectTags.config.SQLTableName .. "` WHERE `SteamID` = '" .. _p:SteamID() .."'")

				if !_oldData then 
							
					sql.Query( "INSERT INTO " .. ObjectTags.config.SQLTableName .. "( SteamID, PrvTags, PubTags ) VALUES( '".._p:SteamID().."', '" .. util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ) .. "' ,'" .. util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ) .. "' )" )
						
				end

				sql.Query( "UPDATE " .. ObjectTags.config.SQLTableName .. " SET PrvTags='"..util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ).."'' , SET PubTags='"..util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ).."'' WHERE SteamID='".._p:SteamID().."'" )

			end
			
		end

		if #ID > 50 then
			
			sql.Commit()	

		end

		return true;

	else

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
				
			local _oldData = sql.Query( "SELECT * FROM `" .. ObjectTags.config.SQLTableName .. "` WHERE `SteamID` = '" .. _p:SteamID() .."'")

			if !_oldData then 
						
				sql.Query( "INSERT INTO " .. ObjectTags.config.SQLTableName .. "( SteamID, PrvTags, PubTags ) VALUES( '".._p:SteamID().."', '" .. util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ) .. "' ,'" .. util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ) .. "' )" )
					
			end

			sql.Query( "UPDATE " .. ObjectTags.config.SQLTableName .. " SET PrvTags='"..util.TableToJSON( _p:getFlag("ObjTags_Prv", {}) ).."'' , SET PubTags='"..util.TableToJSON( _p:getFlag("ObjTags_Pub", {}) ).."'' WHERE SteamID='".._p:SteamID().."'" )

			return true;

		end

	end
	
	return false;

end

// Name: ObjectTags.system.RetrieveSQLTags()
// Arguments: ID (string)
// Purpose: Returns the Private & Public tags of a user directly from the database.
// Returns: PrvTags (table) , PubTags (table)
function ObjectTags.system.RetrieveSQLTags( ID )
	
	CreateTagTable()

	local _p = player.GetBySteamID( ID )

	if _p && IsValid( _p ) && _p:IsPlayer() then
		
		local _OldData = sql.Query( "SELECT PrvTags, PubTags FROM `" .. ObjectTags.config.SQLTableName .. "` WHERE `SteamID` = '" .. _p:SteamID() .."'")

		if _OldData && istable( _OldData) then
				
			local data = _OldData[1];

			return util.JSONToTable(data.PrvTags),util.JSONToTable(data.PubTags);

		end
	
	end
	
	return nil, nil;

end
