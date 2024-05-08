

local elementsToHide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true,
	CHudCrosshair = true,
	CHudWeaponSelection = true,
}
local PixVis

function SetupPixVis()

	PixVis = util.GetPixelVisibleHandle()
	
end
hook.Add( "Initialize", "SetupPixVis", SetupPixVis )


hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if (elementsToHide[ name ]) then return false end
end)
surface.CreateFont("PlayerNameFont2", {size = ScreenScale(5),weight = 1000,antialias = true,shadow = false,font = "Tahoma"})


if !HUD then

	HUD = {}

end
local canShowNamePlates = CreateConVar("wc_drawothernames", "1", {FCVAR_ARCHIVE} )
local useKPH = CreateConVar("wc_kph", "1", {FCVAR_ARCHIVE} )

function shouldShowNameplate()
	return GetConVar("wc_drawothernames"):GetBool()
	
end;
/*
function LoadHud() 
	local _p = LocalPlayer();
	if !IsValid( _p ) then return end
	

	if HUD.Selfie && cvars.Bool( "wc_thirdperson" ) then

		HUD.Selfie:Remove()
		return
		
	end

	if HUD.Selfie then

		HUD.Selfie:Remove()
	
		
	end
	

	local W = ScrW()

	local H = ScrH()
	
	local hOffset = ScrH()/(1080/ScrW() );
	local wOffset = ScrW()/(1920/ScrH() );

	
	local mdlTo;
		
		if !_p then 
		
			mdlTo = "models/player/tfa_vi_arisha.mdl"
			
		elseif _p && _p:GetModel() then
			mdlTo = _p:GetModel()
			
		end
	
	local mdl = vgui.Create( "DModelPanel" )
	
	mdl:SetPos( wOffset * 0.2, 0.3 * hOffset )

	mdl:SetSize( 250, 500 )

	mdl:SetFOV( 12 )

	mdl:SetCamPos( Vector( 200, 0, 50 ) )

	mdl:SetLookAt( Vector( 0, 2, 45 ) )

	mdl:SetModel( mdlTo )

	mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

	mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

	mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

	mdl:SetColor( Color( 200, 200, 200 ) )

	mdl:SetAnimated( false )																																							

	mdl.Angles = Angle( 0, 0, 0 )

	mdl:SetMouseInputEnabled(false)
	local _BodyInfo = _p:getFlag("civ_bodyGroupTable", {});

		local _defaultParam = "hospitalfemale_1";
		
		if _p:getGender() != 1 then
		
			_defaultParam = "hospitalmale_1"
			
		end
		
		local ID = _p:Team()
		local _toFind = ( ID == TEAM_CIVILLIAN ) && "" || ( ID == TEAM_POLICE ) && "job_police_" || ( ID == TEAM_PARAMEDIC ) && "job_paramedic_" || "";
	
	function mdl:LayoutEntity( Entity ) 

		
		local _civillian_model		= _p:getFlag( "playerinfo_" .. _toFind .. "model", "Vindictus-Vella" )
		local _civillian_bdg		= _p:getFlag( "playerinfo_" .. _toFind .. "bodygroups", "" )
		local _civillian_skin		= _p:getFlag( "playerinfo_" .. _toFind .. "skin", 0 )
		

		
			mdl:SetModel( player_manager.TranslatePlayerModel( _civillian_model ) )
			mdl.Entity:SetSkin( _civillian_skin)
			
			local groups =_civillian_bdg
			
			if ( groups == nil ) then groups = "" end
			
			local groups = string.Explode( " ", groups )
			
				for k = 0, mdl.Entity:GetNumBodyGroups() - 1 do
				
					mdl.Entity:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
					
				end
			
			
			 
	end
		
	
	HUD.Selfie = mdl 
end
hook.Add("FinishChat","removeHUDSelfie", function( isTeamChat )

	
end)
 

hook.Add("StartChat","removeHUDSelfie", function( isTeamChat )

		if HUD.Selfie then
		
			HUD.Selfie:Remove()
			
		end
		
	
end)
 
timer.Create("refreshHUD", 120, 0, function() 

	if cvars.Bool( "wc_thirdperson" ) then 
		
		if HUD.Selfie then
		
			HUD.Selfie:Remove()
			
		end
	
	else
	
		LoadHud()
		
	end
	
end) 
 */
_TitleTable = {
	{ time = 0 , title = "Tourist" };
	{ time = (1 * 3600 ), title = "Hipster" };
	{ time = (5 * 3600 ), title = "Sim"	  };
	{ time = (12* 3600 ) , title = "Businessperson"  };
	{ time = (24* 3600 ) , title = "Socialite" };
	{ time = (48* 3600 ) , title = "Investor" };
	{ time = (72* 3600 ) , title = "Experienced" };
	{ time = (96* 3600  ), title = "Seasoned" };
	{ time = (120* 3600  ), title = "Scientist" };
	{ time = (144* 3600  ), title = "Well Done" };
	{ time = (168 * 3600 ), title = "Regular" };
	{ time = (240 * 3600) , title = "Veteran" };
	{ time = (360 * 3600) , title = "Professional Addict" };
	{ time = (480 * 3600), title = "Survivor" };
	{ time = (600* 3600 ) , title = "Downtown Broker" };
	{ time = (720 * 3600 ), title = "Celebrity" };
	{ time = (744 * 3600) , title = "Mass Recycler" };
	{ time = (1440* 3600 ) , title = "Divide by Zero" };
	{ time = (1800 * 3600 ), title = "Terminator" };
	{ time = (2400* 3600 ) , title = "King Downtown" };

}
local _p = LocalPlayer();
local _lastSwitch = 0;
local ShowEnts = false;
local shouldAdjustCameraWhilemoving = CreateConVar("wc_adjustcamera", "1", {FCVAR_ARCHIVE} )
local _LastAttempt = 0;
local KeyRToFunc = {
	[KEY_T] = {function( cmd ) 
		//if !LocalPlayer():getFlag("InMenu", false ) then return vgui.CursorVisible() end
		if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
		if LocalPlayer():getFlag("restrictInv", false) == true then return end
		LocalPlayer().CreationMenu:SetVisible(false)		
	end
	};
}
local _gc = CurTime()
local KeyToFunc = {
	[KEY_T] = {function( cmd ) 
		//if !LocalPlayer():getFlag("InMenu", false ) then return vgui.CursorVisible() end
		if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
		if LocalPlayer():getFlag("restrictInv", false) == true then return end
		CreationMenu()
	end
	};
	[KEY_Q] = { function(cmd)
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
		if vgui.CursorVisible() && !GAMEMODE.BuddyPanel then return end
		if os.time() > _LastAttempt then
			local _slot = 0;

			for k , v in pairs(ITEMLIST) do
				if v.WeaponClass then
					if v.WeaponClass==LocalPlayer():GetActiveWeapon():GetClass() then
						_slot =v.SlotType
					end
				end
			end
			if _slot and _slot > 0 then
				LocalPlayer():Notify("You have deposited your weapon in to your inventory.")
				net.Start("slotAdjustment")
					net.WriteInt( _slot, 4 );
				net.SendToServer()
			end
			_LastAttempt = os.time()+5
		
		end
	end};
	[KEY_N] ={ function (cmd)

			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
			if vgui.CursorVisible() && !GAMEMODE.BuddyPanel then return end
		
			
			_lastSwitch = CurTime() + .5;
			if LocalPlayer().PolicePDA && ispanel(LocalPlayer().PolicePDA) then  LocalPlayer().PolicePDA:Close()  LocalPlayer().PolicePDA = nil return  end
			if !LocalPlayer():IsAdmin() && LocalPlayer():Team() != TEAM_MAYOR && LocalPlayer():Team() != TEAM_POLICE then  
			else
			LocalPlayer():ConCommand("wc_policepda")
			LocalPlayer():setFlag("restrictInv", true)
			end	

	end };
	[KEY_INSERT] = { function( cmd ) 
			local _newVal = 1;
			
			if IsInThirdperson() then
			
				_newVal = 0;
				
			end
			
			LocalPlayer():ConCommand( "wc_thirdperson " .. _newVal )
			
			_lastSwitch = CurTime() + 1;
	end  };
	[KEY_O] = { function( cmd ) 
				
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
			if vgui.CursorVisible() && !GAMEMODE.BuddyPanel then return end
		
			if vgui.CursorVisible() then return end
			
			_lastSwitch = CurTime() + .5;
			if LocalPlayer():getFlag("organization",0) == 0 then return LocalPlayer():Notify( "You must join or create a organization to open this menu") end
			if LocalPlayer().OrgMenu then LocalPlayer().OrgMenu:Close() LocalPlayer().OrgMenu = nil 

			else 
			
			LocalPlayer().OrgMenu = ShowOrganizationPanel()
			LocalPlayer():setFlag("restrictInv", true)
		
			end
		
		
	end };
	[KEY_B] = { function( cmd ) 
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
			if vgui.CursorVisible() && !GAMEMODE.BuddyPanel then return end
				//if LocalPlayer():getFlag("restrictInv", false) == true then return end
				
				
				
				_lastSwitch = CurTime() + .5;
				net.Start("buddyFromDirectInput")
				net.SendToServer()
				
		end  };
	[KEY_C] = { function( cmd ) 
		//if !LocalPlayer():getFlag("InMenu", false ) then return vgui.CursorVisible() end
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
				
				
				
				_lastSwitch = CurTime() + .5;
				net.Start("directInputF1")
					net.WriteInt( 3 , 8 )
				net.SendToServer()
		end  };
	[KEY_G] = { function( cmd ) 
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
					
					local _p = LocalPlayer();
					if _p:NearNPC("normcarret") || _p:NearNPC( "govtcarret" )  || _p:NearNPC( "paramcarret" ) then
					
						_lastSwitch = CurTime() + .5;
						net.Start("depositCarToGarage" )
						
						net.SendToServer() 
						
					end
				
			
			end  };
	[KEY_H] = { function( cmd ) 
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
				_lastSwitch = CurTime() + .5;
				local wep = LocalPlayer():GetActiveWeapon();
				
				if CustomizableWeaponry.canOpenInteractionMenu && IsValid(wep) and wep.CW20Weapon then
					return wep.attemptToggleInteractionMenu(wep)
				end
			end  };
	[KEY_I] = { function( cmd )
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
				
				_lastSwitch = CurTime() + .5;
				net.Start("directInputF1")
					net.WriteInt( 5 , 8 )
				net.SendToServer()
				
				end  };
	[KEY_J] = { function( cmd ) 
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
				
				
				
				_lastSwitch = CurTime() + .5;
				net.Start("directInputF1")
					net.WriteInt( 7 , 8 )
				net.SendToServer()
		end  };
	[KEY_K] = { function( cmd ) 
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
				
				
				
				_lastSwitch = CurTime() + .5;
				net.Start("directInputF1")
					net.WriteInt( 8 , 8 )
				net.SendToServer()
				
		end  };
	[KEY_M] = { function( cmd ) 
				//if !LocalPlayer():getFlag("InMenu", false ) then return vgui.CursorVisible() end
			if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
				if LocalPlayer():getFlag("restrictInv", false) == true then return end
				
				
				
				_lastSwitch = CurTime() + .5;
				net.Start("directInputF1")
					net.WriteInt( 1 , 8 )
				net.SendToServer()
				
		end  };

	[KEY_Z] = { function( cmd )
		LocalPlayer():UpdateHUD()
	end }; 
	[KEY_SPACE] = { function( cmd )
				if  LocalPlayer():getFlag("inVehicleShop", false) == true  then
				
					fsrp.Vehicle.SkipVehicleIntro()
					
				end
							
							end  
	};

}
for i=1,7 do
	KeyToFunc[i] = { function( cmd )
		local _p = LocalPlayer()
		if _gc+1 > CurTime() then return else _gc=CurTime() end
		local x = i-1;
		if _p:getFlag("restrictInv", false) == true then  return end
		if IsInMenu==true then 
			local _target =LocalPlayer():getFlag("TargetSlot", nil)
			//local _inv = LoadStringToInventory(_p:getFlag("inventory", nil ))
			local _abar = LocalPlayer().ActionBar;

			if _abar and _abar.ItemSlot and _abar.ItemSlot[x] then
				_abar.ItemSlot[x].ItemSlot = _target;
				_abar.ItemSlot[x].ID = _target//self.InventorySlotCache[self.TargetUI.SlotID].ID;
				_abar.ItemSlot[x]:SetItemTable()
			end
			local _stbl = _p:getFlag("actionbarslots",{});
			_stbl[x] = {};
			_stbl[x].ItemSlot = _target
			_stbl[x].ID = _target

			LocalPlayer():setFlag("actionbarslots",_stbl)
			net.Start("sendItemSlots")
				net.WriteTable(_stbl)
			net.SendToServer()
			timer.Simple(.5, function() LocalPlayer().ActionBar:Update() end)
			return  
		end
		if chatBox.IsOpen != nil or gui.IsGameUIVisible() then return end
		local _abar = LocalPlayer().ActionBar;
		local _is = LocalPlayer():getFlag("actionbarslots",nil);
		if _is  and _is[x] and _is[x].ItemSlot then
			
			InventorySlotCache = LoadStringToInventory(_p:getFlag("inventory", nil ))
			net.Start("useItemAtIndex")
					net.WriteInt(  _is[x].ItemSlot, 8 )
					net.WriteInt(  _is[x].ID, 32 );
			net.SendToServer()
			timer.Simple(.1,function()
				InventorySlotCache = LoadStringToInventory(_p:getFlag("inventory", nil ))
				if InventorySlotCache[x].Amount == 0 then 
					_is[i] = nil; 
					LocalPlayer():setFlag("actionbarslots",_is);
					LocalPlayer().ActionBar:Update()
				end 
			end)
		end		

	end  };
end
local SCREEN_W, SCREEN_H = 2560, 1440;

local _w, _h = ScrW( ), ScrH( );
local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
function CreationMenu()
	if !LocalPlayer():IsDev() then return end
	if LocalPlayer().CreationMenu then
		LocalPlayer().CreationMenu:SetVisible(true)
	else
		local Frame = vgui.Create("DFrame")
		Frame:SetSize(_wMod*600,_hMod*500);
		Frame:Center()
		Frame:MakePopup()
		Frame:ShowCloseButton(true)
		Frame.OnClose = function(self)
			LocalPlayer().CreationMenu = nil;
		end

		LocalPlayer().CreationMenu = Frame;

		local _gridscroll = vgui.Create("DScrollPanel",Frame)
		_grid:SetSize(_wMod*550,_hMod*450)
		_grid:SetPos(_wMod*25,_hMod*25)
		

		_grid = vgui.Create("DGrid", _gridscroll)
		_grid:Dock(FILL)

		for k , v in pairs( _propList) do
			local _n = _grid:Add("SpawnIcon")
			
			_n:SetModel(v)
			_n:SetSize(_wMod*50,_hMod*50)
		end
	end

end
hook.Add( "CreateMove", "adjustCameraWhileMoving", function ( cmd )
		
		if cmd:GetMouseWheel() > 0 then
			if cmd:KeyDown(IN_ATTACK) == true and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then return end
			local _w = LocalPlayer():GetWeapons();
			local _curk = 1
			for k  , v in pairs( _w ) do 
				if v == LocalPlayer():GetActiveWeapon() then
					_curk = k;
				end
			end
			if LocalPlayer():Alive() then
				if _curk-1 <1 then
					cmd:SelectWeapon(_w[#_w]);
				else
					cmd:SelectWeapon(_w[_curk-1]);
				end
			end
			cmd:SetMouseWheel(0)
			if LocalPlayer().WeaponWheel  then LocalPlayer().WeaponWheel:Update() end

		elseif cmd:GetMouseWheel() < 0 then
			if cmd:KeyDown(IN_ATTACK) == true and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then return end
			local _w = LocalPlayer():GetWeapons();
			local _curk = 1

			for k  , v in pairs( _w ) do 
				if v == LocalPlayer():GetActiveWeapon() then
					_curk = k;
				end
			end
			if LocalPlayer():Alive() then
				if _curk+1 > #_w then
					cmd:SelectWeapon(_w[1]);
				else
					cmd:SelectWeapon(_w[_curk+1]);
				end
			end
			
			cmd:SetMouseWheel(0)
			if LocalPlayer().WeaponWheel  then LocalPlayer().WeaponWheel:Update() end

		end
		if !LocalPlayer().FSpectate && shouldAdjustCameraWhilemoving:GetBool() && LocalPlayer():GetMoveType() != MOVETYPE_NOCLIP then
		
		if _lastSwitch < CurTime() then
			
			for k ,v in pairs( KeyToFunc ) do
			
				if input.IsKeyDown( k ) then
					
					v[1]( cmd )
					
			
					break
					
				end
				
			end
			for k ,v in pairs( KeyRToFunc ) do
			
				if input.WasKeyReleased( k ) then
					
					v[1]( cmd )
					
			
					break
					
				end
				
			end
		end

		if IsInThirdperson() then
			
			if cmd:KeyDown(IN_MOVELEFT) && cmd:KeyDown(IN_FORWARD) then
					
				local _viewAng = cmd:GetViewAngles()
				local _newAng = _viewAng + Angle( 0, 0.2,0 )
				
				cmd:SetViewAngles( _newAng ) 
			elseif cmd:KeyDown(IN_MOVERIGHT) && cmd:KeyDown(IN_FORWARD) then
				local _viewAng = cmd:GetViewAngles()
				local _newAng = _viewAng + Angle( 0, -0.2,0 )
				
				cmd:SetViewAngles( _newAng ) 
			
			elseif cmd:KeyDown(IN_MOVERIGHT) && cmd:KeyDown(IN_BACK) then
					
				local _viewAng = cmd:GetViewAngles()
				local _newAng = _viewAng + Angle( 0, -0.2,0 )
				
				cmd:SetViewAngles( _newAng ) 
				
			elseif cmd:KeyDown(IN_MOVELEFT) && cmd:KeyDown(IN_BACK) then
				local _viewAng = cmd:GetViewAngles()
				local _newAng = _viewAng + Angle( 0, 0.2,0 )
				
				cmd:SetViewAngles( _newAng ) 
				
			elseif cmd:KeyDown(IN_MOVERIGHT) then
			
				local _viewAng = cmd:GetViewAngles()
				local _newAng = _viewAng + Angle( 0, -0.1,0 )
				
				cmd:SetViewAngles( _newAng ) 
			
			elseif cmd:KeyDown(IN_MOVELEFT) then
			
				local _viewAng = cmd:GetViewAngles()
				local _newAng = _viewAng + Angle( 0, 0.1,0 )
				
				cmd:SetViewAngles( _newAng ) 
			end
		
		end
	end

end )
local _pMeta = FindMetaTable( 'Player' );

function _pMeta:GetJobTimePlayed(_j)

	return  tonumber(self:getFlag( "jobPlaytimes", {} )[_j].Played);

end
function _pMeta:GetJobTimeInfo(_j)

	return  self:getFlag( "jobPlaytimes", {} )[_j];

end
function _pMeta:GetTimePlayed()

	return tonumber(self:getFlag("playTime", 0  ))
	
end
function _pMeta:TimeSinceJoin()

	return RealTime() - self:getFlag( "joinTime" , 0 );
	
end
function _pMeta:GetPlaytimeTitle( )

	local _pTime = self:GetTimePlayed()
	local _gender = self:getGender();
	local _returnTit = "";
	local _found = 1;
	
	for k , v in pairs ( _TitleTable ) do
	
		if _pTime > v.time then
				
			_found = k;
			if _TitleTable[(k+1)] && _pTime < _TitleTable[(k+1)].time then
				
				break;

			end

		end
		
	end
	
	return _TitleTable[_found].title;
end

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );
local _truemoney = 0;
local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
hook.Add("Think", "lerpMoney", function()
	
	if _truemoney != LocalPlayer():getMoney() then
		
		
		 
		_truemoney = Lerp( 0.05 , _truemoney, LocalPlayer():getMoney() )
			 
		
		
	end
	
end)


surface.CreateFont( "MoneyText", {
	font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = ScreenScale(7),
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
surface.CreateFont( "ZoneText", {
	font = "Segoe UI", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = ScreenScale(16),
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
local targLerp = 255;
local LastMoneyShow = CurTime();
local LastZoneShow = CurTime()
surface.CreateFont("PlayerNameFont", {size = ScreenScale(7),weight = 1000,antialias = true,shadow = false,font = "Tahoma"})
	local gradient = Material( 'vgui/gradient-r' ) -- cache before use!

local _pMeta = FindMetaTable('Player');
function UpdateMoneyShow()
	LastMoneyShow = CurTime()
end
local function UpdateZoneShow()
	LastZoneShow = CurTime()

end
function _pMeta:UpdateHUD()

	UpdateMoneyShow()
	UpdateZoneShow()

end

local _zone;

local function SpeedText ( MPH )
	if (useKPH:GetBool()) then return math.Round(MPH * 1.609344) .. " KPH"; end
	
	return MPH .. " MPH";
end

local _HealthColors = {
	[1] = {0,19, Color(158,28,39)};
	[2] = {20,39, Color(196,104,20)};
	[3] = {40,59, Color(255,225,20)};
	[4] = {60,79, Color(195,255,20)};
	[5] = {80,100, Color(90,255,20)};
};
function _pMeta:GetHealthColor()
	local _hp = self:Health()
	local _found = 5;

	for k , v in pairs( _HealthColors) do
		
		if _hp == v[1] || _hp == v[2] || _hp > v[1] && _hp < v[2] then
	
			_found = k;
			break;
		end

	end
	return _HealthColors[_found][3];
end
local _Star = Material("icon16/star.png")
function GM:HUDPaint()
	
	//if LocalPlayer():Alive() && LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon():GetClass() && LocalPlayer():GetActiveWeapon():GetClass() == "gmod_camera" then return end
	local xcoor = ScrW() * 0.1
	local ycoor = ScrH() * 0.8
	local _hudAlpha = 128;
	local MoneyAlpha = 255;
	local ZoneAlpha = 255;
	LastMoneyShow = CurTime()
	LastZoneShow = CurTime()
	//draw.SimpleTextOutlined(LocalPlayer():getRPName(), "OpenSans25", 350 *(ScrW()/1920), 725 * (ScrH()/1080), Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0, 0, 0, 255));

	
	if !LocalPlayer():getFlag("shouldTeleport", false ) && LocalPlayer():Alive() then
		
			
		if (LastMoneyShow + 10 < CurTime()) then
			local TimeLeft = LastMoneyShow + 15 - CurTime();
			MoneyAlpha = (255 / 5) * TimeLeft;
		end
		//hAlpha = Lerp(0.05,hAlpha,targLerp);
				
		//draw.RoundedBoxEx( 0,_wMod * 1500, _hMod * 895, _wMod * 300 , _hMod * 60 , Color(25,25,25,_hudAlpha) )
		//draw.RoundedBoxEx( 0,_wMod * 1505, _hMod * 900, _wMod * 290 , _hMod * 50 , Color(56,56,56,_hudAlpha+8) )
		//draw.SimpleText( math.floor(_truemoney) , "MoneyText", _wMod * 1790,_hMod * 908, Color(255, 255, 255, _hudAlpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT, 1, Color(0, 0, 0, 255));
		
	    surface.SetMaterial( gradient )
	    surface.SetDrawColor( 0, 0, 0, MoneyAlpha ) -- solid white, 0,0,0 is black
	    surface.DrawTexturedRect( _wMod*1450, _hMod*900, _wMod*200, _hMod*60 )
		draw.NoTexture()
	    surface.DrawTexturedRect( _wMod*1649, _hMod*900, _wMod*100, _hMod*60 )

	    surface.SetDrawColor( 128,128,128, MoneyAlpha*0.05 )
	    surface.DrawTexturedRect( _wMod*1500, _hMod*905, (_wMod*245), _hMod*25 )

	    surface.SetDrawColor( 0,0,0, 200 )
	    surface.DrawTexturedRect( _wMod*1750, _hMod*900, (_wMod*110), _hMod*60 )

	    local _col = LocalPlayer():GetHealthColor();
	    surface.SetDrawColor( _col.r,_col.g,_col.b, MoneyAlpha*0.05 )

		local _health = LocalPlayer():Health()/LocalPlayer():GetMaxHealth();
	    local _hsize = _wMod*(245*_health); 
	    surface.DrawTexturedRect( _wMod*1500+((_wMod*245)-_hsize), _hMod*905, _hsize, _hMod*25 )
	    surface.SetDrawColor( 128,128,128, MoneyAlpha*0.05 )
	    surface.DrawTexturedRect( _wMod*1500, _hMod*930, (_wMod*245), _hMod*25 )
	    surface.SetDrawColor( 0,0,255, MoneyAlpha*0.05 )
		local _armor = LocalPlayer():Armor()/255;
	    local _asize = _wMod*(245*_armor); 
	    surface.DrawTexturedRect( _wMod*1500+((_wMod*245)-_asize), _hMod*930, _asize, _hMod*25 )

		draw.SimpleText("$".. math.floor(_truemoney) , "MoneyText", _wMod * 1856,_hMod * 919, Color(255, 255, 255, MoneyAlpha), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT, 1, Color(0, 0, 0, 255));

	
	end
	
	if (LastZoneShow + 1  < CurTime()) then
		local TimeLeft = LastZoneShow + 2 - CurTime();
		ZoneAlpha = (255) * TimeLeft;
	end

	if LocalPlayer():GetZoneName() && _zone != LocalPlayer():GetZoneName()[1] then
		_zone = LocalPlayer():GetZoneName()[1] || "";
		UpdateZoneShow()
	end
	if LocalPlayer():Alive() then
		if IsValid(LocalPlayer():GetActiveWeapon()) && LocalPlayer():GetActiveWeapon():GetClass() == "god_stick" then ZoneAlpha= 255 end;
		draw.SimpleText( (_zone || "") , "ZoneText", _wMod * 5,_hMod * 1035, Color(255, 255, 255, ZoneAlpha/2), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0, 0, 0, ZoneAlpha));
	end
			
	local color = team.GetColor(LocalPlayer():Team());					
	if (LocalPlayer():getFlag("warrent", false)) then
		local _stars = LocalPlayer():getFlag("warrent_stars",0);
		surface.SetMaterial(_Star)
		local _basex,_basey = ScrW()-(_wMod*400), _hMod*880
		for i=1,_stars do
			surface.SetDrawColor(0,0,0)
			surface.DrawTexturedRect( (_basex+(_wMod*45))+(i*25),_basey-(_hMod*7),25,25)
			surface.SetDrawColor(255,255,255)
			surface.DrawTexturedRect( (_basex+(_wMod*47.25))+(i*25),_basey-(_hMod*5),20,20)
		end
		draw.SimpleTextOutlined((LocalPlayer():getFlag("cuffed", false) == false && "Wanted" || "Wanted(Cuffed)"), "ZoneText", _basex,_basey, Color(255, 255, 255, Alpha), 1, 1, 1, Color(color.r, color.g, color.b, Alpha));
	end
						
	local ourPos = LocalPlayer():GetPos();
	// Door Stuff / Vehicles
	local FadePoint = 300;
	local RealDist = 450;
	
	local eyeTrace = LocalPlayer():GetEyeTrace();
	local shootPos = LocalPlayer():GetShootPos();
	
	surface.SetFont("PlayerNameFont");
	local w, h = surface.GetTextSize("Player Name");
	
	if shouldShowNameplate() then  
	for k, v in pairs(player.GetAll()) do
		local vcol = v:GetColor()

		if (v && v  && v != LocalPlayer() && v:Alive() && vcol.a > 0) then
		//if (v && v  && v:Alive() && vcol.a > 0) then // use this to test localplayer 
			
			local dist = v:GetPos():Distance(ourPos);
			
			if (dist <= RealDist) then
				local trace = {}
				trace.start = shootPos;
				trace.endpos = v:GetShootPos();
				trace.filter = {LocalPlayer(), v};
				
				if (v:InVehicle()) then table.insert(trace.filter, v:GetVehicle()); end
				if (LocalPlayer():InVehicle()) then table.insert(trace.filter, LocalPlayer():GetVehicle()); end
				
				local tr = util.TraceLine( trace ) 
				
				if (!tr.Hit) then
					local alpha3 = 255;
					
					if (dist >= FadePoint) then
						local moreDist = RealDist - dist;
						local percOff = moreDist / (RealDist - FadePoint);
						
						alpha3 = 255 * percOff;
					end
					
					local AttachmentPoint = v:GetAttachment(v:LookupAttachment('eyes'));
					if !AttachmentPoint then AttachmentPoint = v:GetAttachment(v:LookupAttachment('head')); end

					if (AttachmentPoint) then 
					
						
						local realPos = Vector(v:GetPos().x, v:GetPos().y, AttachmentPoint.Pos.z + 10);
						cam.Start3D( )
						
						local screenPos = realPos:ToScreen();
						
						cam.End3D()
						local Rank = v:getFlag("jobPlaytimes", nil );

						
						if (v:getFlag("cuffed", false)) then
						    if dist < 400/3 then
								cam.Start3D()
						    	local posShit = v:LocalToWorld(v:OBBCenter()):ToScreen();
								cam.End3D()
							    draw.SimpleText('Cuffed', 'PlayerNameFont', posShit.x, posShit.y, Color(255, 30, 30,255), 1, 1);
							end
						end		
							local color = team.GetColor(v:Team());					
						if (v:getFlag("warrent", false)) then
							local _stars = v:getFlag("warrent_stars",0);
							cam.Start3D()
					    	local posShit = v:LocalToWorld(v:OBBCenter()):ToScreen();
							cam.End3D()

							surface.SetMaterial(_Star)
							for i=1,_stars do
								surface.SetDrawColor(0,0,0)
								surface.DrawTexturedRect( ((screenPos.x-2.5)-w*.71)+(i*22), (screenPos.y-2.5) - h * 4.7,25,25)
								surface.SetDrawColor(255,255,255)
								surface.DrawTexturedRect( (screenPos.x-w*.71)+(i*22), screenPos.y - h * 4.7,20,20)
							end
							draw.SimpleTextOutlined("Arrest Warrant", "PlayerNameFont", screenPos.x, screenPos.y+20, Color(255, 255, 255, Alpha), 1, 1, 1, Color(color.r, color.g, color.b, Alpha));
						end
						
							local pointDown = (realPos + Vector(0, 0, math.sin(CurTime() * 2) * 3)):ToScreen()
							local pointUp = (realPos + Vector(0, 0, 20 + math.sin(CurTime() * 2) * 3)):ToScreen() 
							
							local Size = math.abs(pointDown.y - pointUp.y);
							
						
							local name = v:getRPName()
							if name == "John Doe" then return end
							local _split = string.Explode( " " , name );
							if v:Team() == TEAM_POLICE && _split[2] then
					
								name = "Officer " .. _split[2];
						
							end
							draw.SimpleTextOutlined(name, "PlayerNameFont", screenPos.x, screenPos.y - h, Color(255, 255, 255, alpha3), 1, 1, 1, Color(color.r, color.g, color.b, alpha3));
							if v:IsModerator() && !v:IsDisguised() || LocalPlayer():IsSuperAdmin() then
								draw.SimpleTextOutlined(v:Name(), "PlayerNameFont", screenPos.x, screenPos.y - h * 3, Color(255, 255, 255, alpha3), 1, 1, 1, Color(255 * math.sin(RealTime()*5 ), 0, 0, alpha3));
							end
							if v:getFlag("organization",nil) != nil && fsrp.orgs[v:getFlag("organization", nil)] then
							
								draw.SimpleTextOutlined( "<" .. fsrp.orgs[v:getFlag("organization",nil)][2] .. ">" , "PlayerNameFont", screenPos.x, screenPos.y - h * 2, Color(255, 255, 255, alpha3), 1, 1, 1, Color(255 * math.sin(RealTime()*5 ), 0, 0, alpha3));

							end
						
									if (LocalPlayer():Team()== TEAM_POLICE) && IsValid(v:GetVehicle()) then
										local Speed = math.Round(v:GetVehicle():GetVelocity():Length() / 17.6)
										local c = Color(255, 255, 255, alpha3)
										local _comp = v:GetVehicle():GetZoneName()[4] && v:GetVehicle():GetZoneName()[4] || 60;

										if(Speed > _comp) then
											c = Color(255, 200, 0, alpha3)
																			
											if(Speed > 60 + 10) then
												c = Color(255, 0, 0, alpha3)
											end
										
										end
										
										draw.SimpleTextOutlined(SpeedText(Speed), "PlayerNameFont", screenPos.x, screenPos.y - h * 4, c, 1, 1, 1, c)
									end

						if Rank && v:Team() != TEAM_CIVILLIAN && table.HasValue( {TEAM_POLICE, TEAM_PARAMEDIC}, v:Team()) then	
							local _job = fsrp.JobRanks[v:Team()];
							
							if v:getFlag("jobPlaytimes", nil) then
								//print( 	v:getFlag("jobPlaytimes", {} ) )
								//print( 	v:getFlag("jobPlaytimes", {} )[v:Team()] )
								//print( 	v:getFlag("jobPlaytimes", {} )[v:Team()].Rank)
								//print(  _actRank)
								//print(  _job[tonumber(v:getFlag("jobPlaytimes", {} )[v:Team()].Rank)] )
								//print(  _job[tonumber(v:getFlag("jobPlaytimes", {} )[v:Team()].Rank)].name )
								
									//print( tonumber(v:getFlag("jobPlaytimes", {} )[v:Team()].Rank) )
									
								local _timePlayed = v:getFlag( "jobPlaytimes", {} );
								if _timePlayed[v:Team()].Rank  then
									local _nameIn  = _job[1].name;
									
									for x, y in pairs( _job ) do
										if y.rank == _timePlayed[v:Team()].Rank then
											_nameIn = y.name
											
											break
											
										end
										
									end
											
									draw.SimpleTextOutlined( _nameIn , 'PlayerNameFont2', screenPos.x, screenPos.y, Color(255, 255, 255, 255), 1, 1, 1, Color(28, 134, 238, 255));
									
								end
								
							end
						else
							if v:SteamID() == "STEAM_0:1:24177118" && !v:IsDisguised() then
							
								draw.SimpleTextOutlined( "God" , 'PlayerNameFont2', screenPos.x, screenPos.y, Color(225, 255 * math.sin(CurTime()), 225, 255), 1, 1, 1, Color(28, 134, 238, 255));
							
							else
							
								draw.SimpleTextOutlined( v:GetPlaytimeTitle() , 'PlayerNameFont2', screenPos.x, screenPos.y, Color(255, 255, 255, 255), 1, 1, 1, Color(28, 134, 238, 255));

							end
						end	
					end
					
				end
				
			end
			
		end
					
			end	
			
		
	end
	

				if !LocalPlayer():InVehicle() && LocalPlayer():GetEyeTrace().Entity && LocalPlayer():GetEyeTrace().Entity:IsVehicle() then
				
					local _id = LocalPlayer():GetEyeTrace().Entity:getFlag("carOwner", "")
					if LocalPlayer():SteamID() == _id && LocalPlayer():NearNPC("normcarret") || LocalPlayer():NearNPC( "govtcarret" )  || LocalPlayer():NearNPC( "paramcarret" ) then
					
						draw.SimpleTextOutlined( "Press G to deposit your vehicle." , 'PlayerNameFont2', ScrW() / 2 , ScrH() - _hMod * 100, Color(255, 255, 255, 255), 1, 1, 1, Color(28, 134, 238, 255));

						
					end
				
				end
				
	if (!LocalPlayer():InVehicle() && eyeTrace.Entity && IsValid(eyeTrace.Entity) && (eyeTrace.Entity:IsDoor() )) then
		local dist = eyeTrace.Entity:GetPos():Distance(ourPos);
		
		if (dist <= RealDist) then
			local Alpha = 255;
					
			if (dist >= FadePoint) then
				local moreDist = RealDist - dist;
				local percOff = moreDist / (RealDist - FadePoint);
						
				Alpha = 255 * percOff;
			end
			local alphaF2 = 255;
					
			if (dist >= 200) then
				local moreDist = 350 - dist;
				local percOff = moreDist / (RealDist - FadePoint);
						
				alphaF2 = 255 * percOff;
			end
			
			if (eyeTrace.Entity:IsDoor()) && !IsPropertyFrameUp() then
				cam.Start3D()
				local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter()):ToScreen();
				cam.End3D()
				local doorTable = eyeTrace.Entity:getFlag("doorID", nil )
				local _clubDoor = eyeTrace.Entity:getFlag("clubhouseDoor", nil )
				local _businessdoor = eyeTrace.Entity:getFlag("businessDoor", nil )
				local _playerBusinesses = LocalPlayer():GetBusiness(true);

				if (_clubDoor) then
					local _house = fsrp.ClubhousePropertyTable[_clubDoor]
					local _found = LocalPlayer():HasBusinessIDTag(_house.ClubHouseInformation.Tag,true) == true && true || false;
					if !_found then
						draw.SimpleTextOutlined( "Clubhouse", "OpenSans30", Pos.x, Pos.y, Color(255, 225, 225, Alpha), 1, 1, 1, Color(100, 0, 0, Alpha));
						draw.SimpleTextOutlined('Purchase on MazeForeclosures', "OpenSans30", Pos.x, Pos.y + 25, Color(255, 255, 255, alphaF2/2), 1, 1, 1, Color(255, 64, 0, alphaF2));
					else
						draw.SimpleTextOutlined( "Your Clubhouse <Left Click>", "OpenSans30", Pos.x, Pos.y, Color(255, 225, 225, Alpha), 1, 1, 1, Color(100, 0, 0, Alpha));
					end

				end

				if (_businessdoor) then
					local _found = false;
					local _house = fsrp.I_BusinessPropertyTable[_businessdoor]
					for x , y in pairs( _playerBusinesses ) do
						if y[2] == fsrp.I_BusinessPropertyTable[_businessdoor].BusinessInformation.Tag then
							_found = true;
							break;
						end
					end

					if !_found then
						//draw.SimpleTextOutlined( "", "OpenSans30", Pos.x, Pos.y, Color(225, 225, 255, Alpha), 1, 1, 1, Color(0, 0, 100, Alpha));
						draw.SimpleTextOutlined('Purchase on TheOpenRoad', "OpenSans30", Pos.x, Pos.y + 25, Color(255, 255, 255, alphaF2/2), 1, 1, 1, Color(255, 64, 0, alphaF2));
					else
						draw.SimpleTextOutlined( "Your " .. fsrp.config.IllegalBusinessTypes[_house.BusinessInformation.Type].Name .. " Farm <Left Click>" , "OpenSans30", Pos.x, Pos.y, Color(225, 225, 255, Alpha), 1, 1, 1, Color(0, 0, 100, Alpha));
					end
					
				end

				if (doorTable) then	
				
					local doorOwner = fsrp.PropertyTable[tonumber(doorTable)].PrimaryOwner;
					if (!doorOwner ) then
						draw.SimpleTextOutlined( fsrp.PropertyTable[tonumber(doorTable)].Name .. " ($".. fsrp.PropertyTable[tonumber(doorTable)].Cost..")", "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(0, 100, 0, Alpha));
						draw.SimpleTextOutlined('Press F2 To Purchase', "OpenSans30", Pos.x, Pos.y + 25, Color(255, 255, 255, alphaF2), 1, 1, 1, Color(255, 64, 0, alphaF2));
					else
						draw.SimpleTextOutlined('Owned By ' .. doorOwner[1], "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
						draw.SimpleTextOutlined(fsrp.PropertyTable[tonumber(doorTable)].Name, "OpenSans30", Pos.x, Pos.y + 25, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
						
						local _owner = player.GetBySteamID( doorOwner[2])
						if _owner && _owner:getFlag("organization",nil) != nil && fsrp.orgs[_owner:getFlag("organization", nil)] then
							
							draw.SimpleTextOutlined( fsrp.orgs[_owner:getFlag("organization",nil)][2] , "PlayerNameFont", Pos.x, Pos.y - 25  , Color(255, 255, 255, alpha3), 1, 1, 1, Color(255 * math.sin(RealTime()*5 ), 0, 0, alpha3));

						end
						

					end 
					
				else
				
				
					if (eyeTrace.Entity:IsPoliceDoor()) and fsrp.mayorgovernment and fsrp.mayorgovernment.name then
						draw.SimpleTextOutlined('Owned By ' .. fsrp.mayorgovernment.name .. ' Municipal Government', "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsNeutralDoor()) and fsrp.mayorgovernment and fsrp.mayorgovernment.name then
						draw.SimpleTextOutlined('Owned By ' .. fsrp.mayorgovernment.name .. ' Civil Services', "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif eyeTrace.Entity:IsCustomNameDoor() then
						local s = eyeTrace.Entity:GetCustomName();
						draw.SimpleTextOutlined(string.format(s,fsrp.mayorgovernment.name), "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					
					
					//	draw.SimpleTextOutlined('Unownable', "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					end
				 
				
				end
			end
		end
		
	elseif eyeTrace.Entity:IsVehicle() && !LocalPlayer():InVehicle() then
				cam.Start3D()
				local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter()):ToScreen();
				cam.End3D()
			local dist = eyeTrace.Entity:GetPos():Distance(ourPos);
		
		if (dist <= RealDist) then
			local Alpha = 255;
					
			if (dist >= FadePoint) then
				local moreDist = RealDist - dist;
				local percOff = moreDist / (RealDist - FadePoint);
						
				Alpha = 255 * percOff;
			end
				local _ownerSteamID = eyeTrace.Entity:getFlag("carOwner" , "")
				local _owner = player.GetBySteamID( _ownerSteamID)
				if _owner then
					draw.SimpleTextOutlined('Owned By ' .. player.GetBySteamID( _ownerSteamID ):getRPName(), "OpenSans30", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
				
					if  _owner:getFlag("organization",nil) != nil && fsrp.orgs[_owner:getFlag("organization", nil)] then
						draw.SimpleTextOutlined( fsrp.orgs[_owner:getFlag("organization",nil)][2] , "PlayerNameFont", Pos.x, Pos.y - 25  , Color(255, 255, 255, alpha3), 1, 1, 1, Color(255 * math.sin(RealTime()*5 ), 0, 0, alpha3));
					end
					
				end
		end
			
	end
end


