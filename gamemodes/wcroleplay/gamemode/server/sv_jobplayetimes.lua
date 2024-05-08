

local _pMeta = FindMetaTable( 'Player' );

function _pMeta:LoadJobTimes( )
	if SERVER then
	
		fsdb:Query("SELECT `policetime`, `policerank`, `paramedictime`, `paramedicrank`, `mayortime`,`mayorrank` FROM `fsdb_jobtime` WHERE `steamid`='" .. self:SteamID() .. "'",
			function( _,data )
			
			if data && data[1] && data[1]["policetime"] then
			
			
				local _pTimeTable = {
				
					[TEAM_POLICE] = {
						Played = data[1]["policetime"] || 0 ;
						Rank = data[1]["policerank"] || 1 ;
					};
					
					[TEAM_PARAMEDIC] = {
						Played = data[1]["paramedictime"] || 0 ;
						Rank = data[1]["paramedicrank"] || 1 ;
					};

					[TEAM_MAYOR] = {
						Played = data[1]["mayortime"] || 0 ;
						Rank = data[1]["mayorrank"] || 1 ;
					};
					
				}
				self.__JobTimes = _pTimeTable
				self:setFlag( "jobPlaytimes", _pTimeTable )
					
				NetworkJobTimesToClient( self )
			else
			
				fsdb:Query("INSERT INTO `fsdb_jobtime` (`steamid`,`policetime`,`paramedictime`, `policerank`, `paramedicrank`, `mayortime`,`mayorrank`) VALUES('" .. self:SteamID() .. "', 0, 1,0,1,0,1)");
				
				local _toSet = {
				
					[TEAM_PARAMEDIC] = {
						Played = 0;
						Rank = 1;
					};
					
					[TEAM_POLICE] = {
						Played = 0;
						Rank = 1;
					};
					
					[TEAM_MAYOR] = {
						Played = 0;
						Rank = 1;
					};
					
				};
				
				self.__JobTimes = _toSet
				self:setFlag( "jobPlaytimes", _toSet ) 
				
				
			
			
			
				NetworkJobTimesToClient( self )
			end 
			
	end)
	end
end



function _pMeta:SetJobRank( team,rank)
		local v = self;
		local _team = team;
		
		if table.HasValue( {TEAM_POLICE, TEAM_PARAMEDIC, TEAM_MAYOR}, _team) then
			// Update the time
			local _PlayTime = v:getFlag( "jobPlaytimes", v.__JobTimes );
			
			if _PlayTime then
				 
				
				_PlayTime[_team].Rank = rank;
				_PlayTime[_team].Played = fsrp.JobRanks[_team][rank].time + 1;
					
				
				
				v:setFlag( "jobPlaytimes", _PlayTime )
				// check for promotion
				v:UpdateJobRank()
				// Save the time
				local PTime		= _PlayTime[TEAM_POLICE].Played || 0;
				local PRank		= _PlayTime[TEAM_POLICE].Rank || 1;
				local PATime		= _PlayTime[TEAM_PARAMEDIC].Played || 0;
				local PARank		= _PlayTime[TEAM_PARAMEDIC].Rank || 1;
				local MATime		= _PlayTime[TEAM_MAYOR].Played || 0;
				local MARank		= _PlayTime[TEAM_MAYOR].Rank || 1;
				

				fsdb:Query("UPDATE `fsdb_jobtime` SET `mayortime`='" .. MATime .."', `mayorrank`='" .. MARank .."',`policetime`='" .. PTime .."', `policerank`='" .. PRank .."', `paramedictime`='" .. PATime .."', `paramedicrank`='" .. PARank .."' WHERE `steamid`='" .. v:SteamID() .. "'");		

				NetworkJobTimesToClient(v)
			else
			
				v:LoadJobTimes()
			end
			end
			
		
		
	
end


function _pMeta:UpdateJobRank( )


	local CurrentRank = self:getFlag('jobPlaytimes', {});
	local NextRank = 0;
	local Team = self:Team();
	if !TeamsToTrack then return end
	if table.HasValue(TeamsToTrack, Team) then		
		for k, v in pairs(fsrp.JobRanks[Team]) do
			if CurrentRank[Team] >= v and NextRank < k then
				NextRank = k;
				CurrentRank[Team].Rank = NextRank;
			end
		end
	end

	
		if CurrentRank[Team].Rank != NextRank then
		
			self:setFlag('jobPlaytimes', CurrentRank);
			
			if NextRank != 0 then
			
				local IsPromo = false;
				
				if CurrentRank != 0 and CurrentRank < NextRank then
				
					self:Notify('You have been promoted to: ' .. fsrp.JobRanks[Team][NextRank]);
					
				else
				
					self:Notify('Current Rank: ' .. fsrp.JobRanks[Team][NextRank]);
					
				end
				
			end
			
		end
		
	NetworkJobTimesToClient( self )
end

function UpdateAllPlayerJobTimes()


for k,v in pairs(player.GetAll()) do
		local _team = v:Team();
		
        if (_team != TEAM_CITIZEN) then 
		if table.HasValue( {TEAM_POLICE, TEAM_PARAMEDIC, TEAM_MAYOR}, _team) then
			// Update the time
			local _PlayTime = v:getFlag( "jobPlaytimes", v.__JobTimes );
			
			if _PlayTime then
				
				
				_PlayTime[_team].Played = _PlayTime[_team].Played + 60;
					
				
				
				v:setFlag( "jobPlaytimes", _PlayTime )
				// check for promotion
				v:UpdateJobRank()
				// Save the time
				local PTime		= _PlayTime[TEAM_POLICE].Played || 0;
				local PRank		= _PlayTime[TEAM_POLICE].Rank || 1;
				local PATime		= _PlayTime[TEAM_PARAMEDIC].Played || 0;
				local PARank		= _PlayTime[TEAM_PARAMEDIC].Rank || 1;
				local MATime		= _PlayTime[TEAM_MAYOR].Played || 0;
				local MARank		= _PlayTime[TEAM_MAYOR].Rank || 1;
				

				fsdb:Query("UPDATE `fsdb_jobtime` SET `mayortime`='" .. MATime .."', `mayorrank`='" .. MARank .."',`policetime`='" .. PTime .."', `policerank`='" .. PRank .."', `paramedictime`='" .. PATime .."', `paramedicrank`='" .. PARank .."' WHERE `steamid`='" .. v:SteamID() .. "'");		

				NetworkJobTimesToClient(v)
			else
			
				v:LoadJobTimes()
			end
			end
			
		end
		
	end
	
end

timer.Create('UpdateJobTime', 60, 0, function()

	UpdateAllPlayerJobTimes()
	
end);

util.AddNetworkString("networkJobTimes")

function NetworkJobTimesToClient( v )
	
	for k , x in pairs( player.GetAll() ) do
	
		net.Start("networkJobTimes")
			net.WriteString( v:SteamID() ) 
			net.WriteTable( v:getFlag("jobPlaytimes" , {} ) ) 
		net.Send(x)
	
	end
end
