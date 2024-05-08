fsdb = fsdb or {}
fsrp.devprint( "[560Roleplay] - Fetching Paydays" )

function GetReward( _p )

	if ( string.find( _p:Nick(), '[560RP]' ) ) then

		return true
	
	else 
	
		return false 
	
	end
end

function GivePaydayCash()

	local _count = table.Count( player.GetAll() )
	fsdb.saveWeather()
	for k , v in pairs( player.GetAll() ) do
	
		local _toGive = PAYDAY_AMOUNT + _count;
		local _hasReward = GetReward( v );
		local _accountLevel = v:getBankAccount();
		if v.__paydayhealmoney == true then
				if v:canAffordBank( (HEALTH_RESET_COST + 250) ) then
				
					v:Notify("You have been deducted -$".. HEALTH_RESET_COST + 250 .." for receiving a health treatment")
					v:setBank( v:getBank() - (HEALTH_RESET_COST + 250) )
					
				else
				
					v:setMoney ( 0 )
					
				end
				
				v.__paydayhealmoney = false
				return
				
		end
		

			local totalrew;
		if _accountLevel == 0 then
			
		if _hasReward then

			_toGive = _toGive * 1.25;
		end
			v:addMoney( _toGive )
			v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive)) .. " to wallet!" )
			
		elseif _accountLevel == 1 then
		
			_toGive = _toGive - 15;
		if _hasReward then

			_toGive = _toGive * 1.25;
		end
			local _toGiveBankmoney = v:getBank() * 0.002;
			v:addBank( (_toGiveBankmoney + _toGive) )
			v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive) + math.ceil(_toGiveBankmoney)) .. " to your Smart Savings account!" )
					
		elseif _accountLevel == 2 then
		
			_toGive = _toGive - 10;
		if _hasReward then

			_toGive = _toGive * 1.25;
		end
			local _toGiveBankmoney = v:getBank() * 0.001;
			v:addBank( (_toGiveBankmoney + _toGive) )
			v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive) + math.ceil(_toGiveBankmoney)) .. " to your Chequing Supreme account!" )
			//v:Notify( "(Interest: $" .. math.ceil(_toGiveBankmoney) .. " | Payday: $" .. math.ceil(_toGive) .. ")" )
			
				
		elseif _accountLevel == 3 then
		
			_toGive = _toGive - 30;
		if _hasReward then

			_toGive = _toGive * 1.25;
		end
			local _toGiveBankmoney = v:getBank() * 0.002;
			v:addBank( (_toGiveBankmoney + _toGive) )
			v:Notify( "You have been given a payday of $" .. (math.ceil(_toGive) + math.ceil(_toGiveBankmoney)) .. " to your Buisiness account!" )
			//v:Notify( "(Interest: $" ..math.ceil( _toGiveBankmoney ).. " + Payday: $" .. math.ceil(_toGive) .. ")" )
			v:BuisinessPayday()
		end
		
		if !_hasReward then
		
			v:Notify(  "(You have could make up to 25 Percent more if you put on the [560RP] Tag!)" )

		end
		
		for x, y in pairs( QUEST_TABLE ) do
		
			if v.__activeQuests && v.__activeQuests[x] && !v.__activeQuests[x].Completed then
				v:Notify( "Current Active Quests:" .. v.__activeQuests[x].Name .. "! (Check F1 for more!)" )
				
			end
		
		end
	end
	
	
end

hook.Add( "Initialize", "distributePaydays", function ( )
	fsdb.loadWeather()
	
	timer.Create( "paydayDistribution", PAYDAY_TIME , 0, function()
		fsdb.saveWeather()
		GivePaydayCash()
		
	end )
	
	
end )

fsrp.devprint( "[560Roleplay] - Payday Initialized" )