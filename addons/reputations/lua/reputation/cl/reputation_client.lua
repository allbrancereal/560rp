
if engine.ActiveGamemode() == "sandbox" then

	local hide = {
		["CHudHealth"] = false,
		["CHudBattery"] = false,
		["CHudAmmo"] = true,
	}

	hook.Add( "HUDShouldDraw", "HideHUD", function( name )
		if ( hide[ name ] ) then return false end

		-- Don't return anything here, it may break other addons that rely on this hook.
	end )

end

if PlayerReputations.ShowDebugPrints then

	print( "Including Reputation Client VGUI Files.")

end

surface.CreateFont( "LocalReputationFont_Large", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = ScreenScale(7.5),
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

surface.CreateFont( "LocalReputationFont_Medium", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
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

surface.CreateFont( "LocalReputationFont_Small", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = ScreenScale(5),
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

local SCREEN_W, SCREEN_H = 3840, 2160;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
_wMod = _wMod*2
_hMod = _hMod*2
local _EntityRepDraw = {
	CurrentPosW = "right",
	CurrentPosH = "bottom",
	WPosDefs = {
		["left"] = 10;
		["right"] = 1505;
	};
	HPosDefs = {
		["up"] = 100;
		["bottom"] = 970;
	}
}

hook.Add("HUDPaint", "DrawReputationOnEntity", function()

	local _p = LocalPlayer()
	local _trace = _p:GetEyeTrace();
	local _ent = _trace.Entity;

	if IsValid(_ent) && _ent:GetPos():Distance( LocalPlayer():GetPos() ) < 400 then

		local _entRep = _ent:GetEntityReputation();
		local _repFound = PlayerReputations.config.Reputations[_entRep] || PlayerReputations.config.EntityDictionary[_ent:GetClass()] && PlayerReputations.config.Reputations[PlayerReputations.config.EntityDictionary[_ent:GetClass()].rep];

		if _repFound then
			
			surface.SetFont( "LocalReputationFont_Large" );
			local _entName = "Test Entity Name";

			if LocalPlayer():getFlag("robbingBank", false ) == true then return end 
			if _ent:GetClass() == "cn_npc" then
				_entName = cnQuests[_ent:GetQuest()].name
			elseif PlayerReputations.config.EntityDictionary[_ent:GetClass()] then
				_entName = PlayerReputations.config.EntityDictionary[_ent:GetClass()].name;
			else
				_entName = ""
			end
			if isstring(_entName) then
				local _textX, _textY = surface.GetTextSize( _entName )
				local _textRepFoundX, _textRepFoundY = surface.GetTextSize( _repFound.name )

				local _xModifier = _textX > _textRepFoundX && _textX || _textRepFoundX; 
				local _StartW = _EntityRepDraw.WPosDefs[_EntityRepDraw.CurrentPosW];
				local _StartH = _EntityRepDraw.HPosDefs[_EntityRepDraw.CurrentPosH];

				
				draw.RoundedBox(5,_wMod * _StartW,_hMod * _StartH,_wMod * (_xModifier+400),_hMod * 50, Color(0 ,0 ,0 ,225) )

				
				
				draw.DrawText( _entName , "LocalReputationFont_Large",_wMod *( _StartW+7.5),_hMod * (_StartH+5),Color(255,255,255,255),TEXT_ALIGN_LEFT)
				draw.DrawText( _repFound.name , "LocalReputationFont_Medium",_wMod *( _StartW+30),_hMod * (_StartH+25),Color(255,255,255,255),TEXT_ALIGN_LEFT)
			end
		end
		
	end
	
end)

/*-----------------------------
Reputation Menu (Category>Faction>Reputation);
-----------------------------*/
local function ReputationMenu()
	
	local _p = LocalPlayer();

	if _p.ReputationMenu != nil then
		
		_p.ReputationMenu:Remove()
		_p.ReputationMenu = nil;

	end

	local _Frame = vgui.Create("DFrame")
	_Frame:SetSize( _wMod * 500, _hMod * 1080) 
	_Frame:ShowCloseButton(false)
	_Frame:Dock(LEFT)
	_Frame:MakePopup()
	_Frame:SetDraggable(false)
	_Frame:SetTitle("")

	function _Frame:Paint( w, h )

		draw.RoundedBox( 0 , 0, 0 ,w ,h , Color(0,0,0,225) )

		draw.DrawText( "Factions" , "LocalReputationFont_Large",_wMod*25, _hMod*15 ,Color(255,255,255,255),TEXT_ALIGN_LEFT)

	end
	
	local _ExitBut = vgui.Create("DButton", _Frame);
	_ExitBut:SetSize(_wMod * 50, _hMod * 50);
	_ExitBut:SetPos( _Frame:GetWide()-_ExitBut:GetWide(), 0)
	_ExitBut:SetText( "" )
	function _ExitBut:Paint( w , h )

		draw.RoundedBox( 0 , 0, 0 ,w ,h , Color(56,56,56,225) )
		surface.SetFont( "LocalReputationFont_Large" );
		local _textX, _textY = surface.GetTextSize( "X" )

		draw.DrawText( "X" , "LocalReputationFont_Large",w/2-(_textX/2),h/2-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_LEFT)

	end
	
	function _ExitBut:OnMousePressed( _c )

		if _c == MOUSE_LEFT then
				
			_p.ReputationMenu = nil;	
			_Frame:Remove()		

		end

	end

	local _FrameScrollPanel = vgui.Create( "DScrollPanel", _Frame )
	_FrameScrollPanel:SetSize( _Frame:GetWide() , _Frame:GetTall() - (_hMod * 50) )
	_FrameScrollPanel:SetPos( 0 , _hMod * 50 )
	//_FrameScrollPanel:Dock(FILL)
	_Frame.Categories = {};

	function _Frame:CreateCategory( name, includedfactions )
		//if _Frame.Categories[name] then return end;

		local _cat = vgui.Create("DPanel", _Frame)

		local _NumOfReps = #includedfactions || includedfactions || 1;
		_NumOfReps = _NumOfReps + 1;
		_cat:SetSize( _Frame:GetWide() ,(_NumOfReps * 50) * _hMod  )
		_cat:Dock(TOP);
		//_cat:SetPos( 0 ,(_hMod * ((#_Frame.Categories*60 ))) )
		//_cat:SetText( "" )
		_cat:DockMargin( 0, 0, 0,5 )
		_cat.Factions = includedfactions;
		_cat.Closed = true;

		local _catPanel = vgui.Create( "DScrollPanel" , _cat );
		_catPanel:SetSize( _cat:GetWide() , _cat:GetTall()-(60*_hMod) )
		_catPanel:SetPos( 0 , 60*_hMod )
		//_catPanel:Dock(TOP)

		function _cat:FindSize()
			if _cat.Closed == false then				
				_cat:SetSize( _Frame:GetWide() ,(_NumOfReps * 60) * _hMod  )
				_cat:DockMargin( 0, 0, 0,5 )
				_catPanel:SetSize( _cat:GetWide() , _cat:GetTall() )
				
				if _cat.FactionList then
					
					if !_cat.FactionList.Factions || #_cat.FactionList.Factions <=0 then return end
					local _openFacs = 0;
					for k , v in pairs( _cat.FactionList.Factions )do
						
						if v.Closed == false then
							
							_openFacs = _openFacs+1;

						end

					end
					local _MinReq = 3;

					if _openFacs == 0 then
						_MinReq = 1.5;
					end
					
					_cat:SetSize( _Frame:GetWide() ,(math.max( (#_cat.FactionList.Factions+_openFacs),_MinReq ) * 100) * _hMod  )

					//_catPanel:SetSize( _cat:GetWide() , _cat:GetTall()-(100*_hMod) )
					_catPanel:Dock(FILL)
					_catPanel:DockMargin(0,60,0,0)
					_cat.FactionList:SetSize( _cat:GetWide()-_wMod*15 , (math.max( (#_cat.FactionList.Factions+_openFacs),_MinReq ) * 100)  )
					//_cat.FactionList:Dock(FILL)
				end
			else
				_cat:SetSize( _Frame:GetWide() ,50 * _hMod  )
				_catPanel:SetSize( _cat:GetWide() , _cat:GetTall() )
		
			end
		end
		
		local _catBut = vgui.Create("DButton", _cat);
		_catBut:SetPos( _wMod * 5 , _hMod * 5 )
		_catBut:SetSize( _wMod*40, _hMod*40);
		_catBut:SetText( "" );
		_cat:FindSize()
		_catBut.ParentCat = _cat;
		function _catBut:Paint( w, h )

			local _closedText = _catBut.ParentCat.Closed == true && "►" || "▼";

			draw.RoundedBox( 0 , 0, 0 ,w ,h , Color(56,56,56,225) )
			surface.SetFont( "LocalReputationFont_Large" );
			local _textX, _textY = surface.GetTextSize( _closedText )

			draw.DrawText( _closedText , "LocalReputationFont_Large",w/2-(_textX/2),h/2-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_LEFT)

			//_cat:FindSize()
		end
	
		function _catBut:OnMousePressed( _c )

			if _c == MOUSE_LEFT then
					
				_catBut.ParentCat.Closed = !_catBut.ParentCat.Closed;	
				_catBut.ParentCat:FindSize()

				if _catBut.ParentCat.Closed == true then

					_catPanel:Clear()
					//_cat.FactionList:Remove()

				else

					// Create the information
					_catBut.ParentCat:SetupFactionList()

				end

			end

		end

		function _cat:SetupFactionList()

			local _factionList = vgui.Create( "DScrollPanel" , _cat )
			_factionList:SetSize( _cat:GetWide() , _catPanel:GetTall() )
			_factionList:SetPos( 0 , 0 )
			//_factionList:Dock(FILL)

			_factionList.Factions = {};

			--for i=1, 30 do
					
				--local _FactionDebugBut = vgui.Create("DButton", _factionList);
				--_FactionDebugBut:Dock(TOP)
				--_FactionDebugBut:SetSize( _cat:GetWide() , _hMod * 60 )
		
				--_factionList:Add( _FactionDebugBut )
				--table.insert( _factionList.Factions , _FactionDebugBut );

			--end
			
			for k , v in pairs( _cat.Factions ) do
				
				local _FactionRow = vgui.Create("DPanel", _factionList);
				_FactionRow:Dock(TOP)
				_FactionRow:SetSize( _cat:GetWide() , _hMod * 75 )
				_FactionRow:DockMargin(0,0,0,5)
				_FactionRow.Fac = v;
				//_FactionDebugBut:SetText( PlayerReputations.config.Factions[v][1] )
				_FactionRow.Closed = true;
				_FactionRow.Cat = _cat;
				function _FactionRow:Paint(w,h)

					draw.RoundedBox( 0 , 0, 10 ,w ,h-10 , Color(25,25,25,225) )
					draw.RoundedBox( 0 , 0, 0 ,w ,10 , Color(255,255,255,225) )
					surface.SetFont( "LocalReputationFont_Medium" );
					local _textX, _textY = surface.GetTextSize( PlayerReputations.config.Factions[v][1] )

					//draw.DrawText( PlayerReputations.config.Factions[v][1] , "LocalReputationFont_Medium",_FactionRow:GetWide()*0.1 - (_textX*0.8), _FactionRow:GetTall()*0.5 - (_textY*1.5),Color(255,255,255,255),TEXT_ALIGN_LEFT)


				end
				
				local _facToggle = vgui.Create( "DButton" , _FactionRow );
				//_facToggle:SetPos( _FactionRow:GetWide()*0.1 - (_facToggle:GetWide()*0.8), _FactionRow:GetTall()*0.5 - (_facToggle:GetTall()*1.5) )
				//_facToggle:SetSize( _wMod * 70, _hMod * 70 )
				_facToggle:SetSize(  _cat:GetWide() , _hMod * 75 )
				_facToggle:SetText( "" )
				function _facToggle:Paint( w, h)

					local _closedText = _FactionRow.Closed == true && "►" || "▼";
					surface.SetFont( "LocalReputationFont_Medium" );
					local _textX, _textY = surface.GetTextSize( _closedText )
					draw.DrawText( _closedText  , "LocalReputationFont_Medium",(w*.07)-(_textX/2),(h*0.5)-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_LEFT)
					draw.DrawText( PlayerReputations.config.Factions[v][1]   , "LocalReputationFont_Medium",(w*.125)-(_textX/2),(h*0.5)-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_LEFT)

				end
				
				
				local _RepList = vgui.Create( "DScrollPanel", _FactionRow);
				//_RepList:SetSize( _FactionRow:GetWide(), _hMod * 10 )
				_RepList:Dock(FILL)
				_RepList:DockMargin( 0,75,0,0 )

				function _FactionRow:SetupReputationList()

					for x , y in pairs( PlayerReputations.config.Reputations ) do
						
						if PlayerReputations.config.Factions[v][2] 
							&& istable(PlayerReputations.config.Factions[v][2]) 
							&& PlayerReputations.config.Factions[v][2][x] 
							&& PlayerReputations.config.Reputations[PlayerReputations.config.Factions[v][2][x]]
							then
							
							local _RepNum = PlayerReputations.config.Factions[v][2][x];
							local _RepAmount , _DefaultedRepAmount = LocalPlayer():GetReputation( _RepNum )
							local _RepBracket, _DefaultedBracket = LocalPlayer():GetReputationBracket( _RepNum )
							local _Reputation = vgui.Create( "DPanel" )
							_Reputation:SetSize( _FactionRow:GetWide() , _hMod*75 );
							_Reputation:Dock( TOP )

							_RepToGet = _RepBracket[3] - _RepBracket[2]
						
							local _CurrentRepInBracket = _RepBracket[3] - _RepAmount;
							//print( _RepBracket[3] .. " - " .. _RepAmount .. " = ".. _CurrentRepInBracket)
							//_Reputation:SetText( PlayerReputations.config.Reputations[_RepNum].name )
							_Reputation.name = _DefaultedRepAmount == true && "Hidden" || PlayerReputations.config.Reputations[_RepNum].name;
							local _RepTarget = _DefaultedBracket != true && _DefaultedRepAmount != true && (_RepToGet-_CurrentRepInBracket) .. "/" .. _RepToGet || "";
							//_RepTarget = (_CurrentRepInBracket) .. "/" .. _RepToGet;
							function _Reputation:Paint( w , h )

								draw.RoundedBox( 0 , 0, 10 ,w ,h-10 , Color(86,86,86,225) )
								draw.RoundedBox( 0 , 0, 0 ,10 ,h , Color(220,220,220,225) )
								draw.RoundedBox( 0 , 0, 0 ,10 ,10 , Color(0,0,0,240) )
								draw.RoundedBox( 0 , 10, 0,w-10 ,10 , Color(70,70,70,225) )
								local _textX, _textY = surface.GetTextSize( PlayerReputations.config.Reputations[_RepNum].name )
								draw.DrawText( _Reputation.name  , "LocalReputationFont_Medium",(w*.09),(h*0.5)-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_LEFT)

								draw.DrawText( _RepTarget , "LocalReputationFont_Medium",(w*.8),(h*0.5)-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_RIGHT)

							end
							
							_RepList:Add( _Reputation )

						end
						
					end
				
				end

				_FactionRow.ReputationList = _RepList;
				
				function _FactionRow:FindSize()

					if _FactionRow.Closed == true then

						_FactionRow:SetSize( _cat:GetWide() , _hMod * 75 )		
						_RepList:Dock(FILL)				

					else

						local SizeMod = PlayerReputations.config.Factions[_FactionRow.Fac];

						if istable(SizeMod) then
							
							SizeMod = #SizeMod;

						else

							SizeMod = 1;

						end

						_FactionRow:SetSize( _cat:GetWide() , _hMod * ((75*2)+(SizeMod*75)) )

					end

				end
				_FactionRow:FindSize()
				function _facToggle:OnMousePressed( _k )

					if _k == MOUSE_LEFT then
						
						_FactionRow.Closed = !_FactionRow.Closed;

						if _FactionRow.Closed == true then
							
							_FactionRow.ReputationList:Clear();

						else

							_FactionRow:SetupReputationList()

						end
						_FactionRow:FindSize()
						_FactionRow.Cat:FindSize()
					end

				end
				
				_factionList:Add( _FactionRow )
				table.insert( _factionList.Factions , _FactionRow );


			end

			_cat.FactionList = _factionList;
			_cat:FindSize()
			_catPanel:Add(_factionList);
		end
		
		function _cat:Paint( w, h )

			draw.RoundedBox( 0 , 0, 0 ,w ,h , Color(56,56,56,225) )
			surface.SetFont( "LocalReputationFont_Large" );
			local _textX, _textY = surface.GetTextSize( name )

			draw.DrawText( name , "LocalReputationFont_Large",(w*0.1)*_wMod,_hMod*25-(_textY/2),Color(255,255,255,255),TEXT_ALIGN_LEFT)

			//_cat:FindSize()
		end

		
		_FrameScrollPanel:Add(_cat);
		table.insert(_Frame.Categories,_cat);
	end
	/*
		PlayerReputations.config.Categories = {
			{ "Patch 1.0" , {1,2,3} }
		}
	*/

	for k , v in pairs( PlayerReputations.config.Categories ) do
		
		_Frame:CreateCategory( v[1] , v[2] )
	
	end
		//_Frame:CreateCategory( "asseaters", {1} )
		
	_p.ReputationMenu = _Frame;
	
	return _Frame;
end

hook.Add( "ReputationMenu" , "RepStart", ReputationMenu)