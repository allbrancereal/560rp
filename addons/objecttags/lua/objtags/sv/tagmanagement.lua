
if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag Management File.")

end

ObjectTags.system = ObjectTags.system || {};

// Name: ObjectTags.system.GetSavedPlayerTags()
// Purpose: Returns the saved players data from the save method file.
// Arguments: ID (string)
// Returns: Tags (table)
function ObjectTags.system.GetSavedPlayerTags( ID )

	local _SafeMode = ObjectTags.config.SaveMode;

	if _SafeMode == 0 then
		
		return ObjectTags.system.RetrieveSQLTags( ID );
	
	elseif _SafeMode == 1 then
		
		return ObjectTags.system.RetrieveMySQLTags( ID )

	else

		return ObjectTags.system.RetrieveDataTags( ID )

	end

end

// Name: ObjectTags.system.SavePlayerTags()
// Purpose: Saves the players tag based on Safe mode config
// Arguments: ID (string / table of strings)
// Returns: success (bool)
function ObjectTags.system.SavePlayerTags( ID )

	local _SafeMode = ObjectTags.config.SaveMode;

	if _SafeMode == 0 then
		
		ObjectTags.system.SaveSQLTags( ID );
		
		return true;
	
	elseif _SafeMode == 1 then
		
		ObjectTags.system.SaveMySQLTags( ID )
		
		return true;

	else

		ObjectTags.system.SaveDataTags( ID )

		return true;

	end

	return false;
end	

local _pMeta = FindMetaTable("Player");

// Name: PLAYER:SetDataTags()
// Purpose: Sets the players data tags to the arguments data tags.
// Arguments: _Prv (table), _Pub (table)
// Returns: Success (bool)
function _pMeta:SetDataTags( _Prv, _Pub )

	if _Prv && istable( _Prv ) then
		
		self:setFlag("ObjTags_Prv", _Prv )
	
	end	

	if _Prv && istable( _Prv ) && _Pub && istable( _Pub ) then

		self:setFlag("ObjTags_Pub", _Pub ) 

	end

	return false;

end

// Name: ObjectTags.system.LoadPlayerTags(  )
// Purpose: Loads the players tags onto their flags.
// Arguments: ID (string)
// Returns: Success (bool)
function ObjectTags.system.LoadPlayerTags( ID )

	local _PrvTags, _PubTags = ObjectTags.system.GetSavedPlayerTags( ID );

	local _pInQuestion = player.GetBySteamID( ID );

	local _Success = false;

	if _pInQuestion && IsValid( _pInQuestion ) then 

		_Success = _pInQuestion:SetDataTags( (_PrvTags != nil && _PrvTags || {}) , (_PubTags != nil && _PubTags || {})  )

	end
	
	return _Success;

end

