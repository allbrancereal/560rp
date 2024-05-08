
local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

local _p = LocalPlayer()

	function ShowCarRetrieval ( enum )		
		// enum  = 1 - civillian cars , 2 - government cars  3 - param
		
		_p = LocalPlayer()
		if _p:getFlag("carretrieval", nil) then
	
			return

		end
		
		_p:setFlag("carretrieval", true)
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
				
		
		_p:setFlag("carretrieval", false)
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
		local _scrollCameraPanel = vgui.Create( "DScrollPanel" , Frame )
		
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
		
		_scrollCameraPanel:SetSize(  Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 130  )
		_scrollCameraPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollCameraPanel:SetPadding( _hMod * 100 )
		_scrollCameraPanel:SetVisible( false )
		
		Frame:MakeBt( function( )
			
			if Frame.Key then
			
				net.Start("retrieveVehicleFromGarage")
					net.WriteString( Frame.Key )
				net.SendToServer()
			
			end
		_p:setFlag("carretrieval", nil)
			_scrollPanel:SetVisible( false )
			_scrollCameraPanel:SetVisible( false )
			Frame:Close()
		
			
		end , "Retrieve" )
		Frame:MakeBt( function( )
		
			_scrollPanel:SetVisible( true )
			_scrollCameraPanel:SetVisible( false )
		
		end , "Vehicles" )
		Frame:MakeBt( function( )
		
			_scrollPanel:SetVisible( false )
			_scrollCameraPanel:SetVisible( true )
		
		end , "Options" )
		Frame:MakeBt( function( )
		
		_p:setFlag("carretrieval", nil)
			Frame:Close()
		
		end , "Exit" )
		
		_scrollPanel:SetSize(  Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 130  )
		_scrollPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollPanel:SetPadding( _hMod * 100 )
		
		local _VehiclesToShow = {};
		
		if enum == 1 then
			
			for k ,v in pairs( LoadStringToInventory( LocalPlayer():getFlag("inventory", ""  ) ) ) do
			
				if ITEMLIST[v.ID].Vehicle then
				
					table.insert( _VehiclesToShow , fsrp.VehicleDatabase[ITEMLIST[v.ID].ListVehicle] )
				
				end
			
			end
					
		else
			
			for k ,v in pairs( fsrp.VehicleDatabase ) do
				
				_pFoundTeam = false;
							
				
				if ( v.AvaliableTeam ) then
					PrintTable( v.AvaliableTeam ) 
					for b , n in pairs( v.AvaliableTeam ) do
					
						if n == LocalPlayer():Team() then
						
							_pFoundTeam = true;
							
						end
					
					end
						
					if _pFoundTeam then
					
						table.insert( _VehiclesToShow , v )
					
					end
					
				end
			
			end
			
		end
		if #_VehiclesToShow > 0 then
			
			Frame.Key = ITEMLIST[_VehiclesToShow[1].Key].ListVehicle;
		
		end
		
		for k , v in pairs( _VehiclesToShow ) do
		
			local _VItem;
			
			for x , y in pairs( list.Get( "Vehicles") ) do
				
				if x == ITEMLIST[v.Key].ListVehicle then
				
					_VItem = y;
				
				end
				
			end
			
				local lock = false;
				if v.AvaliableGroup && v.AvaliableGroup[ _p:getFlag( "rank" , 10 ) ] then lock = true end
				
				
				local _Vehicle = _scrollPanel:Add( "DButton" )
				_Vehicle:Dock( TOP ) 
				_Vehicle:SetSize( _scrollPanel:GetWide() , _hMod * 150 )
				_Vehicle.VName = _VItem
				_Vehicle.KeyItem = v.Key
				_Vehicle.Item = ITEMLIST[v.Key];
				_Vehicle.ModelToSet = ITEMLIST[v.Key].Model;
				
				function _Vehicle:OnMousePressed( k )
					Frame.Key = self.Item.ListVehicle;
					 
					
				
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
								
							surface.SetDrawColor( self.ActiveColor )
							surface.DrawRect( 0,0,w,h )
							if self.Item.ListVehicle == Frame.Key then
							
								self.ActiveColor = Color( 255, 255, 255 )
							
							end
						if self.Item then
						
							local _canAffordColor = _p:getFlag( "money" , 0 ) > self.Item.Cost && Color( 25 ,255 ,25 , self.Alpha ) || Color( 255 ,0 ,25 , self.Alpha )
							draw.SimpleText( self.VName.Name, "CarDisplayName", _wMod * 5,_hMod * 5, Color( 255 ,255 ,255 , self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )

						end
							
				
			
			end
			
		end
		
	end