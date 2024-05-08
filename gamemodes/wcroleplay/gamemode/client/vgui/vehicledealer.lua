
local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;


local _p = LocalPlayer()
	function ShowDealershipView ( )		

		_p = LocalPlayer()
		Frame = vgui.Create("DFrame")
		Frame:SetSize( _wMod * 650 , ScrH() )
		Frame:ShowCloseButton( false )
		Frame.Alpha = 0;
		Frame.DoBeginning = true;
		Frame:SetTitle( "" )
		Frame.FinishedBeginning = false;
		Frame:Dock( RIGHT )
		Frame.Paint = function( self, w , h )
			
			if self.DoBeginning && self.FinishedBeginning == false then 
				
				self.Alpha = Lerp( 0.05, self.Alpha , 255 ) 
			
				if self.Alpha >= 254 then
				
					self.FinishedBeginning = true;
									
				end
				
			end
			
			surface.SetDrawColor( 25 ,25 ,25 , self.Alpha * 0.5 ) 			
			surface.DrawRect( 0,0, w, h )
			surface.SetDrawColor( 56 ,56 ,56 , self.Alpha * 0.5 ) 			
			surface.DrawRect( _wMod * 15, _hMod * 15 , w - _wMod * 30 , h - _hMod * 15 )
		
		end 
		Frame:Center()
		Frame:MakePopup()
		 
		function Frame:OnClose()
				
			net.Start( "sendClientCloseVehicle" )
			net.SendToServer() 
			
		end
		local i = 1;
		function Frame:MakeBt( fn , t  )
		// Purchase selection
		local _Button = Frame:Add( "DButton" )
		_Button:SetPos( ( _wMod * 115 * i - _wMod * 62.5 ) ,  _hMod *  15 )
		_Button:SetSize( _wMod * 100 , _hMod * 100 )
				
		function _Button:OnMousePressed( k )
				
			fn()
			
		end 
				
		_Button.HoveredColor = Color( 145, 255 ,169, _Button.Alpha)
		_Button.PressedColor = Color( 255, 211 ,93 ,_Button.Alpha)
		_Button.DefaultColor = Color( 255 ,255 ,255 , _Button.Alpha );
		_Button.ActiveColor = Color( 0,0,0 ,0 )
		_Button.Alpha = 0;
		_Button.DoBeginning = true;
		_Button.IsAlphaVisible = false;
		_Button:SetMouseInputEnabled( true )
		_Button.FinishedBeginning = false;
			
		_Button:SetText( "" )
			
			function _Button:Paint( w, h )

				if self.DoBeginning && !self.IsAlphaVisible then
					
					self.Alpha = Lerp( 0.05 , self.Alpha , 255 )
								
					if self.Alpha >= 254 then
								
						self.IsAlphaVisible = true;
									
					end
								
				end
							
				if self:IsDown() then
							
					self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.PressedColor );
								
				elseif self:IsHovered() then
								
					self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.HoveredColor );			
								
				else
								
						self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.DefaultColor );			
								
				end
								
				surface.SetDrawColor( self.ActiveColor )
				surface.DrawRect( 0,0,w,h )
				draw.SimpleText( t, "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
							
			end
			i = i +1
		end
		
		local _scrollPanel = vgui.Create( "DScrollPanel" , Frame )
		local _scrollPaintPanel = vgui.Create( "DScrollPanel" , Frame )
		local _scrollCameraPanel = vgui.Create( "DScrollPanel" , Frame )
		
		local ColorPick = vgui.Create( "DColorMixer", _scrollPaintPanel)
		ColorPick:SetSize( _scrollPaintPanel:GetWide(), _hMod * 300 )
		ColorPick:Dock( TOP )
		//ColorPick:SetPos( 50, 50 )
		ColorPick.Think = function()
			local col = ColorPick:GetColor()
			ColorPick:SetColor(Color(col.r, col.g, col.b, 255))
			
			for k , v in pairs( ents.FindByClass( "cardisplay" ) ) do
					
				if v:getFlag( "mainCarDisplay", false ) == true then
						
					v:SetColor( col )
							
					break;
							
				end
						
			end
			
		end
		_scrollPaintPanel:Add( ColorPick )
		function _scrollCameraPanel:MakeBt( fn , t, col  )
		// Purchase selection
		local _Button = _scrollCameraPanel:Add( "DButton" )
		_Button:Dock( TOP )
		_Button:SetSize( _scrollCameraPanel:GetWide() , _hMod * 100 )
				
		function _Button:OnMousePressed( k )
				
			fn()
			
		end 
				
		_Button.HoveredColor = Color( 145, 255 ,169, _Button.Alpha)
		_Button.PressedColor = Color( 255, 211 ,93 ,_Button.Alpha)
		_Button.DefaultColor = Color( col.r, col.g, col.b , _Button.Alpha );
		_Button.ActiveColor = Color( 0,0,0 ,0 )
		_Button.Alpha = 0;
		_Button.DoBeginning = true;
		_Button.IsAlphaVisible = false;
		_Button:SetMouseInputEnabled( true )
		_Button.FinishedBeginning = false;
			
		_Button:SetText( "" )
			
			function _Button:Paint( w, h )

				if self.DoBeginning && !self.IsAlphaVisible then
					
					self.Alpha = Lerp( 0.05 , self.Alpha , 255 )
								
					if self.Alpha >= 254 then
								
						self.IsAlphaVisible = true;
									
					end
								
				end
							
				if self:IsDown() then
							
					self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.PressedColor );
								
				elseif self:IsHovered() then
								
					self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.HoveredColor );			
								
				else
								
						self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.DefaultColor );			
								
				end
								
				surface.SetDrawColor( self.ActiveColor )
				surface.DrawRect( 0,0,w,h )
				draw.SimpleText( t, "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
							
			end
			i = i +1
		end
		function _scrollPaintPanel:MakeBt( fn , t, col  )
		// Purchase selection
		local _Button = _scrollPaintPanel:Add( "DButton" )
		_Button:Dock( TOP )
		_Button:SetSize( _scrollPaintPanel:GetWide() , _hMod * 50 )
				
		function _Button:OnMousePressed( k )
				
			fn()
			
		end 
		_Button.col = col;
		_Button.HoveredColor = Color( 145, 255 ,169, _Button.Alpha)
		_Button.PressedColor = Color( 255, 211 ,93 ,_Button.Alpha)
		_Button.DefaultColor = Color( _Button.col.r, _Button.col.g, _Button.col.b , _Button.Alpha );
		_Button.ActiveColor = Color( 0,0,0 ,0 )
		_Button.Alpha = 0;
		_Button.DoBeginning = true;
		_Button.IsAlphaVisible = false;
		_Button:SetMouseInputEnabled( true )
		_Button.FinishedBeginning = false;
			
		_Button:SetText( "" )
			
			function _Button:Paint( w, h )

				if self.DoBeginning && !self.IsAlphaVisible then
					
					self.Alpha = Lerp( 0.05 , self.Alpha , 255 )
								
					if self.Alpha >= 254 then
								
						self.IsAlphaVisible = true;
									
					end
								
				end
							
				if self:IsDown() then
							
					self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.PressedColor );
								
				elseif self:IsHovered() then
								
					self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.HoveredColor );			
								
				else
								
						self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.DefaultColor );			
								
				end
								
				surface.SetDrawColor( self.ActiveColor )
				surface.DrawRect( 0,0,w,h )
				draw.SimpleText( t, "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
							
			end
			i = i +1
		end
		_scrollPaintPanel:SetSize(  Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 130  )
		_scrollPaintPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollPaintPanel:SetPadding( _hMod * 100 )
		_scrollPaintPanel:SetVisible( false )
		
		_scrollCameraPanel:SetSize(  Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 130  )
		_scrollCameraPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollCameraPanel:SetPadding( _hMod * 100 )
		_scrollCameraPanel:SetVisible( false )
		
		Frame:MakeBt( function( )
			
			if Frame.Key then
			
				net.Start("PurchaseVehicle")
					
					net.WriteInt( Frame.Key, 16 )
					net.WriteInt( ColorPick:GetColor().r,12 )
					net.WriteInt( ColorPick:GetColor().g,12 )
					net.WriteInt( ColorPick:GetColor().b,12 )
				net.SendToServer( )
			
			end
			_scrollPanel:SetVisible( false )
			_scrollCameraPanel:SetVisible( false )
			_scrollPaintPanel:SetVisible( false )
			Frame:Close()
		
			
		end , "Purchase" )
		Frame:MakeBt( function( )
		
			_scrollPanel:SetVisible( true )
			_scrollCameraPanel:SetVisible( false )
			_scrollPaintPanel:SetVisible( false )
		
		end , "Select" )
		Frame:MakeBt( function( )
		
			_scrollPanel:SetVisible( false )
			_scrollCameraPanel:SetVisible( false )
			_scrollPaintPanel:SetVisible( true )
		
		end , "Paint" )
		Frame:MakeBt( function( )
		
			_scrollPanel:SetVisible( false )
			_scrollCameraPanel:SetVisible( true )
			_scrollPaintPanel:SetVisible( false )
		
		end , "Options" )
		Frame:MakeBt( function( )
		
			Frame:Close()
		
		end , "Exit" )
		
		local _tableOfColors = {
			{Name = "White" , Col = Color( 255 ,255 ,255 )};
			{ Col =  Color(255,0,0,255),Name =  "Red"},
			{  Col = Color(0,255,0,255),Name =  "Green"},
			{  Col = Color(0,0,255,255),Name =  "Blue"},
			{  Col = Color(0,255,255,255), Name = "Teal"},
			{  Col = Color(255,125,0,255),Name =  "Orange"},
			{  Col = Color(255,0,255,255),Name =  "Violet"},
			{  Col = Color(255,215,0,255),Name =  "Gold"},
		
		}
		for k , v in pairs( _tableOfColors ) do
		
			_scrollPaintPanel:MakeBt( function( )
		
				ColorPick:SetColor( v.Col )
		
				for x , y in pairs( ents.FindByClass( "cardisplay" ) ) do
					
					if y:getFlag( "mainCarDisplay", false ) == true then
						
						y:SetColor( v.Col )
							
						break;
							
					end
						
				end
		
			end, v.Name , v.Col )
			
		end
		
		for i = 0, 5 do
		
			_scrollCameraPanel:MakeBt( function( )
			
			
				LocalPlayer():setFlag( "vehicleCamera", i )
			
			end, "Camera #" .. (i+1) , Color(255,255,255) )
			
		end
		local _isMusicON = IsValid( LocalPlayer().VehicleDisplaySong ) && Color( 0, 255, 0, 255 ) || Color( 255, 0 , 0, 255 )
		
		_scrollCameraPanel:MakeBt( function( )
			
		if LocalPlayer().VehicleDisplaySong then
			
			fsrp.Vehicle.RemoveVehicleSong()
		
		else
			
			fsrp.Vehicle.MakeVehicleSong()
		
		end
			
			
		end, "Toggle Intro/Music" , Color(255,255,255) )
			
		_p.VehicleShop = Frame;
		
		_scrollPanel:SetSize(  Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 130  )
		_scrollPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollPanel:SetPadding( _hMod * 100 )
		
		Frame.Key = 315
		for k , v in pairs( ents.FindByClass( "cardisplay" ) ) do
					
			if  v:getFlag( "mainCarDisplay", false ) == true then
						
				v:SetModel( list.Get("Vehicles")[fsrp.VehicleDatabase[ITEMLIST[315].ListVehicle].VehicleName].Model )
				v:SetColor( Color( 255 ,0,0) )
				
				break;
							
			end
						
		end
		for k , v in pairs(fsrp.VehicleDatabase ) do
		
			local _VItem;

			for x , y in pairs( list.Get( "Vehicles") ) do
				
				if x == ITEMLIST[v.Key].ListVehicle then
				
					_VItem = y;
				
				end
				
			end
			if !v.AvaliableTeam then
			
				local lock = false;
				if v.AvaliableGroup && v.AvaliableGroup[ _p:getFlag( "rank" , 10 ) ] then lock = true end
				
				
				local _Vehicle = _scrollPanel:Add( "DButton" )
				_Vehicle:Dock( TOP ) 
				_Vehicle:SetSize( _scrollPanel:GetWide() , _hMod * 150 )
				_Vehicle.VName = _VItem
				_Vehicle.KeyItem = v.Key
				_Vehicle.Item = ITEMLIST[v.Key];
				for k , v in pairs ( list.Get("Vehicles") ) do 
				
					if k == _Vehicle.Item.ListVehicle then
					
						_Vehicle.ModelToSet = v.Model ;
				
					end
					
				end
				function _Vehicle:OnMousePressed( k )
					Frame.Key = self.Item.ID
					
					for k , v in pairs( ents.FindByClass( "cardisplay" ) ) do
					
						if v:getFlag( "mainCarDisplay", false ) == true then
						
							v:SetModel( self.ModelToSet )
							
							break;
							
						end
						
					end
				
				end 
				
				_Vehicle.HoveredColor = Color( 145, 255 ,169, _Vehicle.Alpha)
				_Vehicle.PressedColor = Color( 255, 211 ,93 ,_Vehicle.Alpha)
				_Vehicle.DefaultColor = Color( 25 ,25 ,25 , _Vehicle.Alpha );
				_Vehicle.ActiveColor = Color( 0,0,0 ,0 )
				_Vehicle.Alpha = 0;
				_Vehicle.DoBeginning = true;
				_Vehicle.IsAlphaVisible = false;
				_Vehicle:SetMouseInputEnabled( true )
				_Vehicle.FinishedBeginning = false;
				
				local _VehicleAvatar = vgui.Create( "DModelPanel" , _Vehicle )
				_VehicleAvatar:SetSize( _Vehicle:GetWide() - _wMod * 250, _Vehicle:GetTall() - _hMod * 20 )
				_VehicleAvatar:SetPos( _wMod * 225, _Vehicle:GetTall() - _hMod * 10 )
				_VehicleAvatar:Center()
				_VehicleAvatar:SetModel(  _Vehicle.VName.Model )
				_VehicleAvatar:SetMouseInputEnabled( false )
				_VehicleAvatar:SetCamPos( Vector(-250, 250, 100.46) ) 
				_VehicleAvatar:SetLookAt( Vector(21.62, 5.41, 5) )
				_Vehicle:SetText( "" )
				function _Vehicle:Paint( w, h )

							if self.DoBeginning && !self.IsAlphaVisible then
							
								self.Alpha = Lerp( 0.05 , self.Alpha , 255 )
								
								if self.Alpha >= 254 then
								
									self.IsAlphaVisible = true;
									
								end
								
							end
							
								if self:IsDown() then
								
									self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.PressedColor );
								
								elseif self:IsHovered() then
								
									self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.HoveredColor );			
								
								else
								
									self.ActiveColor = lerpColor( 0.05 * 1 , self.ActiveColor, self.DefaultColor );			
								
								end
								
								if self.Item.ID == Frame.Key then
								
									self.ActiveColor = Color( 255, 255, 255 )
								
								end
								
							surface.SetDrawColor( self.ActiveColor )
							surface.DrawRect( 0,0,w,h )
						if self.Item then
						
							local _canAffordColor = LocalPlayer():getMoney() > self.Item.Cost && Color( 25 ,255 ,25 , self.Alpha ) || Color( 255 ,0 ,25 , self.Alpha )
							draw.SimpleText( self.VName.Name, "CarDisplayName", _wMod * 5,_hMod * 5, Color( 255 ,255 ,255 , self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
							draw.SimpleText( "Price: $" ..  self.Item.Cost, "CarDisplayPrice", _wMod * 5,_hMod * 35, _canAffordColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
							
						end
							
				end
			
			end
			
		end
		
	end

net.Receive( "resetMainDisplayModel", function( _l, _p )

	local _modelPath = net.ReadString()
	local _modelIndex = net.ReadInt( 16 )
	
	if IsValid( ents.GetByIndex( _modelIndex ) ) then
	
		ents.GetByIndex( _modelIndex ):SetModel( _modelPath )
		ents.GetByIndex( _modelIndex ):SetSkin( 0 )
		ents.GetByIndex( _modelIndex ):SetColor( Color(255,255,255,255) )
		
	end

end )

local function makeSkipVIntroText()
	local _StartTime = CurTime();
	local _TextAlpha = 0
	hook.Add("HUDPaint", "VehicleSkipIntroText", function( w, h )
		
		local w = ScrW()
		local h = ScrH()
		
		if _StartTime < CurTime() + 5  then
		
			_TextAlpha = Lerp( 0.05, _TextAlpha , 255 )
		
		end
		
		if _StartTime < CurTime() + 20 then
		
			_TextAlpha = Lerp( 0.05, _TextAlpha , 0 )
		
		end
	
		draw.SimpleText( "Press Space to skip the Intro", "Trebuchet20", w/2, h - _hMod * 50 , Color( 255 ,255 ,255 , _TextAlpha ) , TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )
		
	end )

end

local function killSkipVIntroText()

	if hook.GetTable()["HUDPaint"]["VehicleSkipIntroText"] then
	
		hook.Remove( "HUDPaint", "VehicleSkipIntroText" )
	
	end
	
end

hook.Add( "ClientStartVehicleShop", "MakeSkipHudTextForVehicleShop", function( )

	if !system.IsOSX() then


	makeSkipVIntroText()
	
	hook.Run( "ClientFinishedVehicleShopIntro" )
	
else

	makeSkipVIntroText()
end

end )

hook.Add("ClientFinishedVehicleShop", "ResetVehicleShopOnClose", function()
	
	if _p.VehicleShop && IsValid( _p.VehicleShop ) then
	
		_p.VehicleShop:Close()
		_p.VehicleShop = nil;
		
	end
	
	killSkipVIntroText()
	
end )
					
hook.Add("ClientFinishedVehicleShopIntro" , "hookVehicleShopIntoIntro", function() 
	
	if !_p.VehicleShop || !IsValid( _p.VehicleShop ) then
	
		ShowDealershipView()

	end
	
	killSkipVIntroText()
	
end )