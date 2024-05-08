
if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag Implementations.")

end 

/* Thanks Overv */
// https://gmod.facepunch.com/f/gmoddev/lhhv/Get-player-by-name/1/

function RetrievePlayerByName( name )
	name = name:lower()
	for k , v in pairs( player.GetAll() ) do
		if ( v:Nick():lower():find( name, 1, true ) ) then
			return v
		end
		if ( v:getRPName():lower():find( name, 1, true ) ) then
			return v
		end
	end
end

/*
hook.Add( "PlayerSay", "ChatTagManagement", function( ply, text, public )

	if ply:IsDev() then

		local _Sentence = string.Explode( " " , string.lower( text ) );
		local IsPrivate = false;

		if ( _Sentence[1] == "!addtag" ) then

			local _p = RetrievePlayerByName( _Sentence[2])

			if _p && _p:IsPlayer() then
				
				_p:AddTag( _Sentence[3] )
				
				ply:ChatPrint( "Added the tag of " .. _Sentence[3] .. " to " .. _p:Nick() )
				_p:ChatPrint( ply:Nick() .. " has added the following tag to your account: " .. _Sentence[3] )
			end


			return "";
			
		elseif ( _Sentence[1] == "!remtag" ) then
			
			local _p = RetrievePlayerByName( _Sentence[2])

			if _p && _p:IsPlayer() then

				_p:RemoveTag( _Sentence[3] )

				ply:ChatPrint( "Removed the tag of " .. _Sentence[3] .. " to " .. _p:Nick() )
				_p:ChatPrint( ply:Nick() .. " has removed the following tag to your account: " .. _Sentence[3] )

			end
			
			return "";
		end

	end

	return text;

end )
*/

gameevent.Listen( "player_disconnect" );
hook.Add( "player_disconnect", "SavePlayerTagsOnDisconnect", function( _data )

	// All of the data values; shown in case saving is done using steamid, or whatever...
	local _id = _data.userid;			// Same as Player:UniqueID( );
	local _p = Player( _id ); 			// The Player Entity, if valid
	local _steamID = data.networkid // 

	//DarkRPranks.jobtiming.UpdateJobTime( _p , _p:Team() )
	//print(_steamid)
	//PrintTable(_p:getFlag("PlayerJobTimes", {})) 

	ObjectTags.system.SavePlayerTags( _id )

end );

hook.Add( "ShutDown", "SaveAllPlayerTags", function( )
	
	for k , v in pairs( player.GetHumans() ) do

		ObjectTags.system.SavePlayerTags( v:SteamID() )

	end	
	
end );

hook.Add( "PlayerFullyConnected" , "LoadTagTable", function( _p, _clientside ) 

	//ObjectTags.system.LoadPlayerTags( _p:SteamID() )
		/*
	timer.Simple(3 ,function()

		if !_p || !IsValid( _p ) || !_p:IsPlayer() then return end

		if tonumber(os.date( "%H" , os.time() )) >= 18 && tonumber(os.date( "%H" , os.time() ))  < 19 then
			
			print("Attempting to add donator tag to " .. _p:Nick() )
			local _Success, Code = _p:AddTag("donator");
			
			if _Success == true then

				_p:Notify("You have received donator tag for playing between 6-7PM.")
				print("Successfully added donator tag to " .. _p:Nick() )
			
			elseif _Success == false && Code == 1 then

				print("Did not add donator tag to " .. _p:Nick() .. " because they already have the tag.")

			end

		else

			print("Did not add donator tag to " .. _p:Nick() .. " because its not peak hour.")

		end

	end)
		*/

end)