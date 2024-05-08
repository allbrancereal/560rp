

local MaleMenu = { }
local Frame
local default_animations = { "idle_all_01", "menu_walk", "pose_standing_02", "pose_standing_03", "idle_fist" }

local function KeyboardOn( pnl )
	if ( IsValid( Frame ) and IsValid( pnl ) and pnl:HasParent( Frame ) ) then
		Frame:SetKeyboardInputEnabled( true )
	end
end
hook.Add( "OnTextEntryGetFocus", "lf_playermodel_keyboard_on", KeyboardOn )
local function KeyboardOff( pnl )
	if ( IsValid( Frame ) and IsValid( pnl ) and pnl:HasParent( Frame ) ) then
		Frame:SetKeyboardInputEnabled( false )
	end
end
hook.Add( "OnTextEntryLoseFocus", "lf_playermodel_keyboard_off", KeyboardOff )


function MaleMenu.Setup( bool )
	local buy = false;
	
	if bool then
	
		buy = true 
		
	else 
	
		buy = false 
		
	end
	
	Frame = vgui.Create( "DFrame" )
	local fw, fh = 960, 700
	Frame:SetSize( fw, fh )
	Frame:SetTitle( "PlayerModel Selector" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:SetScreenLock( false )
	Frame:ShowCloseButton( true )
	Frame:Center()
	Frame:AlignTop(  )
	Frame:MakePopup()
	Frame:SetKeyboardInputEnabled( false )
	local r, g, b = 97, 100, 102
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 10, 0, 0, w, h, Color( r, g, b, 127 ) ) return true
	end
	
	Frame.lblTitle:SetTextColor( Color( 0, 0, 0, 255 ) )
	Frame.lblTitle.Paint = function ( self, w, h )
		draw.SimpleTextOutlined( Frame.lblTitle:GetText(), "DermaDefaultBold", 1, 2, Color( 255, 255, 255, 255), 0, 0, 1, Color( 0, 0, 0, 255) ) return true
	end
	
	Frame.btnMinim:SetVisible( false )
	Frame.btnMaxim.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "WindowMinimizeButton", panel, w, h ) end
	Frame.btnMaxim:SetEnabled( true )
	Frame.btnMaxim.DoClick = function()
		Frame:SetVisible( false )
	end

	local mdl = Frame:Add( "DModelPanel" )
	mdl:Dock( LEFT )
	mdl:SetSize( 520, 0 )
	mdl:SetFOV( 36 )
	mdl:SetCamPos( Vector( 0, 0, 0 ) )
	mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 160, 80, 255 ) )
	mdl:SetDirectionalLight( BOX_LEFT, Color( 80, 160, 255, 255 ) )
	mdl:SetAmbientLight( Vector( -64, -64, -64 ) )
	mdl:SetAnimated( true )
	mdl.Angles = Angle( 0, 0, 0 )
	mdl:SetLookAt( Vector( -100, 0, -22 ) )

	local b = Frame:Add( "DButton" )
	b:SetSize( 100, 18 )
	b:SetPos( 790, 3 )
	b:SetText( "Visit Our Website" )
	b.DoClick = function()
		gui.OpenURL( "http://560rp.com" )
	end
	
	local b = Frame:Add( "DButton" )
	b:SetSize( 120, 30 )
	b:SetPos( 400, 30 )
	b:SetText( "Apply playermodel" )
	b:SetEnabled(true)
	b.DoClick = function()
	
		if LocalPlayer():GetModel() == player_manager.TranslatePlayerModel( LocalPlayer().__sel_mod ) then
			LocalPlayer():Notify("You can not chose your own model");
			return
		end
		//print("send the update")
		net.Start("lf_playermodel_update")
			net.WriteString( LocalPlayer().__sel_mod )
			net.WriteString( LocalPlayer().__sel_bodygroups )
			net.WriteInt( LocalPlayer().__sel_skin , 32 )
			net.WriteBool( buy )
		net.SendToServer()
		Frame:ToggleVisible( bool )

	end;
	--[[local topmenu = Frame:Add( "DPanel" )
	topmenu:SetPaintBackground( false )
	topmenu:Dock( TOP )
	topmenu:SetSize( 0, 40 )
	
	
	local c = topmenu:Add( "DCheckBoxLabel" )
	c.cvar = "cl_playermodel_selector_force"
	c:SetPos( 250, 8 )
	c:SetValue( GetConVar(c.cvar):GetBool() )
	c:SetText( "Enforce your playermodel" )
	c:SetTooltip( "If enabled, your selected playermodel will\nbe protected. No other function will be\nable to change your playermodel anymore." )
	c:SizeToContents()
	c.Label.Paint = function ( self, w, h )
		draw.SimpleTextOutlined( c.Label:GetText(), "DermaDefault", 0, 0, Color( 255, 255, 255, 255), 0, 0, 1, Color( 0, 0, 0, 255) ) return true
	end
	c.OnChange = function( p, v )
		RunConsoleCommand( c.cvar, v == true and "1" or "0" )
	end]]
	
	
	local sheet = Frame:Add( "DPropertySheet" )
	sheet:Dock( RIGHT )
	sheet:SetSize( 430, 0 )
		
		
		local modeltab = sheet:Add( "DPropertySheet" )
		sheet:AddSheet( "Model", modeltab, "icon16/user.png" )
		
			local ModelScroll = modeltab:Add( "DScrollPanel" )
			modeltab:AddSheet( "Icons", ModelScroll, "icon16/application_view_tile.png" )
			ModelScroll:DockMargin( 2, 0, 2, 2 )
			ModelScroll:Dock( FILL )
			
			local ModelIconLayout = ModelScroll:Add( "DIconLayout" )
			ModelIconLayout:SetSpaceX( 2 )
			ModelIconLayout:SetSpaceY( 2 )
			ModelIconLayout:Dock( FILL )
			
			local modelicons = { }
			
			
			//local ModelList = modeltab:Add( "DListView" )
			//modeltab:AddSheet( "Table", ModelList, "icon16/application_view_list.png" )
			//ModelList:DockMargin( 5, 0, 5, 5 )
			//ModelList:Dock( FILL )
			//ModelList:SetMultiSelect( false )
			//ModelList:AddColumn( "Model" )
			//ModelList:AddColumn( "Path" )
			//ModelList.OnRowSelected = function()
				//local sel = ModelList:GetSelected()
				//if !sel[1] then return end
				//local name = tostring( sel[1]:GetValue(1) )
				//RunConsoleCommand( "cl_playermodel", name )
				//RunConsoleCommand( "cl_playerbodygroups", "0" )
				//RunConsoleCommand( "cl_playerskin", "0" )
				//RunConsoleCommand( "cl_playerflexes", "0" )
				//timer.Simple( 0.1, function() MaleMenu.UpdateFromConvars() end )
			//end
			
			local Models = {};
			
				for k, v in pairs(mdlTable[2]) do 
				
					local iterator = iterateModelTable( 2, k );
					
						if iterator.id && iterator.mdl && player_manager.TranslateToPlayerModelName( iterator.mdl ) != "kleiner" then
						table.insert(Models, {2, iterator.mdl , iterator.name , player_manager.TranslateToPlayerModelName( iterator.mdl )}); 
						else
						
							print( iterator.mdl )
						
						end
				end
			
			
				
			timer.Simple( 0.5, function()
				modelicons= {};
				for k, v in pairs( Models ) do
					
					if v[1] == LocalPlayer():getGender() then
					
						local icon = ModelIconLayout:Add( "SpawnIcon" )
						icon:SetSize( 64, 64 )
						icon:InvalidateLayout( true )
						icon:SetModel( v[2] )
						icon:SetTooltip( v[4] )
						table.insert( modelicons, icon )
						icon.DoClick = function()
							LocalPlayer().__sel_mod = v[4]
							LocalPlayer().__sel_bodygroups = "0"
							LocalPlayer().__sel_skin = "0"
							
							
							timer.Simple( 0.1, function() MaleMenu.UpdateFromConvars() end )
						end
					end
					//ModelList:AddLine( name, model )
				end
			
			end)
		
		local bdcontrols = sheet:Add( "DPanel" )
		local bgtab = sheet:AddSheet( "Bodygroups", bdcontrols, "icon16/group.png" )
		bdcontrols:DockPadding( 8, 8, 8, 8 )

		local bdcontrolspanel = bdcontrols:Add( "DPanelList" )
		bdcontrolspanel:EnableVerticalScrollbar( true )
		bdcontrolspanel:Dock( FILL )
		
		
		
		--[[local PanelSelect = sheet:Add( "DPanelSelect" )
		sheet:AddSheet( "Model", PanelSelect, "icon16/user.png" )

		for name, model in SortedPairs( player_manager.AllValidModels() ) do

			local icon = vgui.Create( "SpawnIcon" )
			icon:SetModel( model )
			icon:SetSize( 64, 64 )
			icon:SetTooltip( name )
			icon.playermodel = name

			PanelSelect:AddPanel( icon, { cl_playermodel = name } )

		end]]
		
		

	-- Helper functions

	function MaleMenu.PlayPreviewAnimation( panel, playermodel )

		if ( !panel or !IsValid( panel.Entity ) ) then return end

		local anims = list.Get( "PlayerOptionsAnimations" )

		local anim = default_animations[ math.random( 1, #default_animations ) ]
		if ( anims[ playermodel ] ) then
			anims = anims[ playermodel ]
			anim = anims[ math.random( 1, #anims ) ]
		end

		local iSeq = panel.Entity:LookupSequence( anim )
		if ( iSeq > 0 ) then panel.Entity:ResetSequence( iSeq ) end

	end

	-- Updating

	function MaleMenu.MakeNiceName( str )
		local newname = {}

		for _, s in pairs( string.Explode( "_", str ) ) do
			if ( string.len( s ) == 1 ) then table.insert( newname, string.upper( s ) ) continue end
			table.insert( newname, string.upper( string.Left( s, 1 ) ) .. string.Right( s, string.len( s ) - 1 ) ) -- Ugly way to capitalize first letters.
		end

		return string.Implode( " ", newname )
	end

	function MaleMenu.UpdateBodyGroups( pnl, val )
		if ( pnl.type == "bgroup" ) then

			mdl.Entity:SetBodygroup( pnl.typenum, math.Round( val ) )

			local str = string.Explode( " ", LocalPlayer().__sel_bodygroups )
			if ( #str < pnl.typenum + 1 ) then for i = 1, pnl.typenum + 1 do str[ i ] = str[ i ] or 0 end end
			str[ pnl.typenum + 1 ] = math.Round( val )
			LocalPlayer().__sel_bodygroups = table.concat( str, " " ) 
			
			
			
		elseif ( pnl.type == "skin" ) then

			mdl.Entity:SetSkin( math.Round( val ) )
			LocalPlayer().__sel_skin = math.Round( val )
			

		end
	end

	function MaleMenu.RebuildBodygroupTab()
		bdcontrolspanel:Clear()
		//flexcontrolspanel:Clear()
		
		bgtab.Tab:SetVisible( false )
		//flextab.Tab:SetVisible( false )
		if LocalPlayer().__sel_skin then
		local nskins = mdl.Entity:SkinCount() - 1
		if ( nskins > 0 ) then
			local skins = vgui.Create( "DNumSlider" )
			skins:Dock( TOP )
			skins:SetText( "Skin" )
			skins:SetDark( true )
			skins:SetTall( 50 )
			skins:SetDecimals( 0 )
			skins:SetMax( nskins )
			skins:SetValue( LocalPlayer().__sel_skin )
			skins.type = "skin"
			skins.OnValueChanged = MaleMenu.UpdateBodyGroups
			
			bdcontrolspanel:AddItem( skins )
			
				mdl.Entity:SetSkin( LocalPlayer().__sel_skin )
				
			
			
			
			bgtab.Tab:SetVisible( true )
		end
		end
		if LocalPlayer().__sel_bodygroups then
		local groups = string.Explode( " ", LocalPlayer().__sel_bodygroups )
			for k = 0, mdl.Entity:GetNumBodyGroups() - 1 do
				if ( mdl.Entity:GetBodygroupCount( k ) <= 1 ) then continue end

				local bgroup = vgui.Create( "DNumSlider" )
				bgroup:Dock( TOP )
				bgroup:SetText( MaleMenu.MakeNiceName( mdl.Entity:GetBodygroupName( k ) ) )
				bgroup:SetDark( true )
				bgroup:SetTall( 50 )
				bgroup:SetDecimals( 0 )
				bgroup.type = "bgroup"
				bgroup.typenum = k
				bgroup:SetMax( mdl.Entity:GetBodygroupCount( k ) - 1 )
				bgroup:SetValue( groups[ k + 1 ] or 0 )
				bgroup.OnValueChanged = MaleMenu.UpdateBodyGroups
				
				bdcontrolspanel:AddItem( bgroup )

				mdl.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )
				
				bgtab.Tab:SetVisible( true )
			end
		end
		
	end
	
	function MaleMenu.UpdateFromConvars()

		local model = LocalPlayer().__sel_mod;
		local modelname = player_manager.TranslatePlayerModel( model )
		
		util.PrecacheModel( modelname )
		
		
		
		mdl:SetModel( modelname )
		//mdl.Entity.GetPlayerColor = function() return Vector( GetConVar( "cl_playercolor" ):GetString() ) end
		mdl.Entity:SetPos( Vector( -100, 0, -61 ) )

		MaleMenu.PlayPreviewAnimation( mdl, model )
		MaleMenu.RebuildBodygroupTab()
	end


	MaleMenu.UpdateFromConvars()

	--[[function PanelSelect:OnActivePanelChanged( old, new )

		if ( old != new ) then -- Only reset if we changed the model
			RunConsoleCommand( "cl_playerbodygroups", "0" )
			RunConsoleCommand( "cl_playerskin", "0" )
			RunConsoleCommand( "cl_playerflexes", "0" )
		end

		timer.Simple( 0.1, function() MaleMenu.UpdateFromConvars() end )

	end]]

	-- Hold to rotate

	function mdl:DragMousePress()
		self.PressX, self.PressY = gui.MousePos()
		self.Pressed = true
	end

	function mdl:DragMouseRelease() self.Pressed = false end

	function mdl:LayoutEntity( Entity )
		if ( self.bAnimated ) then self:RunAnimation() end

		if ( self.Pressed ) then
			local mx, my = gui.MousePos()
			self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )
			
			self.PressX, self.PressY = gui.MousePos()
		end

		Entity:SetAngles( self.Angles )
	end

end

function MaleMenu.Toggle( bool )

		if IsValid( Frame ) then
			Frame:Remove()
			MaleMenu.Setup( bool )
		else
			MaleMenu.Setup( bool )
		end
		
end 

function togglemalemodelchanger( bool )
	
	MaleMenu.Toggle( bool )
	
end

