
net.Receive( "createacharacter_Receive", function( len , _p )

	local _p = LocalPlayer();
	
	
	//local eyeang = _p:EyeAngles()
		
	//_p:SetEyeAngles( Angle( 0 ,eyeang.y  ,eyeang.r ) )
		
	StartCreateACharacterMenu()
	
end )


net.Receive( "createacharacter_Finish", function( len , _p )

	
end )


local FRAMEAlpha = 0;


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

local FRAME;

function StartCreateACharacterMenu()

	local _p = LocalPlayer();

	if FRAME then
	
		FRAME:Remove()
		
	end
		LocalPlayer():setFlag("restrictInv", true)

	FRAME = vgui.Create( "DFrame" )
	
	FRAME:SetSize( _wMod * 700 , _hMod * 1080 )
	//FRAME:SetSize( ScrW() - 25 , _hMod * 1080 )
	
	FRAME:ShowCloseButton( false )
	
	FRAME:SetTitle("Chose your model and skins!")
	FRAME:SetPos( _wMod * 1150 , _hMod )
	//FRAME:SetPos( 15 , _hMod )
	
	FRAME:MakePopup()
	
	function FRAME:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, FRAMEAlpha )
		surface.DrawRect( 0, 0 , w , h )
		
	end
	
	function FRAME:OnClose( )
	
		LocalPlayer():setFlag("restrictInv", false)
		FRAME.DoCloseAnim = true;
		FRAME.DoBeginning = true;
		FRAMEAlpha = 0;
		
		net.Start( "createacharacter_CloseMenuFromClient" )
		
		net.SendToServer()
		
	end
	
	FRAME.DoBeginning = true;
	
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
	
	
	FRAME.Tabs = { CRModelList() , CRBDGMenu() };
	
	local advButtons = {
			
						{
							ID				= 1;
							Parent			= FRAME;
							Pos 			= {  _wMod * 75, _hMod * 50 };
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
							Pos 			= { FRAME:GetWide() - _wMod * 225, _hMod * 50 };
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
							ID				= 3;
							Parent			= FRAME;
							Pos 			= { FRAME:GetWide() - _wMod * 225 - 45-(_wMod*150), _hMod * 50 };
							Size 			= { _wMod * 150 , _hMod * 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 128 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Create";
							DoAlpha			= true;
							ShowToolTip		= false;
							DisableOnInit	= false;
							OnPressed = function( self )
								if _p:getFlag("createacharacter_playerModel_cart", "" ) != "" then
									
									net.Start("createacharacter_sendCharacterInfo")
									
										net.WriteString( _p:getFlag("createacharacter_playerModel_cart", "" )  ) // model playermanager name
										net.WriteInt( _p:getFlag("createacharacter_bodySkin_cart", 0 ) , 8) // skin
										net.WriteString( _p:getFlag("createacharacter_bodygroups_cart", "" ) ) // bodygroup

									net.SendToServer()
									
									net.Start("createacharacter_CloseMenuFromClient")
									net.SendToServer()	
									
									_p:setFlag("creatingCharacter" , false )
									StartCreateACharacterMenu()
									
									FRAME:Remove();
								
								else
								
									_p:Notify("You have to chose a model to proceed!")
								
								end
								
							end;
						};
		
	}
	
	
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
		
	for k, v in pairs( FRAME.Tabs ) do 
	
		if ispanel( v ) then
		
			v:RefreshInformation() 
		
			
		end
		
	end
	
	_p:setFlag("createacharacter_playerModel_cart", _p:getFlag("playerinfo_model", "" )  )
	_p:setFlag("createacharacter_bodySkin_cart", 0 ) 
	_p:setFlag("createacharacter_bodygroups_cart", "" ) 
end

local bdcontrolspanel
function CRBDGMenu()


	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( ScrW()/12 / 2 , 185)
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 300)
	panel._tabAlpha = 0;
	panel.Paint = function( self, w, h ) 
		//draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,panel._tabAlpha),true,true)	
		//draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
		surface.SetDrawColor( 255, 255, 255, panel._tabAlpha/2 )
		surface.DrawRect( 25, 25 , w - 50, h - 50)
		
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
				skins:SetValue( LocalPlayer():getFlag("createacharacter_bodySkin_cart", 0 ) )
				skins.type = "skin"
				//skins.OnValueChanged = Menu.UpdateBodyGroups
				function skins:OnValueChanged ( val )
				
					
					local _delay = _p:getFlag( "createacharacter_Bodygroup_delay" , 0)
					
					if _delay < CurTime() then
					
					
				
						//mdl.Entity:SetSkin( math.Round( val ) )
						_p:setFlag("createacharacter_bodySkin_cart", math.ceil(val) ) 
					
						net.Start( "createacharacter_UpdateSkin" )
						
							net.WriteInt( math.ceil( val ) , 8 )
							
						net.SendToServer( )
						_p:setFlag( "createacharacter_Bodygroup_delay" , CurTime() + 1 )
						
					else
					
						
						timer.Simple(  0.1, function()
					 		
							
								
							//mdl.Entity:SetSkin( math.Round( val ) )
							_p:setFlag("createacharacter_bodySkin_cart", math.ceil(val) ) 
								
							net.Start( "createacharacter_UpdateSkin" )
							
								net.WriteInt( math.ceil( val ) , 8 )
								
							net.SendToServer( )
							
							_p:setFlag( "createacharacter_Bodygroup_delay" , CurTime() + 1 )
							
						end )
						
						
					end
					
				end
				
				bdcontrolspanel:AddItem( skins )
				
					//mdl.Entity:SetSkin( _p:getFlag("createacharacter_bodySkin", 0 ) )
					
				
				
				
			end

			local groups = string.Explode( " ", _p:getFlag("createacharacter_bodygroups_cart", "0" ) )
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
				
					local _delay = _p:getFlag( "createacharacter_Bodygroup_delay" , 0 )
					
					
					if _delay < CurTime() then
					
						//mdl.Entity:SetBodygroup( self.typenum, math.Round( val ) )

						local str = string.Explode( " ", _p:getFlag("createacharacter_bodygroups_cart", "0" ) )
						if ( #str < self.typenum + 1 ) then for i = 1, self.typenum + 1 do str[ i ] = str[ i ] or 0 end end
						str[ self.typenum + 1 ] = math.Round( val )
						
						_p:setFlag("createacharacter_bodygroups_cart", table.concat( str, " " ) ) 
						
						net.Start( "createacharacter_UpdateBodygroups" )
						
								net.WriteInt( math.Round( val ) , 8 )
								net.WriteInt( self.typenum , 8 )
						
						net.SendToServer( )
						_p:setFlag( "createacharacter_Bodygroup_delay" , CurTime() + 1 )
						
					else
						
						timer.Simple( 0.1, function()
							
							//mdl.Entity:SetBodygroup( self.typenum, math.Round( val ) )

							local str = string.Explode( " ", _p:getFlag("createacharacter_bodygroups_cart", "0" ) )
							if ( #str < self.typenum + 1 ) then for i = 1, self.typenum + 1 do str[ i ] = str[ i ] or 0 end end
							str[ self.typenum + 1 ] = math.Round( val )
							
							_p:setFlag("createacharacter_bodygroups_cart", table.concat( str, " " ) ) 
							
							net.Start( "createacharacter_UpdateBodygroups" )
							
								net.WriteInt( math.Round( val ) , 8 )
								net.WriteInt( self.typenum , 8 )
							
							net.SendToServer( )
						_p:setFlag( "createacharacter_Bodygroup_delay" , CurTime() + 1 )
						
						
						end )
					
					end
						
						
				end
						
				bdcontrolspanel:AddItem( bgroup )

				//mdl.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )
				
			end
			
		
		
	end
	
	
	return panel;
	
end


function CRModelList()


	
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
			modeltab:SetSize( panel:GetWide() - 5 , panel:GetTall() - 200 )
			local ModelScroll = modeltab:Add( "DScrollPanel" )
			
			modeltab:AddSheet( "Beginner Model List", ModelScroll, "icon16/application_view_tile.png" )
			
			ModelScroll:DockMargin( 2, 0, 2, 2 )
			ModelScroll:Dock( FILL )

			local ModelIconLayout = ModelScroll:Add( "DIconLayout" )
			ModelIconLayout:SetSpaceX( 2 )
			ModelIconLayout:SetSpaceY( 2 )
			ModelIconLayout:Dock( FILL )
			
			local modelicons = { }

			local Models = {};
			local _p = LocalPlayer();
			
			local _pTeam = _p:Team()
			
			timer.Simple( 1, function()
			
			
				for k, v in pairs( mdlTable[1] ) do 
				/*
					local iterator = iterateModelTable( 1, k );
					
						if iterator.id && iterator.mdl && player_manager.TranslateToPlayerModelName( iterator.mdl ) != "kleiner" then*/
					if v.beginner then
					
						table.insert(Models, { 1, v.path}); 
						
					end
					
				end
				for k, v in pairs( mdlTable[2] ) do 
				/*
					local iterator = iterateModelTable( 1, k );
					
						if iterator.id && iterator.mdl && player_manager.TranslateToPlayerModelName( iterator.mdl ) != "kleiner" then*/
					if v.beginner then
					
						table.insert(Models, { 2, v.path}); 
						
					end
					
				end
							
			
			/*else
				if !jobMdlTable[_pTeam] then return Frame:Close() end;
				
				local _pNameFancy = ( _pTeam == TEAM_PARAMEDIC ) && "Paramedic" || ( _pTeam == TEAM_POLICE ) && "Police Officer" || "John Doe";
				for k , v in pairs( jobMdlTable[_pTeam][_p:getGender()]) do
				
					table.insert( Models, { _p:getGender(), v.model, _pNameFancy } )
					
				end
			*/
			
			modelicons= {};
			for k, v in pairs( Models ) do
										
				local icon = ModelIconLayout:Add( "SpawnIcon" )
				icon:SetSize( 64, 64 )
				icon:InvalidateLayout( true )
				icon:SetModel( v[2] )
				icon.mdl = v[2];
				table.insert( modelicons, icon )
				icon.DoClick = function()
					
												
				_p:setFlag("createacharacter_playerModel_cart",player_manager.TranslateToPlayerModelName( icon.mdl )  );
							
				net.Start("createacharacterr_updatePlayerModel" )
					net.WriteString( player_manager.TranslateToPlayerModelName( icon.mdl ) )
					
				net.SendToServer()
				
				timer.Simple( 0.3, function()

					FRAME.Tabs[2]:RefreshSkinCategory() 
	
				end )
							
				end
				
			end
					//ModelList:AddLine( name, model )
				
				
		end)
			

	
	end
	
	return panel;
	
end