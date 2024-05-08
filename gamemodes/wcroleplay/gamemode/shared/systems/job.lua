
local _pMeta = FindMetaTable( 'Player' )
// moved to sv_player
if SERVER then
	function _pMeta:teamBan()		
		self:HasCooldown("JobDemotion",300);
		self:Notify("You have been demoted from your job, but you can keep your weapons.")
		self:LeaveJob()
	end
	util.AddNetworkString("PolicePDAAction")
	net.Receive("PolicePDAAction", function(_l,_p)
		local _integerreturn = net.ReadInt(3);
		local _shouldwarrant = _integerreturn == 1 && true || false;
		local _pid = net.ReadString()
		local _playerfromid = player.GetBySteamID(_pid)
		if _integerreturn <= 2 then
			if !_playerfromid then return _p:Notify("We cannot find that person in the database.") end
			if _p:Team() == TEAM_MAYOR || _p:Team() == TEAM_POLICE || _p:IsAdmin() then
				if !_shouldwarrant then
					if _playerfromid:getBank() < 0 then
						_playerfromid:setBankAccount(2);
						_playerfromid:setBank(0);
					end
					for k , v in pairs(player.GetAll()) do
						if v != _playerfromid then
							v:ChatMessage("[GOVERNMENT] A Warrant has been issued for " .. _playerfromid:getRPName() ,12)
						end
					end
				else
					if _p == _playerfromid then return _p:Notify("You can not put a warrant on yourself.") end
					if _playerfromid:Team() == TEAM_MAYOR then return _p:Notify("You may not put a warrant on the mayor.") end
					if _playerfromid:Team() == TEAM_POLICE then return _p:Notify("You may not put a warrant on another police officer") end
					local _jobinfo = _p:GetJobTimeInfo(TEAM_POLICE);
					if _p:GetJobTimeInfo(TEAM_MAYOR) then
						if _jobinfo then
							if _p:GetJobTimeInfo(TEAM_MAYOR).Rank > _jobinfo then
								_jobinfo = _p:GetJobTimeInfo(TEAM_MAYOR);
							end
						end
					end
					if _jobinfo then
						if _jobinfo.Rank > 2 then
							_playerfromid:ToggleWanted()
						else
							_p:Notify("You must be at rank 3 to request a warrant.")
						end
						
					end
				end
			end
		elseif _integerreturn == 3 && _p:Team() == TEAM_MAYOR then
			if _p == _playerfromid then return _p:Notify("You can not put a warrant on yourself.") end
			if _playerfromid:Team() == TEAM_MAYOR then return _p:Notify("You may not demote yourself.") end
            if _playerfromid:Team() == TEAM_CIVILLIAN then return _p:Notify("You can't demote someome who does not work for you!") end
            _playerfromid:teamBan()
            _playerfromid:changeTeam(GAMEMODE.DefaultTeam, true)
			for k , v in pairs(player.GetAll()) do
				if v != _playerfromid then
					v:ChatMessage("[GOVERNMENT] " .. _playerfromid:getRPName() .. " has been demoted from their duties.",12)
				end
			end
			_playerfromid:Notify("The mayor has demoted you!")
		end
	end)

end

jobInfoTable = {
	[TEAM_PARAMEDIC] = {
		JobName = "Paramedic",
		TimeReq = 1800,
		JoinNotification = "You have joined the Paramedic Team! Travel around the city and help people in need of medical assistance.",
		Paycheque = 75,
		PerEmployee = 5,
		PreReqQuests = {5},
		Equipment = {
			"defibrillator",
			"healthkit",
			"nose"
		}
	};
	[TEAM_POLICE]	 = {
		JobName = "Police Officer",
		TimeReq = 3600,
		JoinNotification = "You have joined the Police Force! Protect citizens from criminals and investigate cases around the city.",
		Paycheque = 85,
		PerEmployee = 5;
		Equipment = {
			"nightstick",
			"handcuffs",
			"cw_mr96",
			"vc_spikestrip_wep",
			"battering_ram",
			"nose"
		}
		
	};
	[TEAM_MAYOR]	={
		JobName = "Elected Mayor",
		TimeReq = 7200,
		JoinNotification = "You have been elected as the Mayor of town. You may adjust it's rules to suit the citizens needs.",
		Paycheque	= 16500,
		Equipment = {
			"nose"
		}
	}
};
function GetMaxEmployees( _t )
	if !jobInfoTable[ _t ].PerEmployee then return false end

	return math.ceil(math.Clamp( #player.GetAll()/jobInfoTable[_t].PerEmployee , 0 , 25 ));

end
function IsJobFull( _t )
	if !jobInfoTable[ _t ].PerEmployee then return false end
	local _maxEmp = math.ceil(math.Clamp( #player.GetAll()/jobInfoTable[_t].PerEmployee , 0 , 25 ));
	local _curEmp = team.NumPlayers( _t )
	return (_curEmp >= _maxEmp)


end
