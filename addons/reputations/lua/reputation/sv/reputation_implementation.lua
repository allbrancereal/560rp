
if PlayerReputations.ShowDebugPrints then

	print( "Including Reputation Implementation Files.")

end

hook.Add("Saved_Reputation", "OnSavedReputation", function( _steamID , _success , _newRow, _failedMainQuery )

	if PlayerReputations.ShowDebugPrints then
		
		print( "Saved " .. _steamID .. "'s reputation." )

	end
	
end )

hook.Add("Reputation_Retrieval" , "ReceiveEquipment", function( _tb )

	if _tb[1] == true then
		
		local _p = player.GetBySteamID(_tb[3]);

		if !_p || !IsValid(_p) || !_p:IsPlayer() then
			
			return
			
		else

			if _tb[2] && _tb[2][1] && _tb[2][1].ReputationData then

				_p:setFlag("knownReputations", util.JSONToTable(_tb[2][1].ReputationData), true );

			end
			
		end	
	end

end )

local _pMeta = FindMetaTable("Player");

function _pMeta:SaveReputations()

	if self:getFlag("loadedIN",false) == true and PlayerReputations.Database then
		
		PlayerReputations.Database:SavePlayerData( self:SteamID() );

	end

end

function _pMeta:RetrieveReputations()

	if self:getFlag("loadedIN",false) == true and PlayerReputations.Database then
		
		PlayerReputations.Database:RetrievePlayerData( self:SteamID() );

	end

end

gameevent.Listen( "player_disconnect" );
hook.Add( "player_disconnect", "SavePlayerReputationsOnDisconnect", function( _data )

	// All of the data values; shown in case saving is done using steamid, or whatever...
	local _id = _data.userid;			// Same as Player:UniqueID( );
	local _p = Player( _id ); 			// The Player Entity, if valid
	local _steamID = data.networkid // 

	//DarkRPranks.jobtiming.UpdateJobTime( _p , _p:Team() )
	//print(_steamid)
	//PrintTable(_p:getFlag("PlayerJobTimes", {})) 

	PlayerReputations.Database:SavePlayerData( _id );

end );

hook.Add( "ShutDown", "SaveAllPlayerReputationsOnShutdown", function( )
	
	for k , v in pairs( player.GetHumans() ) do

		PlayerReputations.Database:SavePlayerData( v:SteamID() )
		
	end	
	
end );

hook.Add( "PlayerFullyConnected" , "LoadReputationsOnJoin", function( _p, _clientside ) 

	if _clientside == false and SERVER then
		_p:RetrieveReputations()
	end
	
end)

timer.Create("ReputationSaver", 60*5,0 , function()

	for k , v in pairs( player.GetAll() ) do
		
		v:SaveReputations()
		
	end

end )