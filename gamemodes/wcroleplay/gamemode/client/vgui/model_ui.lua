

local FRAME;


local FRAMEAlpha = 0;


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

function OpenModelChangingMenu( )
	local _p = LocalPlayer();
	_p:StartShopMusic()
	FRAME = vgui.Create( "DFrame" )
	
		LocalPlayer():setFlag("restrictInv", true)
	FRAME:SetSize( _wMod * 700 , _hMod * 1080 )
	//FRAME:SetSize( ScrW() - 25 , _hMod * 1080 )
	
	FRAME:ShowCloseButton( true )
	
	FRAME:SetPos( _wMod * 1150 , _hMod )
	//FRAME:SetPos( 15 , _hMod )
	FRAME:SetTitle("Model Wardrobe")
	FRAME:MakePopup()
	function FRAME:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, FRAMEAlpha )
		surface.DrawRect( 0, 0 , w , h )
	end
	
	if steamworks.IsSubscribed( fsrp.config.WorkshopSounds ) then
		
		local disableMusic = vgui.Create( "DCheckBoxLabel" ) // Create the checkbox
		local enableMusic = vgui.Create( "DCheckBoxLabel" ) // Create the checkbox
		enableMusic:SetParent( FRAME )
		enableMusic:SetPos(  _wMod * 25,  _hMod * 150 )						// Set the position
		enableMusic:SetText( "Music Enabled" )					// Set the text next to the box
		enableMusic:SetValue( 0 )			 // Initial value ( will determine whether the box is ticked too )
		enableMusic:SizeToContents()					 // Make its size the same as the contents
		function enableMusic:OnChange( value ) 
		
			LocalPlayer():StopShopMusic()
			enableMusic:SetText( "Restarting Music" )
			
			timer.Simple( 0.2, function()
				LocalPlayer():StartShopMusic( )
				enableMusic:SetChecked(!enableMusic:GetChecked() )
				enableMusic:SetText( "Music Enabled" )
				disableMusic:SetText( "Click to Disable Music" )
			end )
			
		end	
		
		disableMusic:SetParent( FRAME )
		disableMusic:SetPos(   _wMod * 25,  _hMod * 125  )						// Set the position
		disableMusic:SetText( "Click to Disable Music" )					// Set the text next to the box
		disableMusic:SetValue( 0 )			 // Initial value ( will determine whether the box is ticked too )
		disableMusic:SizeToContents()					 // Make its size the same as the contents

		function disableMusic:OnChange( value ) 
		
			LocalPlayer():StopShopMusic()
			disableMusic:SetText( "Disabling Music" )
			
			timer.Simple( 0.2, function()
				disableMusic:SetChecked(!disableMusic:GetChecked() )	
				disableMusic:SetText( "Music Disabled" )
				enableMusic:SetText( "Click to Enable Music" )
			end )
		end
	
	end
	_p:setFlag("modelshop_camera_Body", false) 
	_p:setFlag("modelshop_camera_FaceView", false)
	_p:setFlag("modelshop_camera_FullBody", false)
	
	FRAME.Tabs = { ModelList() , AccessoriesMenu(), BodygroupMenu() };
	local _lastNum = 2;
	local advButtons = {
			
						{
							ID				= 1;
							Parent			= FRAME;
							Pos 			= {  _wMod * 10, _hMod * 50 };
							Size 			= { _wMod * 150 , _hMod * 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 ); 
							OriginalColor	= Color( 56, 56 ,56, 128 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Model List";
							ShowToolTip		= true;
							DoAlpha	= true;
							OnPressed = function( self )
								
								for _, x in pairs( FRAME.Tabs ) do 
						
									if ispanel( x ) then
										
										x:SetVisible( false )
										x._tabAlpha =  0;
										
									end
										
								end 
								FRAME.Tabs[self.ID].DoCloseAlpha =  false;
								FRAME.Tabs[self.ID]._tabAlpha =  0;
								
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
							
							end;
							ToolTipBox = { 
								Title = "Model List";
								Size = { 230 , 115 };
								Description = { 
									"This is the model list, it shows you";
									"your currently available models.";
									"";
									"(Note: This is an alpha gamemode, Suggest";
									"-your ideas or invest to bring them to life.)";
								};
								//BackgroundColor = Color (0,0,0,240);
								
							}
						};
						{
							ID				= 2;							
							Parent			= FRAME;
							Pos 			= { _wMod * 170 , _hMod * 50 };
							Size 			= { _wMod * 150 , _hMod * 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 128 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Accessories";
							DoAlpha			= true;
							ShowToolTip		= true;
							DisableOnInit	= false;
							OnPressed = function( self )
								
								for _, x in pairs( FRAME.Tabs ) do 
						
									if ispanel( x ) then
										
										x:SetVisible( false )
										x._tabAlpha =  0;
										
									end
										
								end 
								FRAME.Tabs[self.ID].DoCloseAlpha =  false;
								FRAME.Tabs[self.ID]._tabAlpha =  0;
								
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
							
							end;
							ToolTipBox = { 
								Title = "Hats & Accessories";
								Size = { 230 , 115 };
								Description = { 
									"In this page you can manage the accessories you wear.";
									"You can wear up to 3 accessories together. ";
									"";
									"";
									"(Note: This is an alpha gamemode, Suggest";
									"-your ideas or invest to bring them to life.)";
								};
							}
						};
						
						{
							ID				= 3;
							Parent			= FRAME;
							Pos 			= { _wMod * 330, _hMod * 50 };
							Size 			= { _wMod * 150 , _hMod * 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 128 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Body-Groups";
							DoAlpha			= true;
							ShowToolTip		= true;
							DisableOnInit	= false;
							OnPressed = function( self )
								
								for _, x in pairs( FRAME.Tabs ) do 
						
									if ispanel( x ) then
										
										x:SetVisible( false )
										x._tabAlpha =  0;
										
									end
										
								end 
								FRAME.Tabs[self.ID].DoCloseAlpha =  false;
								FRAME.Tabs[self.ID]._tabAlpha =  0;
								
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
							
							end;
							ToolTipBox = { 
								Title = "Bodygroups";
								Size = { 230 , 115 };
								Description = { 
									"This is the overview of all the body-groups";
									"You can change everything and it will save.";
									"";
									"";
									"(Note: This is an alpha gamemode, Suggest";
									"-your ideas or invest to bring them to life.)";
								};
							}
						};
						{
							ID				= 4;
							Parent			= FRAME;
							Pos 			= {_wMod * 490 , _hMod * 50 };
							Size 			= { _wMod * 150 , _hMod * 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 128 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Purchase";
							DoAlpha			= true;
							ShowToolTip		= false;
							DisableOnInit	= false;
							OnPressed = function( self )
								
								net.Start("modelchange_buyCart")
								
									net.WriteString( _p:getFlag("modelchange_playerModel_cart", "Vindictus-Vella" )  ) // model playermanager name
									net.WriteInt( _p:getFlag("modelchange_bodySkin_cart", 0 ) , 8) // skin
									net.WriteString( _p:getFlag("modelchange_bodygroups_cart", "" ) ) // bodygroup
									net.WriteVector( _p:getFlag("hatXYZ", Vector(0,0,0) ) )
									net.WriteAngle( _p:getFlag("hatPYR", Angle(0,0,0) ) )
								net.SendToServer()
								
								LocalPlayer():setFlag("restrictInv", false)
		
								LocalPlayer():StopShopMusic()
								net.Start("modelchanger_sendExit")	
									net.WriteBool( true )
								net.SendToServer()		
								FRAME:Remove();
								
							end;
						};
		
	}
	
		FRAME.DoBeginning = true;
	function FRAME:OnClose( )
		LocalPlayer():StopShopMusic()
		net.Start("modelchanger_sendExit")	
			net.WriteBool( false )
		net.SendToServer()
		FRAME.DoCloseAnim = true;
		FRAME.DoBeginning = true;
		FRAMEAlpha = 0;
		
		LocalPlayer():setFlag("restrictInv", false)
		
		
		// Stop this HTML memory leak stuff.
		for k , v in pairs( FRAME.Tabs ) do
		
			if v.webDock then
			
				v.webDock:Remove()
				
			end
			
			if v.deletedOnClose then
			
				for _ , x in pairs( v.deletedOnClose ) do
				
					x:Remove()
					
				end
				
			end
			
		end
		
	end
	
	function FRAME:Think()
		
		if FRAME.DoBeginning == true then
		
			FRAMEAlpha =  Lerp( 0.01, FRAMEAlpha, 128 )
			
			if FRAMEAlpha == 128 then
			
				FRAME.DoBeginning = false;
			
			end
			
		end
		
		if FRAME.DoCloseAnim == true then
		
			FRAMEAlpha =  Lerp( 0.01, FRAMEAlpha, 0 )
			
		end
		
	end
	
	function FRAME:Init()
	
		FRAME.DoBeginning = true;
	 
	end 
	 
	i = 1;
	local _tabButtons = {};
	
	for k , v in pairs( advButtons ) do
		
				
			local cachebut = advancedButton( v );
			table.insert( _tabButtons, cachebut ) ;
				
			
		
		
		i =1+i;		
	end
	
	// We just ran all the tabs, lets hide them.
	for k, v in pairs( FRAME.Tabs ) do 
	
		if ispanel( v ) then
		
			v:SetVisible(false) 
		
		end
		
	end 
	
	
		
			_p:setFlag("modelchange_playerModel_cart", _p:getFlag("playerinfo_model", "Vindictus-Vella" )  )
			_p:setFlag("modelchange_bodySkin_cart", 0 ) 
			_p:setFlag("modelchange_bodygroups_cart", "" ) 
			
	for k, v in pairs( FRAME.Tabs ) do 
	
		if ispanel( v ) then
		
			v:RefreshInformation() 
			
		end
		
	end
end
local bdcontrolspanel
function BodygroupMenu()


	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod * 25  , _hMod * 150)
	panel:SetSize(FRAME:GetWide() - _wMod * 50 ,FRAME:GetTall() - _hMod * 100)
	panel._tabAlpha = 0;
	panel.Paint = function( self, w, h ) 
		//draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,panel._tabAlpha),true,true)	
		//draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
		surface.SetDrawColor( 255, 255, 255, panel._tabAlpha/2 )
		surface.DrawRect( 25, 25 , w , h )
		
	end
	
	function panel:Think()
	
		if panel.DoAlpha == true then
		
			if !panel:IsVisible() then
			
				panel:SetVisible( true ) 
				
			end
			
			panel._tabAlpha = Lerp( 0.05, panel._tabAlpha ,128 )
			
		elseif panel.DoCloseAlpha == true then
		
			panel._tabAlpha = Lerp( 0.05 , panel._tabAlpha, 0 )
			
			if _tabAlpha == 0 then
			
				panel:SetVisible(false)
				
			end
			
		end

	end
	
	function panel:RefreshInformation( )
	
	
		bdcontrolspanel = vgui.Create("DScrollPanel", panel )
		function bdcontrolspanel:Paint( w , h )
		
		end 
		
		bdcontrolspanel:SetPos( 50, 50  )
		bdcontrolspanel:SetSize( panel:GetWide() - 75 , panel:GetTall() - 60 )
		
			local _p = LocalPlayer();
			
			//flexcontrolspanel:Clear()
			
			//flextab.Tab:SetVisible( false )
			self:RefreshSkinCategory()
		
	end
	
	function panel:RefreshSkinCategory()
		local _p = LocalPlayer();
		bdcontrolspanel:Clear()
		
		local nskins = LocalPlayer():SkinCount() - 1
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
				skins:SetValue( LocalPlayer():getFlag("modelchange_bodySkin_cart", 0 ) )
				skins.type = "skin"
				//skins.OnValueChanged = Menu.UpdateBodyGroups
				function skins:OnValueChanged ( val )
				
					
					local _delay = _p:getFlag( "modelchange_Bodygroup_delay" , 0)
					
					if _delay < CurTime() then
					
					
				
						//mdl.Entity:SetSkin( math.Round( val ) )
							_p:setFlag("modelchange_bodySkin_cart", math.ceil(val) ) 
						
						net.Start( "modelchange_UpdateSkin" )
						
							net.WriteInt( math.ceil( val ) , 8 )
							
						net.SendToServer( )
						_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 1 )
						
					else
					
						
						timer.Simple(  0.1, function()
					 		
							
								
							//mdl.Entity:SetSkin( math.Round( val ) )
							_p:setFlag("modelchange_bodySkin_cart", math.ceil(val) ) 
								
							net.Start( "modelchange_UpdateSkin" )
							
								net.WriteInt( math.ceil( val ) , 8 )
								
							net.SendToServer( )
							
						_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 1 )
						end )
						
						
					end
					
				end
				
				bdcontrolspanel:AddItem( skins )
				
					//mdl.Entity:SetSkin( _p:getFlag("modelchange_bodySkin", 0 ) )
					
				
				
				
			end

			local groups = string.Explode( " ", _p:getFlag("modelchange_bodygroups_cart", "0" ) )
			for k = 0, LocalPlayer():GetNumBodyGroups() - 1 do
				if ( LocalPlayer():GetBodygroupCount( k ) <= 1 ) then continue end

				local bgroup = vgui.Create( "DNumSlider" )
				bgroup:SetText( MakeNiceName( LocalPlayer():GetBodygroupName( k ) ) )
				bgroup:SetDark( true )
				bgroup:Dock( TOP )
				bgroup:SetSize( 100, 50 )
				bgroup:SetTall( 50 )
				bgroup:SetWide( 5 )
				bgroup:SetDecimals( 0 )
				bgroup.type = "bgroup"
				bgroup.typenum = k
				bgroup:SetMax( LocalPlayer():GetBodygroupCount( k ) - 1 )
				bgroup:SetValue( groups[ k + 1 ] or 0 )
				//bgroup.OnValueChanged = Menu.UpdateBodyGroups
				function bgroup:OnValueChanged ( val )
				
					local _delay = _p:getFlag( "modelchange_Bodygroup_delay" , 0 )
					
					
					if _delay < CurTime() then
					
						//mdl.Entity:SetBodygroup( self.typenum, math.Round( val ) )

						local str = string.Explode( " ", _p:getFlag("modelchange_bodygroups_cart", "0" ) )
						if ( #str < self.typenum + 1 ) then for i = 1, self.typenum + 1 do str[ i ] = str[ i ] or 0 end end
						str[ self.typenum + 1 ] = math.Round( val )
						
						_p:setFlag("modelchange_bodygroups_cart", table.concat( str, " " ) ) 
						
						net.Start( "modelchange_UpdateBodygroups" )
						
								net.WriteInt( math.Round( val ) , 8 )
								net.WriteInt( self.typenum , 8 )
						
						net.SendToServer( )
						_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 1 )
						
					else
						
						timer.Simple( 0.1, function()
							
							//mdl.Entity:SetBodygroup( self.typenum, math.Round( val ) )

							local str = string.Explode( " ", _p:getFlag("modelchange_bodygroups_cart", "0" ) )
							if ( #str < self.typenum + 1 ) then for i = 1, self.typenum + 1 do str[ i ] = str[ i ] or 0 end end
							str[ self.typenum + 1 ] = math.Round( val )
							
							_p:setFlag("modelchange_bodygroups_cart", table.concat( str, " " ) ) 
							
							net.Start( "modelchange_UpdateBodygroups" )
							
								net.WriteInt( math.Round( val ) , 8 )
								net.WriteInt( self.typenum , 8 )
							
							net.SendToServer( )
						_p:setFlag( "modelchange_Bodygroup_delay" , CurTime() + 1 )
						
						
						end )
					
					end
						
						
				end
						
				bdcontrolspanel:AddItem( bgroup )

				//mdl.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )
				
			end
			
		
		
	end
	
	
	return panel;
	
end

function MakeNiceName( str )
		local newname = {}

		for _, s in pairs( string.Explode( "_", str ) ) do
			if ( string.len( s ) == 1 ) then table.insert( newname, string.upper( s ) ) continue end
			table.insert( newname, string.upper( string.Left( s, 1 ) ) .. string.Right( s, string.len( s ) - 1 ) ) -- Ugly way to capitalize first letters.
		end

		return string.Implode( " ", newname )
end


function ModelList()


	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( ScrW()/12 / 2 , 100)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		//draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,panel._tabAlpha),true,true)	
		//draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
		//surface.SetDrawColor( 255, 255, 255, panel._tabAlpha/2 )
		//surface.DrawRect( 25, 25 , w - 50, h - 50)
	end
	function panel:Think()
	
		if panel.DoAlpha == true then
		
			if !panel:IsVisible() then
			
				panel:SetVisible( true ) 
				
			end
			
			panel._tabAlpha = Lerp( 0.05, panel._tabAlpha ,128 )
			
		elseif panel.DoCloseAlpha == true then
		
			panel._tabAlpha = Lerp( 0.05 , panel._tabAlpha, 0 )
			
			if _tabAlpha == 0 then
			
				panel:SetVisible(false)
				
			end
			
		end

	end
	
	function panel:RefreshInformation( )
		
		
			local modeltab = panel:Add( "DPropertySheet" )
			modeltab:SetPos( 10, 100 )
			modeltab:SetSize( panel:GetWide()  , panel:GetTall() -100 )
			local ModelScroll = modeltab:Add( "DScrollPanel" )
			
			modeltab:AddSheet( "Non-Donator Model List", ModelScroll, "icon16/application_view_tile.png" )
			
			ModelScroll:DockMargin( 2, 0, 2, 2 )
			ModelScroll:Dock( FILL )

			local ModelIconLayout = ModelScroll:Add( "DIconLayout" )
			ModelIconLayout:SetSpaceX( 2 )
			ModelIconLayout:SetSpaceY( 2 )
			ModelIconLayout:Dock( FILL )
			
			local modelicons = { }

			local Models = {};
			local _p = LocalPlayer();
			local _gender = _p:getGender()
			local _pTeam = _p:Team()
			
			if _pTeam == TEAM_CIVILLIAN then
				
				if !mdlTable[ _gender ] then return FRAME:Close() end;
				
				for k, v in pairs( mdlTable[ _gender] ) do 
				/*
					local iterator = iterateModelTable( 1, k );
					
						if iterator.id && iterator.mdl && player_manager.TranslateToPlayerModelName( iterator.mdl ) != "kleiner" then*/
						table.insert(Models, { _gender, v.path}); 
						
				end
			
			elseif TEAM_PARAMEDIC == _pTeam || TEAM_POLICE == _pTeam || TEAM_MAYOR == _pTeam then
			
				if !jobMdlTable[_pTeam] then return FRAME:Close() end;
				local _JobTable =  jobMdlTable[_pTeam];
				
				local _pNameFancy = ( _pTeam == TEAM_PARAMEDIC ) && "Paramedic" || ( _pTeam == TEAM_POLICE ) && "Police Officer" || (_pTeam == TEAM_MAYOR ) && "The Mayor" || "John Doe";
				
				//if !IsValid( _JobTable ) then return FRAME:Close() end
				//if !IsValid( _JobTable[_gender] ) then PrintTable( _JobTable[_gender] ) return FRAME:Close() end
				
				
				for k , v in pairs( _JobTable[tonumber(_gender)] ) do
					
						
							table.insert( Models, {_gender, v.model } )
					
					
			
				end
				
			end
			/*else
				if !jobMdlTable[_pTeam] then return Frame:Close() end;
				
				local _pNameFancy = ( _pTeam == TEAM_PARAMEDIC ) && "Paramedic" || ( _pTeam == TEAM_POLICE ) && "Police Officer" || "John Doe";
				for k , v in pairs( jobMdlTable[_pTeam][_p:getGender()]) do
				
					table.insert( Models, { _p:getGender(), v.model, _pNameFancy } )
					
				end
			*/
			
		timer.Simple( 0.1, function()
			
			modelicons= {};
			for k, v in pairs( Models ) do
										
				local icon = ModelIconLayout:Add( "SpawnIcon" )
				icon:SetSize( _wMod*128, _hMod*128 )
				icon:InvalidateLayout( true )
				icon:SetModel( v[2] )
				icon.mdl = v[2];
				table.insert( modelicons, icon )
				icon.DoClick = function()
					
												
				_p:setFlag("modelchange_playerModel_cart",player_manager.TranslateToPlayerModelName( icon.mdl )  );
							
				net.Start("modelchanger_updatePlayerModel" )
					net.WriteString( player_manager.TranslateToPlayerModelName( icon.mdl ) )
				net.SendToServer()
				
				timer.Simple( 0.3, function()
					if FRAME && FRAME.Tabs then
					
						FRAME.Tabs[3]:RefreshSkinCategory() 
	
					end
					
				end )
							
				end
				
			end
					//ModelList:AddLine( name, model )
				
				
		end)
			

	
	end
	
	return panel;
	
end

function AccessoriesMenu()


	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( ScrW()/12 / 2 , 100)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,panel._tabAlpha),true,true)	
		draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
	end
	function panel:Think()
	
		if panel.DoAlpha == true then
		
			if !panel:IsVisible() then
			
				panel:SetVisible( true ) 
				
			end
			
			panel._tabAlpha = Lerp( 0.05, panel._tabAlpha ,128 )
			
		elseif panel.DoCloseAlpha == true then
		
			panel._tabAlpha = Lerp( 0.05 , panel._tabAlpha, 0 )
			
			if _tabAlpha == 0 then
			
				panel:SetVisible(false)
				
			end
			
		end

	end
	
	function panel:RefreshInformation( )
		local _p = LocalPlayer()
		local OptionsForm = vgui.Create( "DForm", panel)
		OptionsForm:SetPos(_wMod * 25, _wMod * 100)
		OptionsForm:SetSize(panel:GetWide() - _wMod * 50, panel:GetTall() - _hMod * 200)
		OptionsForm:SetSpacing(10)
		OptionsForm:SetName("Hat Movement Options")
		OptionsForm.Paint = function()
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawOutlinedRect( 0, 0, OptionsForm:GetWide(), OptionsForm:GetTall() )
		end
		
		OptionsForm:AddItem(OuputVectors)
		
		local CamPosForm = vgui.Create( "DForm", panel)
		CamPosForm:SetPos(25, 30)
		CamPosForm:SetSize(panel:GetWide() - 50)
		CamPosForm:SetSpacing(10)
		CamPosForm:SetName("Hat Position")
		CamPosForm.Paint = function()
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawOutlinedRect( 0, 0, CamPosForm:GetWide(), CamPosForm:GetTall() )
		end
		OptionsForm:AddItem(CamPosForm)

		local CamPos_X = vgui.Create("DNumSlider")
		CamPos_X:SetText("Hat Position: X")
		CamPos_X:SetMin(-15)
		CamPos_X:SetMax(15)
		CamPos_X:SetDecimals(0)
		CamPos_X:SetValue(0)
		CamPosForm:AddItem(CamPos_X) 

		local CamPos_Y = vgui.Create("DNumSlider")
		CamPos_Y:SetText("Hat Position: Y")
		CamPos_Y:SetMin(-15)
		CamPos_Y:SetMax(15)
		CamPos_Y:SetDecimals(0)
		CamPos_Y:SetValue(0)
		CamPosForm:AddItem(CamPos_Y) 

		local CamPos_Z = vgui.Create("DNumSlider")
		CamPos_Z:SetText("Hat Position: Z")
		CamPos_Z:SetMin(-15)
		CamPos_Z:SetMax(15)
		CamPos_Z:SetDecimals(0)
		CamPos_Z:SetValue(0)
		CamPosForm:AddItem(CamPos_Z) 

		local LookAtForm = vgui.Create( "DForm", panel)
		LookAtForm:SetPos(25, 30)
		LookAtForm:SetSize(panel:GetWide() - 50)
		LookAtForm:SetSpacing(10)
		LookAtForm:SetName("Hat Angles")
		LookAtForm.Paint = function()
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawOutlinedRect( 0, 0, LookAtForm:GetWide(), LookAtForm:GetTall() )
		end
		OptionsForm:AddItem(LookAtForm)

		local LookAt_X = vgui.Create("DNumSlider")
		LookAt_X:SetText("Hat Angles: P")
		LookAt_X:SetMin(-180)
		LookAt_X:SetMax(180)
		LookAt_X:SetDecimals(0)
		LookAtForm:AddItem(LookAt_X) 

		local LookAt_Y = vgui.Create("DNumSlider")
		LookAt_Y:SetText("Hat Angles: Y")
		LookAt_Y:SetMin(-180)
		LookAt_Y:SetMax(180)
		LookAt_Y:SetDecimals(0)
		LookAtForm:AddItem(LookAt_Y) 

		local LookAt_Z = vgui.Create("DNumSlider")
		LookAt_Z:SetText("Hat Angles: R")
		LookAt_Z:SetMin(-180)
		LookAt_Z:SetMax(180)
		LookAt_Z:SetDecimals(0)
		LookAt_Z:SetValue(0)
		LookAtForm:AddItem(LookAt_Z) 
		
			
		function CamPos_X:OnValueChanged ( ValX )
			local _OldPos =  _p:getFlag("hatXYZ", Vector(0,0,0) );
			
			_p:setFlag( "hatXYZ", Vector( ValX, _OldPos.y, _OldPos.z ) );
			
		end

		function CamPos_Y:OnValueChanged ( ValY )
		
			local _OldPos =  _p:getFlag("hatXYZ", Vector(0,0,0) );
			
			_p:setFlag( "hatXYZ", Vector( _OldPos.x, ValY, _OldPos.z ) );
			
		end

		function CamPos_Z:OnValueChanged ( ValZ )
		
			local _OldPos =  _p:getFlag("hatXYZ", Vector(0,0,0) );
			
			_p:setFlag( "hatXYZ", Vector( _OldPos.x, _OldPos.y, ValZ ) );
			
		end

		function LookAt_X:OnValueChanged ( ValX )
		
			local _OldPos =  _p:getFlag("hatPYR", Angle(0,0,0) );
			
			_p:setFlag( "hatPYR", Angle( ValX, _OldPos.y, _OldPos.r ) );
		end

		function LookAt_Y:OnValueChanged ( ValY )
		
		
			local _OldPos =  _p:getFlag("hatPYR", Angle(0,0,0) );
			
			_p:setFlag( "hatPYR", Angle( _OldPos.p, ValY, _OldPos.r ) );
		end

		function LookAt_Z:OnValueChanged ( ValZ )
		
			local _OldPos =  _p:getFlag("hatPYR", Angle(0,0,0) );
			
			_p:setFlag( "hatPYR", Angle( _OldPos.p, _OldPos.y, ValZ ) );
			
		end
		local DefaultButANG = vgui.Create("DButton")
		DefaultButANG:SetText("\nDefault PYR\n")
		DefaultButANG:SizeToContents()
		OptionsForm:AddItem(DefaultButANG)
	
		local _PYRHat =  _p:getFlag("hatPYR", Angle(0,0,0) );
		local _XYZHat =  _p:getFlag("hatXYZ", Vector(0,0,0) );
		LookAt_Y:SetValue(_PYRHat.p)
		LookAt_X:SetValue(_PYRHat.y)
		LookAt_Z:SetValue(_PYRHat.r)
		CamPos_Y:SetValue(_XYZHat.x)
		CamPos_Z:SetValue(_XYZHat.y)
		CamPos_X:SetValue(_XYZHat.z)
		
		function DefaultButANG:DoClick()
			LookAt_Y:SetValue(0)
			LookAt_Y:SetDecimals(0)
			LookAt_X:SetValue(0)
			LookAt_X:SetDecimals(0)
			LookAt_Z:SetValue(0)
			LookAt_Z:SetDecimals(0)
			
			net.Start("defaulthatCoords")
				net.WriteBool( true )
			net.SendToServer()
		end
		local DefaultBut = vgui.Create("DButton")
		DefaultBut:SetText("\nDefault XYZ\n")
		DefaultBut:SizeToContents()
		OptionsForm:AddItem(DefaultBut)
	
		
		function DefaultBut:DoClick()
			CamPos_Y:SetDecimals(0)
			CamPos_Y:SetValue(0)
			CamPos_Z:SetDecimals(0)
			CamPos_Z:SetValue(0)
			CamPos_X:SetDecimals(0)
			CamPos_X:SetValue(0)
			
			
			net.Start("defaulthatCoords")
				net.WriteBool( false )
			net.SendToServer()
		end
			
			
	end
	
	return panel;
	
end

function ExitModelChangingMenu( )

	if FRAME then
	
		FRAME:Close( )
	
	end
	
end