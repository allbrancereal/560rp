
if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag Data Saving File.")

end

ObjectTags = ObjectTags || {};
ObjectTags.system = ObjectTags.system || {};

// Name: RetrieveTagSaveFolder()
// Purpose: Helper function allowing us to grab quick access to the data tags save directory
// Arguments: /
// Returns: folder (string)
local function RetrieveTagSaveFolder()

	local _filename = "/" .. ObjectTags.config.SaveLocation;

	local _folder = string.lower( ( GM or GAMEMODE ).Name ) .. _filename;
	if ( !file.Exists( _folder .. _filename, "DATA" ) ) then
		file.CreateDir( _folder );
	end

	return _folder;

end

// Name: ObjectTags.system.SaveDataTags()
// Purpose: Saves data to the txt format in the data folder of the server.
// Arguments: ID (string or table of strings)
// Returns: success (bool)
function ObjectTags.system.SaveDataTags( ID )

	local _folder = RetrieveTagSaveFolder( );

	if istable( ID ) then

		for k , v in pairs( ID ) do

			local _p = player.GetBySteamID( v );

			if _p && IsValid( _p ) && _p:IsPlayer() then

				local _toSave = {
					prv = util.TableToJSON( _p:getFlag( "ObjTags_Prv" , {}) || {} ),
					pub = util.TableToJSON( _p:getFlag( "ObjTags_Pub" , {}) || {} )
				};

				file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt",util.TableToJSON(_toSave) , "DATA" );

			end		

		end
		
		
		return true;

	else

		local _p = player.GetBySteamID( ID );

		if _p && IsValid( _p ) && _p:IsPlayer() then
			
			local _toSave = {
				prv = util.TableToJSON( _p:getFlag( "ObjTags_Prv" , {}) || {} ),
				pub = util.TableToJSON( _p:getFlag( "ObjTags_Pub" , {}) || {} )
			};

			file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt", util.TableToJSON(_toSave) , "DATA" );

			return true;

		end

	end

	return false;

end

// Name: ObjectTags.system.RetrieveDataTags()
// Purpose: Retrieves the data saved to the data folder relative to config.
// Arguments: ID (string)
// Returns: PrvTags(table), PubTags(table);
function ObjectTags.system.RetrieveDataTags( ID )

	local _folder = RetrieveTagSaveFolder( );
	local _p = player.GetBySteamID( ID );

	if _p && IsValid( _p ) && _p:IsPlayer() then
		
		local _dataResult = file.Read( _folder .. string.safe( _p:SteamID( ) ) .. ".txt" );
		
		if _dataResult then 

			local _Tb =  util.JSONToTable( _dataResult );

			return util.JSONToTable(_Tb.prv), util.JSONToTable(_Tb.pub);

		end
	
	end
			
	return nil, nil;
end
