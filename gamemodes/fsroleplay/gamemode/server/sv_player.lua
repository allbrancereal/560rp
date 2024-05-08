fsrp = fsrp || {}

fsrp.devprint("[560Roleplay] - Fetching Serverside Player Networking")
net.Receive( "fsrp.sendUsYourName" , function( len, _p )

	local firstName, lastName, pmodel = net.ReadString( ) , net.ReadString( ), net.ReadString()
	
	if fsrp.IsValidName( firstName, lastName ) then
	
		fsdb:Query("UPDATE `fsdb_user` SET `first_name`='" .. firstName .. "', `last_name`='" .. lastName .. "' WHERE `id`='" .. _p:SteamID() .. "';");

		fsrp.devprint("[560Roleplay] - Updated Player (It's their first time here!)")
		
		_p:setFirstName( firstName )
		_p:setLastName( lastName )
		
		// Model Stuff
		local modelInfo = ExplodeModelInfo(pmodel) or {};
		local theirNewModel = _p:GetModelPath(modelInfo.sex or "f", tonumber(modelInfo.id) or 1);
		
		_p:SetModel( theirNewModel.mdl );
		_p.__oModel = modelInfo;
		fsdb:Query( "UPDATE `fsdb_user` SET `model` = '" .. modelInfo.sex .. "_" .. modelInfo.id .. "' WHERE `id`='" .. _p:SteamID() .. "';" );
		
		_p.__mSex = modelInfo.sex or 1;


	end

end )

net.Receive( "buyInitialShare", function ( len , _p ) 

	local _bID = net.ReadInt( 8 )
	
	if _p:getShares( _bID ).shares > 0 then
		
		return _p:Notify("Go to the buisiness to buy shares!")
			
	else
	
		if _p:getBankAccount() == 3 then
		
			_p:setShares( _bID , 1 , 1,  0 )
			fsrp.UpdateClientShares( _p, _bID, 1, 1, 0 )	
			_p:Notify("You have bought your initial stock, go to the buisiness to get more!")
				
			saveBuisinesses( _p )
			
		else
			
			_p:Notify("You need a buisiness account to initialize a stock")
			
		end
		
	end
		
end )

net.Receive( "fsrp.changemodel", function( len, _p )

	local _mdlTable = net.ReadTable();
	
	if _p:canAfford( FACIAL_COST ) then
	
		_p:SetModel( _mdlTable[2] );
		_p:setClientGender( _mdlTable[1] );
		_p.__oModel = ExplodeModelInfo( _mdlTable[3] )
		fsdb:Query( "UPDATE `fsdb_user` SET `model` = '" .. _mdlTable[3] .."' WHERE `id`='" .. _p:SteamID() .. "';" );
		_p:ChatPrint( "You have changed your model" )
		
	else
	
		_p:ChatPrint( "You can not afford this" )
	
	end

end )

local _pMeta = FindMetaTable("Player")

function _pMeta:SetPlayerTeam( int )

	if int > 4 || int < 0 then return false end
	
	self:SetTeam( int )
	
	return true

end

function GM:PlayerDeath( _p , _i, _k )
	
	local _kt = tostring(_k)
	
	if _k && IsValid( _k ) && _k:IsPlayer() then
	
		_kt = _k:Nick()
		
	end
	
	if _k:IsVehicle() && IsValid( _k:GetDriver( ) ) then
	
		_kt = _k:GetDriver():Nick() .. " (Withing a Vehicle)";
		
	end
	
	if _k != _p then
		
		print( "[560Roleplay] " .. _kt .. " has killed " .. _p:Nick() .. "." )
		
	end
	
	_p.__DeathPos = _p:GetPos()
	
	fsrp.DeadPlayers[ _p:UniqueID() ] = { _p.__DeathPos };
	
	if _i && _i:IsVehicle( ) then
	
		_p.__RespawnTime = CurTime() + math.random( 20 , 40 )
		
		_p:Notify( "You have been hit by a vehicle. Paramedics will be able to revive you once called out" )
	
	elseif _p:WaterLevel() >= 3 then
	
		_p.__RespawnTime = CurTime() + math.random( 40 , 60 )
	
	else
	
		_p.__RespawnTime = CurTime() + math.random( 10 , 20 )
		
	end

end

function GM:PlayerDeathThink ( _p )

	_p.__RespawnTime = _p.__RespawnTime || 0
	
	if _p.__RespawnTime < CurTime( ) then
	
		fsrp.DeadPlayers[ _p:UniqueID() ] = nil;
		_p.__Crippled = 0;
		_p:Spawn()
		
		_p:Notify( "You have died, sadly the paramedics were not able to restore you to a concious state." )


	end
	
end

function GM:CanPlayerSuicide( _p )

	if !_p:IsSuperAdmin() then return end
	
end

function GM:GetFallDamage( _p , speed )

	return math.Clamp( speed / 10 , 5, 100 )
	
end

function GM:ScalePlayerDamage( _p , _hg , _di )
	
	local _a = _di:GetAttacker( )
	local _ds = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
	
	if _a && IsValid( _a ) && _a:IsPlayer() then
	
		if ( !self:PlayerShouldTakeDamage( _p , _a ) ) then
		
			return _di
			
		end
		
	end

	if _p:Alive() then
	
		if _hg == HITGROUP_HEAD then
		
			_di:ScaleDamage( 1.5 )
			
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_CHEST || _hg == HITGROUP_GENERIC then
		
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/hitingut0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/hitingut0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_LEFTARM || _hg == HITGROUP_RIGHTARM then
		
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/myarm0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/myarm0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_GEAR then
			
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/startle0"..math.random(1, 2)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/startle0"..math.random(1, 2)..".wav");
			
			end
			
		elseif _hg == HITGROUP_RIGHTLEG || _hg == HITGROUP_LEFTLEG && _p.__Crippled == false then
		
			_p.__Crippled = true;
			
			_p:Notify( "Your legs have been broken! You should seek a medic!" )
			
			
			if _p:getGender() == 1 then
			
				_ds = Sound('vo/npc/female01/myleg0' .. math.random(1, 2) .. '.wav');
				
			else
			
				_ds = Sound('vo/npc/male01/myleg0' .. math.random(1, 2) .. '.wav');
			
			end
			
		else
		
			if _p:getGender() == 1 then
			
				_ds = Sound("vo/npc/female01/pain0"..math.random(1, 9)..".wav");
				
			else
			
				_ds = Sound("vo/npc/male01/pain0"..math.random(1, 9)..".wav");
			
			end
			
		end // Hitgroup
		
		sound.Play( _ds , _p:GetPos() , 100 , 100 );
		
	end // IsAlive()

	
	if _p:Team() == TEAM_POLICE then
	
		_di:ScaleDamage( 0.90 )
		
	end
	
	return _di;
end	// Function
fsrp.devprint("[560Roleplay] - Accquired Serverside Player Networking")
