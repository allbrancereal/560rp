surface.CreateFont("FSRP_Scoreboard_ServerName_Font", {size = ScreenScale(8),weight = 900,antialias = true,shadow = false,font = "coolvetica"})
surface.CreateFont ("FSRP_Scoreboard_Players_Font", {size = ScreenScale(7),weight = 400,antialias = true,shadow = false,font = "coolvetica"})
surface.CreateFont ("RateFont", {size = ScreenScale(6),weight = 0,antialias = true,shadow = false,font = "coolvetica"})
surface.CreateFont ("FSRP_Scoreboard_JobsNumberPlayers_Font", {size = ScreenScale(7),weight = 400,antialias = true,shadow = false,font = "coolvetica"})

local IDsToClass = {};
IDsToClass[TEAM_CIVILLIAN] = "Civillian";
IDsToClass[TEAM_POLICE] = "Police Officer";
IDsToClass[TEAM_PARAMEDIC] = "Paramedic";

local _Ratings = {
	{Name = "Winner", Silk = Material( "icon16/award_star_gold_1.png")};
	{Name = "Friendly", Silk = Material( "icon16/heart.png")};
	{Name = "Dumb", Silk = Material( "icon16/box.png")};
	{Name = "Funny", Silk = Material( "icon16/funny2.png")};
	{Name = "Zing", Silk = Material( "icon16/lightning.png")};
	{Name = "Rich", Silk = Material( "icon16/money.png")};
	{Name = "Agree", Silk = Material( "icon16/tick.png")};
	{Name = "Disagree", Silk = Material( "icon16/cross.png")};
	{Name = "Useful", Silk = Material( "icon16/bullet_wrench.png")};
	{Name = "Late", Silk = Material( "icon16/clock.png")};
	{Name = "Optimistic", Silk = Material( "icon16/rainbow.png")};
	{Name = "Magical", Silk = Material( "icon16/wand.png")};
	{Name = "Informative", Silk = Material( "icon16/book_addresses.png")};

}

local StarIcon = Material( "icon16/star.png");
local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
function Scoreboard()
	if !IsValid( LocalPlayer() ) || !LocalPlayer():Alive() then return end
	
	LocalPlayer():setFlag("restrictInv", true)
	FSRP_Scoreboard_DFrame = vgui.Create("DFrame")
	FSRP_Scoreboard_DFrame:SetSize(_wMod * 1000,math.Clamp( _hMod * 100 + ( _hMod * 50 * #player.GetAll() ) , _hMod * 100,_hMod *  800 ) )
	FSRP_Scoreboard_DFrame:SetTitle("")
	FSRP_Scoreboard_DFrame:SetDraggable(false)
	FSRP_Scoreboard_DFrame:ShowCloseButton(false)
	FSRP_Scoreboard_DFrame:SetPos( ScrW() / 2 - _wMod * 1000/2, _hMod * 150)
	
	FSRP_Scoreboard_DFrame.HostName = GetHostName()
	FSRP_Scoreboard_DFrame.MaxOfficerString = "Officers: " .. team.NumPlayers(TEAM_POLICE) .. " / " .. GetMaxEmployees(TEAM_POLICE);
	FSRP_Scoreboard_DFrame.MaxParamedicString = "Medics: ".. team.NumPlayers(TEAM_PARAMEDIC) .. " / " .. GetMaxEmployees(TEAM_PARAMEDIC)
	FSRP_Scoreboard_DFrame.Paint = function(self,w,h)
		draw.RoundedBox(8, 0, 0, w, self:GetTall(), Color(56, 56, 56, 225))

		//surface.SetMaterial(Material("gui/gradient_up.png"))
		surface.SetDrawColor(Color(25, 25, 25, 255))
		surface.DrawTexturedRectUV(2, 2, _wMod * w - 4, _wMod * self:GetTall() - 4, 128, 128, 128, 128)

		//surface.SetMaterial(Material("gui/gradient_up.png"))
		surface.SetDrawColor(0, 0, 0, 220)
		surface.DrawTexturedRect( -self:GetTall() * 0.3, _wMod *w, _hMod * (self:GetTall() * 1.3), 90)

		draw.SimpleTextOutlined(self.HostName,"Trebuchet24",w/2,_hMod * 25,Color(255,255,255,180),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,200) )	

		//draw.SimpleTextOutlined(self.MaxOfficerString,"FSRP_Scoreboard_JobsNumberPlayers_Font",_wMod * 350 ,42,Color(0, 0, 255, 255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 1.5, Color(0,0,0,200) )
		//draw.SimpleTextOutlined(self.MaxParamedicString,"FSRP_Scoreboard_JobsNumberPlayers_Font",_wMod * 250-#self.MaxOfficerString,42,Color(255, 0, 255, 255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 1.5, Color(0,0,0,200) )
	end
	
	function FSRP_Scoreboard_DFrame:Update()
		self.MaxOfficerString = "Officers: " .. team.NumPlayers(TEAM_POLICE) .. " / " .. GetMaxEmployees(TEAM_POLICE);
		self.MaxParamedicString =  "Medics: " .. team.NumPlayers(TEAM_PARAMEDIC) .. " / " .. GetMaxEmployees(TEAM_PARAMEDIC)
	end
		FSRP_Scoreboard_DPanelList = vgui.Create("DPanelList",FSRP_Scoreboard_DFrame)
		FSRP_Scoreboard_DPanelList:SetSize(_wMod * 980, _hMod * 740)
		FSRP_Scoreboard_DPanelList:SetPos(_wMod * 12,_hMod * 54)
		FSRP_Scoreboard_DPanelList:SetPadding(6)
		FSRP_Scoreboard_DPanelList:SetSpacing(6)
		FSRP_Scoreboard_DPanelList:EnableVerticalScrollbar(true)
			
		FSRP_Scoreboard_DPanel = vgui.Create("DPanel")
		FSRP_Scoreboard_DPanel:SetHeight(_hMod * 30)
		FSRP_Scoreboard_DPanel.Paint = function(self)
			local W,H = self:GetSize()
			draw.RoundedBox(0,0,0,W,H,Color(28,28,28,255))
			draw.RoundedBox(0,0,0,W,15,Color(46,46,46,255))
			surface.SetDrawColor(0,0,0,255)
			surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
			draw.SimpleTextOutlined("Role-play Name","FSRP_Scoreboard_Players_Font",_wMod * 15,_hMod * 15,Color(255,255,255,180),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 1.5, Color(0,0,0,200) )
			draw.SimpleTextOutlined("Ping","FSRP_Scoreboard_Players_Font",W-  _wMod *15,_hMod *15,Color(255,255,255,180),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER, 1.5, Color(0,0,0,200) )		
		end
		FSRP_Scoreboard_DPanelList:AddItem(FSRP_Scoreboard_DPanel)


		for k,v in pairs(player.GetAll()) do
			if IsValid( v ) || v:Alive() then
			local FSRP_Scoreboard_DButton = vgui.Create("DButton")
			FSRP_Scoreboard_DButton:SetText('')
			FSRP_Scoreboard_DButton:SetHeight(_hMod * 40)
			FSRP_Scoreboard_DButton.Think = function() if !v:IsValid() then FSRP_Scoreboard_DButton:Remove() end end
			FSRP_Scoreboard_DButton.Paint = function(self,w,h)
				if !v:IsValid() then return end
				local W,H = self:GetSize()

				local cin = (math.sin(CurTime()) + 1) / 3

				local color = Color( 88, 88, 88, 255 )


				tag = "Online Player"
				local userGroupCol = {
					[0] =  HSVToColor(math.abs(math.sin(CurTime() *0.25) *335) , 1, 1 );

					[1] = Color(255, 0, 255, 150 + math.sin(RealTime() * 2) * 50 );
					
					[2] = Color( 25, 200+ math.sin(RealTime() * 2) * 50, 0, 255);
					
					[3] = Color( 128, 0, 128, 150 + math.sin(RealTime() * 2) * 50);
					
					[4] = Color( 150, 25 + math.sin(RealTime() * 2) * 50, 0, 255 );
					
					[5] = Color( 0,255,255, 255 );
					
					[6] = Color( 255, 120, 0, 255 );
					
					[7] = Color( 255, 0, 255, 255 );
					
					[8] = Color( 255, 200, 50, 255 );
					
					[9] = Color( 50, 50, 200, 255 );
					
					[10] = Color( 88, 88, 88, 255 );
					
				}
				if v:getFlag("disguised", false) then
					color = Color( 88, 88, 88, 255 )
					tag = v:GetPlaytimeTitle();
				
				//elseif v:IsCouncilMember() then
					//color = Color( (math.sin(CurTime() * 5 ) + 1) / 3 * 235, 43, 255 - ((math.sin(CurTime() * 5) + 1) / 3 * 255), 255);
				else
					tag = v:GetPlaytimeTitle()
					color = userGroupCol[v:GetUserGroupRank()];
					if v:IsDonator() then
						color = Color(0,215,255)
					elseif v:IsPremium() then
						color = Color(255,215,0)
					end
				end
				draw.RoundedBox(0,0,0,W,H,color)
				local _Name = v:getRPName() || "John Doe";
				if LocalPlayer():IsModerator() && !v:IsDisguised() then
					if !IDsToClass[v:Team()] then 
						draw.SimpleTextOutlined(  string.sub( _Name, 1, 20 ) ,"FSRP_Scoreboard_Players_Font",_wMod *58,_hMod * 20,Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 2, Color(0,0,0,200) )
					else
						draw.SimpleTextOutlined(  string.sub( _Name, 1, 20 )  ,"FSRP_Scoreboard_Players_Font",_wMod *58,_hMod *20,Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 2, Color(0,0,0,200) )
					end
				else
					draw.SimpleTextOutlined( string.sub( _Name, 1, 20 ) ,"FSRP_Scoreboard_Players_Font",_wMod *58,_hMod *20,Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 2, Color(0,0,0,200) )
				end

				draw.SimpleTextOutlined(v:Ping(),"FSRP_Scoreboard_Players_Font",W- _wMod * 21,_hMod *20,Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER, 1, Color(0,0,0,200) )		
			end
			local _defaultRatings = ""; 
			
			for k , v in pairs( _Ratings ) do
				
				if k != #_Ratings then
				
					_com = ","
					
				else
				
					_com = ""
					
				end
				
				_defaultRatings = _defaultRatings .. "0" .. _com 
			
			end
			local _RRatings = v:getFlag("ratings" , _defaultRatings )
			
			if #_RRatings <= 0 then 
			
				_RRatings = _defaultRatings
				
			end
			
			local _RatingsSplit = string.Explode( ",", _RRatings ) 
			local _rbuttons = {};
			
			for x , y in pairs( _Ratings ) do
				
				local RButton = vgui.Create("DButton", FSRP_Scoreboard_DButton )
				RButton:SetText( "" )
				RButton:SetToolTip( y.Name )
				RButton:SetPos( _wMod * 145  + x * _wMod * 55 , _hMod * 10 )
				RButton:SetSize( _wMod * 60 , _hMod * 40 )
				RButton.Silk = y.Silk;
				RButton.TextToShow = _RatingsSplit[x];
				RButton.Pos = x;
				RButton.Pl = v;
				
				function RButton:Paint(  w , h )
				
					surface.SetDrawColor( 255 ,255 ,255 ,255 )
					surface.SetMaterial( self.Silk )
					surface.DrawTexturedRect( _wMod * 5 , _hMod * 5 , _wMod * 16, _hMod * 16  )
					
					draw.SimpleText( self.TextToShow, "RateFont", _wMod * 25,_hMod * -2, Color( 255 ,255 ,255 ) , 0,0 )
				

				end 
				function RButton:OnMousePressed( k )
				
					net.Start("RatePlayer")
					net.WriteInt( x , 8 )
					net.WriteString( v:SteamID() );
					net.SendToServer()
					
					timer.Simple( .1, function()
						
						if !self then return end
						if !self.Pl then return end
						
						for k , v in pairs( _rbuttons ) do
						
							_RatingsSplit = string.Explode( ",", v.Pl:getFlag("ratings" , _defaultRatings ) ) 
							v.TextToShow = (_RatingsSplit[v.Pos] != nil && _RatingsSplit[v.Pos] || v.TextToShow);
						
						end
						
					end )
					table.insert( _rbuttons, self )
				end
				
			end
			FSRP_Scoreboard_DButton.DoClick = function()
					surface.PlaySound("buttons/button9.wav")
				local options = DermaMenu()
				options:SetPos( gui.MousePos() )
				options:AddOption("Copy SteamID", function() SetClipboardText(v:SteamID()) surface.PlaySound("buttons/button9.wav") end):SetImage("icon16/tag_blue.png")
				options:AddOption("Copy Nick Player", function() SetClipboardText(v:Nick()) surface.PlaySound("buttons/button9.wav") end):SetImage("icon16/user_edit.png")
				options:AddSpacer()
				if !v:IsModerator() || LocalPlayer():IsModerator() then
				
					options:AddOption("Open Steam Profile", function() v:ShowProfile() surface.PlaySound("buttons/button9.wav") end):SetImage("icon16/world.png")
				
				end
				
				options:AddSpacer()
				
			end
					
			
			FSRP_Scoreboard_DButton.OnCursorEntered = function()
				surface.PlaySound("garrysmod/ui_return.wav")
			end		
			
			local plicon = vgui.Create("AvatarImage",FSRP_Scoreboard_DButton)
			plicon:SetPos(_wMod * 7, _hMod * 4	 ) 
			plicon:SetSize(_wMod * 32,_hMod * 32)
			plicon:SetPlayer(v)

			if !v:IsDisguised() && v:IsDonator() then
				local donplicon = vgui.Create("DPanel", FSRP_Scoreboard_DButton)
				donplicon:SetPos(_wMod * 45, _hMod * 3	 ) 
				donplicon:SetSize(_wMod * 32,_hMod * 32)
				donplicon.Paint = function( w, h )
					surface.SetDrawColor( 255 ,255 ,255 ,255 )
					surface.SetMaterial( StarIcon )
					surface.DrawTexturedRect( 0,0, _wMod * 16, _hMod * 16  )
				end
			end

			FSRP_Scoreboard_DPanelList:AddItem(FSRP_Scoreboard_DButton)
		end
	end
	return FSRP_Scoreboard_DFrame
end
function GM:ScoreboardShow()

	
	FSRP_Scoreboard = Scoreboard()
	LocalPlayer().ScoreBoardOpen = true;
	if FSRP_Scoreboard then
	
		FSRP_Scoreboard:Update()
	
	end
	
	gui.EnableScreenClicker(true)
end
	
function GM:ScoreboardHide()
	if FSRP_Scoreboard and FSRP_Scoreboard:IsValid() then FSRP_Scoreboard:Close() end
	LocalPlayer().ScoreBoardOpen = false;
	gui.EnableScreenClicker(false)
	LocalPlayer():setFlag("restrictInv", false)
end