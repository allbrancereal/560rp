
local SCREEN_W, SCREEN_H = 3840, 2160;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
_wMod=_wMod*2;
_hMod=_hMod*2;

net.Receive("SendClientVehicleCustomizerUpdate", function( _l , _p )
	
	local _modeltoset = net.ReadString() 
	
	for k , v in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
		
		if v:getFlag("vehicleCustomizer", false ) == true then
			
			v:SetModel( _modeltoset )
		
		end
		
	end

end )

local _p = LocalPlayer()
function ShowVehicleCustomization ( )	
	net.Start("EnteredVehicleCustomization")
	net.SendToServer()
end
	
local function BodygroupTab( vehicleClass, frm, bdg  )
		
	local Frame = vgui.Create("DPanel", frm)
	Frame:SetSize( frm:GetWide() , _hMod* 400 )
	Frame:SetPos( 0 , _hMod * 215 )
	Frame.Alpha = 0;
	Frame.DoBeginning = true;
	Frame.FinishedBeginning = false;
	Frame.Paint = function( self, w , h )
		
		if self.DoBeginning && self.FinishedBeginning == false then 
				
			self.Alpha = Lerp( 0.05, self.Alpha , 255 ) 
			
			if self.Alpha >= 254 then
				
				self.FinishedBeginning = true;
									
			end
				
		end
			
		surface.SetDrawColor( 255 ,255 ,255 , self.Alpha * 0.5 ) 			
		surface.DrawRect( 0,0 + _hMod * 5, w, h - _hMod * 10 )
		surface.DrawRect( _wMod * 25, _hMod * 0, w - _wMod * 50, _hMod * 5  )
	
	end 
	
	local _scrollPanel = vgui.Create( "DScrollPanel" , Frame )
	_scrollPanel:SetSize( Frame:GetWide() - _wMod * 40, Frame:GetTall() - _hMod * 100)
	_scrollPanel:SetPos( _wMod * 20 ,  _hMod * 25 )
		
	function Frame:Update( bdgOr)
			_scrollPanel:Clear()
	
			local _entInQuestion = nil
			
				for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
						
					if y:getFlag( "vehicleCustomizer", false ) == true then
							
						_entInQuestion = y
								
						break;
								
					end
							
				end
		
			if !_entInQuestion then return _p:Notify("couldnt find ent") end
			
			if bdgOr then
			
				bdg = bdgOr
				
			end
			local groups = bdg
			
			for k = 0, _entInQuestion:GetNumBodyGroups() - 1 do
				if ( _entInQuestion:GetBodygroupCount( k ) <= 1 ) then continue end

				local bgroup = vgui.Create( "DNumSlider" )
				bgroup:SetText( MakeNiceName( _entInQuestion:GetBodygroupName( k ) ) )
				bgroup:SetDark( true )
				bgroup:Dock( TOP )
				bgroup:SetSize( 100, 50 )
				bgroup:SetTall( 50 )
				bgroup:SetWide( 5 )
				bgroup:SetDecimals( 0 )
				bgroup.type = "bgroup"
				bgroup.typenum = k
				bgroup:SetMax( _entInQuestion:GetBodygroupCount( k ) - 1 )
				bgroup:SetValue( groups[ k + 1 ] or 0 )
				//bgroup.OnValueChanged = Menu.UpdateBodyGroups
				function bgroup:OnValueChanged ( val )
				
					local _delay = _p:getFlag( "modelchange_Bodygroup_delay" , 0 )
					
					
					if _delay < CurTime() then
					
						//mdl.Entity:SetBodygroup( self.typenum, math.Round( val ) )

						local str = string.Explode( ",", _p:getFlag("carmodelchange_bodygroups_cart", "" ) )
						if ( #str < self.typenum + 1 ) then for i = 1, self.typenum + 1 do str[ i ] = str[ i ] or 0 end end
						str[ self.typenum + 1 ] = math.Round( val )
						
						_entInQuestion:SetBodygroup( self.typenum , val )
						_p:setFlag("carmodelchange_bodygroups_cart", table.concat( str, "," ) ) 
						
						_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 0.5 )
						
					else
						
						timer.Simple( 0.1, function()
							
							//mdl.Entity:SetBodygroup( self.typenum, math.Round( val ) )

							local str = string.Explode( ",", _p:getFlag("carmodelchange_bodygroups_cart", "" ) )
							if ( #str < self.typenum + 1 ) then for i = 1, self.typenum + 1 do str[ i ] = str[ i ] or 0 end end
							str[ self.typenum + 1 ] = math.Round( val )
							
							_entInQuestion:SetBodygroup( self.typenum , val )
							_p:setFlag("carmodelchange_bodygroups_cart", table.concat( str, "," ) ) 
							
							_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + .5 )
						
						
						end )
					
					end
						
						
				end
						
				_scrollPanel:AddItem( bgroup )
	
			end
			
	end
	Frame:Update()
	
	return Frame;
	
end 
		
local function SkinTab( vehicleClass, frm )
		
	local Frame = vgui.Create("DPanel", frm)
	Frame:SetSize( frm:GetWide() , _wMod * 400 )
	Frame:SetPos( 0 , _hMod * 215 )
	Frame.Alpha = 0;
	Frame.DoBeginning = true;
	Frame.FinishedBeginning = false;
	Frame.Paint = function( self, w , h )
		
		if self.DoBeginning && self.FinishedBeginning == false then 
				
			self.Alpha = Lerp( 0.05, self.Alpha , 255 ) 
			
			if self.Alpha >= 254 then
				
				self.FinishedBeginning = true;
									
			end
				
		end
			
		surface.SetDrawColor( 255 ,255 ,255 , self.Alpha * 0.5 ) 			
		surface.DrawRect( 0,0 + _hMod * 5, w, h - _hMod * 10 )
		surface.DrawRect( _wMod * 25, _hMod * 0, w - _wMod * 50, _hMod * 5  )
	
	end 
	
	local _scrollPanel = vgui.Create( "DScrollPanel" , Frame )
	_scrollPanel:SetSize( Frame:GetWide() - _wMod * 40, Frame:GetTall() - _hMod * 100)
	_scrollPanel:SetPos( _wMod * 20 ,  _hMod * 25 )
	
	function Frame:Update( val )
	_scrollPanel:Clear()
			local _entInQuestion = nil
			
				for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
						
					if y:getFlag( "vehicleCustomizer", false ) == true then
							
						_entInQuestion = y
								
						break;
								
					end
							
				end
		
			if !_entInQuestion then return end
		local nskins = _entInQuestion:SkinCount() - 1
			if ( nskins > 0 ) then
				local skins = vgui.Create( "DNumSlider" )
				skins:SetText( "Skin" )
				skins:Dock( TOP )
				skins:SetDark( true )
				skins:SetSize( 100, 50 )
				skins:SetTall( 50 )
				skins:SetWide( 5 )
				skins:SetDecimals( 0 )
				skins:SetMax( nskins )
				if val then
				
					skins:SetValue( val )
				
				else
				
					skins:SetValue( 0 )
					
				end
				
				skins.type = "skin"
				//skins.OnValueChanged = Menu.UpdateBodyGroups
				function skins:OnValueChanged ( val )
				
					
					local _delay = _p:getFlag( "modelchange_Bodygroup_delay" , 0)
					
					if _delay < CurTime() then
					
					
				
						//mdl.Entity:SetSkin( math.Round( val ) )
						_p:setFlag("carmodelchange_bodySkin_cart", math.floor(val) ) 
						_entInQuestion:SetSkin( val )
						_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 1 )
						
					else
					
						
						timer.Simple(  0.1, function()
					 		
							
							_p:setFlag("carmodelchange_bodySkin_cart", math.floor(val) ) 
							_entInQuestion:SetSkin( val )
						//mdl.Entity:SetSkin( math.Round( val ) )
								
							
							_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 1 )
						
						end )
						
						
					end
					
				end
				
				_scrollPanel:AddItem( skins )
		end	
			
	end
	Frame:Update()
	
	return Frame;
			
end
		
local function LoadTab( vehicleClass, frm )
		
	local Frame = vgui.Create("DPanel", frm)
	Frame:SetSize( frm:GetWide() , _wMod * 400 )
	Frame:SetPos( 0 , _hMod * 215 )
	Frame.Alpha = 0;
	Frame.DoBeginning = true;
	Frame.FinishedBeginning = false;
	Frame.Paint = function( self, w , h )
		
		if self.DoBeginning && self.FinishedBeginning == false then 
				
			self.Alpha = Lerp( 0.05, self.Alpha , 255 ) 
			
			if self.Alpha >= 254 then
				
				self.FinishedBeginning = true;
									
			end
				
		end
			
		surface.SetDrawColor( 255 ,255 ,255 , self.Alpha * 0.5 ) 			
		surface.DrawRect( 0,0 + _hMod * 5, w, h - _hMod * 10 )
		surface.DrawRect( _wMod * 25, _hMod * 0, w - _wMod * 50, _hMod * 5  )
	
	end 
	
	local _scrollPanel = vgui.Create( "DScrollPanel" , Frame )
	_scrollPanel:SetSize( Frame:GetWide() - _wMod * 40, Frame:GetTall() - _hMod * 100)
	_scrollPanel:SetPos( _wMod * 20 ,  _hMod * 25 )
	
		function _scrollPanel:MakeBt( fn , t, col  )
		// Purchase selection
		local _Button = _scrollPanel:Add( "DButton" )
		_Button:Dock( TOP )
		_Button:SetSize( _scrollPanel:GetWide() - _wMod * 30 , _hMod * 100 )
		_Button:SetPos( _wMod * 15 , 0 )
				
		function _Button:OnMousePressed( k )
				
			fn( k )
			
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
				if self:IsHovered() then
				
					draw.SimpleText( "Left click: Preview, Right click: Delete", "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				else
				
					draw.SimpleText( t, "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
									
				
				end
							
			end
			
		end
		
	local _p = LocalPlayer();
	
	function Frame:Update()
		
		_scrollPanel:Clear()
		
		for k , v in pairs( file.Find( "560roleplay/vehicles/" .. vehicleClass  .. "/*" , "DATA" , "dateasc" ) ) do
			
			_scrollPanel:MakeBt( function( key ) 
			
				// blah laod shit
				if key == MOUSE_LEFT then
				
					for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
									
						if y:getFlag( "vehicleCustomizer", false ) == true then
								
								local _Information = file.Read( "560roleplay/vehicles/" .. vehicleClass .. "/" .. v , "DATA" )
								local _splitinfo = string.Explode( ";", _Information )						
								local groups = _splitinfo[1]
								
								if ( groups == nil ) then groups = "" end
								
								local groups = string.Explode( ",", groups )
								
								for k = 0, y:GetNumBodyGroups() - 1 do
								
									y:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
									
								end	
								local _col = string.Explode( ",",  _splitinfo[3] );
								
								y:SetSkin( tonumber(_splitinfo[2]) )
								y:SetColor( Color( _col[1],_col[2],_col[3] ) )
												
												
								_p:setFlag("carmodelchange_bodySkin_cart",  tonumber(_splitinfo[2])  ) 
								
								_p:setFlag("carmodelchange_bodygroups_cart", table.concat( groups, "," ) ) 
								self:Update()
								frm._scrollPanel.SubPanels[1]:Update( groups )
								frm._scrollPanel.SubPanels[2]:Update( tonumber(_splitinfo[2]) )
							break;
							
						end
						
					end
					
				elseif key == MOUSE_RIGHT then
				
					file.Delete( "560roleplay/vehicles/" .. vehicleClass .. "/" .. v );
					
					self:Update()
					
				end
				
			end , "Date: " .. os.date( "%Y-%m-%d - %H:%M:%S" , string.TrimRight( tostring( v) , ".txt" )  ), Color( 255 ,255 ,255 ) )
			
		end
	
	end
	
	return Frame;
		
end
		
local function SaveTab( vehicleClass, frm )
		
	local Frame = vgui.Create("DPanel", frm)
	Frame:SetSize( frm:GetWide() ,_wMod * 400  )
	Frame:SetPos( 0 , _hMod * 215 )
	Frame.Alpha = 0;
	Frame.DoBeginning = true;
	Frame.FinishedBeginning = false;
	Frame.Paint = function( self, w , h )
		
		if self.DoBeginning && self.FinishedBeginning == false then 
				
			self.Alpha = Lerp( 0.05, self.Alpha , 255 ) 
			
			if self.Alpha >= 254 then
				
				self.FinishedBeginning = true;
									
			end
				
		end
			
		surface.SetDrawColor( 255 ,255 ,255 , self.Alpha * 0.5 ) 			
		surface.DrawRect( 0,0 + _hMod * 5, w, h - _hMod * 10 )
		surface.DrawRect( _wMod * 25, _hMod * 0, w - _wMod * 50, _hMod * 5  )
	
	end 
	
	function Frame:Update()
		local _saveString = "";
		local _color = nil;
		for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
						
			if y:getFlag( "vehicleCustomizer", false ) == true then
						
				_color = y:GetColor()
				break;
								
			end
							
		end
		
		if !_color then return end
		
		local _skin = _p:getFlag("carmodelchange_bodySkin_cart", 0 ) 
		local _bdg = _p:getFlag("carmodelchange_bodygroups_cart","" ) 
		_saveString = _bdg .. ";" .. _skin .. ";" .. _color.r .. "," .. _color.g .. "," .. _color.b;
		
		file.Write( "560roleplay/vehicles/" .. vehicleClass .. "/" .. tostring( os.time() ) .. ".txt" , _saveString )
	
	end 
			
	return Frame;
	
end
	
local function MakeVehicleCustomizer ( vehicleClass , bdg, skin, color)		
		

		_p = LocalPlayer()
		if _p:getFlag("InVCustomization", nil ) == true then return end
		
		_p:setFlag("InVCustomization", true )
		
		
		local Frame = vgui.Create("DFrame")
		Frame:SetSize( _wMod * 650 , ScrH()*_hMod )
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

			surface.SetDrawColor( 14,0,14, self.Alpha * 0.5 ) 		
			surface.DrawRect( 0, h - (_hMod*470) , w - _wMod * 15 ,_hMod*500 )
		
		end 
		Frame:Center()
		Frame:MakePopup()
		 
		if !file.Exists( vehicleClass , "data/560roleplay/" ) then
		
			file.CreateDir( "560roleplay/")
			
		end
		
		if !file.Exists( vehicleClass , "data/560roleplay/vehicles" ) then
		
			file.CreateDir( "560roleplay/vehicles")
			
		end
			
		if !file.Exists( vehicleClass , "data/560roleplay/vehicles/" .. vehicleClass ) then
			
			file.CreateDir( "560roleplay/vehicles/" .. vehicleClass )
			
		end
	
		function Frame:OnClose()
				
			_p:setFlag("InVCustomization", nil )
			
			net.Start("ExitVehicleCustomization")
			net.SendToServer()
		end
		local i = 1;
		function Frame:MakeBt( fn , t, thov  )
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
				
				if thov && self:IsHovered() then
				
					draw.SimpleText(thov, "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				else
					
					draw.SimpleText( t, "Trebuchet24", w/2, h/2, Color( 25 ,25 ,25 , self.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
								
				end
							
			end
			i = i +1
		end
		
		local _scrollPanel = vgui.Create( "DScrollPanel" , Frame )
		local _scrollPaintPanel = vgui.Create( "DScrollPanel" , Frame )
		local _scrollCameraPanel = vgui.Create( "DScrollPanel" , Frame )
		Frame._scrollPanel = _scrollPanel;
		
		local ColorPick = vgui.Create( "DColorMixer", _scrollPaintPanel)
		ColorPick:SetSize( _scrollPaintPanel:GetWide(), _hMod * 300 )
		ColorPick:Dock( TOP )
		//ColorPick:SetPos( 50, 50 )
		ColorPick.Think = function()
			local col = ColorPick:GetColor()
			ColorPick:SetColor(Color(col.r, col.g, col.b, 255))
			
			for k , v in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
					
				if v:getFlag( "vehicleCustomizer", false ) == true then
						
					v:SetColor( col )
							
					break;
							
				end
						
			end
			
		end
		_scrollPaintPanel:Add( ColorPick )
		function _scrollPanel:MakeBt( fn , t, col  )
		// Purchase selection
		local _Button = _scrollPanel:Add( "DButton" )
		_Button:Dock( LEFT )
		_Button:SetSize( _wMod * 155 , _hMod * 100 )
				
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
		_scrollPaintPanel:SetSize(  Frame:GetWide() - _wMod * 30 ,_hMod * 500  )
		_scrollPaintPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollPaintPanel:SetPadding( _hMod * 100 )
		_scrollPaintPanel:SetVisible( false )
		
		_scrollCameraPanel:SetSize(  Frame:GetWide() - _wMod * 30 , _hMod * 470  )
		_scrollCameraPanel:SetPos( _wMod * 15, _hMod*610  )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		//_scrollCameraPanel:SetPadding( _hMod * 100 )
		_scrollCameraPanel:SetVisible( true )
		
		_scrollPanel.SubPanels = { BodygroupTab( vehicleClass, Frame, bdg, skin, color ) , SkinTab( vehicleClass, Frame ) , LoadTab( vehicleClass, Frame ) , SaveTab( vehicleClass, Frame ) };
		
		
		for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
						
			if y:getFlag( "vehicleCustomizer", false ) == true then
					
				local groups = bdg
				
				if ( groups == nil ) then groups = "" end
				
				local groups = string.Explode( ",", groups )
				
				for k = 0, y:GetNumBodyGroups() - 1 do
				
					y:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
					
				end	
				
				y:SetSkin( skin )
				y:SetColor( color )
				_p:setFlag("carmodelchange_bodySkin_cart", skin ) 
				_p:setFlag("carmodelchange_bodygroups_cart", bdg ) 
										
				for k , v in pairs( _scrollPanel.SubPanels ) do
					
					v:SetVisible( false );
							
				end
						
				timer.Simple( 1 , function() 
					
					if !_scrollPanel.SubPanels then return end
					
					_scrollPanel.SubPanels[1]:Update( bdg )
					_scrollPanel.SubPanels[3]:Update( skin )
					_scrollPanel.SubPanels[2]:Update()
					_scrollPanel.SubPanels[1]:SetVisible( true )
				
				end )
				
				break;
								
			end
							
		end
		
		Frame:MakeBt( function( )
			
			if Frame.Key then
			
				/*net.Start("PurchaseVehicle")
					
					net.WriteInt( Frame.Key, 16 )
					net.WriteColor( ColorPick:GetColor() )
				net.SendToServer( )
				*/
			end
			
			local _color = nil;
			local _bdg = nil;
			local _skin = nil;
			for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
							
				if y:getFlag( "vehicleCustomizer", false ) == true then
							
					_skin = _p:getFlag("carmodelchange_bodySkin_cart", 0) 
					_bdg = _p:getFlag("carmodelchange_bodygroups_cart","" ) 
					_color = y:GetColor()
					break;
									
				end
								
			end
			
			if _skin && _bdg && _color then
			
				net.Start("PurchaseVehicleCustomization")
					net.WriteString( vehicleClass )
					net.WriteString( _bdg )
					net.WriteInt( _skin , 8 )
					net.WriteColor( Color(_color.r,_color.g,_color.b) )
				net.SendToServer()
				
			end
			
			for k , v in pairs( _scrollPanel.SubPanels ) do
				
				v:SetVisible( false );
						
			end
			_scrollPanel.SubPanels[3]:Update()
			_scrollPanel:SetVisible( false )
			//_scrollCameraPanel:SetVisible( false )
			_scrollPaintPanel:SetVisible( false )
			Frame:Close()
		
			
		end , "Purchase" , "$5000" )
		Frame:MakeBt( function( )
		
			for k , v in pairs( _scrollPanel.SubPanels ) do
				
				v:SetVisible( false );
						
			end
			_scrollPanel.SubPanels[3]:Update()
			_scrollPanel:SetVisible( true )
			//_scrollCameraPanel:SetVisible( false )
			_scrollPaintPanel:SetVisible( false )
		
		end , "Customize" )
		Frame:MakeBt( function( )
		
			for k , v in pairs( _scrollPanel.SubPanels ) do
				
				v:SetVisible( false );
						
			end
			_scrollPanel.SubPanels[3]:Update()
			_scrollPanel:SetVisible( false )
			//_scrollCameraPanel:SetVisible( false )
			_scrollPaintPanel:SetVisible( true )
		
		end , "Paint" )
		Frame:MakeBt( function( )
		
			for k , v in pairs( _scrollPanel.SubPanels ) do
				
				v:SetVisible( false );
						
			end
			_scrollPanel.SubPanels[3]:Update()
			
			_scrollPanel:SetVisible( false )
			//_scrollCameraPanel:SetVisible( true )
			_scrollPaintPanel:SetVisible( false )
		
		end , "Options" )
		Frame:MakeBt( function( )
		
			_p:setFlag("InVCustomization", false )
			
			net.Start("ExitVehicleCustomization")
			net.SendToServer()
			
			Frame:Close()
					
		end , "Exit" )
		

		local _tableOfColors = {
			{ Col = Color(3,255,171,255), Name = "Mint Green"};
			{ Col = Color(5,5,255,255), Name = "Shiny Blue"};
			{ Col = Color(2,153,57,255), Name = "Joker Green"};
			{ Col = Color(247,136,206,255), Name = "Pindel Pink"};
			{ Col = Color(236,255,140,255), Name = "Bleek Banana"};

			{ Col = Color(187,235,42,255), Name = "Watermelon"};
			{ Col = Color(73,76,153,255), Name = "Magnetic Blue"};
			{ Col = Color(66,208,255,255), Name = "Aqua Blue"};
			{ Col = Color(221,225,3,255), Name = "Toxic Yellow"};
			{ Col = Color(135,197,245,255), Name = "Epsilon Blue"};

			{ Col = Color(0,255,0,255), Name = "Digital Green"};
			{ Col = Color(96,62,148,255), Name = "Bright Purple"};
			{ Col = Color(255,105,180,255), Name = "Neon Pink"};
			{ Col = Color(227,190,70,255), Name = "Bright Gold"};
			{ Col = Color(22,161,18,255), Name = "Turkey Stuffer Green"};

			{ Col = Color(5,193,25,255), Name = "Neon Blue"};
			{ Col = Color(27,29,163,255), Name = "Neon Purple"};
			{ Col = Color(135,197,245,255), Name = "Kifflom"};
			{ Col = Color(227,190,70,255), Name = "Light Gold Chrome"};
			{ Col = Color(251,184,41,255), Name = "Dark Gold Chrome"};

			{ Col = Color(255,105,180,255), Name = "Hot Pink"};
			{ Col = Color(157,153,188,255), Name = "Detox Purple"};
			{ Col = Color(0,70,0,255), Name = "Glossy Green"};
			{ Col = Color(107,33,76,255), Name = "Bold Purple"};
			{ Col = Color(127,200,255,255), Name = "Sky Blue"};

			{ Col = Color(123,255,255,255), Name = "Neon Sky Blue"};
			{ Col = Color(0,0,0,255), Name = "Pure Black"};
			{ Col = Color(22,161,18,255), Name = "Glowing Green"};
			{ Col = Color(255,255,1,255), Name = "Sharpe Yellow"};
			{ Col = Color(251,86,4,255), Name = "Bright Orange"};

			{ Col = Color(249,82,107,255), Name = "Cotton Candy Pink"};
			{ Col = Color(229,14,6,255), Name = "Deep Red"};
			{ Col = Color(5,193,255,255), Name = "Flueorescent Blue"};
			{ Col = Color(140,255,25,255), Name = "Freeze Blue"};
			{ Col = Color(0,0,36,255), Name = "Blue Chrome"};

			{ Col = Color(51,51,153,255), Name = "Red Bull Blue"};
			{ Col = Color(51,255,153,255), Name = "Monster Energy Neon Green"};
			{ Col = Color(153,34,34,255), Name = "Dr. Pepper Red"};
			{ Col = Color(71,225,12,255), Name = "Razer Green"};
			{ Col = Color(206,250,5,255), Name = "Electric Lime"};

			{ Col = Color(44,117,255,255), Name = "Blazing Blue"};
			{ Col = Color(254,0,1,255), Name = "Neon Red"};
			{ Col = Color(255,65,5,255), Name = "Sunshine Orange"};
			{ Col = Color(111,0,255,255), Name = "Electric Indigo"};
			{ Col = Color(255,3,62,255), Name = "American Rose"};

			{ Col = Color(0,15,255,255), Name = "Laser Blue"};
			{ Col = Color(123,255,255,255), Name = "Neon Aqua Blue"};
			{ Col = Color(0,43,21,255), Name = "Chameleon Green"};
			{ Col = Color(140,138,255,255), Name = "Perpiling Purple"};
			{ Col = Color(64,124,132,255), Name = "Serpentine Green"};


			{ Col = Color(52,0,17,255), Name = "Menacing Red"};
			{ Col = Color(14,0,14,255), Name = "Venomous Red"};
			{ Col = Color(242,80,32,255), Name = "Creamsicle Orange"};
			{ Col = Color(3,51,9,255), Name = "Glycerine Green"};
			{ Col = Color(13,0,13,255), Name = "Better Than Your Blue"};

			{ Col = Color(132,255,10,255), Name = "Corrosive Green"};
			{ Col = Color(100,60,0,255), Name = "Pure Orange"};
			{ Col = Color(97,69,72,255), Name = "Very Soft Pink"};
			{ Col = Color(11,1,2,255), Name = "REALLY Dark Red"};
			{ Col = Color(3,39,15,255), Name = "New Lime"};

			{ Col = Color(39,15,3,255), Name = "Brown Town"};
			{ Col = Color(104,106,118,255), Name = "Nardo Green"};
			{ Col = Color(103,186,118,255), Name = "Light Teal"};
			{ Col = Color(14,0,14,255), Name = "Dark Soul Purple"};
			{ Col = Color(0,204,120,255), Name = "Neon Mint"};		

			{ Col = Color(255,0,0,255), Name = "Devil Red"};
			{ Col = Color(64,0,74,255), Name = "Why Not Purple?"};
			{ Col = Color(11,11,11,255), Name = "RedForDays"};
			{ Col = Color(0,150,45,255), Name = "Neon Lime"};
		
		}
		for k , v in pairs( _tableOfColors ) do
		
			_scrollPaintPanel:MakeBt( function( )
		
				ColorPick:SetColor( v.Col )
		
				for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
						
					if y:getFlag( "vehicleCustomizer", false ) == true then
							
						y:SetColor( v.Col )
								
						break;
								
					end
							
				end
			
			end, v.Name , v.Col )
			
		end
		
		
		_p:setFlag("vCustomYOffset" , 0 )
		_p:setFlag("vCustomzOffset" , 0 )
		_p:setFlag("vCustomXOffset" , 0 )
		
		local offsetx = vgui.Create( "DNumSlider" , _scrollCameraPanel)
		offsetx:SetText( "Camera X Offset" )
		offsetx:Dock( TOP )
		offsetx:SetSize( 100, 50 )
		offsetx:SetTall( 50 )
		offsetx:SetWide( 5 )
		offsetx:SetDecimals( 0 )
		offsetx:SetMax( 30 )
		offsetx:SetMin( -30 )
		offsetx:SetValue( 0 )
		function offsetx:OnValueChanged ( val )
		
			_p:setFlag("vCustomXOffset" , val )
		end		
		
		local offsetz = vgui.Create( "DNumSlider", _scrollCameraPanel )
		offsetz:SetText( "Camera X offsetz" )
		offsetz:Dock( TOP )
		offsetz:SetSize( 100, 50 )
		offsetz:SetTall( 50 )
		offsetz:SetWide( 5 )
		offsetz:SetDecimals( 0 )
		offsetz:SetMax( 150 )
		offsetz:SetMin( -150 )
		offsetz:SetValue( 0 )
		function offsetz:OnValueChanged ( val )
		
			_p:setFlag("vCustomzOffset" , val )
		end		
		local offsety = vgui.Create( "DNumSlider", _scrollCameraPanel )
		offsety:SetText( "Camera Y Offset" )
		offsety:Dock( TOP )
		offsety:SetSize( 100, 50 )
		offsety:SetTall( 50 )
		offsety:SetWide( 5 )
		offsety:SetDecimals( 0 )
		offsety:SetMax( 150 )
		offsety:SetMin( -150 )
		offsety:SetValue( 0 )
				//skins.OnValueChanged = Menu.UpdateBodyGroups
		function offsety:OnValueChanged ( val )
		
			_p:setFlag("vCustomYOffset" , val )
		end		
		_scrollCameraPanel:Add( offsetx )
		_scrollCameraPanel:Add( offsety )
		_scrollCameraPanel:Add( offsetz )
		_scrollPanel:SetSize(  Frame:GetWide() - _wMod * 30 , Frame:GetTall() - _hMod * 130  )
		_scrollPanel:SetPos( _wMod * 15, _hMod * 115   )
		//_scrollPanel:DockMargin( 0, _hMod * 150 , 0 , _hMod * 150  )
		_scrollPanel:SetPadding( _hMod * 110 )
			
		LocalPlayer():setFlag( "vehicleCustomCamera", 1 )
		for i = 1, #fsrp.VCustomizationCameras do
		
			_scrollCameraPanel:MakeBt( function( )
			
			
				_p:setFlag( "vehicleCustomCamera", i )
					
				_p:setFlag("vCustomYOffset" , 0 )
				_p:setFlag("vCustomzOffset" , 0 )
				offsetx:SetValue( 0 )
				offsetz:SetValue( 0 )
				offsety:SetValue( 0 )
				_p:setFlag("vCustomXOffset" , 0 )
			end, "Camera #" .. (i+1) , Color(255,255,255) )
			
		end
		_scrollPanel:MakeBt( function()
				
				for k , v in pairs( _scrollPanel.SubPanels ) do
			
					v:SetVisible( false );
					
				end
				
				_scrollPanel.SubPanels[1]:SetVisible( true )
				
			end, 
			"Bodygroups", 
			Color( 255 ,255 ,255 ) 
		)
		_scrollPanel:MakeBt( function() 
		
			for k , v in pairs( _scrollPanel.SubPanels ) do
			
				v:SetVisible( false );
					
			end
				
			_scrollPanel.SubPanels[2]:SetVisible( true )
			
		end, 
		
		"Skins", 
		
		Color( 255 ,255 ,255 ) 
		
		)
		
		_scrollPanel:MakeBt( function() 
		
			for k , v in pairs( _scrollPanel.SubPanels ) do
			
				v:SetVisible( false );
					
			end
				
			_scrollPanel.SubPanels[3]:SetVisible( true )
			_scrollPanel.SubPanels[3]:Update()
			_scrollPanel.SubPanels[1]:Update()
			_scrollPanel.SubPanels[2]:Update()
		
		end, 
		
		"Load", 
		
		Color( 255 ,255 ,255 ) 
		
		)
		
		_scrollPanel:MakeBt( function() 
			
			local _saveString = "";
			local _color = nil;
			for x , y in pairs( ents.FindByClass( "vehiclecustomizationpointer" ) ) do
							
				if y:getFlag( "vehicleCustomizer", false ) == true then
							
					_color = y:GetColor()
					break;
									
				end
								
			end
			
			if !_color then return end
			
			local _skin = _p:getFlag("carmodelchange_bodySkin_cart", 0 ) 
			local _bdg = _p:getFlag("carmodelchange_bodygroups_cart","" ) 
			_saveString = _bdg .. ";" .. _skin .. ";" .. _color.r .. "," .. _color.g .. "," .. _color.b;
			
			file.Write( "560roleplay/vehicles/" .. vehicleClass .. "/" .. tostring( os.time() ) .. ".txt" , _saveString )
		
			for k , v in pairs( _scrollPanel.SubPanels ) do
			
				v:SetVisible( false );
					
			end
				
			_scrollPanel.SubPanels[3]:SetVisible( true )
			_scrollPanel.SubPanels[3]:Update()
			_scrollPanel.SubPanels[1]:Update()
			_scrollPanel.SubPanels[2]:Update()
			
		end, 
		
		"Save Current", 
		
		Color( 255 ,255 ,255 ) 
		
		)
				
		
end

		
net.Receive( "SendClientVehicleCustomizer" , function( _l , _p )
	print("hi")
	MakeVehicleCustomizer( net.ReadString(), net.ReadString() , net.ReadInt( 8 ) , net.ReadColor() )
end )
