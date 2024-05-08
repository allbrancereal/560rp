timer.Simple( 1 ,function() 
	surface.CreateFont( "Trebuchet6", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(6),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false, 
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "Trebuchet5", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 22,
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "CarDisplayPrice", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(8),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "CarDisplayName", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(9),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "Trebuchet24", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(8),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "Trebuchet32", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = ScreenScale(20),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "Trebuchet20", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = ScreenScale(12),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "Trebuchet19", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = ScreenScale(9),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )
	surface.CreateFont( "Trebuchet18", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = 18,
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "ShopDescFont", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size =  ScreenScale(5),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

end )
local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
surface.CreateFont( "Trebuchet12", {
	font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 15,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

function lerpColor( _delta, _from , _to  )

	if _delta > 1 || _delta < 0 then return end
	
	local _retTbl = {}
	
	_retTbl.r	= _from.r + ( _to.r - _from.r ) * _delta;
	_retTbl.g	= _from.g + ( _to.g - _from.g ) * _delta;
	_retTbl.b	= _from.b + ( _to.b - _from.b ) * _delta;
		
	if _from.a && _to.a then
		_retTbl.a	= _from.a + ( _to.a - _from.a ) * _delta;
	end
	
	
	
	return _retTbl;
	
end

net.Receive("inventoryHooks", function(  )
	local _p = LocalPlayer();
	
	_p.__IsInInventory = _p.__IsInInventory || false;

	if _p.__IsInInventory then
	
		exitInventoryFromClient()
		IsInMenu = false
	else
	
		createMenuFromClient()
		IsInMenu =true
	end
	
end )

local FRAME;
local menuAlpha = 0;

// Advanced button
// I feel like I need it
/*

	// Animated Button
	_tbl.Pos 			= { x , y };
	_tbl.Size 			= { w, h };
	_tbl.RelativeColor	= Color( 56, 56 ,56, 128 );
	_tbl.OriginalColor	= Color( 56, 56 ,56, 128 );
	_tbl.HoveredColor 	= Color( 255, 255 , 255, 255 );
	_tbl.PressedColor 	= Color( 25, 25 , 25, 128 );
	_tbl.Text 			= "";
	_tbl.OnPressed		= f;
	_tbl.OnRelease		= f;
	_tbl.ThinkFunc		= f;
	_tbl.PaintFunc		= f;
	_tbl.OnClose		= f;
	_tbl.NoAlphaColor	= bool;
	
	
*/
function advancedButton( _tbl, Frame)

	local buttonToolTip;
	
	local advBut = vgui.Create( "DButton" , _tbl.Parent )
	
	advBut:SetPos( ( _tbl.Pos[1] || 0 ) , ( _tbl.Pos[2] || 0 ) )
	
	advBut:SetSize( ( _tbl.Size[1] || 100 ) , ( _tbl.Size[2] || 50 ) )
	
	advBut:SetDisabled( ( _tbl.DisableOnInit || false ) );
	
	advBut._beginAlpha = 0;
	
	if _tbl.ID then
	
		advBut.ID = _tbl.ID;
		
	end
	
	advBut.__Text = ( _tbl.Text || "" ) 
		
	advBut.RelativeColor = _tbl.RelativeColor || Color( 56, 56 ,56, 0 );
	
	advBut.OriginalColor = _tbl.OriginalColor || Color( 56, 56 ,56, 128 );
	
	advBut.HoveredColor = _tbl.HoveredColor || Color( 255, 255 , 255, 255 );
	
	advBut.PressedColor = _tbl.PressedColor || Color( 25, 25 , 25, 128 );
	
	advBut.TextWhite = Color( 255, 255 ,255 , _beginAlpha );
	
	advBut.TextBlack = Color( 56, 56 , 56, _beginAlpha );
	
	advBut.RelativeTextColor = advBut.TextWhite;
	
	advBut:SetText("")
	
	advBut.DoBeginningAlpha = false;
		
	if _tbl.DoAlpha then
		
		advBut.RelativeColor.a = advBut._beginAlpha;
		
		advBut.DoBeginningAlpha = true;
		
	end
		
	advBut._IsPressedLerp = false;
	
	function advBut:Paint( w, h )
	
		surface.SetDrawColor( advBut.RelativeColor )
		surface.DrawRect( 0, 0 , w , h )
		
		
		
		draw.SimpleText( ( advBut.__Text || "" ) , "Trebuchet24", w/2, h/2 , advBut.RelativeTextColor ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
		
		if _tbl.PaintFunc then
		
			_tbl.PaintFunc()
			
		end
		
	end
	
	function advBut:OnMousePressed( keyCode )
		advBut._IsPressedLerp = true;
		
		if _tbl.OnPressed then
		
			_tbl.OnPressed( self, keyCode )
		
		end
		
	end
	
	function advBut:OnMouseReleased( keyCode )
		
		if _tbl.OnRelease then
		
			_tbl.OnRelease( keyCode )
	
		end
		
	end
	
	function advBut:OnClose( )
	
		if _tbl.OnClose then
		
			_tbl.OnClose()
			
		end
		
		
		advBut._beginAlpha = 0;
		
	end	
	advBut.TargetX = ( _tbl.Pos[1] ) 

	

	function advBut:MoveToTarget()
		local _x , _y = self:GetPos()
		self:MoveTo( self.TargetX,_y , .5, 0,.2 )
	end
	

	function advBut:MoveToOriginal()
		local _x , _y = self:GetPos()
		self:MoveTo(self.TargetX-_wMod*100, _y, 1, .50, .2)
	end
	function advBut:OnCursorEntered()
		self:MoveToTarget()
	end
	
	advBut.Frame = Frame;
	function advBut:OnCursorExited()
		if self.Frame then
			for k , v in pairs( self.Frame.Tabs ) do
				for x , y in pairs( self.Frame.TabButtons) do					
					
					if k == y.ID then
						if v:IsVisible() == false then
							y:MoveToOriginal() 
						end
					end

				end
			end
		end
	end
	
	function advBut:Think( )
	
		
		if !advBut:IsHovered() then
		
			advBut.RelativeColor = lerpColor( 0.05, advBut.RelativeColor , advBut.OriginalColor );
			advBut.RelativeTextColor = lerpColor( 0.05 , advBut.RelativeTextColor, advBut.TextWhite );
			
			if self._IsPressedLerp == true then
				
				self._IsPressedLerp = false;
			
			end
		
		end
		
		if _tbl.ThinkFunc then
		
			_tbl.ThinkFunc()
			
		end
		
		if advBut.DoAlpha then
		
			advBut._beginAlpha = Lerp( 0.05, advBut._beginAlpha , 255 )
						
		end
		
		if advBut._IsPressedLerp then
		
			advBut.RelativeColor = lerpColor( 0.05, advBut.RelativeColor , advBut.PressedColor );
								
		end
		
		if advBut:IsHovered() then
			

			advBut.RelativeColor = lerpColor( 0.05, advBut.RelativeColor , advBut.HoveredColor );
			advBut.RelativeTextColor = lerpColor( 0.05 , advBut.RelativeTextColor, advBut.TextBlack );

		/*	
			if _tbl.ShowToolTip && !IsValid( buttonToolTip ) then
			
				buttonToolTip = createAnimatedToolTip( _tbl.ToolTipBox ,self.Frame);
				return
			end*/
				
			return
		end
		
		/*
		if _tbl.ShowToolTip && IsValid( buttonToolTip ) && !advBut:IsHovered() then
		
			buttonToolTip:Remove()
			return
		end*/
							
		
		
		
	end
	
	return advBut
end

/*

	// Animated Button
	_tbl.Pos 			= { x , y };
	_tbl.Size 			= { w, h };
	_tbl.RelativeColor	= Color( 56, 56 ,56, 128 );
	_tbl.OriginalColor	= Color( 56, 56 ,56, 128 );
	_tbl.Text 			= "";
	_tbl.ThinkFunc		= f;
	_tbl.PaintFunc		= f;	
	
*/
function createAnimatedToolTip( _tb,Frame )
	
	local _row = {};
	local toolTipFrame = vgui.Create( "DFrame" )
	toolTipFrame:SetSize( _tb.Size[1] , _tb.Size[2] )
	toolTipFrame:SetVisible( true )
	toolTipFrame:SetDrawOnTop( true )
	toolTipFrame:ShowCloseButton( false )
	toolTipFrame:SetTitle( "" )
	toolTipFrame.RelativeColor = _tb.BackgroundColor || Color( 0,0,0, 240 );
	toolTipFrame.Frame = Frame;
	function toolTipFrame:Think()
	
		self:SetPos( gui.MousePos() )
		//if !toolTipFrame.Frame then self:Remove() return end
		
	end
	
	if _tb.Title then
	
		toolTipFrame.Title = _tb.Title;
		
	end
	
	if _tb.Description then
	
		toolTipFrame.Description = _tb.Description;
		
	end
	
	
	function toolTipFrame:Paint( w, h )
	
		surface.SetDrawColor( toolTipFrame.RelativeColor )
		surface.DrawRect( 0, 0 , w , h )
		
		if toolTipFrame.Title then
		
			draw.SimpleText( toolTipFrame.Title, "Trebuchet12", 15, 5 , Color ( 255 ,255 ,255 , menuAlpha ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

		end
		
		if toolTipFrame.Description then

			for k , v in pairs( toolTipFrame.Description ) do
			
				draw.SimpleText( v, "Trebuchet12", 15, 15*k + 5  , Color ( 255 ,255 ,255 , menuAlpha ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
			
			end
			
		
		end
		
	end

	return toolTipFrame;
end
function createMenuFromClient(  firstTab )


	
	FRAME = vgui.Create( "DFrame" )
	FRAME:SetPos( 0 , ScrH() * 0.1 )
	FRAME:SetSize( ScrW() , ScrH() * 0.8 )
	FRAME:ShowCloseButton( true )
	FRAME:SetDeleteOnClose( false )
	FRAME:SetTitle( "" )
	FRAME:MakePopup()
	IsInMenu = true;

	FRAME.DoBeginning = true;
	FRAME.DoCloseAnim = false;
	
	function FRAME:Paint( w, h )
	
		//surface.SetDrawColor(  255, 225, 120 , menuAlpha )
		surface.SetDrawColor(25, 25, 25 , menuAlpha*2 )
		surface.DrawRect( 0, 0 , w , h )
		surface.SetDrawColor( 25, 25, 25 , menuAlpha )
		surface.DrawRect( _wMod*1, _hMod*1 , w-_wMod*1 , h-_hMod*1 )
		
		draw.SimpleText( "West Coast RPG - Menu" , "Trebuchet32", _wMod*20,_hMod*10 , Color ( 255 ,255 ,255 , 255 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
	
		surface.SetDrawColor( 255, 225, 120 , menuAlpha )
		surface.DrawRect( 0, 0 , _wMod*10 ,h )

	end
	
	function FRAME:OnClose( )
	
		FRAME.DoCloseAnim = true;
		FRAME.DoBeginning = true;
		menuAlpha = 0;
		IsInMenu = false;
		
		
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
		
			menuAlpha =  Lerp( 0.05, menuAlpha, 128 )
			
			if menuAlpha == 128 then
			
				FRAME.DoBeginning = false;
			
			end
			
		end
		
		if FRAME.DoCloseAnim == true then
		
			menuAlpha =  Lerp( 0.05, menuAlpha, 0 )
			
		end
		
	end
	
	function FRAME:Init()
	
		FRAME.DoBeginning = true;
	 
	end 
	FRAME.Tabs = { MOTD() , DevCycle() , MyCharacter() , Quests() , MyInventory() , MyBusinesses(), Crafting(), SkillsAndResearch(), Settings() }
	
	// We just ran all the tabs, lets hide them.
	for k, v in pairs( FRAME.Tabs ) do 
	
		if ispanel( v ) then
		
			v:SetVisible(false) 
		
		end
		
	end 
	
	
	
	local MenuButtons = {
							
						{
							ID				= 1;
							Parent			= FRAME;
							Pos 			= { 0, 50};
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 255, 56 ,56, 255 );
							OriginalColor	= Color( 56,56,56, 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Message of the Day";
							ShowToolTip		= true;
							DoAlpha	= true;
							OnPressed = function( self )
								
								for _, x in pairs( FRAME.Tabs ) do 
						
									if ispanel( x ) then
										
										x:SetVisible( false )
										x._tabAlpha =  0;
										
									end
										
								end 
								local _panel = FRAME.Tabs[self.ID];
								_panel:OnInit()
	
								_panel.DoCloseAlpha =  false;
								_panel._tabAlpha =  0;
								
								_panel:SetVisible( true )
								_panel.DoAlpha =  true 
							
							end;
							ToolTipBox = { 
								Title = "Message of the Day";
								Size = { 230 , 115 };
								Description = { 
									"This button will lead you to the our group";
									"located at https://steamcommunity.com/groups/westcoast-rp.";
									"";
									"You can check out our home-page or find";
									"more about in-game content here!";
								};
								//BackgroundColor = Color (0,0,0,240);
								
							}
						};
						{
							ID				= 2;
							Parent			= FRAME;
							Pos 			= { 0, 125 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 5, 5, 5 , 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Steam Workshop";
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

								if !steamworks.IsSubscribed("2122465484") then
									
									gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2122465484")
								
								end
							
								FRAME.Tabs[self.ID].DoCloseAlpha =  false;
								FRAME.Tabs[self.ID]._tabAlpha =  0;
								
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
							
							end;
							ToolTipBox = { 
								Title = "Development Cycle";
								Size = { 230 , 115 };
								Description = { 
									"This is our over-view of the alpha. Updates-";
									"as well as developer commentary is posted";
									"in this menu for ease-of-access.";
									"";
									"(Note: This is an alpha gamemode, Suggest";
									"-your ideas or invest to bring them to life.)";
								};
							}
						};
						{
							ID				= 3;
							Parent			= FRAME;
							Pos 			= { 0, 200 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56,56,56, 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "My Character";
							DoAlpha			= true;
							DisableOnInit	= false;
							ShowToolTip		= true;
							OnPressed = function( self )
								
								for _, x in pairs( FRAME.Tabs ) do 
						
									if ispanel( x ) then
										
										x:SetVisible( false )
										x._tabAlpha =  0;
										
									end
										
								end 
								FRAME.Tabs[self.ID].DoCloseAlpha =  false;
								FRAME.Tabs[self.ID]._tabAlpha =  0;
								
								timer.Simple( 0.2, function()
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
								end)
							end;
							ToolTipBox = { 
								Title = "My Character";
								Size = { 230 , 110 };
								Description = { 
									"This is the over-view of your character.";
									"You can extract useful information to find";
									"out new things about yourself through game-";
									"play. We encourage trying out jobs to access";
									"special information about them here.";
								};
							}
						};
						{
							ID				= 4;
							Parent			= FRAME;
							Pos 			= { 0, 275 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 5, 5, 5 , 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Quests";
							DoAlpha			= true;
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
								
								timer.Simple( 0.2, function()
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
								end)
							end;
							ShowToolTip		= true;
							ToolTipBox = { 
								Title = "Quests";
								Size = { 230 , 100 };
								Description = { 
									"You can look up your quest progress here.";
									"There is no archive of quests because we";
									"are working on perfecting the questing system";
									"to perfection."
								};
							}
						};
						{
							ID				= 5;
							Parent			= FRAME;
							Pos 			= { 0, 350 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "My Inventory";
							DoAlpha			= true;
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
							ShowToolTip		= true;
							ToolTipBox = { 
								Title = "My Inventory";
								Size = { 230 , 150 };
								Description = { 
									"With your inventory you may equip, drop";
									"and use items that receive during game-play.";
									"Some items are more common than others and ";
									"certain quests will give you an item as a";
									"reward for completing them.";
									"";
									"(Note: Your crafting tab directly links to your";
									"-inventory.)";
								};
							}
						};
						{
							ID				= 6;
							Parent			= FRAME;
							Pos 			= {0, 425 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 5, 5, 5 , 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "My Illegal Businesses";
							DoAlpha			= true;
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
							ShowToolTip		= true;
							ToolTipBox = { 
								Title = "My Illegal Businesses";
								Size = { 230 , 90 };
								Description = { 
									"You can see your status of your invested";
									"businesses here. If you do not own any";
									"shares in a business then you can try";
									"finding the mysterious slav around town.";
								};
							}
						};
						{
							ID				= 7;
							Parent			= FRAME;
							Pos 			= {0, 500 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Crafting";
							DoAlpha			= true;
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
							ShowToolTip		= true;
							ToolTipBox = { 
								Title = "Crafting";
								Size = { 230 , 150 };
								Description = { 
									"Together with your gathered items in your";
									"inventory, you can put them together to make";
									"special items that will help you with what you";
									"require.";
									"";
									"(Note: What you can craft is directly";
									"dependent on your skills and research.";
									"Not all items may be legal to craft).";
								};
							}
						};
						{
							ID				= 8;
							Parent			= FRAME;
							Pos 			= { 0, 575 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 5, 5, 5 , 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Skill & Research";
							DoAlpha			= true;
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
								
								for k, v in pairs( FRAME.Tabs[self.ID]._skills ) do
								 	
									if IsValid(v) then
										v.TrueValue = 0;
									end
																							
								end
								
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
							
							end;
							ShowToolTip		= true;
							ToolTipBox = { 
								Title = "Skill's & Research";
								Size = { 230 , 100 };
								Description = { 
									"Through research your can receive status";
									"upgrades & bonuses that will help you find";
									"your own path in the world.";
									"";
									"(Note: Some research can strain you.)"
								};
							}
						};
						{
							ID				= 9;
							Parent			= FRAME;
							Pos 			= { 0, 650 };
							Size 			= { ScrW() * 0.1 , 50 };
							RelativeColor	= Color( 56, 56 ,56, 128 );
							OriginalColor	= Color( 56, 56 ,56, 255 );
							HoveredColor 	= Color( 255, 255 , 255, 255 );
							PressedColor 	= Color( 25, 25 , 25, 128 );
							Text 			= "Settings";
							DoAlpha			= true;
							DisableOnInit	= false;
							OnPressed = function( self )
								
								for _, x in pairs( FRAME.Tabs ) do 
						
									if ispanel( x )  then
										
										
										x:SetVisible( false )
										x._tabAlpha =  0;
										
									end
										
								end 
								
								FRAME.Tabs[self.ID].DoCloseAlpha =  false;
								FRAME.Tabs[self.ID]._tabAlpha =  0;
								
								
								FRAME.Tabs[self.ID]:SetVisible( true )
								FRAME.Tabs[self.ID].DoAlpha =  true 
							
							end;
							ShowToolTip		= true;
							ToolTipBox = { 
								Title = "Settings";
								Size = { 230 , 50 };
								Description = { 
									"With this menu you can adjust all client-side";
									"options.";
								};
							}
						};
						
	}
	i = 1;
	local _tabButtons = {};
	FRAME.TabButtons = {};
	for k , v in pairs( MenuButtons ) do

	
		local cachebut = advancedButton( v , FRAME );
		local _x , _y = cachebut:GetPos();
		cachebut:SetPos(_x-_wMod*100, _y + _hMod*50)
		table.insert( FRAME.TabButtons, cachebut ) ;		
		
		
		i =1+i;		
	end
	_tabButtons = FRAME.TabButtons


	for _, x in pairs( FRAME.Tabs ) do 

		if ispanel( x )  then
			
			
			x:SetVisible( false )
			x._tabAlpha =  0;
			
		end
			
	end
	local _ToShow = 5;
	
	if firstTab then
	
		_ToShow = firstTab; 
		
	end
	FRAME.Tabs[_ToShow].DoCloseAlpha =  false;
	FRAME.Tabs[_ToShow]._tabAlpha =  0;
	if isfunction(FRAME.Tabs[_ToShow].OnInit) then
		FRAME.Tabs[_ToShow].OnInit()
	end
	
	FRAME.Tabs[_ToShow]:SetVisible( true )
	FRAME.Tabs[_ToShow].DoAlpha =  true 

					
	for k , v in pairs( FRAME.Tabs ) do
		for x , y in pairs( FRAME.TabButtons) do					
			
			if k == y.ID then
				if v:IsVisible() == false then
					y:MoveToOriginal() 
				else
					y:MoveToTarget()
				end
			end

		end
	end
	
	
	for k, v in pairs( FRAME.Tabs ) do 
	
		if ispanel( v ) then
		
			v:RefreshInformation() 
		
		end
		
	end
	
	return FRAME;
end

 local Menu
 local IsInMenu = false;

local _pMeta = FindMetaTable('Player')
function _pMeta:UpdateClientInventoryVGUI()

	if Menu and IsValid(Menu) and ispanel(Menu) then
		Menu.Tabs[5]:RefreshInformation();
	end

end
net.Receive("updateInventory", function(_l,_p)

	LocalPlayer():UpdateClientInventoryVGUI();

end)

net.Receive("bindF1Menu", function( _len , _p )
	
	local _InvOverRide = net.ReadInt( 8 )
	
	if LocalPlayer():getFlag("InMenu", false) == false then 
		Menu = createMenuFromClient( _InvOverRide )
		IsInMenu = true;
		LocalPlayer().__IsInInventory = true;
		LocalPlayer():setFlag("InMenu", true )
	else
		
		if Menu then
			
			if !Menu.Tabs[_InvOverRide]:IsVisible() then
			
				Menu:Close()
				IsInMenu = false;
				LocalPlayer():setFlag("InMenu", false )
			
				Menu = createMenuFromClient( _InvOverRide )
				LocalPlayer():setFlag("InMenu", true )
				IsInMenu = true;
				return
				
			end
			
			LocalPlayer().__IsInInventory = false;
			
			Menu:Close()
			IsInMenu = false;
			
		end

		LocalPlayer():setFlag("InMenu", false )
			
	end

end)

function removeClientInventory()

	if IsValid( FRAME ) then
	
 		Menu = nil;
		FRAME:Remove()
		LocalPlayer().__IsInInventory = false;
	
	end
	
end

function exitInventoryFromClient( )

	if IsValid( FRAME ) then
	
 		Menu = nil;
		FRAME:Close()
		LocalPlayer().__IsInInventory = false;
		
	end
	
end

function MOTD()
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel._tabAlpha = 0;
	panel:SetPos( _wMod*140,75)
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
		draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
	end
	
	function panel:OnInit()

		if !ispanel( panel.webDock ) then

			panel.webDock = vgui.Create( "HTML", panel )
			panel.webDock:Dock( FILL )
			panel.webDock:OpenURL( "https://www.youtube.com/watch?v=-5kXA_MgD5A" )
		
		end
	end	
	
	panel.OnRemove = function(self)
		if IsValid(self.webDock) then
			self.webDock:Remove()
		end
	end
	if IsValid( panel.webDock ) then
		panel.webDock:Remove()
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
		 if self.webDock then
			self.webDock:Refresh( true )
		end
	end
	
	return panel;
	
end

/*
	_tb.Parent = panel;
	_tb.Pos = { 0, 0 }	
	_tb.Text = "Text"	
	_tb.Color = Color( 255, 255 ,255 ,255 )	
	_tb.FinalAlpha;
*/
function createFadeInText( _tb )
	local _tAlpha = 0;
	
	if _tb.Parent then 
	
		textPanel = vgui.Create( "DPanel" , _tb.Parent )
	
	else
	
		textPanel = vgui.Create( "DPanel" )
		
	end
	
	textPanel:SetPos( _tb.Pos[1], _tb.Pos[2] )
	
	textPanel.FadedInColor = Color( _tb.Color.r , _tb.Color.g , _tb.Color.b , _tAlpha );
	
	textPanel.DoIntro = true;
	
	textPanel.Text = _tb.Text;
	
	textPanel.FinalAlpha = _tb.FinalAlpha;
	
	function textPanel:Paint( w, h )
	
		//surface.SetDrawColor( self.FadedInColor )
		//surface.DrawRect( 0, 0 , w , h )
		
		
		
		draw.SimpleText( ( self.__Text || "" ) , "Trebuchet12", w/2, h/2 , self.FadedInColor ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
	
	
	end
	function textPanel:Think()
	

		if self.DoIntro then
		
			_tAlpha = Lerp( 0.05 , _tAlpha , self.FinalAlpha );
			
			if _tAlpha == self.FinalAlpha then
			
				self.DoIntro = false
				
			end
			
		end
	
	end

	return textPanel
end

function MyCharacter()
	
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel._tabAlpha = 0;
	panel:SetPos( _wMod*140,75)
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)
		draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)		
	end
	panel.deletedOnClose = {};
	
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
	
		local _p = LocalPlayer();
		self:MakeModelInformation( _p )
		
		if LocalPlayer():IsModerator() then
		
			local _civButton = vgui.Create("DButton", panel )
			_civButton:SetPos( (panel:GetWide()* 0.5) + (_wMod * 100* -1 + ( 15*-1 ) )   , _hMod * 100 )
			_civButton:SetSize( _wMod * 100, _hMod * 50 )
			_civButton.ID = i;
			_civButton:SetText( "" )
			_civButton.RelativeTextColor=Color( 255, 255 ,255 , _beginAlpha );
			_civButton.RelativeColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.OriginalColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.HoveredColor 	= Color( 255, 255 , 255, _tabAlpha );
			_civButton.PressedColor 	= Color( 25, 25 , 25, _tabAlpha );
			_civButton.TextWhite = Color( 255, 255 ,255 , _beginAlpha );
			_civButton.TextBlack = Color( 56, 56 , 56, _beginAlpha );
			_civButton.Panel = panel;
			function _civButton:Paint( w, h )
			
				draw.RoundedBoxEx(0,0,0,w,h, _civButton.RelativeColor ,true,true)
				
				draw.SimpleText( "Select Player" , "Trebuchet6", w/2, h/2 , self.RelativeTextColor  ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
				
			end
			function _civButton:OnMousePressed( keyCode )
			
				self.DoMouseRelease = true; 
				
				
					
				local PlayerSelector = DermaMenu()
				PlayerSelector:SetParent( self )
				//PlayerSelector:SetPos( _wMod * 250 , _hMod * 50 )
				
				local PlayerList = PlayerSelector:AddSubMenu( "Select Player:" )
				for k , v in pairs( player.GetAll() ) do
				
					PlayerList:AddOption( v:Nick() .. " (" .. v:getRPName() .. ", " .. v:SteamID() .. ")", function() 
						
						_civButton.Panel.ModelPanel:Remove()
						_civButton.Panel:MakeModelInformation( v ) 
						
					end )
							
				end
				
						
				
				PlayerSelector:Open(  )	
				
			end
			
			function _civButton:OnMouseReleased( keyCode )
			
				self.DoMouseRelease = false;
			
			end
			function _civButton:Think()
			
				if !self:IsHovered() then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.OriginalColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
					
					if self.DoMouseRelease then
					
						self.DoMouseRelease = false;
						
					end
					
				end
				
				if self:IsHovered() && 	!self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextBlack )
				
					return
				end
				
				if self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
				
					return
				
				end
				
			end	
			
			
		end
		
	end
	
		local _p = LocalPlayer();
	function panel:MakeModelInformation( _p )
		if !IsValid( _p ) then return end
		if self.ModelPanel then
		
			self.ModelPanel:Remove()
			
		end
		
		local mdlTo;
			
		if !_p then 
			
			mdlTo = "models/player/tfa_vi_arisha.mdl"
				
		elseif _p && _p:GetModel() then
			mdlTo = _p:GetModel()
			
		end
		
		local mdl = vgui.Create( "DModelPanel", panel )
		mdl:SetVisible( true )
		mdl:SetPos( 25 , 0 )

		mdl:SetSize( panel:GetWide() /3 , panel:GetTall() )

		mdl:SetFOV( 12 )

		mdl:SetCamPos( Vector( 200, 0, 50 ) )

		mdl:SetLookAt( Vector( 0, 2, 45 ) )

		mdl:SetModel( mdlTo )

		mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

		mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

		mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

		mdl:SetColor( Color( 200, 200, 200 ) )

		mdl:SetAnimated( false )																																							

		mdl.Angles = Angle( 0, 0, 0 )
		
		mdl.TeamSelected = TEAM_CIVILLIAN;
		
	mdl:SetMouseInputEnabled(false)
	function mdl:LayoutEntity( Entity ) 

		
	local _BodyInfo = _p:getFlag("civ_bodyGroupTable", {});

		local _defaultParam = "hospitalfemale_1";
		
		if _p:getGender() != 1 then
		
			_defaultParam = "hospitalmale_1"
			
		end
		
		local ID = mdl.TeamSelected
		local _toFind = ( ID == TEAM_CIVILLIAN ) && "" || ( ID == TEAM_POLICE ) && "job_police_" || ( ID == TEAM_PARAMEDIC ) && "job_paramedic_" || "";
	
		local _civillian_model		= _p:getFlag( "playerinfo_" .. _toFind .. "model", "Vindictus-Vella" )
		local _civillian_bdg		= _p:getFlag( "playerinfo_" .. _toFind .. "bodygroups", "" )
		local _civillian_skin		= _p:getFlag( "playerinfo_" .. _toFind .. "skin", 0 )
		

		
			mdl:SetModel( player_manager.TranslatePlayerModel( _civillian_model ) )
			mdl.Entity:SetSkin( _civillian_skin)
			
			local groups =_civillian_bdg
			
			if ( groups == nil ) then groups = "" end
			
			local groups = string.Explode( " ", groups )
			
				for k = 0, mdl.Entity:GetNumBodyGroups() - 1 do
				
					mdl.Entity:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
					
				end
			
			
	end
		
			panel.ModelPanel = mdl;
			
		
	
		local _civButtonInformationTable = {
			[1] = { TEAM_CIVILLIAN , "Civillian" };
			[2] = { TEAM_POLICE , "Police" };
			[3] = { TEAM_PARAMEDIC, "Paramedic" };
		}
		
		//local _p = LocalPlayer()
		
		if self.CivButtons then
		
			for k , v in pairs( self.CivButtons ) do
		
				if ispanel( v ) then
			
					v:Remove() 
					
				end
		
			end
		
		end
		
		
			local _civButton = vgui.Create("DButton", panel )
			_civButton:SetPos( (panel:GetWide()* 0.5) + (_wMod * 100* 5 + ( 15*5 ) )   , _hMod * 100 )
			_civButton:SetSize( _wMod * 150, _hMod * 50 )
			_civButton:SetText( "" )
			_civButton.RelativeTextColor=Color( 255, 255 ,255 , _beginAlpha );
			_civButton.RelativeColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.OriginalColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.HoveredColor 	= Color( 255, 255 , 255, _tabAlpha );
			_civButton.PressedColor 	= Color( 25, 25 , 25, _tabAlpha );
			_civButton.TextWhite = Color( 255, 255 ,255 , _beginAlpha );
			_civButton.TextBlack = Color( 56, 56 , 56, _beginAlpha );
			function _civButton:Paint( w, h )
			
				draw.RoundedBoxEx(0,0,0,w,h, _civButton.RelativeColor ,true,true)
				
				draw.SimpleText( "Attendance Rewards", "Trebuchet6", w/2, h/2 , self.RelativeTextColor  ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
				
			end
			function _civButton:OnMousePressed( keyCode )
			
				self.DoMouseRelease = true; 
				
				//mdl.DrawJobHalo = false;
				
				//local _toSet;
				
				//mdl.TeamSelected = _civButtonInformationTable[i][1];	
				local _tb = {[1] = true}
				local _revtbl = LocalPlayer():GetDailyRewardTable();
				local _allowfour =  (_revtbl && _revtbl[3] && _revtbl[3][4] && ( _revtbl[3][4][1] == 1 && true || false ));
				if _allowfour  == true then
					_tb[4] = true;
				end
				local _allowthree = (_revtbl && _revtbl[3] && _revtbl[3][3] && _revtbl[3][3][1] == 1 && true || false)

				if _allowthree == true then
					_tb[3] = true;
				end

				local _allowtwo = (LocalPlayer():getFlag("organization","") > 0)
				if _allowtwo == true  then
					_tb[2] = true;
				end
				local _newtb = {};
				for k=1,4 do
					if _tb[k] then
						_newtb[k] = true;
					end
				end
				
				ShowDailyRewardCalendar(_newtb)
				
				exitInventoryFromClient()
				
			end
			
			function _civButton:OnMouseReleased( keyCode )
			
				self.DoMouseRelease = false;
			
			end
			function _civButton:Think()
			
				if !self:IsHovered() then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.OriginalColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
					
					if self.DoMouseRelease then
					
						self.DoMouseRelease = false;
						
					end
					
				end
				
				if self:IsHovered() && 	!self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextBlack )
				
					return
				end
				
				if self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
				
					return
				
				end
				
			end	

			local _civButton = vgui.Create("DButton", panel )
			_civButton:SetPos( (panel:GetWide()* 0.5) + (_wMod * 100* 4 + ( 15*4 ) )   , _hMod * 100 )
			_civButton:SetSize( _wMod * 100, _hMod * 50 )
			_civButton:SetText( "" )
			_civButton.RelativeTextColor=Color( 255, 255 ,255 , _beginAlpha );
			_civButton.RelativeColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.OriginalColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.HoveredColor 	= Color( 255, 255 , 255, _tabAlpha );
			_civButton.PressedColor 	= Color( 25, 25 , 25, _tabAlpha );
			_civButton.TextWhite = Color( 255, 255 ,255 , _beginAlpha );
			_civButton.TextBlack = Color( 56, 56 , 56, _beginAlpha );
			function _civButton:Paint( w, h )
			
				draw.RoundedBoxEx(0,0,0,w,h, _civButton.RelativeColor ,true,true)
				
				draw.SimpleText( "Reputations", "Trebuchet6", w/2, h/2 , self.RelativeTextColor  ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
				
			end
			function _civButton:OnMousePressed( keyCode )
			
				self.DoMouseRelease = true; 
				
				//mdl.DrawJobHalo = false;
				
				//local _toSet;
				
				//mdl.TeamSelected = _civButtonInformationTable[i][1];
				hook.Run("ReputationMenu")
				exitInventoryFromClient()
				
			end
			
			function _civButton:OnMouseReleased( keyCode )
			
				self.DoMouseRelease = false;
			
			end
			function _civButton:Think()
			
				if !self:IsHovered() then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.OriginalColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
					
					if self.DoMouseRelease then
					
						self.DoMouseRelease = false;
						
					end
					
				end
				
				if self:IsHovered() && 	!self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextBlack )
				
					return
				end
				
				if self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
				
					return
				
				end
				
			end	

		self.CivButtons = {}
		
		for i = 1 ,  3 do
		
			local _civButton = vgui.Create("DButton", panel )
			_civButton:SetPos( (panel:GetWide()* 0.5) + (_wMod * 100* i + ( 15*i ) )   , _hMod * 100 )
			_civButton:SetSize( _wMod * 100, _hMod * 50 )
			_civButton.ID = i;
			_civButton:SetText( "" )
			panel.CivButtons[i] = _civButton;
			_civButton.RelativeTextColor=Color( 255, 255 ,255 , _beginAlpha );
			_civButton.RelativeColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.OriginalColor	= Color( 56, 56 ,56, _tabAlpha );
			_civButton.HoveredColor 	= Color( 255, 255 , 255, _tabAlpha );
			_civButton.PressedColor 	= Color( 25, 25 , 25, _tabAlpha );
			_civButton.TextWhite = Color( 255, 255 ,255 , _beginAlpha );
			_civButton.TextBlack = Color( 56, 56 , 56, _beginAlpha );
			function _civButton:Paint( w, h )
			
				draw.RoundedBoxEx(0,0,0,w,h, _civButton.RelativeColor ,true,true)
				
				draw.SimpleText( _civButtonInformationTable[i][2], "Trebuchet6", w/2, h/2 , self.RelativeTextColor  ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
				
			end
			function _civButton:OnMousePressed( keyCode )
			
				self.DoMouseRelease = true; 
				
				mdl.DrawJobHalo = false;
				
				local _toSet;
				
				mdl.TeamSelected = _civButtonInformationTable[i][1];
					
				
				
			end
			
			function _civButton:OnMouseReleased( keyCode )
			
				self.DoMouseRelease = false;
			
			end
			function _civButton:Think()
			
				if !self:IsHovered() then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.OriginalColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
					
					if self.DoMouseRelease then
					
						self.DoMouseRelease = false;
						
					end
					
				end
				
				if self:IsHovered() && 	!self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextBlack )
				
					return
				end
				
				if self.DoMouseRelease then
				
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
					self.RelativeTextColor = lerpColor( 0.05, self.RelativeTextColor , self.TextWhite )
				
					return
				
				end
				
			end	
			
		end
		
		local InfoDisplay = {
		
			[1] = "HP " .. tostring(_p:Health() ) ;
			[2] = "Armor " .. tostring(_p:Armor() ) ;
			[3] = "Money " .. tostring(math.Round(_p:getMoney(),2) ) ;
			[4] = "Bank Money " .. tostring(math.Round(_p:getBank(),2) ) ;
			[5] = "Role-play Name " .. tostring( _p:getRPName() ) ;
			[6] = "Time-Played " ..  math.ceil((_p:GetTimePlayed()/60/60)) .. " hours. (" .. _p:GetPlaytimeTitle( ) .. ")" ;
			//[7] = "Paramedic Rank " .. tostring( fsrp.JobRanks[TEAM_PARAMEDIC][tonumber(_p:getFlag("jobPlaytimes", {[TEAM_PARAMEDIC] = {Rank = 1, Played = 0};[TEAM_POLICE] = {Rank = 1, Played = 0}} )[TEAM_PARAMEDIC].Rank)].name);
			//[8] = "Police Rank " ..tostring( fsrp.JobRanks[TEAM_POLICE][tonumber(_p:getFlag("jobPlaytimes", {[TEAM_PARAMEDIC] = {Rank = 1, Played = 0};[TEAM_POLICE] = {Rank = 1, Played = 0}} )[TEAM_POLICE].Rank)].name);
		}
		if _infoPanel then
		
			_infoPanel:Remove()
			
		end
		if sidePanel then
		
			sidePanel:Remove()
			
		end
		
		if charInfo then 
		
			charInfo:Remove()
			
		end
		InfoDisplay[6] = "Time-Played " ..  math.ceil((_p:GetTimePlayed()/60/60)) .. " hours. (" .. _p:GetPlaytimeTitle( ) .. ")";
		local _infoPanel = vgui.Create("DPanel", panel )
		_infoPanel:SetSize( 25,panel:GetTall() )
		_infoPanel:SetPos( panel:GetWide() - 25, 0 )
		
		
		local sidePanel = vgui.Create("DPanel", panel )
		sidePanel:SetSize( 25,panel:GetTall() )
		sidePanel:SetPos( panel:GetWide() - 25, 0 )
		
		
		local charInfo = vgui.Create("DPanel", panel )
		charInfo:SetSize( 600 * _wMod , panel:GetTall()	)
		charInfo:SetPos( (panel:GetWide()* 0.5) + (_wMod * 100* 1+ ( 15*1 ) ), _hMod * 175 )
		function charInfo:Paint(w,h)
		
			for k , v in pairs( InfoDisplay ) do
			
				draw.SimpleText( (InfoDisplay[k] &&  InfoDisplay[k]) , "Trebuchet20", 0,0 + k*40*_hMod , self.RelativeTextColor  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
			
			end
			
		end
		
		table.insert( self.CivButtons ,charInfo)
		table.insert( self.CivButtons ,sidePanel)
		table.insert( self.CivButtons ,_infoPanel)
			if LocalPlayer().__itemSlots then
		
				for k , v in pairs( LocalPlayer().__itemSlots ) do
				
					v:Remove()
					
				end
			
			else
			
				LocalPlayer().__itemSlots = {}
				
			end
		
		
		self.deletedOnClose[1] = mdl;
		if _p == LocalPlayer() then
			local _slotName = {
				[1] = "Primary";
				[2] = "Secondary";
				[3] = "Hat";
			
			}
			
			for i = 1, 3 do
			
				local _pnl = vgui.Create( "DButton" , panel )
				_pnl:SetPos( _wMod * 500 ,25*i + (_hMod * 130)* i )
				_pnl:SetSize( _wMod * 250 , _hMod * 125)
				_pnl.SlotID = i;
				_pnl:SetToolTip("Left Click to un-equip if you have a equiped weapon");
				_pnl:SetText("")
				
				function _pnl:Paint( w, h )
				
					surface.SetDrawColor( 255,255,255,255 )
					surface.DrawOutlinedRect( 0, 0 , w , h )
					draw.SimpleText( _slotName[i] , "Trebuchet20", w-_wMod*5,0 ,Color(128,128,128,128)  , TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )

				end
					
					_pnlMdl = vgui.Create( "DModelPanel", _pnl )
					_pnlMdl:SetSize( _pnl:GetWide(), _pnl:GetTall())
				if LocalPlayer():getFlag("itemSlot_" .. _pnl.SlotID ) then
					local _item = ITEMLIST[LocalPlayer():getFlag("itemSlot_" .. _pnl.SlotID )];
					_pnlMdl:SetMouseInputEnabled( false )
					_pnlMdl:SetModel( _item.Model )
					_pnlMdl:SetCamPos( _item.CamPos )
					_pnlMdl:SetLookAt(_item.LookAt )
					_pnlMdl:SetVisible(true)
		
				end
				_pnl.mdl = _pnlMdl;
				function _pnl:UpdateItemSlot()
				
							self.mdl:SetVisible(false)
				
							for k , v in pairs( LocalPlayer().__InvButtons ) do
							
								v:SetItemTable()
								
							end
							
						if LocalPlayer():getFlag("itemSlot_" .. self.SlotID ) then
							local _item = ITEMLIST[LocalPlayer():getFlag("itemSlot_" .. self.SlotID )];
							self.mdl:SetMouseInputEnabled( false )
							self.mdl:SetModel( _item.Model )
							self.mdl:SetCamPos( _item.CamPos )
							self.mdl:SetLookAt(_item.LookAt )
							self.mdl:SetVisible(true)
				
						end
							
				
				end
				
				function _pnl:OnMousePressed()
					
					self.mdl:SetVisible(false)
					if LocalPlayer():getFlag("itemSlot_" .. _pnl.SlotID ) then
					
						net.Start("slotAdjustment")
							net.WriteInt( i, 4 );
						net.SendToServer()
						timer.Simple( 0.1 , function() 
							
							for k , v in pairs( LocalPlayer().__InvButtons ) do
							
								v:SetItemTable()
								
							end
							
							if self.SlotID && LocalPlayer():getFlag("itemSlot_" .. self.SlotID ) then
									
								self.mdl:SetVisible(false)
									
									
							end
							
						end )
					end
					
				end
				
				table.insert( LocalPlayer().__itemSlots , _pnl );
				
			end
			
		end
		
	end
	
	return panel;
	
end


function MyBusinesses()
	
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)
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
	
	
		local _BusinessList = vgui.Create( "DScrollPanel", panel )
		_BusinessList:SetPos( _wMod * 25 , _hMod * 25 )
		_BusinessList:SetSize( panel:GetWide() - _wMod * 50 , panel:GetTall() - _hMod * 50 )
		
		_BusinessList.AddMaterial =  Material( "icon16/wrench.png" );
		_BusinessList.RemoveMaterial =  Material( "icon16/wrench.png" );
		_BusinessList.InformationMaterial =  Material( "icon16/information.png" );
		

		//if !fsrp.I_BusinessPropertyTable[_PropertyID] then return end			
		local _IDTData =  LocalPlayer():getFlag("DT_ID_Business_DATA" , {} )	
		local _IDEData = LocalPlayer():getFlag("EVO_ID_Business_DATA" , {} )	
		
		for k , v in pairs( fsrp.ClubhousePropertyTable ) do
			
			local _foundtag = false;

			for x , y in pairs(_IDTData)do
				if v.ClubHouseInformation && v.ClubHouseInformation.Tag == y then
					_foundtag = true;
				end
			end

			local _ourmat = nil
			local _pre = "fsrp";
			local _fileformat = ( game.GetMap() == "rp_evocity_v33x" && "png" || "jpg" ) ;
			local _mattouse = nil;
			if _foundtag == true then
				if v.Mat then
				
					_ourmat = v.Mat;
					

					_mattouse =   Material( "properties/" .. _ourmat );
					
				end
				local _Bar = _BusinessList:Add( "DPanel" )
				//_Bar:SetText( v.Name )
				_Bar:Dock( TOP )
				_Bar:SetSize( _BusinessList:GetWide() ,  _hMod * 200 )
				_Bar:DockMargin( 0, 0, 0, 18 )
				_Bar.ID = k;
				_Bar.Skill = v;	
				_Bar.Min = 0;
				_Bar.Max = 300;
				_Bar.Value = 0// math.Clamp( LocalPlayer():getFlag( "businessCD_" .. k , 0 ), 0 , 300 ) // max points
				_Bar.TrueValue = 0;
				
				_barImage = vgui.Create("DPanel", _Bar)
				_barImage:SetSize(_wMod * 225 , _hMod * 190 )
				_barImage:SetPos( _wMod* 20, _hMod * 5 )
				_barImage.Mat = _mattouse;
				
				function _barImage:Paint(w,h)
					if self.Mat then
						surface.SetDrawColor(255,255,255)
						surface.SetMaterial(self.Mat)
						surface.DrawTexturedRect(0,0,w,h)
					end
				end
				function _Bar:Update()
				
					_Bar.Value = 0//math.Clamp( LocalPlayer():getFlag( "businessCD_" .. k , 0  ) , 0 , 300 ); 
				
				end 
				/*

				_Bar._SupplyButton = vgui.Create("DButton", _Bar)
				_Bar._SupplyButton:SetSize( _wMod*300,_hMod*90)
				_Bar._SupplyButton:SetText( "Supply" )
				_Bar._SupplyButton:SetText("")
				_Bar._SupplyButton:SetPos( _Bar:GetWide() - _Bar._SupplyButton:GetWide()-_wMod*25 , _hMod*7.5)

				function _Bar._SupplyButton:OnMousePressed()
				
					_Bar._SupplyButton.Clicked = true;
					
				end
				
				function _Bar._SupplyButton:OnMouseReleased()
					_Bar._SupplyButton.Clicked = nil;
					
				end

				function _Bar._SupplyButton:OnCursorExited()
					_Bar._SupplyButton.DoHover = nil;
					
				end

				function _Bar._SupplyButton:OnCursorEntered()
					_Bar._SupplyButton.DoHover = true;
					
				end

				function _Bar._SupplyButton:Paint( w , h )
					local _Col = Color(25,25,25,225);

					if _Bar._SupplyButton.Clicked then
					
						_Col =Color(25,225,25,225)
						
					elseif _Bar._SupplyButton.DoHover then

						_Col =Color(225,25,25,225)

					end
					
					draw.RoundedBoxEx(0,0,0, w,h,_Col ,true,true)									
					draw.SimpleText( "Supply", "Trebuchet24", w/2,h/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )

				end
				
				_Bar._DeliverButton = vgui.Create("DButton", _Bar)
				_Bar._DeliverButton:SetSize( _wMod*300,_hMod*90 )
				_Bar._DeliverButton:SetText("")
				_Bar._DeliverButton:SetPos( _Bar:GetWide() - _Bar._DeliverButton:GetWide()-_wMod*25 , _hMod*102.5 )

				function _Bar._DeliverButton:OnMousePressed()
				
					_Bar._DeliverButton.Clicked = true;
					
				end
				
				function _Bar._DeliverButton:OnMouseReleased()
					_Bar._DeliverButton.Clicked = nil;
					
				end

				function _Bar._DeliverButton:OnCursorExited()
					_Bar._DeliverButton.DoHover = nil;
					
				end

				function _Bar._DeliverButton:OnCursorEntered()
					_Bar._DeliverButton.DoHover = true;
					
				end

				function _Bar._DeliverButton:Paint( w , h )
					local _Col = Color(25,25,25,225);
					
					if _Bar._DeliverButton.Clicked then
					
						_Col =Color(25,225,25,225)
						
					elseif _Bar._DeliverButton.DoHover then

						_Col =Color(225,25,25,225)

					end
					
					draw.RoundedBoxEx(0,0,0, w,h,_Col ,true,true)									
					draw.SimpleText( "Deliver Goods", "Trebuchet24", w/2,h/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )

				end
				
				*/

				function _Bar:Think( )
				
					if _Bar.Value != _Bar.TrueValue then
					
						_Bar.TrueValue = Lerp( 0.05,  _Bar.TrueValue , ( _Bar.Value - CurTime()) );
				
					end
					
				end
				_Bar.PropData = v;

				function _Bar:Paint( w , h )
					
					if !self._IsWorking then
					
						self._IsWorking = LocalPlayer():getFlag( "businessCD_" .. k , 0 ) > CurTime() && true || false;
					
					end
					
					//local _IsWorkingText = ( IsValid( _IsWorking ) && "(Currently at work)" || "(Send to Work)" );
					
					surface.SetFont( "Trebuchet20" );
					local x, y = surface.GetTextSize( _Bar.Skill.Name )
					
					draw.RoundedBoxEx(0,0,0,w,h,Color(50,50,120,panel._tabAlpha),true,true)	
					draw.RoundedBoxEx(0,5,5,w-10,h-10,Color(56,56,56,panel._tabAlpha),true,true)	
					
					//self:Update();
					
					
					local alpha = math.Clamp( _Bar.TrueValue / _Bar.Max , 0, 1 );

					draw.RoundedBoxEx(0,5,5, (w * alpha) -10 ,h-10,Color(225,100,100,panel._tabAlpha),true,true)	
					

					draw.SimpleText( _Bar.Skill.Name  , "Trebuchet24", _wMod*260, y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

					draw.SimpleText( self.PropData.ClubHouseInformation.Desc  , "Trebuchet24", _wMod*260, y+y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

				end
				
				
				_Bar:Update();			

			end
		end

		_IDTData =  LocalPlayer():GetBusiness(true)		
		_IDEData = LocalPlayer():GetBusiness()
		local _activetable = _IDTData;

		local _diffmap = false;
			for k , v in pairs( fsrp.I_BusinessPropertyTable  ) do
				
				local _foundtag = false;
				local _playerData = 0;
				for x , y in pairs(_IDTData)do
					if v.BusinessInformation && v.BusinessInformation.Tag == y[2] then
						
						_foundtag = true;
						_diffmap = game.GetMap() == "rp_downtown_v4c_v2" && false || true;
						_playerData = x;

					end
				end
				for x , y in pairs(_IDEData)do
					if v.BusinessInformation && v.BusinessInformation.Tag == y[2] then
						
						_foundtag = true;
						_diffmap = game.GetMap() == "rp_downtown_v4c_v2" && false || true;
						_playerData = x;

					end
				end


				_diffmap = v.DifferentMap && true or false;
				local _ourmat = nil
				local _pre = "fsrp";
				local _fileformat = ( game.GetMap() == "rp_evocity_v33x" && "png" || "jpg" ) ;
				local _mattouse = nil;

				if _foundtag == true then

					if v.Mat then
					
						_ourmat = v.Mat;
						
						_mattouse =   Material( "/properties/" .. _ourmat );
						
					end
	
					local _Bar = _BusinessList:Add( "DPanel" )
					//_Bar:SetText( v.Name )
					_Bar:Dock( TOP )
					_Bar:SetSize( _BusinessList:GetWide() ,  _hMod * 200 )
					_Bar:DockMargin( 0, 0, 0, 18 )
					_Bar.ID = k;
					_Bar.Skill = v;	
					_Bar.Min = 0;
					_Bar.Max = 300;
					_Bar.Value = 0// math.Clamp( LocalPlayer():getFlag( "businessCD_" .. k , 0 ), 0 , 300 ) // max points
					_Bar.TrueValue = 0;
					_Bar.DiffMap = _diffmap;
					_barImage = vgui.Create("DPanel", _Bar)
					_barImage:SetSize(_wMod * 225 , _hMod * 190 )
					_barImage:SetPos( _wMod* 20, _hMod * 5 )
					_barImage.Mat = _mattouse;
					
					function _barImage:Paint(w,h)
						if self.Mat then
							surface.SetDrawColor(255,255,255)
							surface.SetMaterial(self.Mat)
							surface.DrawTexturedRect(0,0,w,h)
						end
					end
					
					function _Bar:Update()
					
						_Bar.Value = 0//math.Clamp( LocalPlayer():getFlag( "businessCD_" .. k , 0  ) , 0 , 300 ); 
					
					end 
					
					_Bar._UpgradeButton = vgui.Create("DButton", _Bar)
					_Bar._UpgradeButton:SetSize( _wMod*300,_hMod*50)
					_Bar._UpgradeButton:SetText( "Supply" )
					_Bar._UpgradeButton:SetText("")
					_Bar._UpgradeButton:SetPos( _Bar:GetWide() - _Bar._UpgradeButton:GetWide()-_wMod*25 , _hMod*7.5)

					function _Bar._UpgradeButton:OnMousePressed()
					
						_Bar._UpgradeButton.Clicked = true;
						BusinessUpgradePanel(_playerData)
						FRAME:Close()
					end
					
					function _Bar._UpgradeButton:OnMouseReleased()
						_Bar._UpgradeButton.Clicked = nil;
						
					end

					function _Bar._UpgradeButton:OnCursorExited()
						_Bar._UpgradeButton.DoHover = nil;
						
					end

					function _Bar._UpgradeButton:OnCursorEntered()
						_Bar._UpgradeButton.DoHover = true;
						
					end

					function _Bar._UpgradeButton:Paint( w , h )
						local _Col = Color(25,25,25,128);
						
						if _Bar._UpgradeButton.Clicked then
						
							_Col =Color(25,225,25,128)
							
						elseif _Bar._UpgradeButton.DoHover then

							_Col =Color(225,25,25,128)

						end

						draw.RoundedBoxEx(0,0,0, w,h,_Col ,true,true)									
						draw.SimpleText( "Upgrade", "Trebuchet24", w/2,h/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )

					end
					if _activetable[_playerData][8] and _activetable[_playerData][8][4] and _activetable[_playerData][8][4][2] then
						local _businessTypeInformation = fsrp.config.IllegalBusinessTypes[v.BusinessInformation.Type];
						local _count = 1;

						for x ,y in pairs( _activetable[_playerData][8][4][2] ) do
						
							if cnQuests[y]  then

								local _niconp = vgui.Create("DPanel",_Bar)
								_niconp:SetPos(_wMod*150 + (_count*300), _hMod*50)
								_niconp:SetSize(_wMod*300,_hMod*128)
								
								function _niconp:Paint( w , h )									

									//draw.RoundedBoxEx(0,_wMod* 50,_hMod*50,_wMod*150,_hMod*150,Color(56,56,56,128) ,true,true)									
									draw.SimpleText( cnQuests[y].name, "Trebuchet24", w/2,_hMod*8, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )

								end

								local _nicon = vgui.Create("DModelPanel",_niconp)
								_nicon:SetSize(_wMod*128,_hMod*128)
								_nicon:SetPos(_wMod*86,_hMod*5)

								_nicon:SetModel( tostring( cnQuests[y].model) )


								_count = _count +1
							
							end
						end
						
					end	
					
					local _residingBusiness = LocalPlayer():getFlag("ResidingInControlledProperty", 0);
					
					if !_diffmap  &&  _activetable[_playerData] && !_activetable[_playerData][8] and (v.ID == _residingBusiness)then

						if _activetable[_playerData][3] && _activetable[_playerData][3] < 4 then

							_Bar._SupplyButton = vgui.Create("DButton", _Bar)
							_Bar._SupplyButton:SetSize( _wMod*300,_hMod*50)
							_Bar._SupplyButton:SetText( "Supply" )
							_Bar._SupplyButton:SetText("")
							_Bar._SupplyButton:SetPos( _Bar:GetWide() - _Bar._SupplyButton:GetWide()-_wMod*25 , _hMod*74)

							function _Bar._SupplyButton:OnMousePressed()
							
								_Bar._SupplyButton.Clicked = true;
								BusinessMissionSelection(_playerData,1)
								FRAME:Close()
								
							end
							
							function _Bar._SupplyButton:OnMouseReleased()
								_Bar._SupplyButton.Clicked = nil;
								
							end

							function _Bar._SupplyButton:OnCursorExited()
								_Bar._SupplyButton.DoHover = nil;
								
							end

							function _Bar._SupplyButton:OnCursorEntered()
								_Bar._SupplyButton.DoHover = true;
								
							end

							function _Bar._SupplyButton:Paint( w , h )
								local _Col = Color(25,25,25,128);
								
								if _Bar._SupplyButton.Clicked then
								
									_Col =Color(25,225,25,128)
									
								elseif _Bar._SupplyButton.DoHover then

									_Col =Color(225,25,25,128)

								end

								draw.RoundedBoxEx(0,0,0, w,h,_Col ,true,true)									
								draw.SimpleText( "Supply", "Trebuchet24", w/2,h/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )

							end
						end
						if _activetable[_playerData][4] && _activetable[_playerData][4] > 0 then
							_Bar._DeliverButton = vgui.Create("DButton", _Bar)
							_Bar._DeliverButton:SetSize( _wMod*300,_hMod*50 )
							_Bar._DeliverButton:SetText("")
							_Bar._DeliverButton:SetPos( _Bar:GetWide() - _Bar._DeliverButton:GetWide()-_wMod*25 , _hMod*(141.5) )

							function _Bar._DeliverButton:OnMousePressed()
							
								_Bar._DeliverButton.Clicked = true;
								BusinessMissionSelection(_playerData,3)
								FRAME:Close()
							end
							
							function _Bar._DeliverButton:OnMouseReleased()
								_Bar._DeliverButton.Clicked = nil;
								
							end

							function _Bar._DeliverButton:OnCursorExited()
								_Bar._DeliverButton.DoHover = nil;
								
							end

							function _Bar._DeliverButton:OnCursorEntered()
								_Bar._DeliverButton.DoHover = true;
								
							end

							function _Bar._DeliverButton:Paint( w , h )
								local _Col = Color(25,25,25,128);
								
								if _Bar._DeliverButton.Clicked then
								
									_Col =Color(25,225,25,128)
									
								elseif _Bar._DeliverButton.DoHover then

									_Col =Color(225,25,25,128)

								end						
								
								draw.RoundedBoxEx(0,0,0, w,h,_Col ,true,true)									
								draw.SimpleText( "Cash Out Goods", "Trebuchet24", w/2,h/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )

							end
							
						end
					end
					
					function _Bar:Think( )
					
						if _Bar.Value != _Bar.TrueValue then
						
							_Bar.TrueValue = Lerp( 0.05,  _Bar.TrueValue , ( _Bar.Value - CurTime()) );
					
						end
						
					end
								
					_Bar.Data = _activetable[_playerData];

					function _Bar:Paint( w , h )
						
						if !self._IsWorking then
						
							self._IsWorking = LocalPlayer():getFlag( "businessCD_" .. k , 0 ) > CurTime() && true || false;
						
						end
						
						//local _IsWorkingText = ( IsValid( _IsWorking ) && "(Currently at work)" || "(Send to Work)" );
						
						surface.SetFont( "Trebuchet20" );
						local x, y = surface.GetTextSize( _Bar.Skill.Name )
						
						draw.RoundedBoxEx(0,0,0,w,h,Color(225,150,0,panel._tabAlpha),true,true)	
						draw.RoundedBoxEx(0,5,5,w-10,h-10,Color(56,56,56,panel._tabAlpha),true,true)	
						
						//self:Update();
						
						
						local alpha = math.Clamp( _Bar.TrueValue / _Bar.Max , 0, 1 );

						draw.RoundedBoxEx(0,5,5, (w * alpha) -10 ,h-10,Color(225,100,100,panel._tabAlpha),true,true)	
						local _wcount =1;
						draw.SimpleText( _Bar.Skill.Name  , "Trebuchet24", _wMod*(60+_wcount*200) , y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						//_wcount = _wcount+1
						if self.Data then
							local count = 1;

							draw.SimpleText( "Supply Left: #" .. self.Data[3]  , "Trebuchet24", _wMod*(60+_wcount*200), (y*count)+y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
							
							count = count+1
							draw.SimpleText( "Production: #" .. self.Data[4] , "Trebuchet24", _wMod*(60+_wcount*200), (y*count)+y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
							
						    if self.Data[8] && istable(self.Data[8]) && #self.Data[8] > 0 then
								count = count+1
								draw.SimpleText( "Deliver to:" , "Trebuchet24", _wMod*(60+_wcount*200), (y*count)+y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
							end
							_wcount = _wcount+1

						    if self.Data[6] && istable(self.Data[6]) && #self.Data[6] > 0 then

								count = count+1
								draw.SimpleText( "Upgrades:"  , "Trebuchet24", _wMod*(60+_wcount*200), (y*1)+y/2, Color( 225, 255 ,225 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						    	local _count = 1;
						    	_wcount = _wcount+1
						    	for x,y in pairs(self.Data[6]) do
						    		if  v.BusinessInformation.Upgrades[x] then
										draw.SimpleText( v.BusinessInformation.Upgrades[x].Name , "Trebuchet24", _wMod*(60+_wcount*200),_hMod*(24+ (_count*30)), Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
										_count = _count+1;
									end
						    	end
						    	_wcount = _wcount+1
						    end

						    local _mis = self.Data[7]
						    local _trgt = fsrp.config.SupplyMissions

						    if self.Data[5] and istable(self.Data[5]) then

						    	_mis = self.Data[5];
						    	_trgt = fsrp.config.InitMissions

						    end

						    if _mis and istable(_mis) && _mis[1]  then

						    	if !_mis[4][1] then
							    	local _loc = _trgt[_mis[1]]

									if _loc and _loc.location then 
										draw.SimpleText(  "Active Supply Drop Area: " .. BonfireTaxis.Config[_loc.location[1]][_loc.location[2]].name , "Trebuchet24", _wMod*(60+_wcount*200), y/2, Color( 255, 225 ,225 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
										surface.SetDrawColor(255,255,255,255)
										surface.SetMaterial( BonfireTaxis.Config[_loc.location[1]][_loc.location[2]].mat )
										surface.DrawTexturedRect(_wMod*(60+_wcount*200),_hMod*50,_wMod*250,_hMod*125)
							    		_wcount = _wcount+1
									end
								else
									draw.SimpleText(  "Supply Drop Completed, return to the business.", "Trebuchet24", _wMod*(60+_wcount*200), y/2, Color( 225, 255 ,225 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

								end
							end
						end
					end
					
					
					_Bar:Update();
				end

			end
	end
	
	return panel;
	
end

function DevCycle()
	
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,panel._tabAlpha),true,true)	
		draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
	end
	
	if IsValid( panel.webDock ) then
		panel.webDock:Remove()
	end
	
	if !ispanel( panel.webDock ) then
	
		panel.webDock = vgui.Create( "HTML", panel )
		panel.webDock:Dock( FILL )
		panel.webDock:OpenURL( "https://trello.com/b/CBCrK2mg/560roleplay-gamemode" )
	
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
	
		 
		self.webDock:Refresh( true )
	
	end
	
	
	return panel;
	
end

function Quests()
	
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
		//draw.RoundedBoxEx(1,5,5,w - 10,h - 10,Color(25,25,25,panel._tabAlpha),true,true)	
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
		local _quests = LocalPlayer():getFlag( "questTable", {} );
	
		local _QuestInformationPanel = vgui.Create("DPanel", panel)
		_QuestInformationPanel:SetSize(panel:GetWide()/2,panel:GetTall())
		_QuestInformationPanel:SetPos(panel:GetWide()/2,0)	
		
		function _QuestInformationPanel:Paint( w, h ) 
		
			draw.RoundedBoxEx( 0,0,0,w,h,Color(75,75,75,panel._tabAlpha ) )
			
			if self.Quest then
			
				local _completion = _quests[self.Quest.ID];
				local _col = Color(255,255,255);
				local _pret = "[Incompleted]\t"
				if _completion.Completed && _completion.Completed == true then
					_col = Color(128,225,128,255)
					_pret = "[Completed]\t"
				else
					if _completion.Step > 1 then
						draw.SimpleText( "Current Step: " .. self.Quest.Desc[_completion.Step], "Trebuchet6", 25, 75 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
					end
				end
				draw.SimpleText( _pret.. self.Quest.Name , "Trebuchet24", 25, 25 , _col ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
				draw.SimpleText( "Description: " .. self.Quest.Desc[1], "Trebuchet6", 25, 90 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
				local _revc = 1;
				for k , v in pairs(self.Quest.RewardTable) do
					
					if k == 'money' then
						draw.SimpleText( "Reward Money: $" .. v, "Trebuchet6", 25, 90+(_revc*25) , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						_revc = _revc+1;
					end
					if k == 'xp' then
						if RotoLevelSystem.config.PerkTrees[v.id] then
							draw.SimpleText( "Reward XP: " .. RotoLevelSystem.config.PerkTrees[v.id].Name .. " +" .. v.xp .. "xp", "Trebuchet6", 25, 90+(_revc*25) , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
							_revc = _revc+1;
						end
					end					
					if k == 'items' then
						draw.SimpleText( "Reward Items:", "Trebuchet6", 275, 90+(_revc*25) , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						
						for x,y in pairs(v) do
							local _id = y[1];
							local _am = y[2];
							draw.SimpleText( ITEMLIST[_id].Name .. " x" .. _am, "Trebuchet6", 275, 90+((x+1)*25) , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						end
					end
					if k == 'misc' then 
						for x,y in pairs(v) do
							local _id = y[1];
							local _am = y[2];
							draw.SimpleText( y, "Trebuchet6", 275, 90+((x+1)*25) , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						end
					end

				end			

				if self.MaterialToShow then

					surface.SetDrawColor(255,255,255,255)
					surface.SetMaterial(self.MaterialToShow)
					surface.DrawTexturedRect(0,h/2,w,h/2)
				end
				
			
			else			
				draw.SimpleText( "Nothing Selected", "Trebuchet24", 25, 25 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
				draw.SimpleText( "Chose a quest on the left to continue!" , "Trebuchet6", 25, 75 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
			end
			
		end
		
		local _QuestListPanel = vgui.Create("DPanel", panel)
		_QuestListPanel:SetSize(panel:GetWide()/2,panel:GetTall())
		_QuestListPanel.InformationPanel = _QuestInformationPanel;
		function _QuestListPanel:Paint( w, h ) 
		
			draw.RoundedBoxEx( 0,0,0,w,h,Color(25,25,25,panel._tabAlpha ) )
						
		end

		local _QuestList = vgui.Create("DScrollPanel",_QuestListPanel)
		_QuestList:Dock(FILL)
		_QuestList.QuestListPanel = _QuestListPanel
		for k ,v in pairs(QUEST_TABLE) do
			if _quests[k] then
				local _questinfo = v;

				local _questToShow = _QuestList:Add("DPanel");
				_questToShow:SetTall(_hMod*100)
				_questToShow:Dock(TOP)
				_questToShow.Quest = v;

				_questToShow.QuestList = _QuestList;
				
				function _questToShow:Paint( w, h ) 
		
					draw.RoundedBoxEx( 0,0,0,w,h,Color(56,56,56,panel._tabAlpha ) )
					draw.RoundedBoxEx( 0,_wMod*5,_hMod*5,w-_wMod*10,h-_hMod*10,Color(75,75,75,panel._tabAlpha ) )

					draw.RoundedBoxEx( 0,w/4*3,_hMod*5,w/4*1-_wMod*10,h-_hMod*10,Color(128,128,128,panel._tabAlpha ) )
					surface.SetFont("Trebuchet24")
					local _w, _x = surface.GetTextSize(self.Quest.Name);
					draw.SimpleText( self.Quest.Name , "Trebuchet24",_wMod*20, h/2 -_x/2, Color(255,255,255) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
					

					local _w, _x = surface.GetTextSize("Select");
					draw.SimpleText( "Select" , "Trebuchet24",w/2*1.75-_w/2-_wMod*1, h/2 -_x/2, Color(255,255,255) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
		
				end
				function _questToShow:OnCursorEntered()
					_quests = LocalPlayer():getFlag( "questTable", {} );
					self.QuestList.QuestListPanel.InformationPanel.Quest = self.Quest;
					if v.Location then
						if BonfireTaxis.Config[game.GetMap()] and BonfireTaxis.Config[game.GetMap()][v.Location[game.GetMap()]] and BonfireTaxis.Config[game.GetMap()][v.Location[game.GetMap()]].mat then 
							local _mat = BonfireTaxis.Config[game.GetMap()][v.Location[game.GetMap()]].mat
							if _mat then
								self.QuestList.QuestListPanel.InformationPanel.MaterialToShow = _mat
							end
						end
					end
				end
				
			end
		end

	end
	
	return panel;
	
end


function MyInventory()
	
	
	local _p = LocalPlayer();
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
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
	
		local _rarityColors = {
			[0] = Color(255,255,255);
			[1] = Color(51, 204, 51);
			[2] = Color(0, 102, 255);
			[3] = Color(204, 0, 153);
			[4] = Color(255, 153, 51);
			[5] = Color(255, 204, 255);
		}
	function panel:RefreshInformation( )
		
/*
		if InventoryInformationBox && InventoryInformationBox.ModelBox then
			InventoryInformationBox.ModelBox:Remove()
			InventoryInformationBox.ModelBox = nil;
			InventoryInformationBox:Remove()
			InventoryInformationBox = nil;

		elseif InventoryInformationBox then
			InventoryInformationBox:Remove()
			InventoryInformationBox = nil;
		end*/

		if self.ScrollPanel then
			if self.ScrollPanel.Grid then
				for k , v in pairs( self.ScrollPanel.Grid:GetChildren() ) do
					v:SetItemTable()
				end
			end
			--self.ScrollPanel:Remove();
			--self.ScrollPanel = nil;

			return
		end
		self:Clear();
		local scrollPanel = vgui.Create( "DScrollPanel" , panel)

		self.ScrollPanel = scrollPanel
		//scrollPanel:SetSize(panel:GetWide() / 2 - _wMod * 110,panel:GetTall() )
		//scrollPanel:SetPos( 0, 0 )
		
		scrollPanel:SetPos( _wMod * 25 , _hMod * 100 )
		
		scrollPanel:SetSize( panel:GetWide() /2 - _wMod * 50 , panel:GetTall() - _hMod * 200 )
		local grid = vgui.Create( "DGrid", scrollPanel )
		scrollPanel.Grid = grid;
		grid:SetPos( _wMod * 5 , _hMod * 5 )
		grid:SetCols( 7 )
		grid:SetColWide( _wMod * 110 )
		grid:SetRowHeight( _hMod * 110 )
		local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
		
		local InventoryInformationBox = vgui.Create( "DPanel" , panel )
		
		InventoryInformationBox.ModelBox = vgui.Create( "DModelPanel", InventoryInformationBox )
		InventoryInformationBox.ModelBox:SetSize( 500 , 500 )
		InventoryInformationBox.ModelBox:SetPos( 0 ,50 )
		
		//InventoryInformationBox:SetPos( _wMod * 775, _hMod * 25 )
		//InventoryInformationBox:SetSize( _wMod * 960 , _hMod * 670 )
		InventoryInformationBox:SetSize( panel:GetWide() /2 - _wMod * 50 , panel:GetTall() - _hMod * 200 )
		InventoryInformationBox:SetPos( panel:GetWide() /2 - _wMod * 25  , _hMod * 100 )
		InventoryInformationBox.SlotID = 0;
		
		function InventoryInformationBox:RefreshSlot( id )
			
		local _Inventory = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
		
			if _Inventory then
			
				if _Inventory[id] && _Inventory[id] && _Inventory[id].Amount >= 1 then
					self:Show()
					self.SlotID = id;
					self.InventoryItem = ITEMLIST[_Inventory[id].ID];
					self.Amount = _Inventory[id].Amount;
					self.ModelBox:SetModel( self.InventoryItem.Model );
					self.ModelBox:SetLookAt( self.InventoryItem.LookAt );
					self.ModelBox:SetCamPos( self.InventoryItem.CamPos );
					
					if self.InventoryItem.Scale then
						self.ModelBox.Entity:SetModelScale(self.InventoryItem.Scale);
					end
					if self.InventoryItem.Skin then
						self.ModelBox.Entity:SetSkin(self.InventoryItem.Skin);
					end
				else
					self:Hide()
				
				end
			
			end
			
		end
		
		function InventoryInformationBox:Paint( w, h ) 
		
			draw.RoundedBoxEx( 0,0,0,w,h,Color(25,25,25,panel._tabAlpha ) )
			
			if self.InventoryItem then
			
				draw.SimpleText( self.InventoryItem.Name  .. " (x" .. self.Amount .. ")", "Trebuchet24", 25, 25 ,_rarityColors[self.InventoryItem.Quality] or Color(255,255,255)  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
				draw.SimpleText( self.InventoryItem.Description, "Trebuchet6", 25, 75 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
		
			else
			
				draw.SimpleText( "Nothing Selected", "Trebuchet24", 25, 25 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
				draw.SimpleText( "Chose an item on the left to continue!" , "Trebuchet6", 25, 75 , Color( 255, 255 ,255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
		
			
			end
			
		end
		/*
		_usebutton = vgui.Create("DButton", InventoryInformationBox)
		_usebutton:SetText( "Use Item" )
		_usebutton:SetPos( 25 , 100 )
		function _usebutton:DoClick()
		local _Inventory = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
			if _Inventory && InventoryInformationBox.SlotID != 0 then
				
				net.Start("useItemAtIndex")
					net.WriteInt( InventoryInformationBox.SlotID, 6 )
					net.WriteInt(  _Inventory[InventoryInformationBox.SlotID].ID, 8 );
				net.SendToServer()
				timer.Simple( .25, function() 
					InventoryInformationBox:RefreshSlot( InventoryInformationBox.SlotID )
					
					for k , v in pairs( scrollPanel._invButtons ) do
					
						v:SetItemTable()
						
					end

				end)
			
			end
			
		end
		
		
		_dropbutton = vgui.Create("DButton", InventoryInformationBox)
		_dropbutton:SetPos( 25 , 125 )
		_dropbutton:SetText( "Drop Item" )
		function _dropbutton:DoClick()
		
		local _Inventory = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
			
			if _Inventory && InventoryInformationBox.SlotID != 0 then
				
				net.Start("dropItemAtIndex")
					net.WriteInt( InventoryInformationBox.SlotID, 6 )
					net.WriteInt(  _Inventory[InventoryInformationBox.SlotID].ID, 8 );
				net.SendToServer()
				timer.Simple( .25, function() 
					InventoryInformationBox:RefreshSlot( InventoryInformationBox.SlotID )
					
					for k , v in pairs( _Inventory ) do
					
						for k , v in pairs( scrollPanel._invButtons ) do
						
							v:SetItemTable()
							
						end
						
					end
				end)
				
			end
			
		end
		*/
	//print(LocalPlayer():getFlag("inventory", nil ))
	function scrollPanel:RefreshInventorySlots()
		
				
		local _Inventory = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
			
		if !_Inventory then return end
		
		if !self._invButtons then
			self._invButtons = {};
		

			for i =1, MAX_SLOTS do
				
				
				local _button = vgui.Create("inventoryitem", scrollPanel)
				local _amount = 1;
				if _Inventory[i] && _Inventory[i].Amount then
					_amount = _Inventory[i].Amount;
				end
				
				_button:SetText( "ID at " .. i .. " Amount: " .. _amount )
				_button.TargetUI = InventoryInformationBox;
				_button.AllButtons = self._invButtons;
					
				_button.ID = ( i )
				_button:SetItemTable(  ) 
				
								
				_button:SetSize( _wMod * 100, _hMod * 100 )
				
				grid:AddItem( _button )
				
				table.insert( self._invButtons , _button )
				
			end
			
			
		end
		LocalPlayer().__InvButtons = self._invButtons;
		
	end
		scrollPanel:RefreshInventorySlots()
		/* 
		local scrollPanel = vgui.Create( "DScrollPanel" , panel)
		scrollPanel:SetSize(panel:GetWide() ,panel:GetTall() )
		scrollPanel:SetPos( 0, 0 )
			
		local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
		
		_p.InventoryBlocks =  _p.InventoryBlocks || {}
		_p.InventoryBlocks_Linear = _p.InventoryBlocks_Linear || {}

			local i  = 0;
			
			local buttonSize = ( ScrH() == 2160 ) && 175 || ( ScrH() == 1080 ) && 75 || ( ScrH() == 720 ) && 45 || 50;

			for x =1, fsrp.config.InventoryWSlots do
				_p.InventoryBlocks[x] = {}
				
				i = 0;
				for y = 1, fsrp.config.InventoryYSlots do
					_p.InventoryBlocks[x][y] = vgui.Create("inventoryitem", scrollPanel)
				
					
					_p.InventoryBlocks[x][y]:SetInventorySlot( (i*10) + x )
					_p.InventoryBlocks[x][y].ID = ( (i*10) + x )
					
					
					
					_p.InventoryBlocks[x][y]:SetPos(x * buttonSize + 30 * x, y * buttonSize + 30 * y)
					_p.InventoryBlocks_Linear[_p.InventoryBlocks[x][y]] = _p.InventoryBlocks[x][y]

					i = i + 1
				end
				
			end
			*/
		
		end
	
	
	return panel;
	
end

function Crafting()
	
	local _p = LocalPlayer();
	
	local _RecipeTabs = {};
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
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
		
		local _PlayerInventory = _p:GetTotalAmountInv() ;
		local _RecipeInformationPanel = vgui.Create( "DPanel", panel )

		local _CraftButton = vgui.Create( "DButton" , _RecipeInformationPanel )
		_CraftButton:SetPos( _wMod * 25 , _hMod * 50 )
		_CraftButton:SetSize( _wMod * 100 , _hMod * 100 )
		_CraftButton:SetText( "Craft Item" )
		_CraftButton:SetFont("Trebuchet6")
		_CraftButton.ToCraft = 1;
		_CraftButton:SetEnabled(false)
		function _CraftButton:DoClick( )
		
			net.Start("sendCraftRequest")
			net.WriteInt( self.ToCraft, 16 )
			net.SendToServer()
			self:SetEnabled(false)
			timer.Simple( .25, function() 
			for k , v in pairs( LocalPlayer().__InvButtons ) do 
				v:SetItemTable() 
			end
				self:SetEnabled(true) 
			end );
			
		
		end
		
		local _CraftingPanel = vgui.Create("DModelPanel",_RecipeInformationPanel)
		//_CraftingPanel:SetSize(_RecipeInformationPanel:GetWide() - (_wMod*100) , _RecipeInformationPanel:GetTall() - (_hMod *100))
		//_CraftingPanel:SetPos(_wMod*50,_hMod*50)
		_CraftingPanel:Dock(FILL)
		_CraftingPanel:DockMargin(_wMod* 25,_hMod*160,_wMod*25,_hMod*20)
		_CraftingPanel:SetVisible(false)
		_RecipeInformationPanel.CraftPanel = _CraftingPanel
		
		_RecipeInformationPanel:SetSize( panel:GetWide() /2 - _wMod * 50 , panel:GetTall() - _hMod * 200 )
		_RecipeInformationPanel:SetPos( panel:GetWide() /2 - _wMod * 25  , _hMod * 100 )
		function _RecipeInformationPanel:Paint( w , h )
		
			draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
			
			if !_RecipeInformationPanel.RecipeID then return end
			
			draw.SimpleText( "Required Skills:\t\t\t\t\t\t\t\tRequired Items:" , "Trebuchet24", _wMod * 200, _hMod * 50 , Color( 255, 255 ,255 , 255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
		end
						
		_SelectedRecipeItemRequirement = vgui.Create( "DScrollPanel", _RecipeInformationPanel )
		_SelectedRecipeItemRequirement:SetPos( _wMod * 500, _hMod *  75  )
		_SelectedRecipeItemRequirement:SetSize( _wMod * 150 , _hMod * 75   )
		
		function _SelectedRecipeItemRequirement:SetRecipe( id, known )
		
			local _Recipe = fsrp.RecipeTable.AllRecipeList[id]
			_CraftButton.ToCraft = id;
			
			for k , v in pairs( _Recipe.RequiredItems ) do
			
				if _PlayerInventory[v[1]] &&  _PlayerInventory[v[1]].Amount < v.amount then
				
					_CraftButton:SetEnabled( false )
				
				else
					
					_CraftButton:SetEnabled( true )
				
				end
				local _SelReqItemLabel = _SelectedRecipeItemRequirement:Add( "DLabel" )
		
				_SelReqItemLabel:Dock( TOP )
				_SelReqItemLabel:SetSize( 30 , _hMod * 25 )
				_SelReqItemLabel:SetFont("Trebuchet6")
				_SelReqItemLabel:DockMargin( 0, 0 , 0 , 5 )
				_SelReqItemLabel:SetText( ITEMLIST[v.id].Name .. "  #" .. v.amount )
				_SelReqItemLabel:SetTextColor( ( _PlayerInventory[v.id] &&  _PlayerInventory[v.id].Amount >= v.amount )  && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )

				/*
				function _SelReqItemLabel:Think(  )

					_SelReqItemLabel:SetTextColor( ( _PlayerInventory[v.id] &&  _PlayerInventory[v.id].Amount >= v.amount )  && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )
				
				end
				*/
			end
			
		end
		
		_SelectedRecipeSkillRequirement = vgui.Create( "DScrollPanel", _RecipeInformationPanel )
		_SelectedRecipeSkillRequirement:SetPos( _wMod * 275, _hMod *  75  )
		_SelectedRecipeSkillRequirement:SetSize( _wMod * 150 , _hMod * 75   )
		
		function _SelectedRecipeSkillRequirement:SetRecipe( id, known )

			local _Recipe = fsrp.RecipeTable.AllRecipeList[id]
			for k , v in pairs( _Recipe.RequiredSkills ) do
			
				local _SelReqSkillLabel = _SelectedRecipeSkillRequirement:Add( "DLabel" )
		
				if tonumber(_p:GetSkillPoint( v[1] )) < tonumber(v[2]) then
				
					_CraftButton:SetEnabled( false )
					
				end
				_SelReqSkillLabel:Dock( TOP )
				_SelReqSkillLabel:SetSize( 30 , _hMod * 25 )
				_SelReqSkillLabel:DockMargin( 0, 0 , 0 , 5 )
				_SelReqSkillLabel:SetText( firstToUpper( v[1] ) .. "  #" .. v[2] )
				_SelReqSkillLabel:SetTextColor( ( tonumber(_p:GetSkillPoint( v[1] )) >= v[2] ) && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )
				_SelReqSkillLabel:SetFont("Trebuchet6")
				/*
				function _SelReqSkillLabel:Think(  )
						
					_SelReqSkillLabel:SetTextColor( ( _p:GetSkillPoint( v[1] ) >= v[2] ) && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )
				
				end
				*/
			end
			
		end
		function _RecipeInformationPanel:UpdateRecipe( ID, known )
		
			_RecipeInformationPanel.RecipeID = ID;
			
			if _RecipeInformationPanel.CraftPanel then
				local _Recipe = fsrp.RecipeTable.AllRecipeList[ID]
				if ITEMLIST[_Recipe.ToGive] then
					local _item = ITEMLIST[_Recipe.ToGive] ;
					if _item.Model && _item.CamPos && _item.LookAt then
						_RecipeInformationPanel.CraftPanel:SetModel(_item.Model)
						_RecipeInformationPanel.CraftPanel:SetCamPos(_item.CamPos)
						_RecipeInformationPanel.CraftPanel:SetLookAt(_item.LookAt)
						_RecipeInformationPanel.CraftPanel:SetVisible(true)

					end
				end
			end

			local _toUpdate = ( known && true ) || false;
			
			_SelectedRecipeItemRequirement:Clear( )
			_SelectedRecipeItemRequirement:SetRecipe( ID , _toUpdate )
			_SelectedRecipeSkillRequirement:Clear( )
			_SelectedRecipeSkillRequirement:SetRecipe( ID , _toUpdate )

		
			_PlayerInventory = _p:GetTotalAmountInv() ;
		end
		
		_RecipeInformationPanel:UpdateRecipe( 1 , true )
		
		local RecipeCategorySheet = {};
		local CategorySelectionButtons = {};
		local _catIndex = 1;
		local _IDsAble = {};
		
		if _p:GetKnownRecipes() then
					
			for k , v in pairs( _p:GetKnownRecipes() ) do
				
				
				_IDsAble[v] = v;
				
					
				
			end
		
		end
		
		
		for k , v in pairs( fsrp.RecipeTable.Known ) do
			
			if istable(v) then
			
				_IDsAble[tonumber(v.ID)] = tonumber(v.ID);
			
			end
			
		end
		
		//PrintTable( _IDsAble )
		
		for k , v in pairs( fsrp.RecipeTable.AllRecipeList ) do
			//if !_IDsAble[v.ID] then return  end
			
			if !RecipeCategorySheet[v.Category] && v.Category then
				
				RecipeCategorySheet[v.Category] = vgui.Create( "DScrollPanel", panel )
				RecipeCategorySheet[v.Category]:SetPos( _wMod*10 , _hMod * 100 )
				RecipeCategorySheet[v.Category]:SetSize( panel:GetWide() /2 - _wMod * 50 , panel:GetTall() - _hMod * 200 )
				RecipeCategorySheet[v.Category]:SetVisible( false )
				RecipeCategorySheet[v.Category].Name = v.Category;
				RecipeCategorySheet[v.Category]:SetMouseInputEnabled( false )
				
			end
			
			if !CategorySelectionButtons[v.Category] && v.Category then
			
				_butCache = vgui.Create( "DButton" , panel )
				_butCache:SetPos(  (_catIndex * ( _wMod * 160 ))-_wMod*125 , _hMod * 20  )
				_butCache:SetSize( _wMod * 150 , _hMod * 75)
				_butCache:SetText("");
				_butCache.Cat = v.Category;
				
				function _butCache:OnMousePressed( k )
			
					for x , y in pairs( RecipeCategorySheet ) do 
					
						y:SetVisible( false )
						y:SetMouseInputEnabled( false )
						
					end
					
					local _but = RecipeCategorySheet[self.Cat];
					
					_but:SetVisible( true )
					_but:SetMouseInputEnabled( true )					
			
				end
				_butCache.ActiveColor = Color( 0,0,0,0 )
				
				function _butCache:Paint( w,  h )
				
					if self:IsHovered() && !self:IsDown() then
				
						self.ActiveColor = lerpColor( 0.05, self.ActiveColor, Color( 25,25,25,255 ) )
											
					elseif self:IsDown() then
					
						self.ActiveColor = lerpColor( 0.05, self.ActiveColor, Color( 255,255,255,255 ) )
						
					else
					
						self.ActiveColor = lerpColor( 0.05, self.ActiveColor, Color( 128,128,128,56 ) )
						
					
					end
					
					surface.SetDrawColor( self.ActiveColor )
					surface.DrawRect( 0,0,w,h )
					draw.SimpleText( self.Cat , "Trebuchet24", w/2,h/2, Color( 255 ,255 ,255 , 255 ) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end 
				
				CategorySelectionButtons[v.Category] = _butCache;
				
				_catIndex = _catIndex + 1;
				
			end
			
		end
		RecipeCategorySheet["Illegal"]:SetVisible( true )
		RecipeCategorySheet["Illegal"]:SetMouseInputEnabled( true )

		
		
		if #_RecipeTabs > 0 then
		
			for k , v in pairs( _RecipeTabs ) do
			
				v:Remove()
				
			end
			
		end
		
		_RecipeTabs = {};
		
		//PrintTable(_IDsAble)
		
		for k , v in pairs( fsrp.RecipeTable.AllRecipeList ) do
			
			if _IDsAble[v.ID] then 
			
				//if !RecipeCategorySheet[v.Category] then return print( v.Name ) end
				
				local _RecipeBackdrop = RecipeCategorySheet[v.Category]:Add( "DPanel" )
				//_Bar:SetText( v.Name )
				_RecipeBackdrop.ID = v.ID;
				_RecipeBackdrop.Name = v.Name .. "\t(Required Time: " .. math.Round(v.RequiredPlaytime/60,2) .. " minutes)";
				
				local _SkillRequirementList = vgui.Create( "DScrollPanel" , _RecipeBackdrop )
				_SkillRequirementList:SetPos( _wMod * 125, _hMod *  50 )
				_SkillRequirementList:SetSize( _wMod * 150 , _hMod * 75  )
				
				local _ItemRequirementList = vgui.Create( "DScrollPanel" , _RecipeBackdrop )
				_ItemRequirementList:SetPos( _wMod * 425, _hMod *  50 )
				_ItemRequirementList:SetSize( _wMod * 150 , _hMod * 75  )
				
				if v.RequiredLevel then
					local _ReqLevelLabel = vgui.Create( "DLabel" , _RecipeBackdrop )
					_ReqLevelLabel:SetPos( _wMod * 25, _hMod *  110 )
					_ReqLevelLabel:SetSize( 300 , 25 )
					local _lv = 1;
					if LocalPlayer():GetRotoLevel(12) then
						_lv = LocalPlayer():GetRotoLevel(12)[1];
					end
					if _lv > v.RequiredLevel then
						_ReqLevelLabel:SetColor(Color(128,255,128))
					else
						_ReqLevelLabel:SetColor(Color(255,128,128))
					end
					
					_ReqLevelLabel:SetText( "Required Crafting Level:" .. v.RequiredLevel )
					_ReqLevelLabel:SetFont("Trebuchet6")
				end
				
				local _ItemCatLabel = vgui.Create( "DLabel" , _RecipeBackdrop )
				_ItemCatLabel:SetPos( _wMod * 325, _hMod *  35 )
				_ItemCatLabel:SetSize( 300 , 25 )
				_ItemCatLabel:SetText( "Required Items:" )
				_ItemCatLabel:SetFont("Trebuchet6")
						
				local _SkillCatLabel = vgui.Create( "DLabel" , _RecipeBackdrop )
				_SkillCatLabel:SetPos( _wMod * 25, _hMod *  35 )
				_SkillCatLabel:SetSize( 300 , 25 )
				_SkillCatLabel:SetText( "Required Skills:" )
				_SkillCatLabel:SetFont("Trebuchet6")
				
				if v.RequiredSkills then
				
					_RecipeBackdrop.RequiredSkills = v.RequiredSkills;
					
					for x, y in pairs( _RecipeBackdrop.RequiredSkills ) do
					
						local _SkillLabel = _SkillRequirementList:Add( "DLabel" )
						
						_SkillLabel:Dock( TOP )
						_SkillLabel:SetSize( 30, _hMod * 15 )
						_SkillLabel:DockMargin( 0, 0 , 0 ,5)
						_SkillLabel:SetText( firstToUpper( y[1] ) .. "  #" .. y[2] )
						_SkillLabel:SetFont("Trebuchet6")
						//_SkillLabel:SetTextColor(  _p:GetSkillPoint( y[1] ) >= y[2] && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )
						/*function _SkillLabel:Think(  )
						
							_SkillLabel:SetTextColor(  _p:GetSkillPoint( y[1] ) >= y[2] && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )
				
						end*/
					end
					
				end
				if v.RequiredItems then
				
					_RecipeBackdrop.RequiredItems = v.RequiredItems;
					
					for x, y in pairs( _RecipeBackdrop.RequiredItems ) do
					
						local _ItemLabel = _ItemRequirementList:Add( "DLabel" )
						_ItemLabel:SetSize( 30, _hMod * 15 )
						_ItemLabel:Dock( TOP )
						_ItemLabel:DockMargin( 0, 0 , 0 ,5)
						_ItemLabel:SetText( ITEMLIST[y.id].Name .. "  #" .. y.amount )
						_ItemLabel:SetFont("Trebuchet6")

						/*
						function _ItemLabel:Think(  )
						
							_ItemLabel:SetTextColor( ( _PlayerInventory[y.id] &&  _PlayerInventory[y.id].Amount >= y.amount ) && Color( 200, 255, 200, 225 ) || Color( 255, 200, 200 , 255 )  )
				
						end
						*/
					end
					
				end
				
				_RecipeBackdrop:Dock( TOP )
				_RecipeBackdrop:SetSize( RecipeCategorySheet[v.Category]:GetWide() , _hMod * 145 )
				_RecipeBackdrop:DockMargin( 0, 0, 0, 7.5 )
				
							
				function _RecipeBackdrop:Paint( w , h )
					
					
					draw.RoundedBoxEx(0,0,0,w,h,Color(0,0,0,panel._tabAlpha / 3 ),true,true)	
					draw.RoundedBoxEx(0,5,5,w-10,h-10,Color(225,225,225,panel._tabAlpha /3 ),true,true)	
					
				
					
					draw.SimpleText( _RecipeBackdrop.Name , "Trebuchet24", 15, 15, Color( 255, 255 ,255 , 255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
					//self:Update();
					
				end			

				local _SelectButton = vgui.Create( "DButton" , _RecipeBackdrop )
				_SelectButton:SetSize( _wMod * 100, _hMod * 100 )
				_SelectButton:SetPos( _RecipeBackdrop:GetWide() - ( _wMod *  200 ) , _RecipeBackdrop:GetTall()/2 -(_hMod * 50) )
				_SelectButton.RelativeColor = Color(225,225,225 );
				_SelectButton:SetText( "Select Recipe" )
				_SelectButton:SetFont( "Trebuchet6" )
				_SelectButton.Unhovered = Color(225,225,225  );
				_SelectButton.HoveredColor	= Color( 100, 100 , 100);
				_SelectButton.PressedColor = Color( 56, 56 , 56  );
				_SelectButton.ID = v.ID;
				
				function _SelectButton:OnMousePressed( )
				
					self.IsPressed = true;
					
				end
				
				function _SelectButton:OnMouseReleased( )
				
					self.IsPressed = false;
					
				end
				
				function _SelectButton:Think()
				
					if self:IsHovered() then
					
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					
						if _RecipeInformationPanel.RecipeID != self.ID then
						
							_RecipeInformationPanel:UpdateRecipe( self.ID , v.IsUnkown )
					
						end
						
						return	
						
					end
					
					if self.IsPressed then
					
						
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
					
						return
						
					end
					
					self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.Unhovered )
				
				end
				
				function _SelectButton:Paint( w , h )
				
					draw.RoundedBoxEx(0,0,0,w,h,Color(0,0,0,panel._tabAlpha / 3 ),true,true)	
					draw.RoundedBoxEx(0,5,5,w-10,h-10, self.RelativeColor ,true,true)	
				
				end
				
				/*
				local _RequiredItems = v.RequiredItems;
				local _RequiredItemList = vgui.Create( "DScrollPanel", _RecipeBackdrop )
				_RequiredItemList:SetPos( _wMod * 25 , _hMod * 100 )
				_RequiredItemList:SetSize( panel:GetWide() /2 - _wMod * 50 , panel:GetTall() - _hMod * 200 )
				*/
				
				table.insert( _RecipeTabs , _RecipeBackdrop )
				
			
			end
			
		end
		
		/*
		for k , v in pairs( fsrp.RecipeTable.Unknown ) do
			
				local _PlayerKnownRecipes = _p:GetKnownRecipes()
				for x ,y in pairs( _PlayerKnownRecipes ) do
					print( y )
					if y == v.ID then
					
						dontReturn = true;
						
					end
					
				end
				
				if dontReturn then
				
				local _RecipeBackdrop = _CraftingRecipeList:Add( "DPanel" )
				//_Bar:SetText( v.Name )
				_RecipeBackdrop.ID = v.ID;
				_RecipeBackdrop.Name = v.Name;
				
				local _SkillRequirementList = vgui.Create( "DScrollPanel" , _RecipeBackdrop )
				_SkillRequirementList:SetPos( _wMod * 25 , _hMod *  50 )
				_SkillRequirementList:SetSize( _wMod * 250 , _hMod * 100  )
				
				if v.RequiredSkills then
				
					_RecipeBackdrop.RequiredSkills = v.RequiredSkills;
					
					for x, y in pairs( _RecipeBackdrop.RequiredSkills ) do
					
						local _SkillLabel = _SkillRequirementList:Add( "DLabel" )
						_SkillLabel:SetPos( 250 , 80 )
						_SkillLabel:Dock( TOP )
						_SkillLabel:DockMargin( 0, 0 , 0 , 5 )
						_SkillLabel:SetText( firstToUpper( y[1] ) .. " Required: #" .. y[2] )
				
					end
					
				end
				
				_RecipeBackdrop:Dock( TOP )
				_RecipeBackdrop:SetSize( _CraftingRecipeList:GetWide() , _hMod * 200 )
				_RecipeBackdrop:DockMargin( 0, 0, 0, 18 )
				
							
				function _RecipeBackdrop:Paint( w , h )
					
					
					draw.RoundedBoxEx(0,0,0,w,h,Color(0,0,0,panel._tabAlpha / 3 ),true,true)	
					draw.RoundedBoxEx(0,5,5,w-10,h-10,Color(225,225,225,panel._tabAlpha /3 ),true,true)	
					
				
					
					draw.SimpleText( _RecipeBackdrop.Name , "Trebuchet20", 15, 15, Color( 255, 255 ,255 , 255 )  ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
					//self:Update();
					
				end				
				
				/*
				local _RequiredItems = v.RequiredItems;
				local _RequiredItemList = vgui.Create( "DScrollPanel", _RecipeBackdrop )
				_RequiredItemList:SetPos( _wMod * 25 , _hMod * 100 )
				_RequiredItemList:SetSize( panel:GetWide() /2 - _wMod * 50 , panel:GetTall() - _hMod * 200 )
				*//*
				
				table.insert( _RecipeTabs , _RecipeBackdrop )
				
			end
		end*/
		
	end
	
	return panel;
	
end

function SkillsAndResearch()
	
	local _p = LocalPlayer();
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel._skills = {};
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
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
	panel.ActiveTab = 0;

	local _SelectButton = vgui.Create( "DButton" , panel )
	_SelectButton:SetSize( 125, _hMod * 50 )
	_SelectButton:SetPos( _wMod*50 , _hMod*15 )
	_SelectButton.RelativeColor = Color(225,225,225 );
	_SelectButton:SetText( "Show Proficiency" )
	_SelectButton:SetFont( "Trebuchet6" )
	_SelectButton.Unhovered = Color(225,225,225  );
	_SelectButton.HoveredColor	= Color( 100, 100 , 100);
	_SelectButton.PressedColor = Color( 56, 56 , 56  );
	
	
	function _SelectButton:OnMousePressed( )
	
		if panel.ActiveTab == 0 then
			panel.ActiveTab = 1;
			_SelectButton:SetText( "Show Skills" )
		else
			panel.ActiveTab = 0;
			_SelectButton:SetText( "Show Proficiency" )
		end
		
	end
	
	function _SelectButton:OnMouseReleased( )

		if panel.SkillBar then
			panel.SkillBar:Remove()
			if panel.FPL then
				panel.FPL:Remove()
			end
		end
		panel:RefreshInformation()
		
	end
	
	function _SelectButton:Think()
	
		if self:IsHovered() then
		
			self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
		
			return	
			
		end
		
		if self.IsPressed then
		
			
			self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
		
			return
			
		end
		
		self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.Unhovered )
	
	end
	
	function _SelectButton:Paint( w , h )
	
		draw.RoundedBoxEx(0,0,0,w,h,Color(0,0,0,panel._tabAlpha / 3 ),true,true)	
		draw.RoundedBoxEx(0,5,5,w-10,h-10, self.RelativeColor ,true,true)	
	
	end	

	function panel:RefreshInformation( )
		
		local _SkillBar = vgui.Create( "DScrollPanel", panel )
		_SkillBar:SetPos( _wMod * 25 , _hMod * 100 )
		panel.SkillBar = _SkillBar;
		_SkillBar:SetSize( panel:GetWide() - _wMod * 50 , panel:GetTall() - _hMod * 110)
		//_SkillBar:Set
		local _p = LocalPlayer()
		_SkillBar.AddMaterial =  Material( "icon16/add.png" );
		_SkillBar.RemoveMaterial =  Material( "icon16/add.png" );
		
		if panel.ActiveTab == 0 then
			local _FreePointLabel = vgui.Create( "DLabel", panel )
			panel.FPL = _FreePointLabel
			_FreePointLabel:SetFont("Trebuchet24")
			_FreePointLabel:SetPos( _wMod * 25 , _hMod * 55 )
			_FreePointLabel:SetTall( 40 )
			_FreePointLabel:SetWide( panel:GetWide()  )
			function _FreePointLabel:Update()
			
				_FreePointLabel:SetText( "Free points available: " .. _p:GetFreeSkillPoints() )
			
			end
			
			_FreePointLabel:Update(); 
			for k , v in pairs( fsrp.skills.config.SkillTypes ) do
		
				local _Bar = _SkillBar:Add( "DPanel" )
				//_Bar:SetText( v.Name )
				_Bar:Dock( TOP )
				_Bar:SetSize( _SkillBar:GetWide() , 50 )
				_Bar:DockMargin( 0, 0,0, _hMod * 18  )
				_Bar.ID = k;
				_Bar.Skill = v;	
				_Bar.Min = 0;
				_Bar.Max = v.MaxPoints;
				_Bar.Value = 0;
				_Bar.TrueValue = 0;
				
				function _Bar:Update()
				
					local _pSkills =  skillpoint_Helper_GetSkillTable( LocalPlayer() );
					
					_Bar.Value = _pSkills[k];
					
				end 
				
				function _Bar:Think( )
				
					if _Bar.Value != _Bar.TrueValue then
					
						_Bar.TrueValue = Lerp( 0.05,  _Bar.TrueValue , _Bar.Value );
				
					end
					_Bar:Update()
				end
							
				function _Bar:Paint( w , h )
					
					surface.SetFont( "CarDisplayPrice" );
					local x, y = surface.GetTextSize(_Bar.Skill.Name )
					
					draw.RoundedBoxEx(0,0,0,w/2,h,Color(0,0,0,panel._tabAlpha),true,true)	
					draw.RoundedBoxEx(0,5,5,w/2-10,h-10,Color(225,225,225,panel._tabAlpha),true,true)	
					
					//self:Update();
					
					
					local alpha = math.Clamp( _Bar.TrueValue / _Bar.Max , 0, 1 );

					draw.RoundedBoxEx(0,5,5, (w/2 * alpha) -10 ,h-10,Color(225,100,100,panel._tabAlpha),true,true)	
				
					draw.SimpleText( _Bar.Skill.Name .. " Lv. " .. _Bar.Value , "CarDisplayPrice",  _wMod*25, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
					//draw.SimpleText( " - #" .. _Bar.Value , "CarDisplayPrice",  _Bar:GetWide() - _wMod*75, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

				end
				local _bx,_by = _Bar:GetPos();
				local _LabelDesc = vgui.Create("DLabel", _Bar)
				_LabelDesc:SetPos(_Bar:GetWide()/2+_wMod*10,_Bar:GetTall()/2-_hMod*15)
				_LabelDesc:SetSize(_Bar:GetWide()/2-_wMod*10,_hMod*30)
				_LabelDesc:SetText(v.Description)

				_LabelDesc:SetFont("CarDisplayPrice")
				_Bar:Update();
				
				local _UpgradeButton = vgui.Create( "DButton" , _Bar )
				_UpgradeButton:SetSize( 20 , 20 )
				_UpgradeButton:SetText( "" )
				_UpgradeButton:SetPos( _Bar:GetWide()/2 - _Bar:GetTall()*1.6 , _Bar:GetTall() / 2 - _UpgradeButton:GetWide()/2 )
				_UpgradeButton.Bar = _Bar;
				_UpgradeButton.IsFull = false;
				_UpgradeButton.IconMaterial = _SkillBar.AddMaterial;
				
				function _UpgradeButton:ToggleMaterial( )
				
					self.IsFull = true;
					
					_UpgradeButton.IconMaterial = _SkillBar.RemoveMaterial;
				
					self:SetEnabled( false );
					
					self.Bar:Update();
					
				end
				
				function _UpgradeButton:Paint( w , h )
				
					if self.Bar.Value == self.Bar.Max && !self.IsFull then
					
						_UpgradeButton:ToggleMaterial();
					
					end
					
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( _UpgradeButton.IconMaterial ) -- If you use Material, cache it!
					surface.DrawTexturedRect( 0, 0 , w, h )
					
					
				end
				
				function _UpgradeButton:OnMousePressed()
					
							
					if skillpoint_Helper_GetSkillPoint( _p , self.Bar.ID ) + 1 > fsrp.skills.config.SkillTypes[ self.Bar.ID ].MaxPoints then
					
						return _p:Notify( "You have already maximized this skill!" );
						
					end
					
					if _p:GetFreeSkillPoints() <= 0 then
					
						return _p:Notify( "You do not have enough free skill point for this" )
						
					end
			
					net.Start( "skills_SpendPoint" )
						net.WriteString( self.Bar.ID )
					net.SendToServer( )
					
				end
				
				function _UpgradeButton:OnMouseReleased()
					
					timer.Simple( 0.1, function() 
						
						self.Bar:Update();
				
						_FreePointLabel:Update();
					
					end )
					
				end
				
				
				table.insert( self._skills ,  _Bar );
				
			end
		else
			for k=1 ,#RotoLevelSystem.config.PerkTrees do
					local v = RotoLevelSystem.config.PerkTrees[k]
					local _Bar = _SkillBar:Add( "DPanel" )
					//_Bar:SetText( v.Name )
					_Bar:Dock( TOP )
					_Bar:SetSize( _SkillBar:GetWide() , 50 )
					_Bar:DockMargin( 0, 0, 0, _hMod * 18  )
					_Bar.ID = k;
					_Bar.Skill = v;	
					_Bar.Min = 0;
					
					local _lv = 1;
					if _p:GetRotoLevel(self.ID) then
						_lv = _p:GetRotoLevel(self.ID)[1]

					end
					_Bar.Max = RotoLevelSystem.config.InitialXPReq+(RotoLevelSystem.config.AdditionalXPPerLevel*_lv)
			
					_Bar.Value = 0;
					_Bar.TrueValue = 0;
					_Bar.Level = _lv;
					function _Bar:Update()
					
						local _pSkills =  LocalPlayer():GetRotoLevel(self.ID)
					
						if _pSkills then

							self.Value = tonumber(_pSkills[2]);
							self.Max = RotoLevelSystem.config.InitialXPReq+(RotoLevelSystem.config.AdditionalXPPerLevel*self.Level);

							if _p:GetRotoLevel(self.ID) then
								self.Level = _p:GetRotoLevel(self.ID)[1]
							end
						end
						
					end 
					
					function _Bar:Think( )
					
						if self.Value != self.TrueValue then
						
							self.TrueValue = Lerp( 0.05,  self.TrueValue , self.Value );
							
						end
						self:Update()
						
					end
					local _bx,_by = _Bar:GetPos();
					local _LabelDesc = vgui.Create("DLabel", _Bar)
					_LabelDesc:SetPos(_Bar:GetWide()/2+_wMod*10,_Bar:GetTall()/2-_hMod*15)
					_LabelDesc:SetSize(_Bar:GetWide()/2-_wMod*10,_hMod*30)
					_LabelDesc:SetText(v.Description)

					_LabelDesc:SetFont("CarDisplayPrice")
								
					function _Bar:Paint( w , h )
						
						surface.SetFont( "CarDisplayPrice" );
						local x, y = surface.GetTextSize( self.Skill.Name )
						
						draw.RoundedBoxEx(0,0,0,w/2,h,Color(0,0,0,panel._tabAlpha),true,true)	
						draw.RoundedBoxEx(0,5,5,w/2-10,h-10,Color(225,225,225,panel._tabAlpha),true,true)	
						
						//self:Update();
						
						
						local alpha = math.Clamp( self.TrueValue / self.Max , 0, 1 );

						draw.RoundedBoxEx(0,5,5, (w/2 * alpha) -10 ,h-10,Color(225,100,100,panel._tabAlpha),true,true)	
						local _pLevelInfo = LocalPlayer():GetRotoLevel(self.ID);

						draw.SimpleText( self.Skill.Name .. " Lv. " ..  (_pLevelInfo && _pLevelInfo[1] || "1"), "CarDisplayPrice", _wMod*25, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						draw.SimpleText( math.Round((self.Value/self.Max*100),0) .. "%", "CarDisplayPrice",  self:GetWide()/2 - _wMod*75, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

					end
					
					
					_Bar:Update();		
					
					
					table.insert( self._skills ,  _Bar );
				
				
			end
		end
	end
	
	return panel;
	
end

/* Toggles = 
	wc_showtips 1/0
	wc_drawothernames 1/0
	wc_kph 1/0
	wc_adjustcamera 1/0
	wc_thirdperson 1/0
	wc_crosshair 1/0
	wc_thirdperson_upoffset 25/-25
	wc_thirdperson_rightoffset 25/-25
	wc_thirdperson_forwardoffset 25/-25
	wc_thirdperson_rightshoulders 25/-25

*/
local _consolecommands = {
	[1] = {
		1,
		"Show Tip Notifications",
		"wc_showtips",
	};
	[2]= {
		1,
		"Draw Other Player Names",
		"wc_drawothernames",
	};
	[3] = {
		1,
		"Use KPH",
		"wc_kph"
	};
	[4] = {
		1,
		"Show 3D Crosshair",
		"wc_crosshair"
	};
	[5] = {
		1,
		"(Insert) Toggle Thirdperson",
		"wc_thirdperson",
	};
	[6] = {
		1,
		"Use Camera Third Person Spring Arm",
		"wc_adjustcamera",
	};
	[7] = {
		1,
		"Use Right Shoulder for Thirdperson",
		"wc_thirdperson_rightshoulders",
	};
	[8] = {
		2,
		"Spring Arm Offset (Right)",
		"wc_thirdperson_rightoffset",
	};
	[9] = {
		2,
		"Spring Arm Offset (Up)",
		"wc_thirdperson_upoffset",
	};
	[10] = {
		2,
		"Spring Arm Offset (Forward)",
		"wc_thirdperson_forwardoffset",
	};
	[11] = {
		1,
		"Draw Minimap",
		"wc_minimap",
		function(_cur)  RunConsoleCommand("mapview")  end,
	};
}
local _keyboardLayoutImage = Material("westcoastrp/keyboardlayout.png")
function Settings()
	
	
	local panel = vgui.Create( "DPanel",FRAME)
	panel:SetPos( _wMod*140,75)
	panel._tabAlpha = 0;
	panel:SetSize(FRAME:GetWide() - ScrW()/12,FRAME:GetTall() - 125)
	panel.Paint = function( self, w, h ) 
		draw.RoundedBoxEx(0,0,0,w,h,Color(56,56,56,panel._tabAlpha),true,true)	
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
		if panel.SettingScroll then
			panel.SettingScroll:Remove();

			if panel.InformationBox then
				panel.InformationBox:Remove()
			end
		end
		local SettingsScroll = vgui.Create("DScrollPanel",panel)
		SettingsScroll:SetSize(panel:GetWide()-_wMod*8,panel:GetTall()-_hMod*38);
		SettingsScroll:SetPos(_wMod*4, _hMod*34);
		SettingsScroll.Panel = panel;
		panel.SettingScroll = SettingScroll;
		local _InformationBox = vgui.Create("DPanel",panel)
		panel.InformationBox = _InformationBox;
		_InformationBox.Panel = panel;
		_InformationBox:SetSize(SettingsScroll:GetWide()-_wMod*40,_hMod* 20)
		_InformationBox:SetPos(_wMod*20,_hMod*10)
		_InformationBox.CurrentHover = 1;
		function _InformationBox:Paint(w,h)
			//surface.SetMaterial(_keyboardLayoutImage)
			surface.SetDrawColor(25,25,25,255)
			surface.DrawRect(0,0,w,h)
			surface.SetFont( "CarDisplayPrice" );
			
			if _InformationBox.CurrentHover == 1 then
				_instruction = "Off/On"
				_instructiontype = "Command"
			else
				_instruction = "Slider"
				_instructiontype = "Value"
			end
			local x, y = surface.GetTextSize( _instruction  )
			draw.SimpleText(_instruction, "CarDisplayPrice", (w-(x/2)) - _wMod * 55,  (h/2 -(y/2)), Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
			draw.SimpleText(_instructiontype, "CarDisplayPrice", (_wMod * 25),  (h/2 -(y/2)), Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
			//draw.SimpleText( , "CarDisplayPrice",  _VariableBox:GetWide() - _wMod*50, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
		end

		for i=1,#_consolecommands do
			local v = _consolecommands[i];
			local _command = v[3];
			local _information = v;
			
			local _VariableBox = vgui.Create("DPanel",SettingsScroll)
			_VariableBox:Dock(TOP)
			_VariableBox:SetTall(_hMod*50)
			_VariableBox.Command = _information
			_VariableBox.SettingsScroll = SettingScroll
			function _VariableBox:Paint(w,h)
				//surface.SetMaterial(_keyboardLayoutImage)
				surface.SetDrawColor(25,25,25,255)
				surface.DrawRect(0,0,w,h)
				surface.SetDrawColor(56,56,56,255)
				surface.DrawRect(_wMod*2,_hMod*2,w-_wMod*4,h-_hMod*4)
				surface.SetFont( "CarDisplayPrice" );
				local x, y = surface.GetTextSize( self.Command[2]  )
				
				
				draw.SimpleText( self.Command[2] , "CarDisplayPrice", _wMod*25, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
				//draw.SimpleText( , "CarDisplayPrice",  _VariableBox:GetWide() - _wMod*50, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )

			end

			function _VariableBox:OnCursorEntered()
				if _InformationBox then
					_InformationBox.CurrentHover =  _information[1];
				end
			end

			if GetConVar(_information[3]) && _information[1] == 1 then
				local _ToggleBox = vgui.Create("DPanel",_VariableBox)
				_ToggleBox:SetPos(SettingsScroll:GetWide()-_wMod*120, _hMod*5)
				_ToggleBox:SetSize(_wMod*80,_hMod*40)
				_ToggleBox.IsToggled = GetConVar(_information[3]):GetBool();
				_ToggleBox.VariableBox = _VariableBox
				function _ToggleBox:Paint(w,h)
					//surface.SetMaterial(_keyboardLayoutImage)

					if _ToggleBox.IsToggled then
						surface.SetDrawColor(25,25,25,255)
					else
						surface.SetDrawColor(255,128,128,128)
					end
					surface.DrawRect(0,0,w/2,h)
					if _ToggleBox.IsToggled then
						surface.SetDrawColor(255,128,128,128)
					else
						surface.SetDrawColor(25,25,25,255)
					end
					surface.DrawRect(w/2,0,w/2,h)
					
				end
				function _ToggleBox:OnMousePressed(k)
					local _prevVar = GetConVar( _information[3] );
					if _prevVar then
						_prevVar:SetBool(!_prevVar:GetBool())
						_ToggleBox.IsToggled = _prevVar:GetBool();
					end
					if v[4] then
						v[4](_prevVar:GetBool())
					end
				end
				
			end
			if GetConVar(_information[3]) && _information[1] == 2 then
				local _ValueSliderBox = vgui.Create("DPanel",_VariableBox)
				_ValueSliderBox:SetSize(_wMod*400,_hMod*40)
				_ValueSliderBox:SetPos(SettingsScroll:GetWide()-_wMod*(40+400), _hMod*5)
				function _ValueSliderBox:Paint(w,h)
					//surface.SetMaterial(_keyboardLayoutImage)

					surface.SetDrawColor(128,128,128,255)
					
					surface.DrawRect(0,0,w,h)
					
					
				end
				
				local _steps = {
					[1] = -25,
					[2] = -20,
					[3] = -15,
					[4] = -10,
					[5] = -5,
					[6] = 0,
					[7] = 5,
					[8] = 10,
					[9] = 15,
					[10] = 20,
					[11] = 25
				}

				for k , v in pairs(_steps) do
					

					local _valuestep = vgui.Create("DButton",_VariableBox)
					_valuestep:SetPos(SettingsScroll:GetWide()-_wMod*(40+(425-k*35)), _hMod*10)
					_valuestep:SetSize(_wMod*30,_hMod*30)
					_valuestep:SetText("")
					_valuestep.Value = v;
					function _valuestep:OnMousePressed(k)
						local _prevVar = GetConVar( _information[3] );
						if _prevVar then
							_prevVar:SetInt(self.Value)
						end
					end
					local _convarInformation = GetConVar( _information[3] );

					function _valuestep:Paint(w,h)
						//surface.SetMaterial(_keyboardLayoutImage)

						if _convarInformation:GetInt() == self.Value then
							surface.SetDrawColor(255,128,128,128)						
						else
							surface.SetDrawColor(56,56,56,255)
						end
						if self:IsHovered() then
							surface.SetDrawColor(255,255,255,255)							
						end
						
						surface.DrawRect(0,0,w,h)					
						
						surface.SetFont( "CarDisplayPrice" );
						local x, y = surface.GetTextSize( self.Value  )
						
						
						draw.SimpleText( self.Value  , "CarDisplayPrice", w/2-x/2, h/2 -y/2, Color( 255, 255 ,255 , 225 ) ,  TEXT_ALIGN_LEFT , TEXT_ALIGN_LEFT )
						
					
					end
				end
			end

			/*
			local _prevVar = GetConVar( var );
			if _prevVar then
				_prevVar:SetBool(!_prevVar:GetBool())
			end
			*/


		end


		local KeyboardImagePanel = vgui.Create("DPanel",SettingsScroll)
		KeyboardImagePanel:SetTall(_hMod*800)
		function KeyboardImagePanel:Paint(w,h)
			surface.SetMaterial(_keyboardLayoutImage)
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRect(_wMod*10,_hMod*10,w-_wMod*20,h-_hMod*20)
		end
		KeyboardImagePanel:Dock(TOP);

		
	end
	
	return panel;
	

end