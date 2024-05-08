-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT!
include("shared.lua" )
 
function ENT:Draw( )
self:DestroyShadow()
	if LocalPlayer():GetPos():Distance( self:GetPos() ) < 1000 then
		self:DrawModel()
	end
end

net.Receive("sendBonfire", function( len, _p )

	//RunConsoleCommand("play", "dwarksouls/bonfire/bonfirewav.wav" )
	
	local _litBonfires = net.ReadInt(32)
	local _isRefresh = net.ReadBool()
	local _litBonfiresTbl = net.ReadTable()
	for k ,v in pairs( _litBonfiresTbl ) do
	
		ents.GetByIndex( v ).IsLit= true;
		
	end
	ents.GetByIndex( _litBonfires ).IsLit = true;
	
	starttime1 = CurTime()
	alpha1 = 255
	local back = Material("burger/darksouls/blackbar")
	local text_Lit = Material("darksouls/bonfirelit.png")
	
	//ENT.isLit = true
	//ENT:SetParticleAction( "Create" )
	hook.Add( "HUDPaint" , "lightBonfire" , function()
	
		if LocalPlayer().DoBonfireLighting then	
		
		local timepassed = math.abs(CurTime() - starttime1 ) 
			
			if timepassed > 0 and timepassed < 10 then
		
				local mul1 = 0.5 + math.min(timepassed/10,0.1)
			
				if timepassed < 2 and timepassed > 5 then
					alpha1 = (timepassed-3) * (255/2)
				else
					alpha1 = 255 - (timepassed-2) * (255/0.75)
				end
				
				if timepassed then
					alpha2 = (timepassed) * (255/0.5)
				end
				
				if timepassed > 3 then
					alpha2 = 255 - (timepassed-3) * (255/1)
				end
					
				surface.SetDrawColor( 255, 255, 255, math.Clamp(alpha2,0,255) )
				surface.SetMaterial( back )
				surface.DrawTexturedRectRotated( ScrW()/2, ScrH()/2, ScrW() , ScrW()/4 ,0 )
				
				surface.SetDrawColor( 255, 255, 255, math.Clamp(alpha1,0,200) )
				surface.SetMaterial( text_Lit )
				surface.DrawTexturedRectRotated( ScrW()/2, ScrH()/2, 1024*mul1 , (128+80)*mul1,0 )
			
			end
		
		end
	 
	
	end )
	if !_isRefresh then
		
		LocalPlayer().DoBonfireLighting = true;
		LocalPlayer():EmitSound( "darksouls/bonfirelit.wav" )
	
	end
	
	
	timer.Simple( 10, function()
	
		LocalPlayer().DoBonfireLighting = false
		hook.Remove("HUDPaint", "lightBonfire")
		
	end )
	
end )


surface.CreateFont( "Trebuchet20", {
	font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = ScreenScale(7.5),
	weight = 80,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

net.Receive( "sendBonfireMenu" , function( len , _p )
	
	LocalPlayer():EmitSound( "darksouls/enteredbonfire.wav" )
	local _OurBonfire = net.ReadInt( 32 )
	local _id = net.ReadInt( 8 )
	local _bonfiresLit = net.ReadTable();
	LocalPlayer().LitBonfires = _bonfiresLit;
	
	timer.Simple( .25, function()
	
		BonfireMenu( _OurBonfire , _id, _bonfiresLit)
	
	end ) 
	
end )

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;


local function lerpColor( _delta, _from , _to  )

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
function BonfireMenu( _Index , id ,_bonfiresLit)
	
	if _FRAME then _FRAME:Remove() end
	//print( id )
	local _FRAME = vgui.Create( "DFrame" )
	_FRAME:SetSize( _wMod * 750 , _hMod * 500)
	_FRAME:ShowCloseButton( false )
	_FRAME:SetTitle( "" )
	_FRAME:SetPos( _wMod * 250 , _hMod * 100)
	_FRAME:MakePopup()
	_FRAME.Alpha = 0
	_FRAME.DoFadeIn = true;
	_FRAME.CloudMat	= Material("darksouls/cloud.jpg")
	hook.Add("HUDPaint", "CloudPaint", function()
	
	
		surface.SetMaterial( _FRAME.CloudMat )
		surface.SetDrawColor( 255, 255 ,255 , _FRAME.Alpha )
		surface.DrawTexturedRect( 0,0, ScrW() + 100 + (100*math.sin(0.3*CurTime()) ) , ScrH()  + 100 + (100*math.sin(0.3*CurTime()) )  ) 
		draw.RoundedBoxEx( 0, 0 , 0 , ScrW() , ScrH() , Color( 56, 56, 56, _FRAME.Alpha/2 ) )
	
	
	end )
	
	function _FRAME:OnClose()
	
	
			hook.Remove("HUDPaint","CloudPaint")
			
	end
	_FRAME.StartClose = false;
	function _FRAME:Think( )
		
		if _FRAME.DoFadeIn then
		
			_FRAME.Alpha = Lerp( 0.01, _FRAME.Alpha , 255 );
			
			if _FRAME.Alpha == 255 then
			
				_FRAME.DoFadeIn = false;
				
			end
		
		elseif _FRAME.StartClose == true then
		
			_FRAME.Alpha = Lerp( 0.01, _FRAME.Alpha , 0 );
			
			if _FRAME.Alpha == 255 then
			
				_FRAME.DoFadeIn = true;
				_FRAME.StartClose = false;
				_FRAME:Close()
				
			end
			
		end
	
	end
	
	function _FRAME:Paint( w, h )
	
		draw.RoundedBoxEx( 0, 0 , 0 , w , h , Color( 56, 56, 56, _FRAME.Alpha ) )
		draw.RoundedBoxEx( 0, 0 , 0 , w , 25 , Color( 75, 75, 75, _FRAME.Alpha ) )
		draw.SimpleText( "Bonfire", "Trebuchet20", 2, 1.5, Color( 255, 255 ,255 , 255 ) , TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
		
	end

	CloseButton = vgui.Create( "DButton" , _FRAME )
	CloseButton:SetPos( _FRAME:GetWide() - 100 , 0)
	CloseButton:SetSize( 100, 25 )
	CloseButton:SetText( "Exit" )
	CloseButton.Clicked = false;
	
	function CloseButton:Paint( w , h )
	
		draw.RoundedBoxEx( 0, 0 , 0 , w , h , Color( 56,56,56 , _FRAME.Alpha ) )
		
	end
	
	function CloseButton:DoClick( k ) 
		
		self.Clicked = true;
		
		self:GetParent().StartClose = true;
	end
	
	function CloseButton:OnMouseReleased( k )
		
		if k == MOUSE_LEFT then
		
			hook.Remove("HUDPaint","CloudPaint")
			_FRAME:Close()
			
		end
		
	end 
	local _index = 0;
	local _Fx, _Fy = _FRAME:GetPos()
	local _BonfireScroll = vgui.Create("DScrollPanel", _FRAME)
	_BonfireScroll:SetPos( 5, 45 )
	_BonfireScroll:SetSize( _FRAME:GetWide() * 0.5 -10 , _FRAME:GetTall() - 50 )
	/*
		if BonfireTaxis.Config[game.GetMap()] then
		
			_BonfireLocation.MaterialCache = BonfireTaxis.Config[game.GetMap()][k].mat
		
		end
		*/
		
	local _SelectedBonfire = vgui.Create("DPanel", _FRAME )
	_SelectedBonfire:SetPos( _wMod * 375 , _hMod * 35 )
	_SelectedBonfire:SetSize( 310, 175 )
	function _SelectedBonfire:UpdateCurrentSelection( _uid )
		
		if _uid != 0 then
		
			self.TrueTeleport = false;
			if !BonfireTaxis.Config[game.GetMap()][_uid].mat then return end
			self.Mat = BonfireTaxis.Config[game.GetMap()][_uid].mat;
			self.Tbl = BonfireTaxis.Config[game.GetMap()][_uid];
		
		else
		
			self.TrueTeleport = true;
			
		end
		
	end
	function _SelectedBonfire:Paint( w , h )
		
		if self.Mat then
		
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( self.Mat )
			surface.DrawTexturedRect( 0,0, w, h )
		
		end
		
	end 
	
	if id != 0 then
	
		_SelectedBonfire:UpdateCurrentSelection( id );
	
	end
	
		local _TeleportButton = vgui.Create( "DButton" , _FRAME)
	for k , v in pairs( BonfireTaxis.Cache ) do	
		local _BonfireLocation = _BonfireScroll:Add("DButton")
		//_BonfireLocation:SetPos( 50 , (_index*75))
		_BonfireLocation:InvalidateLayout(true)
		_BonfireLocation:SetSize( _BonfireScroll:GetWide(), 40 )
		_BonfireLocation:SetPos( 0, 50 * _index  )
		_BonfireLocation.ID = k;
		_BonfireLocation:SetEnabled( false )
		_BonfireLocation:SetText( BonfireTaxis.Config[game.GetMap()][k].name )
		function _BonfireLocation:Paint( w , h )
				
			draw.RoundedBoxEx( 0,0,0, w,h , Color(120,120,120, _FRAME.Alpha ))
			
		end
		
		function _BonfireLocation:DoClick( k )
		
			_SelectedBonfire:UpdateCurrentSelection( self.ID ) 
			
			if !_TeleportButton:IsEnabled() then _TeleportButton:SetEnabled( true ) end
		end
		
		if table.HasValue( _bonfiresLit , k ) then _BonfireLocation:SetEnabled( true ) end
		
		_index = _index + 1;
	end
		
	//_TeleportButton
	
		_TeleportButton:SetSize( _BonfireScroll:GetWide(), 40 )
		_TeleportButton:SetPos( _FRAME:GetWide() / 2 + 5, 245  )
		_TeleportButton:SetEnabled( false )
		_TeleportButton:SetText( "Teleport" )
		function _TeleportButton:Paint( w , h )
				
			draw.RoundedBoxEx( 0,0,0, w,h , Color(120,120,120, _FRAME.Alpha ))
			
		end
		
		function _TeleportButton:DoClick( k )
		
			hook.Remove("HUDPaint","CloudPaint")
				net.Start("getTeleportCall")
					net.WriteInt((_SelectedBonfire.Tbl.ID),8)
				net.SendToServer()
			
			_FRAME:Close()
		end
		
end 
net.Receive( "GetWhiteScreen", function( _l , _p )


local _White = false;
local _Alpha = 0;
local _DidWhite = false;
local _didfunction = false;
local _DidWhiteStamp = 0;

hook.Add( "HUDPaint", "MakeWhite", function()

	if !_DidWhite then
	
		_Alpha = Lerp( 0.025, _Alpha , 255 )
		
		if _Alpha >= 254 then
		
			_White = true;
			if !_didfunction then
			
				net.Start("sendReadyTP")
				
				LocalPlayer():EmitSound("darksouls/teleport.wav")
				net.SendToServer()
				_didfunction = true;
			
			end
			
			_DidWhite = true; 
			_DidWhiteStamp = CurTime() + 2;
			
		end
	
	elseif _DidWhite && CurTime() > _DidWhiteStamp then
	
		_Alpha = Lerp( 0.05, _Alpha , 0 )
	
		if _Alpha <= 1 then
		
			_White = false;
			hook.Remove( "HUDPaint", "MakeWhite" )
			
		end
		
	end
	
	draw.RoundedBoxEx( 0,0,0,ScrW(),ScrH(), Color(255,255,255, _Alpha ) )
	
end )

end )