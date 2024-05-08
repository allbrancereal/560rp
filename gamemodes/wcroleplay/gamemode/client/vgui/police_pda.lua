

local SCREEN_W, SCREEN_H = 3840, 2160;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

local _pMeta = FindMetaTable('Player')

local _PDATextures = {
	Background = Material( 'wcrp/pda/police_pda');
	LeftArrow = Material( 'wcrp/pda/left_arrow');
	RightArrow = Material( 'wcrp/pda/right_arrow');
	UpArrow = Material( 'wcrp/pda/up_arrow');
	DownArrow = Material( 'wcrp/pda/down_arrow');
	GlowEffect = Material( 'wcrp/pda/gloweffect');
	Enter = Material( 'wcrp/pda/enter');
	Power = Material( 'wcrp/pda/power_button');

}


local function ShowPolicePDA()
	local ply = LocalPlayer();
	if !ply:IsAdmin() && !ply:IsGovernmentOfficial() then return end
	Frame = vgui.Create("DFrame")
	Frame:Dock(FILL)
	Frame:Center()
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)
	Frame:MakePopup()
	Frame.Alpha = 0;
	Frame.Alpha2 = 0;
	Frame.DoBeginning = true;
	Frame.FinBeginning = false;
	Frame.DoBeginning2 = false;
	function Frame:OnClose()
		LocalPlayer().PolicePDA = nil; 

		LocalPlayer():setFlag("restrictInv", false)

	end
	
	function Frame:Paint( w , h )
	
		if self.DoBeginning && !self.FinBeginning then
		
			self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
			
			if self.Alpha > 254 then
			
				self.DoBeginning = false;
			
			end
			
		end
		
		if !self.DoBeginning && !self.FinBeginning then
		
			self.DoBeginning2 = true
			self.FinBeginning = true;
		
		end
		
		if self.DoBeginning2 then
				
			self.Alpha2 = Lerp( 0.1 , self.Alpha2 , 255 ) 
			
			if self.Alpha2 > 254 then
			
				self.DoBeginning2 = false;
			
			end
			
		end
		//local _tex = surface.GetTextureID( 'wcrp/pda/police_pda'  )
		//print(_tex)

		//surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
		//surface.DrawRect( 0,0, w , h )

		//surface.SetTexture( surface.GetTextureID( 'wcrp/pda/police_pda'  ) )		
		surface.SetDrawColor( 255,255,255, self.Alpha2 )
		surface.SetMaterial(_PDATextures.Background)
		surface.DrawTexturedRect( 0,0,w,h )
		draw.NoTexture()

		surface.SetDrawColor(255,255,255,Frame.Alpha2)

		//surface.DrawLine( _wMod * 20 , _hMod * _hAdju+2 , w - _wMod * 20 , _hMod * _hAdju+2)
		
		//draw.SimpleText( self.Owner .. "Stall -\t" .. _statusText, "CashRegisterTitle" , _wMod*25, _hMod * 12.5 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		draw.SimpleText( "Downtown PD Database", "Trebuchet24" , _wMod*(1400),Frame:GetTall()-_hMod*325 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		
	end
	local _Frame = Frame;

	timer.Simple(.5,function() if !_Frame then return end

	if LocalPlayer():Team() == TEAM_MAYOR or LocalPlayer():IsCouncilMember() then
		local _but = vgui.Create("DButton",Frame)
		_but:SetSize(_wMod*250,_hMod*100)
		_but:SetPos(Frame:GetWide()-_wMod*600,Frame:GetTall()-_hMod*325)
		_but:SetText("City Management")
		_but.OnMousePressed = function(p)
			ShowMayorConfig()
		Frame:Close()
		end
	end
	Frame.CloseButton = vgui.Create("DButton", Frame)
	Frame.CloseButton:SetSize(_wMod*256,_hMod*128)
	Frame.CloseButton:SetPos(_wMod*3300,_hMod*56)
	Frame.CloseButton:SetText("")
	Frame.CloseButton.OnMousePressed = function(p)
		Frame:Close()
	end
	
	Frame.CloseButton.Paint = function(self , w, h )
	
		surface.SetDrawColor( 255,255,255, self.Alpha2 )
		surface.SetMaterial(_PDATextures.Power)
		surface.DrawTexturedRect( 0,0,w,h )
		draw.NoTexture()


	end

	local function comma_value(amount)
	  local formatted = amount
	  while true do  
	    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
	    if (k==0) then
	      break
	    end
	  end
	  return formatted
	end

	local _playerlistPanel = vgui.Create("DPanel",Frame)
	_playerlistPanel:SetSize(_wMod*3590,_hMod*1420)
	_playerlistPanel:SetPos(_wMod*125,_hMod*210)
	function _playerlistPanel:Paint(w,h)

		surface.SetDrawColor( 25 ,25 ,25  , 255) 		
		surface.DrawRect( 0,0, w,_hMod*100)
		surface.SetFont("IntroTextSuperSmall")
		local _x,_y = surface.GetTextSize("Name");
		local _x2,_y2 = surface.GetTextSize("Status");
		local _x3,_y3 = surface.GetTextSize("Bank Account Type");
		local _x4,_y4 = surface.GetTextSize("Bank Account Money");
		local _x5,_y5 = surface.GetTextSize("Organization Affiliation");
		draw.SimpleText( "Name", "IntroTextSmall" , _wMod*30,_hMod*7.5 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		draw.SimpleText( "Status", "IntroTextSuperSmall" , _wMod*(400+_x+_x2),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		draw.SimpleText( "Bank Account Type", "IntroTextSuperSmall" , _wMod*(700+_x+_x2+_x3),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		draw.SimpleText( "Bank Account Money", "IntroTextSuperSmall" , _wMod*(1050+_x+_x2+_x3+_x4),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		draw.SimpleText( "Organization Affiliation", "IntroTextSuperSmall" , _wMod*(1400+_x+_x2+_x3+_x4+_x5),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		
	end
	
	local _playerlist = vgui.Create("DScrollPanel",_playerlistPanel)
	_playerlist:SetPos(0,_hMod*100)
	_playerlist:SetSize(_playerlistPanel:GetWide(),_playerlistPanel:GetTall()-_hMod*100)

	local _alt = false;
	for k , v in pairs(player.GetAll()) do
		
		if !ply:IsAdmin() && !ply:IsGovernmentOfficial() then return end
		local _player = _playerlist:Add("DPanel")
		_player:Dock(TOP)
		_player:DockPadding(0,0,5,0)
		_player.Entity = v;
		_player:SetTall(_hMod*110)
		_player.ColorAlt = _alt;
		_alt = !_alt;
		_player.name = v:getRPName();
		_player.wanted = v:getFlag("warrent", false);
		_player.status = _player.wanted == true && "Wanted" || "Unaffiliated";
		_player.bankt = v:getBankAccount() == 0 && "None" || v:getBankAccount() == 1 && "Chequing" || v:getBankAccount() == 2 && "Saving" || v:getBankAccount() == 3 && "Business" || "";
		_player.bank = comma_value(v:getBank());
		_player.Organization = fsrp.orgs[v:getFlag("organization",nil)];
		
		_player.col = (_player.wanted == true && Color(255,0,0,255) || Color(255,255,255));
		function _player:Paint(w,h)

			surface.SetDrawColor( 56 ,56 ,56  , 255) 
			if self.ColorAlt == true then
				surface.SetDrawColor(128,128,128,255)
			end
			surface.DrawRect( 0,0, w , h )
			surface.SetFont("IntroTextSuperSmall")
			local _x,_y = surface.GetTextSize("Name");
			local _x2,_y2 = surface.GetTextSize("Status");
			local _x3,_y3 = surface.GetTextSize("Bank Account Type");
			local _x4,_y4 = surface.GetTextSize("Bank Account Money");
			local _x5,_y5 = surface.GetTextSize("Organization Affiliation");
			draw.SimpleText( self.name, "IntroTextSuperSmall" , _wMod*30,_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText( self.status, "IntroTextSuperSmall" , _wMod*(400+_x+_x2),_hMod*30 , self.col, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText( self.bankt, "IntroTextSuperSmall" , _wMod*(700+_x+_x2+_x3),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText( "$" .. self.bank, "IntroTextSuperSmall" , _wMod*(1050+_x+_x2+_x3+_x4),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
			draw.SimpleText( (self.Organization != nil && self.Organization[2] || "None"), "IntroTextSuperSmall" , _wMod*(1400+_x+_x2+_x3+_x4+_x5),_hMod*30 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		
		end
		local _count = 1;
		if v:getBank() < 0 then
			
			local _resetcurrencybutton = vgui.Create("DButton",_player);
			_player.currencybutton = _resetcurrencybutton;
			_resetcurrencybutton:SetSize(_wMod*350,_hMod*100)
			_resetcurrencybutton:SetText("")
			_resetcurrencybutton:SetPos(_wMod*(2200 + (_count*350)),_hMod*5)
			function _resetcurrencybutton:Paint(w,h)

				surface.SetDrawColor( 56 ,56 ,56  , 255) 
				if self:IsHovered() then
					surface.SetDrawColor(128,128,128,255)
				end
				surface.DrawRect( 0,0, w , h )
				surface.SetFont("IntroTextSuperSmall")
				local _x,_y = surface.GetTextSize("Reset Currency");
				draw.SimpleText( "Reset Currency", "IntroTextSuperSmall" , w/2-_x/2,h/2-_y/2 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
				
			end
			_resetcurrencybutton.player = _player;
			function _resetcurrencybutton:OnMousePressed(k)
				if !ply:IsAdmin() && !ply:IsGovernmentOfficial() then return end
				net.Start("PolicePDAAction")
				net.WriteInt(2,3)
				net.WriteString(self.player.Entity:SteamID())
				net.SendToServer()
			end
			_count = _count + 1;
		end
		
		local _class = LocalPlayer():Team();
		local _timeplayed = LocalPlayer():GetJobTimeInfo(TEAM_POLICE);
		if (_timeplayed && tonumber(_timeplayed.Rank) > 2) || _class == TEAM_MAYOR || LocalPlayer():IsAdmin() then
			local _warrantbutton = vgui.Create("DButton",_player);
			_player.warrantbutton = _warrantbutton;
			_warrantbutton:SetSize(_wMod*350,_hMod*100)
			_warrantbutton:SetText("")
			_warrantbutton:SetPos(_wMod*(2200 + (_count*350)),_hMod*5)
			_warrantbutton.wanted = false;
			_warrantbutton.player = _player;
			_warrantbutton.text = _warrantbutton.player.wanted == true && "Unwarrant" or "Warrant";
			function _warrantbutton:Paint(w,h)

				surface.SetDrawColor( 56 ,56 ,56  , 255) 
				if self:IsHovered() then
					surface.SetDrawColor(128,128,128,255)
				end
				surface.DrawRect( 0,0, w , h )
				surface.SetFont("IntroTextSuperSmall")
				local _x,_y = surface.GetTextSize(_warrantbutton.text);
				draw.SimpleText(_warrantbutton.text , "IntroTextSuperSmall" , w/2-_x/2,h/2-_y/2 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
				
			end
			
			function _warrantbutton:OnMousePressed(k)
				if !ply:IsAdmin() && !ply:IsGovernmentOfficial() then return end
				net.Start("PolicePDAAction")
				net.WriteInt(1,3)
				net.WriteString(self.player.Entity:SteamID())
				net.SendToServer()
			end
			_count = _count + 1;
		end

		if _class == TEAM_MAYOR || LocalPlayer():IsAdmin() then
			local _demotebutton = vgui.Create("DButton",_player);
			_player.demotebutton = _demotebutton;
			_demotebutton:SetSize(_wMod*350,_hMod*100)
			_demotebutton:SetText("")
			_demotebutton:SetPos(_wMod*(2200 + (_count*350)),_hMod*5)
			_demotebutton.wanted = false;
			_demotebutton.player = _player;
			_demotebutton.text = "Demote";
			function _demotebutton:Paint(w,h)

				surface.SetDrawColor( 56 ,56 ,56  , 255) 
				if self:IsHovered() then
					surface.SetDrawColor(128,128,128,255)
				end
				surface.DrawRect( 0,0, w , h )
				surface.SetFont("IntroTextSuperSmall")
				local _x,_y = surface.GetTextSize(_demotebutton.text);
				draw.SimpleText(_demotebutton.text , "IntroTextSuperSmall" , w/2-_x/2,h/2-_y/2 , Color( 255 ,255 ,255 , 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
				
			end
			
			function _demotebutton:OnMousePressed(k)
				if !ply:IsAdmin() && !ply:IsGovernmentOfficial() then return end
				net.Start("PolicePDAAction")
				net.WriteInt(3,3)
				net.WriteString(self.player.Entity:SteamID())
				net.SendToServer()
			end
			_count = _count + 1;
		end
		//_player:SetPos(_wMod*125,_hMod*210)
	end
	end)
	LocalPlayer().PolicePDA = Frame;

	return Frame;

end

concommand.Add("wc_policepda",function( ply, cmd, args )

	if !ply:IsAdmin() && !ply:IsGovernmentOfficial() then return end
	
	LocalPlayer().PolicePDA = ShowPolicePDA();

end)	