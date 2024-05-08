
fsrp.devprint("[560Roleplay] - Initializing Shared Player Hooks" )

if CLIENT then
	
	net.Receive( "PlayerFullyConnected", function( _len )
		local _p = LocalPlayer( );
		hook.Run( "PlayerFullyConnected", _p );
	end );
	
else

	util.AddNetworkString( "PlayerFullyConnected" );
	util.AddNetworkString( "fsrp.startLoadout" );
	//
	// PlayerFullyConnected
	//
	local function DetectPlayerFullyConnected( _p, _hook, ... )
		if ( _p.__FullyConnected ) then return; end

		// They're here...
		_p.__FullyConnected = true;

		// Notify the client that they're here.
		net.Start( "PlayerFullyConnected" );
		net.Send( _p );

		// Broadcast the hook...
		hook.Run( "PlayerFullyConnected", _p );
		if SERVER then
			hook.Run ( "initializePlayer", _p )
		end
	end
	hook.Add( "SetupMove", "PlayerFullyConnected:SetupMove", function( _p, _move, _cmd ) DetectPlayerFullyConnected( _p, "SetupMove" ); end );
	
	
end

fsrp.devprint("[560Roleplay] - Fetched Shared Player Hooks" )
