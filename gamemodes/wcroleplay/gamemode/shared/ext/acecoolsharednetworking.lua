//
// Super Light-Weight Networking and Data Management System - Josh 'Acecool' Moser
//

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end


//
// Returns only the numbers in a string by stripping non-numbers
//
function string.numbers( _text )
	return tonumber( string.gsub( ( _text || "" ), "%D", "" ), 10 ) || -1;
end

//
// Outputs public world-data - SERVER and CLIENT knows all...
//
concommand.Add( "dev_getworlddata", function( _p, _cmd, _args, _args_text )
	if ( IsValid( _p ) && !_p:IsDev( ) ) then return; end

	local _data = data:GetTable( ( _args[ 1 ] && true || false ) );
	local _output = ( _data && _data[ 0 ] ) && _data[ 0 ] || { };
	PrintTable( _output );
end );


//
// Outputs public data ( optionally for entity id ) - SERVER and CLIENT knows all...
//
concommand.Add( "dev_getdata", function( _p, _cmd, _args, _args_text )
	if ( IsValid( _p ) && !_p:IsDev( ) ) then return; end

	local _data = data:GetTable( false );
	local _id = string.numbers( _args_text );
	local _output = ( _data ) && ( ( _id && _data[ _id ] ) && _data[ _id ] || _data ) || { };
	PrintTable( ( _output ) );
end );


//
// Outputs known private data ( optionally for entity id ) - SERVER knows all, clients know some...
//
concommand.Add( "dev_getpdata", function( _p, _cmd, _args, _args_text )
	if ( IsValid( _p ) && !_p:IsDev( ) ) then return; end

	local _data = data:GetTable( true );
	local _id = string.numbers( _args_text );
	local _output = ( _data ) && ( ( _id && _data[ _id ] ) && _data[ _id ] || _data ) || { };
	PrintTable( ( _output ) );
end );

//
// Init...
//

// We modify the entity meta table further down for _ent:SetFlag( _flag, _value, _private ); and _ent:GetFlag( _flag, _value, _private );
local META_ENTITY	= FindMetaTable( "Entity" );

//
data = data || {
	__data = {
		public = {

		};
		private = {

		};
	};
};

// This is to have a secondary link to data in case data is overwritten...
acecool = acecool || { };
acecool.data = data;

//
// Functions
//


//
// Return a valid ent index or false...
//
function data:GetID( _id )
	return ( ( isnumber( _id ) ) && _id || ( ( IsValid( _id ) ) && _id:EntIndex( ) || false ) );
end


//
// Return the active table...
//
function data:GetTable( _private )
	return self.__data[ ( ( _private ) && "private" || "public" ) ];
end


//
// Reset data stored at _id....
//
function data:Reset( _id, _tab )
	// Use simple entity index as the key...
	local _id = self:GetID( _id );
	if ( !_id ) then return; end

	// Grab the data
	if ( _tab[ _id ] ) then
		// Clear public data
		for k, v in pairs( _tab[ _id ] ) do
			v = nil;
		end

		// Finally, nullify the table
		_tab[ _id ] = nil;
	end
end


//
// Returns data for entity id sub flag or returns default if unset....
//
function data:GetFlag( _id, _flag, _default, _private )
	// Use simple entity index as the key...
	local _id = self:GetID( _id );
	if ( !_id ) then return; end

	// Grab the data
	local _data = self:GetTable( _private );

	// If the data is set, then return it ( allow false too... )
	if ( _data[ _id ] && _data[ _id ][ _flag ] != nil ) then
		return _data[ _id ][ _flag ];
	end

	// Or return default...
	return _default;
end


//
// Updates data...
//
function data:SetFlag( _id, _flag, _value, _private )
	// Use simple entity index as the key...
	local _id = self:GetID( _id );
	if ( !_id ) then return false; end

	// Grab current value
	local _current = self:GetFlag( _id, _flag, nil, _private );

	// Never send data that ends up being the same.. may need other checks for different data types... but this is just a quick net system...
	if ( _value == _current ) then return false; end

	// Data isn't the same, we need to get the table to modify it...
	local _data = self:GetTable( _private );

	// May as well grab the end for a few checks...
	local _ent = Entity( _id );

	// Quick edit to allow automated private data-linking between non-player entities which are linked to a player via owner / driver / etc..
	local _isvalid		= IsValid( _ent );

	// The server has a duty to update the client... This can be modified to use my link system...
	// Added quick edit to allow private data-linking between non-player-ents that have an owner / driver / etc...
	if ( SERVER && _isvalid ) then
		net.Start( "AcecoolLightNWSystem" );
			net.WriteUInt( _id, 13 ); -- 13 should be 8192 or so which should be ent limit...
			net.WriteString( _flag );
			net.WriteBit( _private );

			 // If we know the value then write specific type, otherwise use a map...
			-- local _type = TypeID( _value );

			// self should be implied as TypeID... if not, set as ( _type, _value )
			-- net.WriteVars[ _type ]( _type, _value );

			// Write the data...
			net.WriteType( _value );



		// Now, if private only update client otherwise tell everyone...
		if ( _private ) then
			// Quick mod to allow data-linking..
			local _recipient = _ent;
			if ( _isprop || _isweapon ) then _recipient = _ent.Owner; end
			if ( _isvehicle ) then _recipient = _ent:GetDriver( ); end

			net.Send( _recipient );
		else
			net.Broadcast( );
		end
	end

	// Make sure we have an entity index table in public or private table...
	if ( !_data[ _id ] ) then _data[ _id ] = { }; end

	// Now, we update our data on client or server or whatever...
	_data[ _id ][ _flag ] = _value;

	// Just in case we call it in an if and need to know ( hence the false's up above )...
	return true;
end


//
// Entity Helper-Functions
//


//
//
//
function META_ENTITY:getFlag( _flag, _default, _private )
	return acecool.data:GetFlag( self:EntIndex( ), _flag, _default, _private );
end


//
//
//
function META_ENTITY:setFlag( _flag, _value, _private )
	return acecool.data:SetFlag( self:EntIndex( ), _flag, _value, _private );
end


//
// Shared Hooks
//


//
// Override hook for what to happen on player fully connected...
//
function gamemode:PlayerFullyConnected( _p, _clientside )

end


//
// Server / Client Hooks
//
if ( SERVER ) then
	//
	// Network Strings
	//
	util.AddNetworkString( "AcecoolPlayerFullyConnected" );
	util.AddNetworkString( "AcecoolLightNWSystem" );
	util.AddNetworkString( "AcecoolLightNWSystem_FULLSYNC" );


	//
	// We check for EntityRemoved on the server because the client calls this when an ent leaves PVS which causes issues...
	//
	hook.Add( "EntityRemoved", "AcecoolLightNWSystem:Reset", function( _ent )
		// No point in continuing if the entity isn't valid...
		if ( !IsValid( _ent ) ) then return; end

		local _id = _ent:EntIndex( );
		acecool.data:Reset( _id, acecool.data:GetTable( ) );
		acecool.data:Reset( _id, acecool.data:GetTable( true ) );
	end );


	//
	// Hooked into PlayerFullyConnected to sync data to the client that just joined.....
	//
	function META_ENTITY:FullNWSync()
		local _p = self;

		
		if ( IsValid( _p ) && _p.IsPlayer && _p:IsPlayer( ) ) then
			net.Start( "AcecoolLightNWSystem_FULLSYNC" )
				net.WriteUInt( _p:EntIndex( ), 13 );
				net.WriteTable( acecool.data.__data.public );
				net.WriteTable( acecool.data:GetTable( true )[ _p:EntIndex( ) ] || { } );
			net.Send( _p );
		end

	end
	hook.Add( "PlayerFullyConnected", "AcecoolLightNWSystem:Sync", function( _p , is_client )
		// Sync all data for clients...
		_p:FullNWSync()
		
	end );


 
	//
	//
	//
	net.Receive( "AcecoolPlayerFullyConnected", function( _len, _p ) 
		// Call the PlayerFullyConnected and let the hook know it is called serverside...
		hook.Call( "PlayerFullyConnected", gamemode, _p, false );
	end );
else
	//
	// Player Fully Connected System
	//
	__PLAYER_FULLY_CONNECTED_HOOK = __PLAYER_FULLY_CONNECTED_HOOK || false;
	if ( !__PLAYER_FULLY_CONNECTED_HOOK ) then
		//
		__PLAYER_FULLY_CONNECTED_HOOK = true;


		//
		// Apparently SetupMove no longer works properly or there is another issue...
		//
		hook.Add( "RenderScene", "PlayerFullyConnected:RenderSceneCheck", function( )
			// Make sure the player entity is valid, and not "worldspawn"...
			local _p = LocalPlayer( );
			if ( _p == NULL || !_p:IsPlayer( ) ) then return; end

			// Let the world know the local-player has connected...
			hook.Call( "PlayerFullyConnected", gamemode, _p, true );

			// Network the data to the server ( I hate having to trust the client with this because SetupMove no longer works to detect client fully connected on server and other methods are too unreliable )...
			net.Start( "AcecoolPlayerFullyConnected" );
			net.SendToServer( );

			// Kill our helper..
			hook.Remove( "RenderScene", "PlayerFullyConnected:RenderSceneCheck" );
		end );
	end


	//
	// Update raw data table on fully connected...
	//
	net.Receive( "AcecoolLightNWSystem_FULLSYNC", function( )
		local _id = net.ReadUInt( 13 );
		acecool.data.__data.public = net.ReadTable( );
		acecool.data.__data.private[ _id ] = net.ReadTable( );
	end)


	//
	// Read the data...
	//
	net.Receive( "AcecoolLightNWSystem", function( )
		local _p = LocalPlayer( );
		if ( !IsValid( _p ) ) then return; end

		local _id = math.abs( net.ReadUInt( 13 ) );
		local _flag = net.ReadString( );
		local _private = tobool( net.ReadBit( ) );
		local _value = net.ReadType( );



		// Update directly ( don't rely on ENT because it may be NULL if ent was never in PVS )
		acecool.data:SetFlag( _id, _flag, _value, _private );
	end );
end