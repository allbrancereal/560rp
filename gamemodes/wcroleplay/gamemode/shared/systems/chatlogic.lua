

local _pMeta = FindMetaTable( "Player" )

if CLIENT then 
	
	local gradient = Material( 'vgui/gradient-r' ) -- cache before use!

	local _themeTbl = {
		//"http://rotospacest.site.nfoservers.com/theme_1.wav";
		"http://rotospacest.site.nfoservers.com/theme_2.wav";
		"http://rotospacest.site.nfoservers.com/theme_3.wav";
	}
	_showRobbing = false;
	local doClose = false;
	local targLerp = doClose==true && 0 || 255;
	local hAlpha = 0;

	net.Receive("NWRobbing", function( _l , _P )
		local _t = net.ReadInt(3)
		local _r = net.ReadInt(8)
	
		if _t == 1 then

			if !LocalPlayer()._RobbingMusic then				

				//LocalPlayer()._RobbingMusic:Pause();
				LocalPlayer()._RobbingMusic = nil;
				
				sound.PlayURL( _themeTbl[math.random(#_themeTbl)], "", function (stn)
					if IsValid(stn) then
						
						LocalPlayer()._RobbingMusic = stn;
						LocalPlayer()._RobbingMusic:Play();

					end

				end )

			end
		
			hAlpha = 0;
			local _e = net.ReadInt(16)
			LocalPlayer():setFlag("robbingEntity",_e);

			LocalPlayer():Notify("Starting Robbery");
			
			if _r >1 then
				timer.Simple(1,function()
					LocalPlayer():Notify("# Of Organization Members in Robbery: " .. _r );
				end)
			end
			
			ShowRobbingHud();
		elseif _t == 2 then
			//LocalPlayer():Notify("Removing Robbing Hud!")
			//_showRobbing = false;
			//hook.Remove("HUDPaint","RobbingHUD")
			hook.Remove("HUDPaint","RobbingHUD")

		elseif _t == 3 then
			
			hook.Remove("HUDPaint","RobbingHUD")
			if LocalPlayer()._RobbingMusic then
				
				LocalPlayer()._RobbingMusic:Pause();
				LocalPlayer()._RobbingMusic = nil;

			end
		end		
	end )

	local SCREEN_W, SCREEN_H = 3840, 2160;

	local _w, _h = ScrW( ), ScrH( );
	local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
	_wMod = _wMod*2;
	_hMod = _hMod*2;

	function ShowRobbingHud()
		//LocalPlayer():Notify("Drawing Robbing Hud!")
		//_showRobbing = true;

		hook.Add("HUDPaint", "RobbingHUD", function()

			//if !_showRobbing then return end
			hAlpha = Lerp(0.05,hAlpha,targLerp);
			local _rob = LocalPlayer():getFlag("robbingEntity",nil);
			if _rob!= nil then 
				local _target =Entity(_rob);
			//draw.RoundedBoxEx( 0,_wMod * 50, _hMod * 895, _wMod * 300 , _hMod * 60 , Color(25,25,25,255) )
			if _target && _target != nil then
				
			    surface.SetMaterial( gradient )
			    surface.SetDrawColor( 0, 0, 0, hAlpha ) -- solid white, 0,0,0 is black
			    surface.DrawTexturedRect( _wMod*1500, _hMod*970, _wMod*150, _hMod*30 )
				 draw.NoTexture()
			    surface.DrawTexturedRect( _wMod*1650, _hMod*970, _wMod*150, _hMod*30 )

			    local _current = _target:getFlag("currentIntimidation", 0 )
			    local _max = _target:getFlag("requiredIntimidation",0)

			    local _off = _current/_max

			    surface.SetDrawColor( 200, 200, 200, hAlpha )
			    surface.DrawTexturedRect( _wMod*1645, _hMod*975, _wMod*150, _hMod*20 )
			    surface.SetDrawColor( 200,0,0,hAlpha )
			    surface.DrawTexturedRect( _wMod*1645, _hMod*975, _wMod*(150*math.Clamp(_off,0,1)), _hMod*20 )	
				draw.SimpleText( "Intimidation" , "RobberyText", _wMod * 1525,_hMod * 972.5, Color(165, 150, 150, hAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0, 0, 0, 255));

			end
		end
		end)
	end


	surface.CreateFont( "RobberyText", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = ScreenScale(8),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
end
if SERVER then
		
	local function Alarm(objNPC)
		if(objNPC.AlarmSound) then return end
			
			objNPC.AlarmSound = CreateSound(objNPC, "ambient/alarms/alarm1.wav")
			objNPC.AlarmSound:Play()
	end
	// Bank RObbing//
	util.AddNetworkString("NWRobbing")

	local _doAlarm = true;

	function fsrp.ResetRobbers()

		for k , v in pairs( ents.FindByClass("cn_npc")) do
			
			if fsrp.config.RobberyConfig[v:GetQuest()] then
				
				v:setFlag("beingRobbed", false)
				v:setFlag("lastRob", 0)
				v:setFlag("currentIntimidation", 0 )
				if _doAlarm && v.AlarmSound then
					v.AlarmSound:Stop()
					v.AlarmSound = nil;
				end
			end

		end

		net.Start("NWRobbing")
		net.WriteInt( 3 , 3 )
		net.WriteInt(0 , 8 )
		
		if #player.GetAll() > 0 then
			net.Broadcast()
		end
		for k , v in pairs( player.GetAll()) do 

			v:setFlag("robbingBank", nil )

		end

	end

	function fsrp.MessageGovtEmployees( txt )
		for k , v in pairs( player.GetAll() ) do 
			if v:IsGovernmentOfficial() then
				v:ChatMessage(txt,8 )
			end
		end
	end
	
		
	function _pMeta:StartBankRobbery(ent)

		local _realtorToRob;
		for k , v in pairs(ents.FindInSphere( self:GetPos(), 100) ) do
			
			if v && ent && v:GetClass() == "cn_npc" && fsrp.config.RobberyConfig[v:GetQuest()]  && v:GetQuest() == ent.uniqueID  then
				
				_realtorToRob =v;

				break;
			end

		end
		
		if !IsValid(_realtorToRob) then	return self:Notify("Couldn't find NPC to Rob!") end
		local _lastRobbed = _realtorToRob:getFlag("lastRob", 0 );
		local _beingRobbedAlready = _realtorToRob:getFlag("beingRobbed", false);

		if _beingRobbedAlready == true then return self:Notify("This NPC is being robbed already!") end
		if self:getFlag("robbingBank", nil) then return self:Notify("You can't start another robbery!") end

		if _lastRobbed+fsrp.config.TimeBetweenRobbery > os.time() then 

			return self:Notify("Someone has robbed this too recently! Come back later when this place makes more cash. (-" .. ((_lastRobbed+fsrp.config.TimeBetweenRobbery)-os.time()) .. "s)" )

		end

		_realtorToRob:setFlag("beingRobbed", true);
		_realtorToRob:setFlag("lastRob", os.time() );
		self:setFlag("robbingBank", true);
		// 1 - declare robbery

		local _MainRobberOrg = self:getFlag("organization",nil);
		local _CachedRobbers = {};
		local _Robbers = {};
		self:SetWanted(true)
		self:SetStars(3)

		for k , v in pairs(ents.FindInSphere( self:GetPos(), 500) ) do
			
			local _PotentialRobberOrg = v:getFlag("organization",nil);

			
			if v != self && v:IsPlayer() && v:Alive() && !v:IsGovernmentOfficial() then
				
				if _MainRobberOrg != nil && _MainRobberOrg == _PotentialRobberOrg then

					_CachedRobbers[v:SteamID()] = true;
					table.insert( _Robbers , v );
					v:SetWanted(true)
					v:SetStars(3)

				end
				
			end

		end
		

		_CachedRobbers[self:SteamID()] = true;
		table.insert( _Robbers , self );

		for k , v in pairs( _Robbers ) do 

			v:setFlag("robbingBank", true);

		end
	
		fsrp.MessageGovtEmployees( "[EMERGENCY][ROBBERY] " .. cnQuests[_realtorToRob:GetQuest()].name .. " is being robbed! Make your way there!" )
		_realtorToRob:setFlag("robbers", _CachedRobbers )
		_realtorToRob:setFlag("requiredIntimidation", (math.min(#_Robbers,1)*fsrp.config.IntimidationPerRobber) )
		_realtorToRob:setFlag("currentIntimidation", 0 )

		
		_realtorToRob:ResetSequence(6)
		timer.Simple(90, function()
			if _realtorToRob&& IsValid(_realtorToRob) then

				if _realtorToRob:getFlag("beingRobbed",false) == true && _realtorToRob:getFlag("currentIntimidation",0) < _realtorToRob:getFlag("requiredIntimidation",0) then
						
					for k , v in pairs(_Robbers) do
						
						net.Start("NWRobbing")
						net.WriteInt( 3, 3 )
						net.WriteInt(0 , 8 )
						net.Send(v)
						if v:getFlag("robbingBank",nil) then
							v:Notify("You didn't intimidate the NPC fast enough.")
						end
						v:setFlag("robbingBank", nil)
					end

					_realtorToRob:setFlag("beingRobbed", false)
					_realtorToRob:setFlag("lastRob", 0)
					_realtorToRob:setFlag("currentIntimidation", 0 )
					_realtorToRob:ResetSequence(3)

				end
				
					if _doAlarm && _realtorToRob.AlarmSound then
						_realtorToRob.AlarmSound:Stop()
						_realtorToRob.AlarmSound = nil;
					end
			end
			
		end)
		

		net.Start("NWRobbing")
		net.WriteInt( 1 , 3 )
		net.WriteInt(#_Robbers , 8 )
		net.WriteInt(_realtorToRob:EntIndex(),16)
		net.Send(_Robbers)
		
		
		if _doAlarm == true then
			Alarm(_realtorToRob)
		end
	end

end


CustomizableWeaponry.callbacks:addNew("bulletCallback", "bulletCallBackRobberyImpl", function( self , _p, trace , dmg  )

	if CLIENT then return end

	// shot the realtor
	if _p:getFlag("robbingBank", false) == true && 
		trace.Entity && trace.Entity:GetClass() == "cn_npc" && 
		fsrp.config.RobberyConfig[trace.Entity:GetQuest()] then
			
		local _Realtor = trace.Entity;
		local _BeingRobbed = _Realtor:getFlag("beingRobbed", false);
		local _Robbers = _Realtor:getFlag("robbers", {});

		if _Robbers[_p] then
						
			_Realtor:setFlag("currentIntimidation", _Realtor:getFlag("currentIntimidation",0)+1 )

			//_p:Notify( "Level: " .. _Realtor:getFlag("currentIntimidation",0) )
			for x , y in pairs( _Robbers ) do
				local _RobberToShun = player.GetBySteamID(x);

				_RobberToShun:Notify(_p:getFirstName() .. " has shot the ".. fsrp.config.RobberyConfig[trace.Entity:GetQuest()].name .. "!")
			end
		end

	elseif _p:getFlag("robbingBank", false) == true then 
			
			for k , v in pairs( ents.FindInSphere( trace.HitPos, 500 ) ) do
				
				if v:GetClass() == "cn_npc" && fsrp.config.RobberyConfig[v:GetQuest()] then

					local _BeingRobbed = v:getFlag("beingRobbed", false);
					local _Robbers = v:getFlag("robbers", {});

					if _Robbers[_p:SteamID()] then
						
						v:setFlag("currentIntimidation", v:getFlag("currentIntimidation",0)+math.random(1,4) )

						//_p:Notify( v:getFlag("currentIntimidation",0))
						if v:getFlag("currentIntimidation",0) > v:getFlag("requiredIntimidation",0) then
							

							--if v.AlarmSound then
								--v.AlarmSound:Stop()
								--v.AlarmSound = nil;
							--end

							for x ,y in pairs( _Robbers ) do
								local _RobberToReward = player.GetBySteamID(x);
								
								if _RobberToReward:Alive() then

									local _acWeap = _RobberToReward:GetActiveWeapon():GetClass();

									net.Start("NWRobbing")
									net.WriteInt( 2 ,3 )
									net.WriteInt( #_Robbers , 8 )
									net.Send( _RobberToReward )

									if _RobberToReward:getFlag("robbingBank",false) == true && _RobberToReward:Alive() && fsrp.config.RobberyConfig[v:GetQuest()].rewards[_acWeap] then
									
										local _min = fsrp.config.RobberyConfig[v:GetQuest()].rewards[_acWeap][1]
										local _max = fsrp.config.RobberyConfig[v:GetQuest()].rewards[_acWeap][2]
										local _lv = 1;
										if _RobberToReward:GetRotoLevel(13) then
											_lv = _RobberToReward:GetRotoLevel(13)[1];
										end
										_max = _max + (_lv*500);

										local _togive = math.random(_min,_max) * math.max(1,#_Robbers);

										_RobberToReward:AddRotoXP(13,RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_lv))
										
										_RobberToReward:addMoney( _togive )
										_RobberToReward:Notify("You have received $" .. _togive .. " from the job, make your way out and hide!")
									
										v:setFlag("beingRobbed", false)
										v:setFlag("currentIntimidation", 0 )
										_RobberToReward:setFlag("robbingBank", nil)
									else	

										_RobberToReward:Notify("You have lost your robbery reward.")

									end 

								else

									net.Start("NWRobbing")
									net.WriteInt( 3 ,3 )
									net.WriteInt( #_Robbers , 8 )
									net.Send( _RobberToReward )

								end
								
							end	
						
						end

					end

				
				
			end

		end
	end
end)


chatBox = {};
chatBox.ColorIDNames = {};
chatBox.ColorIDNames[1] = "Local";
chatBox.ColorIDNames[2] = "Server";
chatBox.ColorIDNames[3] = "Local OOC";
chatBox.ColorIDNames[4] = "Whisper";
chatBox.ColorIDNames[5] = "Yell";
chatBox.ColorIDNames[6] = "PM";
chatBox.ColorIDNames[7] = "Me";
chatBox.ColorIDNames[8] = "911";
chatBox.ColorIDNames[9] = "Radio";
chatBox.ColorIDNames[10] = "Organization";
chatBox.ColorIDNames[12] = "Advert";
chatBox.ColorIDNames[13] = "Admin";
chatBox.ColorIDNames[14] = "Hive";
chatBox.ColorIDNames[15] = "Report";
chatBox.ColorIDNames[16] = "Event";
chatBox.ColorIDNames[17] = "Roll";
 
local _pMeta = FindMetaTable( "Player" )
// Fake chat message
function _pMeta:ChatMessage ( Chat, id )
		local _toID = id || 11
	if SERVER then

		net.Start("fakechat")
			net.WriteString( Chat )
			net.WriteInt( _toID , 8 )
		net.Send( self )

	elseif CLIENT then
	
		table.insert(chatBox.Record, {CurTime(), "", nil, string.Trim(Chat), chatBox.ColorIDs[_toID], nil});
	
	end
end
 
chatBox.textFilter = {}
/*
chatBox.textFilter["lol"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["rofl"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["ftw"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["ftl"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["pwn"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["lmao"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["lawl"] = "Please do not use acronyms in RP chat."
chatBox.textFilter["asl"] = "Please do not use acronyms in RP chat."
*/
chatBox.Radius = {};
chatBox.Radius.Local = 450;
chatBox.Radius.Yell = 800	;
chatBox.Radius.Whisper = 125;

// ochat = ooc
// fchat = fake chat
// chat = local chat
if SERVER then
// sv player	
else


chatBox.Record = {};


chatBox.ColorIDs = {};
chatBox.ColorIDs = {};
chatBox.ColorIDs[1] = Color(204, 255, 255);
chatBox.ColorIDs[2] = Color(255, 255, 255, 255);
chatBox.ColorIDs[3] = Color(66, 208, 255);
chatBox.ColorIDs[4] = Color(135, 196, 245, 255);
chatBox.ColorIDs[5] = Color(187, 235, 42, 255);
chatBox.ColorIDs[6] = Color(227, 190, 70, 255);
chatBox.ColorIDs[7] = Color(251, 86, 4, 255);
chatBox.ColorIDs[8] = Color(229, 14, 6, 255);
chatBox.ColorIDs[9] = Color(107, 33, 76, 255);
chatBox.ColorIDs[10] = Color(157, 153, 188, 255); 			
chatBox.ColorIDs[11] = Color(236,255,140, 255); 			
chatBox.ColorIDs[12] = Color(249, 82, 107, 255); 			
chatBox.ColorIDs[13] = Color(51, 255, 153, 255); 			
//chatBox.ColorIDs[14] = Color(0, 0, 255, 255); 				
chatBox.ColorIDs[15] = Color(229, 14, 6, 255); 	
chatBox.ColorIDs[16] = Color(206, 250, 5, 255); 			
chatBox.ColorIDs[17] = Color(206, 250, 5, 255); 
chatBox.ColorIDs[18] = Color(229, 14, 6, 255);	
chatBox.newMessageSound = Sound("common/talk.wav");

chatBox.ColorIDNames = {};
chatBox.ColorIDNames[1] = "Local";
chatBox.ColorIDNames[2] = "Server";
chatBox.ColorIDNames[3] = "Local OOC";
chatBox.ColorIDNames[4] = "Whisper";
chatBox.ColorIDNames[5] = "Yell";
chatBox.ColorIDNames[6] = "PM";
chatBox.ColorIDNames[7] = "Me";
chatBox.ColorIDNames[8] = "911";
chatBox.ColorIDNames[9] = "Radio";
chatBox.ColorIDNames[10] = "Organization";
chatBox.ColorIDNames[11] = "System";
chatBox.ColorIDNames[12] = "Advert";
chatBox.ColorIDNames[13] = "Admin";
chatBox.ColorIDNames[14] = "Hive";
chatBox.ColorIDNames[15] = "Report";
chatBox.ColorIDNames[16] = "Event";
chatBox.ColorIDNames[17] = "Roll";
chatBox.ColorIDNames[18] = "Warrant";
function GM:StartChat ( teamSay )
	chatBox.OOC = teamSay;
	chatBox.Text = "";
	chatBox.IsOpen = true;
	
	/*if (GAMEMODE.Options_ShowChatBubble:GetBool()) then
		GAMEMODE.ChatBubbleOpen = true;
		//RunConsoleCommand("pt", "1");
	end*/
	
	return true;
end

function GM:FinishChat ( )

	chatBox.OOC = nil;
	chatBox.Text = nil;
	chatBox.IsOpen = nil;
	/*
	if (GAMEMODE.ChatBubbleOpen) then
		GAMEMODE.ChatBubbleOpen = nil;
		RunConsoleCommand("pt", "0");
	end*/
end

function GM:ChatTextChanged ( newChat )
	chatBox.Text = newChat;
end

// This part is handled through UMsgs so baddies can't hear from across the map. Silly exploiters.
function GM:ChatText ( playerID, playerName, text, type )
	if (LocalPlayer() and LocalPlayer():IsAdmin() != true) then
		if string.find(text, "joined") then return; end
		if string.find(text, "left") then return; end
	end

	surface.PlaySound(chatBox.newMessageSound);
	table.insert(chatBox.Record, {CurTime(), "", nil, string.Trim(text), chatBox.ColorIDs[11], nil});
	Msg(text .. "\n");
end

function GM:OnPlayerChat ( Player, Text, TeamChat, PlayerIsDead ) end
/*
									net.WriteInt( Player:Team() , 8 )
									net.WriteString( Player:Nick() )
									net.WriteString( Player:getRPName() )
									if v[1] == "allchat" then
										local pl = Player;
										local glowType = Color( 0, 0, 0 );
										if (pl:IsCouncilMember() && pl:IsDisguised()  != true) then
											glowType = Color(255, 0, 0)
										elseif (pl:IsDev() && pl:IsDisguised()  != true) then
											glowType = Color(255, 0, 255)	
										elseif (pl:IsSuperAdmin() && pl:IsDisguised()  != true) then
											glowType = Color(128, 0, 128)
										elseif (pl:IsAdmin() && pl:IsDisguised()  != true) then
											glowType = Color(0, 204,0 )
										elseif (pl:IsModerator() && pl:IsDisguised()  != true) then
											glowType = Color(255, 128,0 )
										elseif (pl:IsPremium() && pl:IsDisguised()  != true) then
											glowType = Color(255,215,0)
										end
										net.WriteColor( glowType )
																	
									end*/
									
function getRealChat ( len , _p  )
	//local pl = UMsg:ReadEntity();
	local text = net.ReadString()
	local id = net.ReadInt( 8 );
	local teamID = net.ReadInt( 8 );
	local name = net.ReadString()
	local rpaname = net.ReadString()
	
	//if ( (id == 2 || id == 3) ) then return; end
	
	local RPName = rpaname
	//print( "hi" .. text )
	surface.PlaySound(chatBox.newMessageSound);
	if id == 2 || id == 13 then
	
		RPName = rpaname 
		
	end
	
	Msg("[" .. chatBox.ColorIDNames[id] .. "] " .. tostring(RPName) .. ": " .. string.Trim(tostring(text)) .. "\n");

	table.insert(chatBox.Record, {CurTime(), RPName, team.GetColor(teamID), string.Trim(text), chatBox.ColorIDs[id or 1], nil});
end
net.Receive("localchat", getRealChat);
 
function getRealChatOOC ( len , _p )
	local text = net.ReadString()
	local id = net.ReadInt( 8 );
	local teamID = net.ReadInt( 8 );
	local name = net.ReadString()
	local rpaname = net.ReadString()
	local glowType = Color(0,0,0)
	

	local RPName = rpaname
	//print( "hi" .. text )

	if id == 2 || id == 13 then
	
		glowType = net.ReadColor()
		RPName = name 
		
	end
	
	
	if glowType == Color(0,0,0) then
	
		glowType = nil;
	
	end
	
		
	Msg("[" .. chatBox.ColorIDNames[id] .. "] " .. RPName .. ": " .. string.Trim(text) .. "\n");	
	surface.PlaySound(chatBox.newMessageSound);

	table.insert(chatBox.Record, {CurTime(), RPName, team.GetColor(teamID), string.Trim(text), chatBox.ColorIDs[id or 1], glowType});
			
	
end
net.Receive("allchat", getRealChatOOC);

function getFakeChat ( len , _p  )
	local text = net.ReadString()
	local id = net.ReadInt( 8 )
	
	surface.PlaySound(chatBox.newMessageSound);
	//print( "hi" .. text )
	
	if (chatBox.ColorIDNames[id] && chatBox.ColorIDNames[id] != "") then
		Msg("[" .. chatBox.ColorIDNames[id] .. "] " .. string.Trim(text) .. "\n");
	end
	
	table.insert(chatBox.Record, {CurTime(), "", nil, string.Trim(text), chatBox.ColorIDs[id or 1], nil});
end
net.Receive("fakechat", getFakeChat);

chatBox.Prefixes = {}
chatBox.Prefixes["ooc"] = "OOC";
chatBox.Prefixes["/"] = "OOC";
chatBox.Prefixes["//"] = "Local OOC";
chatBox.Prefixes["looc"] = "Local OOC";
chatBox.Prefixes["me"] = "Action";
chatBox.Prefixes["action"] = "Action";
chatBox.Prefixes["w"] = "Whisper";
chatBox.Prefixes["y"] = "Yell";
chatBox.Prefixes["911"] = "Emergency";
chatBox.Prefixes["999"] = "Emergency";
chatBox.Prefixes["broadcast"] = "Broadcast";
chatBox.Prefixes["radio"] = "Government Radio";
chatBox.Prefixes["org"] = "Organization";
chatBox.Prefixes["pm"] = "Private Message";
//chatBox.Prefixes["tm"] = "Text Message";
chatBox.Prefixes["a"] = "Admin Talk";
chatBox.Prefixes["advert"] = "Advertisement";
//chatBox.Prefixes["hive"] = "Hive";
chatBox.Prefixes["report"] = "Report";
chatBox.Prefixes["it"] = "Event";
//chatBox.Prefixes["event"] = "Event";
chatBox.Prefixes["roll"] = "Roll";
chatBox.Prefixes["drop"] = "Amount $";
//chatBox.Prefixes["barf"] = "Throw Up";
//chatBox.Prefixes["nlr"] = "Check NLR status";

function chat.AddText( ... ) --overwrite chat.AddText so it actually prints to the chat.
    local st = ""
    for k,v in pairs({...}) do
        if(type(v) == "string") then
            st = st .. v
        end
    end
    if( FindMetaTable("Player").ChatPrint ) then
	
    	LocalPlayer():ChatPrint(st)
		
    end
	
end
surface.CreateFont("ChatFont", {size = ScreenScale(6.5),weight = 800,antialias = true,shadow = false,font = "Tahoma"})
chatBox.LinesToShow = 10;

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

hook.Add( "HUDPaint" , "chatBox" , function()

	local border = 0;
	local availableWidth = ScrW();
	local widthPer = (_wMod * 100);
	local heightPer = widthPer * .33;
	
	// Chat 
	local xBuffer =_wMod * 250;
	local ChatFont = "ChatFont"
	
	surface.SetFont(ChatFont);
	local _, y = surface.GetTextSize("what");
	local startY = ScrH() - border * 10 - heightPer - y - 8 - _hMod * 100;
	
	
	if (chatBox.IsOpen) then
		
		local ourType = "Local";
		if (chatBox.OOC) then ourType = "OOC"; end
		
		local drawText = chatBox.Text;
		
		for k, v in pairs(chatBox.Prefixes) do
			if (string.match(string.lower(chatBox.Text), "^[ \t]*[!/]" .. string.lower(k))) then
				
				ourType = v;
				drawText = string.Trim(string.sub(string.Trim(drawText), string.len(k) + 2));
				
				break;
			end
		end
	
		surface.SetFont(ChatFont);
		local x, y = surface.GetTextSize(ourType .. ": " .. drawText);
		
		draw.RoundedBox(0, xBuffer - 2.5, startY + 1.25, x + 15, y, Color(25, 25, 25, 230))
		
		if (math.sin(CurTime() * 5) * 10) > 0 then
			drawText = drawText .. "|";
		end
		
		draw.SimpleText(ourType .. ": " .. drawText, ChatFont, xBuffer + 4, startY + y * .5, Color(255, 255, 255, 200), 0, 1);
		draw.SimpleText(ourType .. ": " .. drawText, ChatFont, xBuffer + 4, startY + y * .5, Color(255, 255, 255, 200), 0, 1);
		//draw.RoundedBox(0, (xBuffer-50) - 2.5, startY - y*chatBox.LinesToShow, x + 15,y*chatBox.LinesToShow, Color(25, 25, 25, 230))
		surface.SetDrawColor(255,255,255)
	end
	
	if (#chatBox.Record > 0) then
		for i = math.Clamp(#chatBox.Record - chatBox.LinesToShow, 1, #chatBox.Record), #chatBox.Record do
			local tab = chatBox.Record[i];
			
			if (chatBox.IsOpen || tab[1] + 15 >= CurTime()) then
				local Alpha = 255;
				
				if (!chatBox.IsOpen && tab[1] + 10 < CurTime()) then
					local TimeLeft = tab[1] + 15 - CurTime();
					Alpha = (255 / 5) * TimeLeft;
				end

				local posX, posY = xBuffer, startY - y * (1.5 + (#chatBox.Record - i));
				
				if tab[3] then
					local col = Color(tab[3].r, tab[3].g, tab[3].b, Alpha);
					
					draw.SimpleText(tab[2] .. ": ", ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha), 2);
					//draw.SimpleText(tab[2] .. ": ", ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha), 2);
					
					if (tab[6]) then
						local Cos = math.abs(math.sin(CurTime() * 2));
						
						draw.SimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, math.Clamp(Alpha * Cos, 0, 255)));
						//draw.SimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, math.Clamp(Alpha * Cos, 0, 255)));
					else
						draw.SimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
						//draw.SimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
					end
				end
				
				local col = Color(tab[5].r, tab[5].g, tab[5].b, Alpha);
				draw.SimpleText(tab[4], ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha));
				//draw.SimpleText(tab[4], ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha));
				draw.SimpleText(tab[4], ChatFont, posX, posY, col);
				//draw.SimpleText(tab[4], ChatFont, posX, posY, col);
			end
		end
	end
	
end)


end
