

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
 
net.Receive( "OrganizationInvite" , function ( _l, _p ) 
	local _i =  net.ReadInt(32);
	local _org = net.ReadTable()
	MakeOrganizationInvite( _i,_org)

end )

function MakeOrganizationInvite( id,_org )

	surface.PlaySound( "Friends/friend_join.wav" )

	if fsrp.orgs[id] then 

		_org = fsrp.orgs[id]
	elseif !_org then
		net.Start( "ReInviteToOrg" ) 
			net.WriteInt(id, 32 )
			net.WriteBool( false )
		net.SendToServer( )
		return 
	end

	local _p = LocalPlayer()

	_p:ChatPrint( _org[5] .. " has invited you to join the organization " .. _org[2] ) 
	local _devSkew = 1;

	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( _wMod * 300 , _hMod * 185 )
	Frame:ShowCloseButton( true )
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	
	Frame.Alpha = 0;
	Frame.Alpha2 = 0;
	Frame.DoBeginning = true;
	Frame.FinBeginning = false;
	Frame.DoBeginning2 = false;
	
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
		
		surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
		surface.DrawRect( 0,0, w , h )
		
		surface.SetDrawColor( 140, 138,255, self.Alpha2 ) 
		surface.DrawRect( _wMod * 10, _hMod * 10, w  - _wMod * 20, h - _hMod * 20 )
		draw.SimpleText( "Invited by " .. _org[5] , "Trebuchet6" , w/2, _hMod * 25 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
		draw.SimpleText( "Join " .. _org[2] , "Trebuchet5" , w/2, _hMod * 50 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
		
	end

	local _but = vgui.Create( "DButton", Frame )
	_but:SetPos( _wMod * 17.5 , _hMod * 90  )
	_but:SetSize( Frame:GetWide()/2 - _wMod * 20 , _hMod * 80 )
	_but:SetText( "" ) 
	
	_but.Alpha = 255;
	_but.HoveredColor = Color( 145, 255 ,169, Frame.Alpha2)
	_but.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
	_but.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
	_but.ActiveColor = Color(135 ,197 ,245 , Frame.Alpha2 )
	_but.DoBeginning = true;
	_but.IsAlphaVisible = true;
	_but.FinishedBeginning = true;
		
	function _but:Paint( w,  h )

				if Frame.Alpha2 <= 254 then
					self.HoveredColor =  Color( 145, 255 ,169, Frame.Alpha2)
					self.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
					self.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
				end
				

				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else

					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			surface.SetDrawColor( self.ActiveColor )
			surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Exit", "Trebuchet6" , w/2, h/2 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
	end
	
	function _but:OnMousePressed( k )
	
		net.Start( "ReInviteToOrg" )
			net.WriteInt( tonumber(_org[1]) , 32 )
			net.WriteBool( false )
		net.SendToServer( )
		Frame:Close()
		
	
	end 
	
	local _sbut = vgui.Create( "DButton", Frame )
	_sbut:SetPos(_wMod * 2.5 +Frame:GetWide()/2  , _hMod * 90  )
	_sbut:SetSize( Frame:GetWide()/2 - _wMod * 20 , _hMod * 80 )
	_sbut:SetText( "" ) 
	_sbut.Alpha = 255;
	_sbut.HoveredColor = Color( 145, 255 ,169, Frame.Alpha2)
	_sbut.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
	_sbut.DefaultColor = Color(135 ,197 ,245, Frame.Alpha2 );
	_sbut.ActiveColor = Color( 135 ,197 ,245 , Frame.Alpha2)
	_sbut.DoBeginning = true;
	_sbut.IsAlphaVisible = true;
	_sbut.FinishedBeginning = true;
		
	
	function _sbut:Paint( w,  h )
		
				if Frame.Alpha2 <= 254 then
					self.HoveredColor =  Color( 145, 255 ,169, Frame.Alpha2)
					self.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
					self.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
				end
				

				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else

					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			
			surface.SetDrawColor( self.ActiveColor )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Join", "Trebuchet6" , w/2, h/2 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
	end
	
	function _sbut:OnMousePressed( k )
	
		net.Start( "ReInviteToOrg" )
			net.WriteInt( tonumber(_org[1]) , 32 )
			net.WriteBool( true )
		net.SendToServer( )
		Frame:Close()

	end 

	return Frame;

end 

function ShowOrganizationPanel( )

	local _p = LocalPlayer();
	if !_p:getFlag("organization",nil) then return _p:Notify( "You must join an organization to view it's members!" ) end
	
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( _wMod * 550 , _hMod * 600 )
	Frame:ShowCloseButton( false )
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	
	function Frame:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
		LocalPlayer().OrgMenu = nil
		
	end 
	
	Frame.Alpha = 0;
	Frame.Alpha2 = 0;
	Frame.DoBeginning = true;
	Frame.FinBeginning = false;
	Frame.DoBeginning2 = false;
	
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
		
		surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
		surface.DrawRect( 0,0, w , h )
		
		surface.SetDrawColor( 140, 138,255, self.Alpha2 ) 
		surface.DrawRect( _wMod * 10, _hMod * 10, w  - _wMod * 20, h - _hMod * 20 )
		
	end
	
	local Panel = vgui.Create( "DPanel" , Frame )
	Panel:SetPos( _wMod * 15 , _hMod * 15 )
	Panel:SetSize( Frame:GetWide() - _wMod * 30, _hMod * 100 )
	local _org = fsrp.orgs[_p:getFlag("organization",nil)];
	if !_org then Frame:Remove() end
	
	local _stringPre = string.ToTable( _org[3] );
	Frame.Motd= _org[3];
	Frame.NameText = _org[2]
	local _hasOrgBoost, _OrgBoostTbl = LocalPlayer():HasOrgBoost();
	local _lastboost = _OrgBoostTbl[1];
	function Panel:Paint( w , h )
	
		surface.SetDrawColor( 135, 197, 245,Frame.Alpha2 * 0.8 )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( Frame.NameText , "Trebuchet20" , w/2, _hMod * 20 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
		draw.SimpleText( Frame.Motd, "Trebuchet6" , w/2, _hMod * 50 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
		draw.SimpleText( "Your Leader: " .. _org[5], "Trebuchet6" , w/2, _hMod * 70 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
		if _hasOrgBoost == true && _OrgBoostTbl != nil then
 			draw.SimpleText( "Boost Until:" .. os.date("%H:%M:%S - %m/%d",_lastboost), "Trebuchet6" , w/2, _hMod * 84 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
 		end
 	
	end
	
	local ScrollPanel = vgui.Create( "DScrollPanel" , Frame )
	ScrollPanel:SetPos( _wMod * 15 , _hMod * 250 )
	ScrollPanel:SetSize( Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 300 )

	if _org[4] == LocalPlayer():SteamID() then
	
		local OrgNameEntry = vgui.Create( "DTextEntry" , Frame )
		OrgNameEntry:SetPos( _wMod * 15 , _hMod * 111 ) 
		OrgNameEntry:SetSize( ScrollPanel:GetWide() /2 , _hMod * 24 )
		OrgNameEntry:SetText( _org[2] )
		OrgNameEntry:SetUpdateOnType( false )
		function OrgNameEntry:Think (  )
		
			Frame.NameText = self:GetValue()
			
		end
		
		Frame:Add( OrgNameEntry )
		
		local OrgMotdEntry = vgui.Create( "DTextEntry" , Frame )
		OrgMotdEntry:SetPos( ScrollPanel:GetWide() /2 + _wMod * 15, _hMod * 111 ) 
		OrgMotdEntry:SetSize( ScrollPanel:GetWide() /2 , _hMod * 24 )
		OrgMotdEntry:SetText( _org[3] )
		OrgMotdEntry:SetUpdateOnType( true )
		function OrgMotdEntry:Think(  )
		
			Frame.Motd = self:GetValue()
			
		end
		
		Frame:Add( OrgMotdEntry )
		
	end
	
	function ScrollPanel:Build() 
		_org = fsrp.orgs[_p:getFlag("organization",nil)];
		_stringPre = string.ToTable( _org[3] );
		ScrollPanel:Clear()
		Frame.Motd= _org[3];
		Frame.NameText = _org[2]
		
		for k  ,v  in pairs( _org[6] ) do
			
			local _but = vgui.Create( "DButton", ScrollPanel )
			_but:Dock( TOP )
			_but:SetSize( 100 ,100 )
			_but:SetText( "" ) 
			_but.Master = self
			function _but:Paint( w,  h )
			
				surface.SetDrawColor( 25, 25, 25,Frame.Alpha2 * 0.5 )
				surface.DrawRect( 0,0 , w , h )
				draw.SimpleText( v, "Trebuchet6" , w/2, h/2 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
			
			end
			
			function _but:OnMousePressed( k ) 
				
				surface.PlaySound("buttons/button9.wav")
				local _master = self.Master;
				
				local _DMenu = DermaMenu()
				_DMenu:SetPos( gui.MousePos() )
				local _canPM = false;
				
				for k , v in pairs( player.GetAll() ) do
				
					if v:getRPName() == v then
					
						_canPM = true;
						
						break;
					end
					
				end
							
				if _org[4] == _p:SteamID() then
				
					_DMenu:AddOption( "Kick from Organization" , function()

						net.Start("kickFromOrg")
							net.WriteString( v ) 
						net.SendToServer() 
						timer.Simple( .5, function() if !_master then return end _master:Build() end )

					end )
			
				end
				
				_DMenu:Open()
			end
			ScrollPanel:Add( _but ) 
			
		end
	
	end
	
	ScrollPanel:Build()
	local _devSkew = 1

	local _but = vgui.Create( "DButton", Frame )
	_but:SetPos( _wMod * 17.5 , _hMod * 140  )
	_but:SetSize( Frame:GetWide()/4 - _wMod * 0 , _hMod * 80 )
	_but:SetText( "" ) 
	
	_but.Alpha = 255;
	_but.HoveredColor = Color( 145, 255 ,169, Frame.Alpha2)
	_but.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
	_but.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
	_but.ActiveColor = Color(135 ,197 ,245 , Frame.Alpha2 )
	_but.DoBeginning = true;
	_but.IsAlphaVisible = true;
	_but.FinishedBeginning = true;
		
	function _but:Paint( w,  h )

				if Frame.Alpha2 <= 254 then
					self.HoveredColor =  Color( 145, 255 ,169, Frame.Alpha2)
					self.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
					self.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
				end
				

				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else

					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			surface.SetDrawColor( self.ActiveColor )
			surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Exit", "Trebuchet6" , w/2, h/2 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
	end
	
	function _but:OnMousePressed( k )
	
		LocalPlayer():setFlag("restrictInv", false)
		Frame:Close()
		LocalPlayer().OrgMenu = nil
		
	
	end 
	if _org[4] == LocalPlayer():SteamID() then
	local _sbut = vgui.Create( "DButton", Frame )
	_sbut:SetPos(_wMod *20 + Frame:GetWide()/4  , _hMod * 140  )
	_sbut:SetSize( Frame:GetWide()/4 - _wMod * 15 , _hMod * 80 )
	_sbut:SetText( "" ) 
	_sbut.Alpha = 255;
	_sbut.HoveredColor = Color( 145, 255 ,169, Frame.Alpha2)
	_sbut.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
	_sbut.DefaultColor = Color(135 ,197 ,245, Frame.Alpha2 );
	_sbut.ActiveColor = Color( 135 ,197 ,245 , Frame.Alpha2)
	_sbut.DoBeginning = true;
	_sbut.IsAlphaVisible = true;
	_sbut.FinishedBeginning = true;
		
	
	function _sbut:Paint( w,  h )
		
				if Frame.Alpha2 <= 254 then
					self.HoveredColor =  Color( 145, 255 ,169, Frame.Alpha2)
					self.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
					self.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
				end
				

				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else

					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			
			surface.SetDrawColor( self.ActiveColor )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Save", "Trebuchet6" , w/2, h/2 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
	end
	
	function _sbut:OnMousePressed( k )
	
		net.Start( "sendOrgChange" )
			net.WriteString( Frame.NameText )
			net.WriteString( Frame.Motd )
		net.SendToServer()
				
		timer.Simple( 0.25 , function () 
				
			if !Frame then return end
			
			_org = fsrp.orgs[_p:getFlag("organization",nil)];
			Frame.Motd= _org[3];
			Frame.NameText = _org[2]
		
		end )
		
	end 

end

	local _Invitebut = vgui.Create( "DButton", Frame )
	_Invitebut:SetPos( (Frame:GetWide()/4 *2) + _wMod *7.5 , _hMod * 140  )
	_Invitebut:SetSize( Frame:GetWide()/4 - _wMod * 15 , _hMod * 80 )
	_Invitebut:SetText( "" ) 
	
	_Invitebut.Alpha = 255;
	_Invitebut.HoveredColor = Color( 145, 255 ,169,Frame.Alpha2)
	_Invitebut.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
	_Invitebut.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2);
	_Invitebut.ActiveColor = Color( 135 ,197 ,245 ,Frame.Alpha2)
	_Invitebut.DoBeginning = true;
	_Invitebut.IsAlphaVisible = true;
	_Invitebut.FinishedBeginning = true;
		
	function _Invitebut:Paint( w,  h )
			
			
				if Frame.Alpha2 <= 254 then
					self.HoveredColor =  Color( 145, 255 ,169, Frame.Alpha2)
					self.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
					self.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
				end
				

				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else

					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			surface.SetDrawColor( self.ActiveColor )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Invite", "Trebuchet6" , w/2, h/2 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
	end
	
	function _Invitebut:OnMousePressed( k )
	
		surface.PlaySound("buttons/button9.wav")
		if _p:SteamID( ) != _org[4] then
			
			return _p:Notify( "You may not invite anyone to the organization, you have to ask your boss to invite someone." )

		end

		local _dMenu = DermaMenu()

		_dMenu:SetPos( gui.MousePos( ) )

		for k , v in pairs ( player.GetAll() ) do
			
			if v:getFlag("organization", nil) == nil || !fsrp.orgs[v:getFlag("organization", nil)] then
					
				_dMenu:AddOption( v:getRPName()  , function () 

					net.Start("InviteToOrg")
						net.WriteString( v:SteamID() )
					net.SendToServer()

				end )

			end		

		end
		_dMenu:Open() 

	end 


	local _DonateBut = vgui.Create( "DButton", Frame )
	_DonateBut:SetPos( (Frame:GetWide()/4 *3) - _wMod *5 , _hMod * 140  )
	_DonateBut:SetSize( Frame:GetWide()/4 - _wMod * 15 , _hMod * 80 )
	_DonateBut:SetText( "" ) 
	
	_DonateBut.Alpha = 255;
	_DonateBut.HoveredColor = Color( 145, 255 ,169,Frame.Alpha2)
	_DonateBut.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
	_DonateBut.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2);
	_DonateBut.ActiveColor = Color( 135 ,197 ,245 ,Frame.Alpha2)
	_DonateBut.DoBeginning = true;
	_DonateBut.IsAlphaVisible = true;
	_DonateBut.FinishedBeginning = true;
		
	function _DonateBut:Paint( w,  h )
			
			
				if Frame.Alpha2 <= 254 then
					self.HoveredColor =  Color( 145, 255 ,169, Frame.Alpha2)
					self.PressedColor = Color( 255, 211 ,93 ,Frame.Alpha2)
					self.DefaultColor = Color( 135 ,197 ,245 ,Frame.Alpha2 );
				end
				

				if self:IsDown() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.PressedColor );
				
				elseif self:IsHovered() then
				
					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.HoveredColor );			
				
				else

					self.ActiveColor = lerpColor( 0.05 * _devSkew , self.ActiveColor, self.DefaultColor );			
				
				end
			
			surface.SetDrawColor( self.ActiveColor )
		surface.DrawRect( 0,0 , w , h )
		draw.SimpleText( "Donate", "Trebuchet6" , w/2, h/3 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
		draw.SimpleText( "Growth Boost", "Trebuchet6" , w/2, h/3*1.75 , Color( 255 ,255 ,255 , Frame.Alpha2 ), 1, 1 ) 
			
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

	function _DonateBut:OnMousePressed( k )
	
		surface.PlaySound("buttons/button9.wav")
		if _p:SteamID( ) != _org[4] then
			
			return _p:Notify( "You may not invite anyone to the organization, you have to ask your boss to invite someone." )

		end

		local _dMenu = DermaMenu()

		local _lv = 1;
		if _p:GetRotoLevel(19) then
			_lv = _p:GetRotoLevel(19)[1]
		end

		local _boostcost = 1500000
		_boostcost = _boostcost - (1000*_lv);
		_dMenu:SetPos( gui.MousePos( ) )
		local _boostcost = fsrp.config.OrgBoostCost;
		if LocalPlayer():canAffordBank(_boostcost) then
			_dMenu:AddOption("$" .. comma_value(_boostcost) .. " - 30 Minutes" , function () 
				net.Start("RequestOrgBoost")
					net.WriteInt(1,3)
				net.SendToServer()
			end )
		end 
		_boostcost = 1500000*2
		_boostcost = _boostcost - (1000*_lv);
		if LocalPlayer():canAffordBank(_boostcost*2) then
			_dMenu:AddOption( "$".. comma_value(_boostcost) .. "- 60 Minutes" , function () 
				net.Start("RequestOrgBoost")
					net.WriteInt(2,3)
				net.SendToServer()
			end )
		
		end
		_boostcost = 1500000*3
		_boostcost = _boostcost - (1000*_lv);
		if LocalPlayer():canAffordBank(_boostcost*3) then
			_dMenu:AddOption("$"..comma_value(_boostcost).." - 90 Minutes" , function () 
				net.Start("RequestOrgBoost")
					net.WriteInt(3,3)
				net.SendToServer()
			end )
		end

		_dMenu:Open() 

	end 
	return Frame

end
