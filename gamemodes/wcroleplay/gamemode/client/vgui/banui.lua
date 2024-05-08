
local SCREEN_W, SCREEN_H = 2560, 1440;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;


// 0 = online player
// 1 = offline player steamID
// 3 = offline player ip

local function BringBanUIUp( steamID, enum)

	local _toBan = player.GetBySteamID( steamID )
	local _p = LocalPlayer();
	
	if !_p:IsModerator() then return _p:Notify( "Only moderators or higher may ban" ) end
	if !_toBan then return _p:Notify( "Player is not on the server anymore" ) end
	
	local FRAME = vgui.Create( "DFrame" )
	FRAME:SetSize( _wMod * 500 , _hMod * 300 )
	FRAME:Center()
	FRAME:MakePopup()
	FRAME:ShowCloseButton( true )
	FRAME.Alpha = 0;
	FRAME.DoBeginning = true;
	FRAME.Alpha2 = 0;
	
	function FRAME:Paint( w , h )
	
		if self.DoBeginning then
		
			self.Alpha = Lerp( 0.05 , self.Alpha , 255 ) 
			
			if self.Alpha >= 128 then
			
				self.DoBeginning = false
				self.FinishedBeginning = true;
				
			end
			
		end
		
		surface.SetDrawColor( 25, 25 ,25 , self.Alpha )
		
		surface.DrawRect( 0,0,w,h ) // frame
		
		if self.FinishedBeginning then
		
			self.StartUI = true;
			
			self.FinishedBeginning = false;
			
		end	

		if self.StartUI then
			
			self.Alpha2 = Lerp( 0.05, self.Alpha2, 255 )
			
			if self.Alpha2 >= 128 then
			
				self.FinishedBootingAlphas = true
				self.StartUI = false;
				
			end
			
		end
		
		if self.FinishedBootingAlphas then
		
			self:StartTrueUpdate( )
			self.FinishedBootingAlphas = false;

		end	
		
		draw.SimpleText( "Steam-ID:" , "Trebuchet24", _wMod * 20,_hMod * 45, Color( 255 ,255 ,255 ,self.Alpha ) , TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT );
			
		draw.SimpleText( "Ban Reason:" , "Trebuchet24", _wMod * 20,_hMod * 90, Color( 255 ,255 ,255 ,self.Alpha ) , TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT );
			
		draw.SimpleText( "Length (s):" , "Trebuchet24", _wMod * 20,_hMod * 135, Color( 255 ,255 ,255 ,self.Alpha ) , TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT );
			
		draw.SimpleText( "IS IPBan:" , "Trebuchet24", _wMod * 20,_hMod * 180, Color( 255 ,255 ,255 ,self.Alpha ) , TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT );
			
	end 
	
	//IPAddy:SetPos( FRAME:GetWide()/2 - _wMod * 60 , _hMod * 0 ) 
	//SteamID:SetPos( FRAME:GetWide() / 2 + _wMod * 10 , _hMod * 25 )
	//ListOptions:SetSize( FRAME:GetWide()/2 - _wMod * 20 
	/*
	FRAME.Buttons = {};
	for i = 1 , 5 do 
		local button = vgui.Create( "DButton" , ListOptions )
		button:SetSize(50,50)
		button:SetEnabled( false )
		button:Dock( TOP )
		button.DoBeginning = true
		button.FinishedBeginning = false
		button.Alpha = 0 
		function button:Paint( w, h )
				
			if self.DoBeginning then
			
				self.Alpha = Lerp( ( 0.05 * i ) , self.Alpha , 255 ) 
				
				if self.Alpha >= 254 then
				
					self.DoBeginning = false
					self.FinishedBeginning = true;
					
				end
				
			end
		
			surface.SetDrawColor( 255 ,255 ,255 , self.Alpha )
			surface.DrawRect( 0,0,w,h )
			
		end
		
		ListOptions:Add( button )
		FRAME.Buttons[i] = button;
	end
	*/
	
	function FRAME:StartTrueUpdate( )
			
		local SteamID = vgui.Create( "DTextEntry", FRAME )
		SteamID:SetSize( FRAME:GetWide()/2 + _wMod * 60 , _hMod * 40 ) 
		SteamID:SetPos( FRAME:GetWide()/2 - _wMod * 65 , _hMod * 40 ) 
		SteamID:SetFont( "Trebuchet24" ) 
		//SteamID:Dock( TOP )
		//SteamID:SetPos( FRAME:GetWide()/2 - _wMod * 60 , _hMod * 0 ) 
		SteamID.OnEnter = function( self ) 
			local val = self:GetValue( )
			
			self:RequestFocus()
		end 
		SteamID:SetValue( steamID )
		
		local BanReason = vgui.Create( "DTextEntry", FRAME )
		BanReason:SetSize( FRAME:GetWide()/2 + _wMod * 60 , _hMod * 40 ) 
		BanReason:SetPos( FRAME:GetWide()/2 - _wMod * 65 , _hMod * 85 ) 
		BanReason:SetFont( "Trebuchet24" ) 
		//BanReason:Dock( TOP )
		//BanReason:SetPos( FRAME:GetWide()/2 - _wMod * 60 , _hMod * 0 ) 
		
		local IPAddy = vgui.Create( "DTextEntry", FRAME )
		IPAddy:SetSize( FRAME:GetWide()/2 + _wMod * 60 , _hMod * 40 ) 
		IPAddy:SetPos( FRAME:GetWide()/2 - _wMod * 65 , _hMod * 130 ) 
		IPAddy:SetFont( "Trebuchet24" ) 
		//IPAddy:Dock( TOP )
		
		local IsIPBan = vgui.Create( "DButton", FRAME )
		IsIPBan:SetSize( _wMod * FRAME:GetWide()/2+_wMod * 60 , _hMod * 40 )
		IsIPBan:SetPos( FRAME:GetWide()/2 - _wMod * 65 , _hMod * 175 ) 
		//IsIPBan:Dock( TOP )
		FRAME.IsIPBan = false
		IsIPBan.Text = "Banning By Steam-ID"
		IsIPBan:SetText( "" )
		
		function IsIPBan:OnMousePressed( k )
		
			FRAME.IsIPBan = !FRAME.IsIPBan;
		
			self.Text = FRAME.IsIPBan && "Banning By IP" || "Banning by Steam-ID";
			
			
		end

		local BanButton = vgui.Create( "DButton", FRAME )
		BanButton:SetSize( _wMod * FRAME:GetWide()/2+_wMod * 60 , _hMod * 40 )
		BanButton:SetPos( FRAME:GetWide()/2 - _wMod * 65 , _hMod * 225 ) 
		BanButton:SetText( "" )

		function BanButton:OnMousePressed( k )

			if IPAddy:GetValue( ) == "" then return end
			if SteamID:GetValue( ) == "" then return end
			
			if BanReason:GetValue( ) == "" then return end
			
			net.Start("banPlayer")
				net.WriteString( SteamID:GetValue( ) )
				net.WriteString( IPAddy:GetValue( ) )
				net.WriteString( BanReason:GetValue( ) )
				net.WriteBool( FRAME.IsIPBan )
			net.SendToServer()

		end
		
		function BanButton:Paint( w , h )
		
			if self.DoBeginning then
			
				self.Alpha = Lerp( 0.05 , self.Alpha , 255 ) 
				
				if self.Alpha >= 254 then
				
					self.DoBeginning = false
					self.FinishedBeginning = true;
					
				end
				
			end
			
			
			surface.SetDrawColor( 255, 255 ,255 , self.Alpha )		
		
			
			
			surface.DrawRect( 0,0,w,h ) // frame
			
			draw.SimpleText( "Ban" , "Trebuchet24", w/2,h/2, Color( 25 ,25 ,25 ,self.Alpha ) , TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER );
			
		end
	
		function IsIPBan:Paint( w , h )
		
			if self.DoBeginning then
			
				self.Alpha = Lerp( 0.05 , self.Alpha , 255 ) 
				
				if self.Alpha >= 254 then
				
					self.DoBeginning = false
					self.FinishedBeginning = true;
					
				end
				
			end
			
			if FRAME.IsIPBan then
			
				surface.SetDrawColor( 255, 0 ,0 , self.Alpha )		
			
			else
			
				surface.SetDrawColor( 0, 255 ,0 , self.Alpha )		
		
			end
			
			surface.DrawRect( 0,0,w,h ) // frame
			
			draw.SimpleText( self.Text , "Trebuchet24", w/2,h/2, Color( 255 ,255 ,255 ,self.Alpha ) , TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER );
			
		end
	
			
	end
	
end

net.Receive( "getBanInformation", function( _l , _p )
	
	BringBanUIUp( net.ReadString() , net.ReadInt( 4 ), net.ReadString() )

end )