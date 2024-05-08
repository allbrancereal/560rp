
if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag Meta.")

end

local _eMeta = FindMetaTable("Entity");

// Name: GetTagPostFix()
// Purpose: Returns a string based on the boolean input
// Arguments: private (bool)
local function GetTagPostFix( private )

	return ( private && private == true && "Prv" || "Pub" )

end

// Name: ENTITY:HasTag()
// Purpose: Returns the public & private tables entry for the tag
// Arguments: tag (string)
function _eMeta:HasTag( tag )

	local _PrvTags, _PubTags = self:GetTags();

	return table.HasValue(_PrvTags, tag), table.HasValue(_PubTags,tag);

end

// Name: ENTITY:HasPublicTag()
// Purpose: Returns true if the object has the tag and false if not
// Arguments: tag (string)
// Returns: HasTag (bool)
function _eMeta:HasPublicTag( tag )

	local _PrvTags, _PubTags = self:HasTag( tag );

	if _PubTags != nil then return _PubTags end
	
	return false;
end

// Name: ENTITY:HasPrivateTag( tag )
// Purpose: Returns true if the object has the tag and false if not
// Arguments: tag (string)
// Returns: HasTag(bool)
function _eMeta:HasPrivateTag( tag )

	local _PrvTags, _PubTags = self:HasTag( tag );

	return _PrvTags != nil && _PrvTags || false;
	
end

// Name: ENTITY:GetTags()
// Purpose: Returns the objects tag tables.
// Arguments: private (bool)
// Returns: Tags (table)
function _eMeta:GetTags( private )

	if private == nil then
		
		return self:getFlag("ObjTags_Prv" , {}, true ), self:getFlag("ObjTags_Pub" , {} );
	
	end

	local _PostFix = GetTagPostFix( private );

	return self:getFlag("ObjTags_" .. _PostFix , {}, private );

end


local function SanitizeTagTables(self)

	local _PrvTags, _PubTags = self:GetTags();
		
	local SanitizedTable = {};
	local inc = 1;
	for k , v in pairs( _PrvTags ) do 

		SanitizedTable[inc] = v;

		inc = inc +1;
	end
	_PrvTags = SanitizedTable;

	self:setFlag("ObjTags_Prv", _PrvTags, true );
		
						
	SanitizedTable = {};
	inc = 1;
	for k , v in pairs( _PubTags ) do 

		SanitizedTable[inc] = v;

		inc = inc +1;

	end
	_PubTags = SanitizedTable;

	self:setFlag("ObjTags_Pub", _PubTags );
		
end


// Name: ENTITY:AddTag()
// Purpose: Adds a tag to the objects tag table (Assumed true unless the second argument declares otherwise)
// Arguments: tag (string), private (bool)
// Returns: Success (bool)
function _eMeta:AddTag( tag , private )

	if !tag then 

		ErrorNoHalt("No Arguments for entity meta:AddTag(). " .. tag .. " " .. private ) ;

		return false ,0;

	end;	
	
	if !isstring(tag) then 

		ErrorNoHalt( "Tag is not a string" ) ;

		return false ,0;

	end;

	local _IsPrivateList = private != nil && private || false;

	local _tags = self:GetTags( _IsPrivateList );

	if table.HasValue(_tags, tag ) then return false,1 end
	
	local _PostFix = GetTagPostFix( _IsPrivateList );

	//_tags[tag] = true;
	
	table.insert( _tags , tag );
	
	self:setFlag("ObjTags_" .. _PostFix, _tags, _IsPrivateList );
	SanitizeTagTables( self )
	
	if SERVER then
		
		ObjectTags.system.SavePlayerTags( self:SteamID() )
		
	end

	return true,0;
end

// Name: ENTITY:RemoveTag()
// Purpose: Removes a tag from the table and returns true if succeeded.
// Arguments: tag (string), private (bool)
// Returns: Success (bool)
function _eMeta:RemoveTag( tag, private )

	if !tag then return ErrorNoHalt( "No arguments for entity meta:RemoveTag(). " .. tag .. " " .. private ) end;
	
	if private == nil then

		local _PrvTags, _PubTags = self:GetTags();

		if table.HasValue(_PrvTags , tag) then
		
			//_PrvTags[tag] = nil;
			local keys = table.KeyFromValue( _PrvTags , tag );
			//print( keys )
			table.remove(_PubTags,keys)
			/*for k , v in pairs( keys ) do 
				table.remove(_PrvTags,v)
			end*/

			table.RemoveByValue( _PrvTags , tag )
			self:setFlag("ObjTags_Prv", _PrvTags, true );
			SanitizeTagTables( self )
		
		end
		
		if table.HasValue(_PubTags , tag) then
			
			//_PubTags[tag] = nil;
			local keys = table.KeyFromValue( _PubTags , tag );
			//print( keys )
			table.remove(_PubTags,keys)
			/*for k , v in pairs( keys ) do 
				table.remove(_PubTags,v)
			end*/

			table.RemoveByValue( _PubTags , tag )
			self:setFlag("ObjTags_Pub", _PubTags );
			SanitizeTagTables( self )

		end

		if SERVER then
			if self:IsPlayer() then
				ObjectTags.system.SavePlayerTags( self:SteamID() )
			end
		end
		
		return true;

	end

	local _tags = self:GetTags( private );

	local _IsPrivateList = private != nil && private || false;
	local _PostFix = GetTagPostFix( _IsPrivateList );


	if _tags[tag] then
			
		_tags[tag] = nil;

		self:setFlag("ObjTags_" .. _PostFix, _tags, private );

		return true;

	end

	if SERVER then
		if self:IsPlayer() then
			ObjectTags.system.SavePlayerTags( self:SteamID() )
		end
	end

	return false;

end
