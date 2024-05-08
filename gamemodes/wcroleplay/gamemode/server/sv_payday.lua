fsdb = fsdb or {}
fsrp.devprint( "[WC-RP] - Fetching Paydays" )
local _tag = 'wc';

function GetReward( _p )

	if ( string.find( _p:Nick():lower(), _tag ) ) || _p:IsSuperAdmin() then

		return true
	
	else 
	
		return false 
	
	end
end

function GivePaydayCash(v )

	local _count = table.Count( player.GetAll() )
	//fsdb.saveWeather()
	//for k , v in pairs( player.GetAll() ) do
	local timePlayed = 0;
	local _indexAtTime = 1;
	
	local _warrent = v:getFlag("warrent", false);
	v:setFlag("SVTimeLastPayday",os.time());
	if v:Team() == TEAM_MAYOR then
		local _paydayCount = 8-v:getFlag("MayorPaydays",0);
		if isnumber(_paydayCount) and _paydayCount-1 < 0 then

			v:LeaveJob(true)
			v:Notify("You have been demoted from your job as mayor because you have served your term.")
			for k , p in pairs(player.GetAll()) do
				if v!=p then
					p:Notify("The mayor has served his term and has been demoted to civillian.")
				end
			end
		
			v:setFlag("MayorPaydays",nil);
		else
			v:setFlag("MayorPaydays", _paydayCount-1);
		end
	end
	if _warrent then
		local _lastwarrent = v:getFlag('Lastwarrent', 0);

		if CurTime()-fsrp.config.WarrentTime > _lastwarrent then
			
			v:ToggleWanted()

		end

	end

	if v:Team() != TEAM_CIVILLIAN && fsrp.JobRanks[v:Team()] then
		
		local timePlayed = v:GetJobTimePlayed(v:Team());
		
		for k , v in pairs( fsrp.JobRanks[v:Team()] ) do
			
			if v.time > timePlayed then
				
				break
								
			end
			
			_indexAtTime = v.Rank || 1;
			
			
			
		end
		
	end
	
		
		local _toGive = fsrp.config.MinimumPayday + _count;
		
	if v:Team() != TEAM_CIVILLIAN && jobInfoTable[v:Team()] then
		local _level = 1;
		if v:GetRotoLevel(3) then
			_level = v:GetRotoLevel(3)[1]
		end
		_toGive =(_count + jobInfoTable[v:Team()].Paycheque * _indexAtTime)*_level;
	
	else
		_toGive = 45;
	end
	
		local _hasReward = GetReward( v );
		local _accountLevel = v:getBankAccount();
		if v.__paydayhealmoney == true then
				if v:canAffordBank( (fsrp.config.HealthResetCost + 250) ) then
				
					v:Notify("You have been deducted -$".. fsrp.config.HealthResetCost + 250 .." for receiving a health treatment")
					v:setBank( v:getBank() - (fsrp.config.HealthResetCost + 250) )
					
				else
				
					v:setMoney ( 0 )
					
				end
				
				v.__paydayhealmoney = false
				return
				
		end
		
		
		if v:IsPremium() then
		
			_toGive = _toGive * 1.5
			
		elseif v:IsDonator() then
		
			_toGive = _toGive * 1.25;
			v:Notify( "You have been given an extra 25% payday cash being a donator!" )
			
		end

			
		if _hasReward || v:IsPremium() then

			_toGive = _toGive * 1.25;
			local _perc = v:IsPremium() && "85%" || v:IsDonator() && "65%" || "35%";
			v:Notify( "You have been given an extra ".._perc.." payday cash for being a premium member!" )
			
		else
		
			
			v:Notify( "You could be earning 25% more each payday if you wear the tag! [" .. _tag:upper() .. "]" )
		
		end

		/* if tonumber(os.date( "%H" , os.time() )) >= 19 && tonumber(os.date( "%H" , os.time() ))  <= 20 then

			_toGive = _toGive * 2;

		end */

		if v:HasCooldown("PaydayBoost") then
			_toGive=_toGive*2
		end
		local totalrew;
		local _zones = v:GetZoneInvestments()
		
		if _zones["rp_downtown_v4c_v2"] and #_zones["rp_downtown_v4c_v2"] <= 0 or  _zones["rp_evocity_v33x"] and #_zones["rp_evocity_v33x"] <= 0 or !_zones["rp_downtown_v4c_v2"]  and !_zones["rp_evocity_v33x"]  then
			local _investment = v:CalculatePropertyIncome();
			_toGive = _toGive + _investment
			v:Notify("You have gained $" .. _investment .. " from your rental investments.")
		elseif _zones["rp_downtown_v4c_v2"] and #_zones["rp_downtown_v4c_v2"] > 0 or  _zones["rp_evocity_v33x"] and #_zones["rp_evocity_v33x"] > 0  then
			local _toget = 0;

			for k , z in pairs(fsrp.config.InvestmentZones) do
				
				if _zones[k] then
					for x, y in pairs(z) do

						if _zones[k][x]  then
							_toget = _zones[k][x]*0.01
							_zones[k][x] = math.max(_zones[k][x]-((y.StartingInvestment*0.01)),0);
							if _zones[k][x] == 0 then
								_zones[k][x] = nil;
							end
						end
					end
				end
				
			end

			v:setFlag("zoneinvestments",_zones)
			v:SavePermanentData(util.TableToJSON(v:getFlag("zoneinvestments" , {} )),  "ZoneInvestments")
			v:FullNWSync()
			_toGive = _toGive +_toget;
			v:Notify("You have gained $" .. _toget .. "  from your zone investments.")
		

		end
		
		if _accountLevel == 0 then
		
			v:addMoney( _toGive )
			v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive)) .. " to wallet!" )
			v:Notify( "If you go to the bank and get a account, you can start investing to make more money!" )
			
		elseif _accountLevel == 1 then

			_toGive = _toGive - fsrp.config.atmfeesurcharge[_accountLevel][3];
			
			local _toGiveBankmoney = v:getBank() * fsrp.config.atmfeesurcharge[_accountLevel][1];
			v:addBank( (_toGiveBankmoney + _toGive) )
			local _bnkacct = {
				"Smart Savings",
				"Chequing",
				"Business",
			}
			v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive) + math.ceil(_toGiveBankmoney)) .. " (+$"..math.ceil(_toGiveBankmoney).." Interest) to your " .. _bnkacct[_accountLevel] .. " account!" )
					
		end
		
		for x, y in pairs( QUEST_TABLE ) do
		
			if v.__activeQuests && v.__activeQuests[y.ID] && v.__activeQuests[y.ID].Completed == false then
				v:Notify( "Current Active Quests:" .. v.__activeQuests[y.ID].Name .. "! (Check F1 for more!)" )
				
			end
		
		end
	//end
	
	
end

fsrp.RestartGoing = false;

function PrintMessageAll ( Text )
	Msg(Text .. '\n');

	for k, v in pairs(player.GetAll()) do
		if v and v:IsValid() and v:IsPlayer() then
			v:Notify(Text)
		end
	end
end



function fsrp.RestartMap ()
	if fsrp.RestartGoing then return false; end
	
	fsrp.RestartGoing = true;
	
	PrintMessageAll('Server restart in 10 minutes.');
	timer.Simple(60 * 1, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 9 minutes.') end);
	timer.Simple(60 * 2, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 8 minutes.') end);
	timer.Simple(60 * 3, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 7 minutes.') end);
	timer.Simple(60 * 4, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 6 minutes.') end);
	timer.Simple(60 * 5, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 5 minutes.') end);
	timer.Simple(60 * 6, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 4 minutes.') end);
	timer.Simple(60 * 7, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 3 minutes.') end);
	timer.Simple(60 * 8, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 2 minutes.') end);
	timer.Simple(60 * 9, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 1 minutes.') end);
	timer.Simple(60 * 9 + 30, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 30 seconds.') end);
	timer.Simple(60 * 9 + 45, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 15 seconds.') end);
	timer.Simple(60 * 9 + 50, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 10 seconds.') end);
	
	for i = 1, 8 do
		timer.Simple(60 * 9 + 50 + i, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in ' .. 10 - i .. ' seconds. (Get Ready!)') end);
	end
	
	timer.Simple(60 * 9 + 59, function() if !fsrp.RestartGoing then return end  PrintMessageAll( 'Server restart in 1 second.') end);
	
	timer.Simple(60 * 10, function() if !fsrp.RestartGoing then return end RunConsoleCommand( 'changelevel', game.GetMap()) end);
	timer.Simple(60 * 9 + 55, function()  if !fsrp.RestartGoing then return end RunConsoleCommand('changelevel') end);

end

function fsrp.AbortRestart()
	if !fsrp.RestartGoing then return end 

	fsrp.RestartGoing = false;
	PrintMessageAll('Server restart has been cancelled.');

end
function fsrp.CreatePaydayDistributionTimer()

	if !timer.Exists("paydayDistributionTimer" ) then
		print("Started Payday Distribution Timer.")
		timer.Create( "paydayDistributionTimer", fsrp.config.PayDayTime , 0, function()
			//fsdb.saveWeather()

			hook.Run( "PaydayDistribution" )
			print("Distributing Paydays.")
			
		end )
	else
		print("Already running payday distribution timer " .. timer.TimeLeft("paydayDistributionTimer"));
	end

end
hook.Add( "InitPostEntity", "distributePaydays", function ( )
	fsdb.loadWeather()
	fsrp.CreatePaydayDistributionTimer()
end )

local _BonusHourTable = {
	{ Time = 18 , Bonus = "Free Donator Hour! (6PM)"};
	{ Time = 19 , Bonus = "Double Payday Bonus Hour! (7PM)"};
	{ Time = 20 , Bonus = "Double Cannabis Bonus Hour! (8PM)"};
	{ Time = 21 , Bonus = "Double Bitcoin Bonus Hour! (9PM)"};
}

local function FindBonusHourTitle()
	local foundBonus = false;
	local actlHr = 1;

	for k , v in pairs( _BonusHourTable ) do

		if v.Time == tonumber(os.date( "%H" , os.time() ))  then

			foundBonus = true;
			actlHr	= k;
			RunConsoleCommand( "hostname", "West Coast Roleplay - Need Admins| " .. v.Bonus )

			break;
		end

	end

	if !foundBonus then

		//RunConsoleCommand( "hostname" , "West Coast Roleplay - Need Admins|Semi-Serious|Reputation|Computers" )

	else

		for k , v in pairs( player.GetAll() ) do

			v:Notify("It's " .. _BonusHourTable[actlHr].Bonus )

		end

	end

	return foundBonus
end
//hook.Add("FindHostName", "findmainhostname", FindBonusHourTitle);
hook.Run("FindHostName");

fsrp.mayorgovernmentdefault = {
	money = fsrp.config.mayoral.citybaseincome,
	name = fsrp.config.mayoral.DefaultName,
	carlimits = {
		policecruiser = fsrp.config.mayoral.carlimits.police.default,
		ambulance = fsrp.config.mayoral.carlimits.ambulance.default,
	},
	tax = {
		income = fsrp.config.mayoral.taxinfo.income.default;
		sales = fsrp.config.mayoral.taxinfo.sales.default
	},
	salary = {
		[TEAM_PARAMEDIC] = fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].default;
		[TEAM_MAYOR] = fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].default;
		[TEAM_POLICE] = fsrp.config.mayoral.salaryinfo[TEAM_POLICE].default;
		[TEAM_CIVILLIAN] = fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].default;
	},
}

fsrp.mayorgovernment = fsrp.mayorgovernmentdefault or {};
util.AddNetworkString("updatemayorconfig")

net.Receive("updatemayorconfig", function(_l, _p)

	if !_p:IsCouncilMember() && _p:Team() != TEAM_MAYOR then return _p:Notify("You need to be a mayor to do this.") end
	local _tb= net.ReadTable()


	fsrp.mayorgovernment.carlimits.policecruiser = math.floor(_tb.maxvehicles.police)
	fsrp.mayorgovernment.carlimits.amublance = math.floor(_tb.maxvehicles.ambulance)

	fsrp.mayorgovernment.tax.income = _tb.tax.income
	fsrp.mayorgovernment.tax.sales =  _tb.tax.sales

	fsrp.mayorgovernment.salary[TEAM_PARAMEDIC] =_tb.salary[TEAM_PARAMEDIC]
	fsrp.mayorgovernment.salary[TEAM_MAYOR] =_tb.salary[TEAM_MAYOR]
	fsrp.mayorgovernment.salary[TEAM_POLICE] =_tb.salary[TEAM_POLICE]
	fsrp.mayorgovernment.salary[TEAM_CIVILLIAN] =_tb.salary[TEAM_CIVILLIAN]

	fsrp.mayorgovernment.name = _tb.name;
	fsrp.config.mayorgovernment.functions.Update()


	for k , v in pairs(player.GetAll()) do 
		v:Notify("The mayor has changed the laws of the land.")
	end

end)
function fsrp.config.mayorgovernment.functions.Update()
	fsrp.mayorgovernment.money = fsrp.mayorgovernment.money + fsrp.config.mayoral.citybaseincome;
	net.Start("updatemayorconfig")
	net.WriteTable(fsrp.mayorgovernment)
	net.Broadcast()
end

function CalculateBankExtra(_p ,_am)
	local _toGive =_am;
	local _toGiveBankMoney = 0;

	if _accountLevel == 0 then
			
		//v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive)) .. " to wallet!" )
		//v:Notify( "If you go to the bank and get a account, you can start investing to make more money!" )
		
	elseif _accountLevel == 1 then

		_toGive = _toGive - fsrp.config.atmfeesurcharge[_accountLevel][3];
		
		_toGiveBankmoney = v:getBank() * fsrp.config.atmfeesurcharge[_accountLevel][1];
		v:addBank( (_toGiveBankmoney + _toGive) )
		local _bnkacct = {
			"Smart Savings",
			"Chequing",
			"Business",
		}
		//v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive) + math.ceil(_toGiveBankmoney)) .. " (+$"..math.ceil(_toGiveBankmoney).." Interest) to your " .. _bnkacct[_accountLevel] .. " account!" )
				
	end
	
	return _toGive,_toGiveBankMoney;
end

function fsrp.config.mayorgovernment.functions.SetupDefaults()

	local _players = #player.GetAll()
	local _timestofit = math.max(1,_players/10-(_players%10));
	/* Vehicle Spawn Limits */
	fsrp.mayorgovernment.carlimits.policecruiser = _timestofit*fsrp.config.mayoral.carlimits.police.default
	fsrp.mayorgovernment.carlimits.ambulance = _timestofit*fsrp.config.mayoral.carlimits.ambulance.default
	fsrp.mayorgovernment.name = fsrp.config.mayoral.DefaultName
	fsrp.mayorgovernment.tax = {
		income = fsrp.config.mayoral.taxinfo.income.default;
		sales = fsrp.config.mayoral.taxinfo.sales.default
	}
	fsrp.mayorgovernment.salary = {
		[TEAM_PARAMEDIC] = fsrp.config.mayoral.salaryinfo[TEAM_PARAMEDIC].default;
		[TEAM_MAYOR] = fsrp.config.mayoral.salaryinfo[TEAM_MAYOR].default;
		[TEAM_POLICE] = fsrp.config.mayoral.salaryinfo[TEAM_POLICE].default;
		[TEAM_CIVILLIAN] = fsrp.config.mayoral.salaryinfo[TEAM_CIVILLIAN].default;
	}
	fsrp.config.mayorgovernment.functions.Update()
end
function fsrp.config.mayorgovernment.functions.AddGovtMoney(am)
	fsrp.mayorgovernment.money = fsrp.mayorgovernment.money + am
	fsrp.config.mayorgovernment.functions.Update()
end

util.AddNetworkString("paydayReport")
function fsrp.config.mayorgovernment.functions.MakePayday()
	local totalgovadded = 0
	for PIndex ,_p in pairs(player.GetAll()) do
		
		
		local _stars = _p:GetStars()
		if _stars>0 then 
			local _LastRob=_p:getFlag("lastRob",0);
			if  _LastRob!=0 and os.time()-_LastRob<30 then
				_p:Notify("Your star has not been removed because your last robbery was right before payday")
			else

				_p:RemoveStar(1); 
				if _stars -1 == 0 then 
					_p:SetWanted(false) 
				end
				_p:Notify("A star has been removed from your record.")
			end
		end

		_p:setFlag("SVTimeLastPayday",os.time());
		local _playerpaydayreport = {
		}
		local _toGive = fsrp.config.MinimumPayday ;
		
		if _p:Team() != TEAM_CIVILLIAN && jobInfoTable[_p:Team()]  then
			local timePlayed = 0;
			local _indexAtTime = 1;
			
			local _warrent = _p:getFlag("warrent", false);

			if _p:Team() == TEAM_MAYOR then
				local _paydayCount = 8-_p:getFlag("MayorPaydays",0);

				if isnumber(_paydayCount) and _paydayCount-1 < 0 then

					_p:LeaveJob(true)
					_p:Notify("You have been demoted from your job as mayor because you have served your term.")
					for k , p in pairs(player.GetAll()) do
						if _p!=p then
							p:Notify("The mayor has served his term and has been demoted to civillian.")
						end
					end 
					timer.Simple(1800,function() if #team.GetPlayers(TEAM_MAYOR) <=0 then
						fsrp.config.mayorgovernment.functions.SetupDefaults()
					end
					end)
					_p:setFlag("MayorPaydays",nil);
				else
					_p:setFlag("MayorPaydays", _paydayCount-1);
				end
			end
			if _warrent then
				local _lastwarrent = _p:getFlag('Lastwarrent', 0);

				if CurTime()-fsrp.config.WarrentTime > _lastwarrent then
					
					_p:ToggleWanted()

				end

			end

			if _p:Team() != TEAM_CIVILLIAN && fsrp.JobRanks[_p:Team()] then
				
				local timePlayed = _p:GetJobTimePlayed(_p:Team());
				
				for k , _p in pairs( fsrp.JobRanks[_p:Team()] ) do
					
					if _p.time > timePlayed then
						
						break
										
					end
					
					_indexAtTime = _p.Rank || 1;
					
					
					
				end
				
			end
			local _level = 1;
			if _p:GetRotoLevel(3) then
				_level = _p:GetRotoLevel(3)[1]
			end
			fsrp.config.mayorgovernment.functions.AddGovtMoney(-fsrp.mayorgovernment.salary[_p:Team()])
			_toGive =(fsrp.mayorgovernment.salary[_p:Team()] * _indexAtTime)*_level;
			_playerpaydayreport.earned = _toGive
			//_p:Notify( "You have been given a payday of $" .. math.Round(_toGive ,2).. " for your civic duties!" )
			_p:Notify("Payday has arrived, check an ATM for your report.")
			net.Start("paydayReport")

			net.WriteTable(_playerpaydayreport)

			net.Send(_p)
			return		
		else

			_toGive = fsrp.mayorgovernment.salary[_p:Team()];

		end		

		local _hasReward = GetReward( _p );
		local _accountLevel = _p:getBankAccount();
		if _p.__paydayhealmoney == true then
				if _p:canAffordBank( (fsrp.config.HealthResetCost + 250) ) then
				
					_p:Notify("You have been deducted -$".. math.Round(fsrp.config.HealthResetCost,2) + 250 .." for receiving a health treatment, and you skipped out on spare money for this payday for living expenses.")
					_p:setBank( _p:getBank() - (fsrp.config.HealthResetCost + 250) )
					
				else
				
					_p:setMoney ( 0 )
					
				end
				
				_p.__paydayhealmoney = false
				return
				
		end
		
		local _rewardtext =  "You could be earning 25% more each payday if you wear the tag! [" .. _tag:upper() .. "]" ;
		if _p:IsPremium() then
			_togivePerc = 1.5;
			if _hasReward then
				_togivePerc = _togivePerc+0.25
			else				
				_p:Notify(_rewardtext)
			end
			_toGive = _toGive * _togivePerc
			//_p:Notify( "You have been given an extra "..math.Round(((_togivePerc-1)*100),2).."% payday cash being a donator!" )
			
		elseif _p:IsDonator() then
		
			_togivePerc = 1.25;
			if _hasReward then
				_togivePerc = _togivePerc+0.25
			else
				_p:Notify(_rewardtext)
			end
			_toGive = _toGive * _togivePerc;
			//_p:Notify( "You have been given an extra "..math.Round(((_togivePerc-1)*100),2).."% payday cash being a donator!" )
			
		end

		if !_p:IsDonator() and !_p:IsPremium() and !_hasReward then
			_p:Notify(_rewardtext)	
		end


		if _p:HasCooldown("PaydayBoost") then
			_toGive=_toGive*2
		end
		local totalrew;
		local _zones = _p:GetZoneInvestments()
		
		if _zones["rp_downtown_v4c_v2"] and #_zones["rp_downtown_v4c_v2"] <= 0 or  _zones["rp_evocity_v33x"] and #_zones["rp_evocity_v33x"] <= 0 or !_zones["rp_downtown_v4c_v2"]  and !_zones["rp_evocity_v33x"]  then
			local _investment = _p:CalculatePropertyIncome();
			_toGive = _toGive + (_investment != nil && _investment or 0)
			_playerpaydayreport.propertyinvestment =_investment
			//_p:Notify("You have gained $" .. _investment .. " from your rental investments.")
		elseif _zones["rp_downtown_v4c_v2"] and #_zones["rp_downtown_v4c_v2"] > 0 or  _zones["rp_evocity_v33x"] and #_zones["rp_evocity_v33x"] > 0  then
			local _toget = 0;

			for k , z in pairs(fsrp.config.InvestmentZones) do
				
				if _zones[k] then
					for x, y in pairs(z) do

						if _zones[k][x]  then
							_toget = _zones[k][x]*0.01
							_zones[k][x] = math.max(_zones[k][x]-((y.StartingInvestment*0.01)),0);
							if _zones[k][x] == 0 then
								_zones[k][x] = nil;
							end
						end
					end
				end
				
			end

			_p:setFlag("zoneinvestments",_zones)
			_p:SavePermanentData(util.TableToJSON(_p:getFlag("zoneinvestments" , {} )),  "ZoneInvestments")
			_p:FullNWSync()
			_toGive = _toGive +_toget;
			//_p:Notify("You have gained $" .. _toget .. "  from your zone investments.")
			_playerpaydayreport.zoneincome = _toget

		end
		local _realtogive,_interest = CalculateBankExtra(_p, _toGive);
		_toGive = (_realtogive+_interest);
		local _todeduct = _toGive*(fsrp.mayorgovernment.tax.income/100);
		_toGive = _toGive - _todeduct 
		_playerpaydayreport.earned = _toGive
		_playerpaydayreport.incometax = _todeduct


		_p:addBank(_toGive) 
		totalgovadded = _todeduct + totalgovadded;
		fsrp.config.mayorgovernment.functions.AddGovtMoney(_todeduct)
		//_p:Notify("You have collected a paycheque of $" .. math.Round(_toGive,2) .. " to you bank account. A total of $" .. math.Round(_todeduct) .. " has been deducted by the government for income tax.")
		_p:Notify("Payday has arrived, check an ATM for your report.")
		net.Start("paydayReport")

		net.WriteTable(_playerpaydayreport)

		net.Send(_p)
	end
	for k , v in pairs(player.GetAll()) do
		v:Notify("The government has collected $" .. math.Round(totalgovadded,2) .. " from all civillians in taxes.")

	end
	fsrp.config.mayorgovernment.functions.Update()
end
 
hook.Add( "PaydayDistribution", "makePaydaysForAll", function()
		
		//FindBonusHourTitle();

		/*
		if tonumber(os.date( "%H" , os.time() )) >= 19 && tonumber(os.date( "%H" , os.time() ))  < 20 then

			for k , v in pairs( player.GetAll() ) do

				v:ChatPrint("Everyone has received double Payday because its bonus hour!")

			end

		end
		*/
		//for k , v in pairs( player.GetAll() ) do 
			//GivePaydayCash(v)
		//end

		fsrp.config.mayorgovernment.functions.MakePayday()
		CleanupOrgs()
		
		timer.Simple( 30, function()
		
			fsrp.blackmarket.help.Randomize()
		
		end )
		local w = ents.FindByClass("func_breakable_surf")
		
		for k,v in pairs(w) do
			if v:Health() <= 0 then
				v:Spawn()
				v:PhysicsInit( SOLID_BSP )
				v:SetSolid( SOLID_BSP )
				v:SetMoveType( MOVETYPE_NONE )
				v:RemoveAllDecals()
			end
		end
		

		if fsrp.StartingTime then
			
			if fsrp.StartingTime+86400 < os.time() then
				
				fsrp.RestartMap()

			end

		else

			fsrp.StartingTime = os.time();

		end	

end)

fsrp.devprint( "[WC-RP] - Payday Initialized" )