//
//	- Josh 'Acecool' Moser
//


//
//
//
vgui.__meta_panel = META_PANEL;
vgui.__data = vgui.__data || {
	stack_index = 0;
	stack = {
		[ 0 ] = "default";
	};
	panels = { };
};
vgui.__data.panels = vgui.__data.panels || { };


//
// Uses util.IntersectRayWithPlane to determine the exact x and y coords the client is looking at ( which can be translating to what element is being looked at )
// Also serves as a helper function to simplify args of util.IntersectRayWithPlane so it can be applied to 3d panels
//
-- local isec = IntersectRayWithPlane( EyePos( ply ), Forward( EyeAngles( ply ) ), pos, trace.HitNormal )
-- if isec then
	-- local ap = pos - isec
	-- local ab = pos - tr
	-- local ad = pos - bl

	-- local ap_ab = Dot( ap, ab )
	-- local ab_ab = Dot( ab, ab )
	-- local ap_ad = Dot( ap, ad )
	-- local ad_ad = Dot( ad, ad )

	--IF they are looking within the bounds of the panel and their line of sight isn't obstructed
	-- if 0 < ap_ab and ap_ab < ab_ab and 0 < ap_ad and ap_ad < ad_ad and IsLineOfSightClear( ply, isec ) then
		-- //Do whatever you'd like, they're looking directly at the panel
	-- end
-- end

-- where trace.HitNormal is the vector of the direction your panel is facing. You could also use ang:Up() if you're not using a trace to determine the position of your panel.
-- pos is the vector of the top left of the rectangle, isec is the intersection of the players view with the plane of the panel, tr is the vector of the top right of the rectangle, and bl is the vector of the bottom left of the rectangle. 

-- I name my variables in accordance with the line that the resulting vector represents.

-- Given point 'P', and a rect w/ points A(top left), B(top right), C(bottom right), and D(bottom left), 
--	a the resulting line from vector P to vector A would be called 'ap'
-- Dot of 2 Vectors are named Vector1_Vector2 so Dot of AP and AD is ap_ad.

-- Check that the dot product of AP and AB is between 0 and the dot product of AB and AB. Then check that the dot product of AP and AD is between 0 and the dot product of AD and AD.

-- If that statement evaluates to true, then your plane intersection vector is inside the rectangle! I also added a check to make sure that the player has view of the intersection point, so that you can't 'look' at a panel that is behind a wall or some such.
function vgui.TranslateViewToPanelCoords( _panel )
	if ( !ispanel( _panel ) ) then return false; end

	//local _x, _y = _panel:GetPosToScreen( );
	local _pos_panel_x0y0 = Vector( 0, 0, 100 );
	local _p = LocalPlayer( );
	local _pos, _ang = EyePos( _p ), EyeAngles( _p );
	local _intersect = util.IntersectRayWithPlane( _pos, _ang:Forward( ), _pos_panel_x0y0, _p:GetEyeTrace( ).HitNormal );
	if ( _intersect ) then
	
	end
end


//
// Returns the current stack table index
//
function vgui.GetStackIndex( )
	return vgui.GetData( ).stack_index;
end


//
// Returns the current stack table id so we know which __data.panels[ _id ] to add panels to...
//
function vgui.GetStackID( )
	return vgui.GetData( ).stack[ vgui.GetData( ).stack_index ];
end


//
// 
//
function vgui.AddStackIndex( _value )
	vgui.GetData( ).stack_index = math.max( 0, vgui.GetStackIndex( ) + _value );
end


//
// Adds an id to the stack; this id will be used when adding new panels, they'll be assigned to this id..
//
function vgui.PushID( _id )
	vgui.AddStackIndex( 1 );
	vgui.GetData( ).stack[ vgui.GetStackIndex( ) ] = _id;
end


//
// Removes the current id from the stack so the previous id can be used..
//
function vgui.PopID( )
	vgui.GetData( ).stack[ vgui.GetStackIndex( ) ] = nil;
	vgui.AddStackIndex( -1 );
end


//
// Adds a panel to the list marked as _id ( so specific panels can be removed with children without hassle ); can remove rows this way too.
//
function vgui.AddPanel( _panel )
	local _panels = vgui.GetPanels( );
	local _id = vgui.GetStackID( )
	if ( !_panels[ _id ] ) then _panels[  _id ] = { }; end

	local _key = table.insert( _panels[ _id ], _panel );

	function _panel:OnRemove( ) //
		table.remove( _panels[ _id ], _key );
	end
end


//
//
//
function vgui.GetData( )
	return vgui.__data;
end


//
//
//
function vgui.GetPanels( )
	return vgui.GetData( ).panels;
end


//
// Deletes all panels associated with an id...
//
function vgui.RemovePanels( _id )
	local _panels = vgui.GetPanels( )[ _id ];
	if ( _id && _panels ) then
		for k, _panel in pairs( _panels ) do
			if ( !_panel || !ispanel( _panel ) ) then continue; end
			_panel:Remove( );
		end
		vgui.GetPanels( )[ _id ] = nil;
	end
end


//
// Processes panels... Useful for applying updates to a group of panels...
//
function vgui.ProcessPanels( _id, _func )
	local _panels = vgui.GetPanels( )[ _id ];
	if ( _id && _panels ) then
		for k, _panel in pairs( _panels ) do
			if ( !_panel || !ispanel( _panel ) || _panel == NULL ) then continue; end
			_func( _panel );
		end
	end
end


//
// Executes callback function for all children of input panel
//
function vgui.ProcessChildren( _panel, _callback )
	// If the panel isn't set, stop
	if ( !_panel ) then return; end

	// One of the rare cases where the index starts at 0 in GMod, start at 0 and go until n - 1 for children
	for i = 0, _panel:ChildCount( ) - 1 do
		// Reference the current child
		local _child = _panel:GetChild( i );

		// If the child isn't a panel, skip it.
		if ( !ispanel( _child ) ) then continue; end

		// If it is a panel, run the callback with the current child as the argument
		_callback( _child );

		// Recurse children of this child
		vgui.ProcessChildren( _child, _callback );
	end
end


//
//
//
function vgui.Clear( )
	// First one removes all vgui-elements with a parent of the WorldPanel ( ALL vgui elements, essentially )

	// Reference the world panel; if you do vgui.Create( "DPanel" ); then it is parented to WorldPanel.
	local _panel = vgui.GetWorldPanel( );

	// Print out the panel
	MsgC( Color( 255, 0, 0, 255 ), _panel, "\n" );

	// Call the processor with the callback to remove the child
	vgui.ProcessChildren( _panel, function( _child )
		_child:Remove( );
	end );


	// Second one removes all vgui elements which have the parent as the HUDPanel; this doesn't work as intended...

	// Reference the HUDPanel; if you do local _panel = vgui.Create( "DPanel" ); _panel:ParentToHUD( );
	local _hud = GetHUDPanel( )

	// Print out the panel
	MsgC( Color( 255, 255, 0, 255 ), _hud, "\n" );

	// Call the processor with the callback to remove the child
	vgui.ProcessChildren( _hud, function( _child )
		_child:Remove( );
	end );

	// Disable the mouse on screen; useful if MakePopup( ) was called on a panel, or if the mouse is unlocked. Prevents mouse staying active.
	gui.EnableScreenClicker( false );
end


//
//
//
function vgui.CreateFrame( _parent, _title, _x, _y, _options )
	local _options = _options || { };

	-- _options.title			= _title;
	_options.x				= _x;
	_options.y				= _y;
	-- _options.draggable		= true;
	_options.makepopup		= true;
	-- _options.drawontop		= false;

	return vgui.CreateEx( "DFrame", _parent, _options );
end


//
//
//
function vgui.CreatePanel( _parent, _title, _x, _y, _options )
	local _options = _options || { };

	-- _options.title			= _title;
	_options.pos			= { x = _x, y = _y };
	-- _options.makepopup		= true;
	-- _options.draggable		= true;
	-- _options.drawontop		= false;

	_options.paint = function( _w, _h )
	
	end

	return vgui.CreateEx( "DPanel", _parent, _options );
end


//
// Simple system so like-items can be grouped together on an "overlay"..
//
function vgui.CreateOverlay( _parent, _options )
	local _options = _options || { };

	-- local _x, _y				= 150, 150; //_parent:GetPos( );
	-- _options.pos				= { x = _x, y = _y };

	-- local _w, _h				= 512, 512 //_parent:GetSize( );
	-- _options.size				= { w = _w, h = _h };

	-- _options.stretchtoparent	= true;
	-- _options.makepopup			= true;
	-- _options.drawontop			= true;
	-- _options.paint = function ( _w, _h )
		-- draw.Icon( 15, 50, "icon16/images.png", color_white );
	-- print( _parent:GetSize( ) );
	-- end

	return vgui.CreateEx( "DPanel", _parent, _options );
end




//
//
//
function vgui.CreateLabel( _parent, _text, _font, _color, _tooltip, _options, _func_doclick )
	local _options = _options || { };

	_options.text			= _text;
	-- _options.pos			= { x = _x, y = _y };
	-- _options.sizetocontents	= true;
	-- _options.mouseinput		= _mouseinput;
	_options.font			= _font;
	_options.color			= _color;
	_options.tooltip		= _tooltip;
	_options.doclick		= _func_doclick;
	-- _options.drawontop		= true;

	return vgui.CreateEx( "DLabel", _parent, _options );
end


//
//
//
function vgui.CreateImage( _parent, _material, _x, _y, _options )
	local _options = _options || { };

	_options.material		= _material;
	_options.pos			= { x = _x, y = _y };
	-- _options.sizetocontents	= true;
	-- _options.drawontop		= true;

	return vgui.CreateEx( "DImage", _parent, _options );
end


//
//
//
function vgui.CreateImageButton( _parent, _image, _tooltip, _options, _func_doclick )
	local _options = _options || { };

	_options.image			= _image;
	-- _options.x				= _x;
	-- _options.y				= _y;
	_options.tooltip		= _tooltip;
	-- _options.mouseinput		= true;
	-- _options.sizetocontents	= true;
	_options.doclick		= _func_doclick;
	-- _options.drawontop		= true;

	return vgui.CreateEx( "DImageButton", _parent, _options );
end


//
//
//	local _button_ok = vgui.CreateButton( _buttons, _text_button, 5, 5, 20, nil, function( ) _window:Close( ) end, { sizetocontents = true, addw = 20 } );
function vgui.CreateButton( _parent, _title, _x, _y, _w, _h, _options, _func_doclick )
	local _options = _options || { };

	// TODO: Fix this...
	-- _options.tooltip		= _tooltip;
	_options.material		= _material;
	_options.pos			= { x = _x, y = _y };
	_options.mouseinput		= true;
	-- _options.sizetocontents	= true;
	_options.onselect		= _func_doclick;
	-- _options.drawontop		= true;

	return vgui.CreateEx( "DButton", _parent, _options );
end


//
//
//
function vgui.CreateComboBox( _parent, _title, _x, _y, _w, _h, choices, _options, _func_onselect )
	local _options = _options || { };

	_options.value			= _title;
	_options.pos			= { x = _x, y = _y };
	_options.size			= { w = _w, h = _h };
	_options.choices		= choices;
	_options.choices_key	= "Name";
	_options.multiselect	= false;
	-- _options.drawontop		= true;

	 // onSelectCallback( _index, _value, _data )
	_options.onselect		= _func_onselect;

	return vgui.CreateEx( "DComboBox", _parent, _options );
end


//
//
//
function vgui.CreateNumSlider( _parent, _title, _x, _y, _w, _h, _min, _max, _precision, _options, _func_onvaluechanged )
	local _options = _options || { };

	// TODO: Fix this
	-- _options.choices		= _choices;

	_options.text			= _title;
	_options.min			= _min;
	_options.max			= _max;
	_options.decimals		= _precision || 2;
	_options.scratchzoom	= 25;
	_options.value			= 0;
	_options.dark			= true;
	_options.pos			= { x = _x, y = _y };
	_options.size			= { w = _w, h = _h };
	_options.multiselect	= false;
	_options.onvaluechanged	= _func_onvaluechanged;
	-- _options.drawontop		= true;

	return vgui.CreateEx( "DNumSlider", _parent, _options );
end


//
//
//
function vgui.CreateTextBox( _parent, _x, _y, _w, _h, _multiline, _options, _func_ongetfocus )
	local _options = _options || { };

	_options.pos			= { x = _x, y = _y };
	_options.size			= { w = _w, h = _h };
	_options.text			= "";
	_options.multiline		= _multiline;
	_options.ongetfocus		= _func_ongetfocus;
	-- _options.drawontop		= true;

	return vgui.CreateEx( "DTextEntry", _parent, _options );
end


-- META_PANEL:CreateTextBox( parent, _x, _y, _w, _h, _multiline, onGetFocusCallback, _options )
-- META_PANEL:CreateNumSlider( _parent, title, _x, _y, _w, _h, min, max, onValueChangedCallback, precision, _options )
-- META_PANEL:CreateComboBox( _parent, _title, _x, _y, _w, _h, choices, onSelectCallback, _options )
-- META_PANEL:CreateImageButton( _parent, _material, _x, _y, _tooltip, doClickCallback, _options )
-- META_PANEL:CreateImage( _parent, _material, _x, _y, _options )
-- META_PANEL:CreateLabel( _parent, _title, _x, _y, _mouseinput, _font, _color, _tooltip, doClickCallback, _options )

-- vgui.CreateLabel( _parent, _title, _x, _y, _mouseinput, _font, _color, _tooltip, doClickCallback, _options )
-- vgui.CreateImage( _parent, _material, _x, _y, _options )
-- vgui.CreateImageButton( _parent, _material, _x, _y, _tooltip, doClickCallback, _options )
-- vgui.CreateComboBox( _parent, _title, _x, _y, _w, _h, choices, onSelectCallback, _options )
-- vgui.CreateNumSlider( _parent, title, _x, _y, _w, _h, min, max, onValueChangedCallback, precision, _options )
-- vgui.CreateTextBox( parent, _x, _y, _w, _h, _multiline, onGetFocusCallback, _options )

//
//
//
function vgui.Notice( _title, _desc, _text_button )
	local _title = _title || "#undefined_title";
	local _desc = _desc || "#undefined_desc";
	local _text_button = _text_button || "#OK";

	local _window = vgui.CreateFrame( _parent, _title, _x, _y, { showclosebutton = false, backgroundblur = true, drawontop = true } );
	local _panel = vgui.CreateEx( "Panel", _window );
	local _label = vgui.CreateLabel( _panel, _desc, 0, 0, false, nil, color_white, nil, nil, { textcolor = color_white, contentalignment = 5 } )
	local _buttons = vgui.CreateEx( "Panel", _window, { h = 30 } );
	local _button_ok = vgui.CreateButton( _buttons, _text_button, 5, 5, 20, nil, function( ) _window:Close( ) end, { addw = 20 } );

	_buttons:SetWide( _button:GetWide( ) + 10 );
	_window:SetSize( _label:GetWide( ) + 50, _label:GetTall( ) + 25 + 45 + 10 );
	_panel:StretchToParent( 5, 25, 5, 45 );
	_label:StretchToParent( 5, 5, 5, 5 );
	_buttons:CenterHorizontal( );
	_buttons:AlignBottom( 8 );
	_window:Center( );
	_window:DoModal( );

	return _window;
end


//
// VGUI Helper Function - Primarily for internal creation of functions such as AddSlider, CreateComboBox, etc but to create the element quickly and efficiently.
//
function vgui.CreateEx( _element, _parent, _options )
	local _panel = vgui.Create( _element, _parent );

	// TODO: Re-evaluate this... Might keep vgui elements open instead...
	// Make sure we remove all trade on close..
	if ( _panel.SetDeleteOnClose ) then _panel:SetDeleteOnClose( true ); end

	if ( !istable( _options ) ) then return _panel; end

	// Positioning Information
	local _x, _y = _panel:GetPos( );
	if ( _options.x ) then _panel:SetPos( _options.x, _y ); _x, _y = _panel:GetPos( ); end
	if ( _options.y ) then _panel:SetPos( _x, _options.y ); _x, _y = _panel:GetPos( ); end
	if ( _options.pos ) then _panel:SetPos( _options.pos.x || _x, _options.pos.y || _y ); end

	// Coloring
	if ( IsColor( _options.textcolor ) || IsColor( _options.text_color ) ) then _panel:SetTextColor( _options.textcolor || _options.text_color ); end

	//
	if ( _options.material ) then _panel:SetMaterial( _options.material ); end	
	if ( _options.image ) then _panel:SetImage( _options.image ); end


	// DModelPanel
	if ( _options.model ) then _panel:SetModel( _options.model ); end
	if ( _options.campos ) then _panel:SetCamPos( _options.campos ); end
	if ( _options.lookat ) then _panel:SetLookAt( _options.lookat ); end

	//
	// Multiple Choice Population
	//
	--------------------------------------------------------------------------------
	// Populate columns in a Data Set
	if ( _options.columns ) then
		for k, v in pairs( _options.columns ) do
			_panel:AddColumn( v );
		end
	end

	// Populate choices / lines
	if ( _options.choices ) then
		for k, v in pairs( _options.choices ) do
			if ( IsTable( v ) ) then
				_panel:AddChoice( k, v[ _options.choices_key ] )
			else
				_panel:AddChoice( v, k )
			end
			_panel:AddColumn( v );
		end
	end

	// True/False
	--------------------------------------------------------------------------------
	if ( isbool( _options.disabled ) ) then _panel:SetDisabled( _options.disabled ); end
	if ( isbool( _options.mouseinput ) ) then _panel:SetMouseInputEnabled( _options.mouseinput ); end
	if ( isbool( _options.keyboardinput ) ) then _panel:SetKeyboardInputEnabled( _options.keyboardinput ); end
	if ( isbool( _options.multiselect ) ) then _panel:SetMultiSelect( _options.multiselect ); end
	if ( isbool( _options.draggable ) ) then _panel:SetDraggable( _options.draggable ); end
	if ( isbool( _options.dark ) ) then _panel:SetDark( _options.dark ); end
	if ( isbool( _options.showclosebutton ) ) then _panel:ShowCloseButton( _options.showclosebutton ); end
	if ( isbool( _options.multiline ) ) then _panel:SetMultiline( _options.multiline ); end
	if ( isbool( _options.backgroundblur ) ) then _panel:SetBackgroundBlur( _options.backgroundblur ); end
	if ( isbool( _options.drawontop ) ) then _panel:SetDrawOnTop( _options.drawontop ); end

	// True / False with alternative vars...
	local _drawbg = ( ( isbool( _options.drawbg ) || isbool( _options.drawbackground ) ) && _options.drawbg || _options.drawbackground );
	if ( _drawbg ) then _panel:SetDrawBackground( _options.drawbg || _options.drawbackground ); end



	// Data
	--------------------------------------------------------------------------------
	if ( _options.tooltip ) then		_panel:SetTooltip( _options.tooltip ); end
	if ( _options.color ) then			_panel:SetColor( _options.color ); end
	if ( _options.font ) then			_panel:SetFont( _options.font ); end
	if ( _options.text ) then			_panel:SetText( _options.text ); end
	if ( _options.title ) then			_panel:SetTitle( _options.title ); end
	if ( _options.min ) then			_panel:SetMin( _options.min ); end
	if ( _options.max ) then			_panel:SetMax( _options.max ); end
	if ( _options.decimals ) then		_panel:SetDecimals( _options.decimals ); end
	if ( _options.value ) then			_panel:SetValue( _options.value ); end
	if ( _options.scratchzoom ) then	_panel.Scratch:SetZoom( _options.scratchzoom ); end
	if ( _options.contents ) then		_panel:SetContents( _options.contents ); end
	if ( _options.html ) then			_panel:SetHTML( _options.html ); end


	//
	// Functions
	//
	--------------------------------------------------------------------------------
	if ( isfunction( _options.doclick ) ) then			_panel.DoClick = _options.doclick; end
	if ( isfunction( _options.paint ) ) then			_panel.Paint = _options.paint; end
	if ( isfunction( _options.onvaluechanged ) ) then	_panel.OnValueChanged = _options.onvaluechanged; end // val
	if ( isfunction( _options.onmousepressed ) ) then	_panel.OnMousePressed = _options.onmousepressed; end // val
	if ( isfunction( _options.onmousereleased ) ) then	_panel.OnMouseReleased = _options.onmousereleased; end // val
	if ( isfunction( _options.ongetfocus ) ) then		_panel.OnGetFocus = _options.ongetfocus; end // val
	if ( isfunction( _options.onrowselected ) ) then	_panel.OnRowSelected = _options.onrowselected; end // lineid, line
	if ( isfunction( _options.onselect ) ) then			_panel.OnSelect = _options.onselect; end // index, value, data
	if ( isfunction( _options.onenter ) ) then			_panel.OnEnter = _options.onenter; end // index, value, data


	//
	// Functionality
	//
	--------------------------------------------------------------------------------
	// MakePopup Enables Mouse Input; should be called on the main window.
	if ( _options.makepopup ) then _panel:MakePopup( ); end



	//
	// Absolutely needs to be called at the end.
	//
	--------------------------------------------------------------------------------
	// Docking
	if ( _options.dock ) then _panel:Dock( _options.dock ); end
	if ( istable( _options.dock_margin ) && #_options.dock_margin == 4 ) then _panel:DockMargin( unpack( _options.dock_margin ) ); end

	// Sizing Information ( Needs to be done after size-to-contents because these shouldn't mix and manual size should override automatic )
	if ( isnumber( _options.w ) || isnumber( _options.width ) || isnumber( _options.wide ) ) then _panel:SetWide( _options.w || _options.width ||_options.wide ); end
	if ( isnumber( _options.h ) || isnumber( _options.height ) || isnumber( _options.tall ) ) then _panel:SetTall( _options.h || _options.height || _options.tall ); end
	if ( isnumber( _options.addw ) || isnumber( _options.addwidth ) || isnumber( _options.addwide ) ) then _panel:SetWide( _panel:GetWide( ) + ( _options.addw || _options.addwidth || _options.addwide ) ); end
	if ( isnumber( _options.addh ) || isnumber( _options.addheight ) || isnumber( _options.addtall ) ) then _panel:SetTall( _panel:GetTall( ) + ( _options.addh || _options.addheight || _options.addtall ) ); end
	if ( _options.size ) then _panel:SetSize( _options.size.w, _options.size.h ); end

	if ( isfunction( _options.moverightof ) ) then _panel:MoveRightOf( _options.moverightof, _options.moverightpx || 0 ) end



	// Specific Subset Sizing Accessors
	if ( _options.labelwide || _options.labelw ) then _panel.Label:SetWide( _options.labelw || _options.labelwide ); end
	if ( _options.labeltall || _options.labelh ) then _panel.Label:SetTall( _options.labelh || _options.labelwide ); end

	// Alignment Information
	if ( _options.alignbottom || _options.align_bottom ) then _panel:AlignBottom( ); end
	if ( _options.aligntop || _options.align_top ) then _panel:AlignTop( ); end
	if ( _options.alignleft || _options.align_left ) then _panel:AlignLeft( ); end
	if ( _options.alignright || _options.align_right ) then _panel:AlignRight( ); end
	if ( _options.center ) then _panel:Center( ); end

	// The direction is based of the number pad, 5 is middle, 7 is top left, 6 is right middle etc.
	if ( isnumber( _options.contentalignment ) || isnumber( _options.content_alignment ) ) then _panel:SetContentAlignment( _options.contentalignment || _options.content_alignment ); end




	// StretchToParent should be called whenever.
	if ( _options.stretchtoparent ) then _panel:StretchToParent( ); end

	// SizeToContents needs to be called after population occurs.
	if ( _options.sizetocontents ) then _panel:SizeToContents( ); end

	// Visibility should occur after data loads to ensure no pop-in effects are seen.
	_panel:SetVisible( ( isbool( _options.visible ) && _options.visible || true ) );

	return _panel;
end


//
// Aliases
//
vgui.CreateElement = vgui.CreateEx;