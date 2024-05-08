-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT!
include("shared.lua" )
 
 ENT.Mat = Material("darksouls/summonsign/orangess.png")
 
function ENT:Draw( )
	self:DrawShadow(false)
	self:DestroyShadow()
	
	if LocalPlayer():GetPos():Distance( self:GetPos() ) < 1000 then
		
		cam.Start3D2D( self:GetPos() + Vector( 0,0,-1 )  ,  self:GetAngles() + Angle(0,-90,0), 1 )
			surface.SetMaterial(  self.Mat )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawTexturedRect( -75*0.5, -25*0.5, 75, 25 )
		
		cam.End3D2D()
		cam.Start3D2D( self:GetPos() + Vector( 0,0,-1 )  ,  self:GetAngles() + Angle(180,-90,0), 1 )
			surface.SetMaterial(  self.Mat )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawTexturedRect( -75*0.5, -25*0.5, 75, 25 )
		
		cam.End3D2D()
		
	end
	
end

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

net.Receive( "sendSoapStoneInformation" , function( _l , _p )

	local _index = net.ReadInt( 20 );
	local _publicInfo = net.ReadTable();
	
	//PrintTable( _publicInfo ) 
	SignMenu( _publicInfo , _index )

end )

surface.CreateFont( "Trebuchet15", {
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


local SCREEN_W, SCREEN_H = 1768, 992;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
local _SignMenuFrameCache;
function ReturnSignMenuFrameCache()

	if ispanel( _SignMenuFrameCache ) then
	
		return _SignMenuFrameCache
		
	else
	
		return nil
		
	end
	
end

net.Receive("receiveSignUpdate", function( _l , _p )
	
	local _Frame = ReturnSignMenuFrameCache()
	
	if IsValid(_Frame) then

		_Frame.Upvotes = net.ReadInt( 20 )
		_Frame.Downvotes = net.ReadInt( 20 )
	
	end

end )

local lastTime = 0
function SignMenu( _tbl , _index )
	if lastTime > CurTime() then return end
	lastTime = CurTime() +1;
	
	local _Frame = vgui.Create("DFrame")
	
	_Frame:SetSize( 800, 300 )
	
	_Frame:Center()
	local _xF , _yF = _Frame:GetPos();
	_Frame:SetPos( _xF , _yF + 200 )
	
	_Frame:ShowCloseButton( true )
	_Frame:MakePopup()
	_Frame.Alpha = 0;
	_Frame.DoAlpha = true;
	_Frame:SetTitle("Soapstone Message")
	_Frame.Message =  _tbl.Sentence;
	_Frame.Author = _tbl.userName;
	_Frame.Upvotes = _tbl.upVotes;
	_Frame.Downvotes = _tbl.downVotes;
	
	function _Frame:Think()
	
		if self.DoAlpha then
			
			self.Alpha = Lerp( 0.02, self.Alpha , 255 )
			
			if self.Alpha == 255 then
			
				self.DoAlpha = false
				
			end
			
		end
			
	
	end
	
	function _Frame:OnClose()
	
		_Frame.DoAlpha = true;
	
	end
	
	function _Frame:Paint( w, h )
	
		draw.RoundedBoxEx( 0,0,0,w,h , Color( 56, 56 ,56 , _Frame.Alpha ) )
	
		draw.RoundedBoxEx( 0,0,0,w,25 , Color(25, 25 ,25 , _Frame.Alpha ) )
		surface.SetFont("Trebuchet15")
		local _x , _y = surface.GetTextSize(  " + " .. self.Upvotes  .. " - " .. self.Downvotes )
		draw.SimpleText( self.Message , "Trebuchet24", w /2 , h * 0.2 , Color(255, 255 ,255, _Frame.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		draw.SimpleText( "- " .. self.Author , "Trebuchet15", w /2 , h * 0.2 + 25 , Color(255, 255 ,255, _Frame.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		draw.SimpleText( " - " .. self.Downvotes , "Trebuchet15", w / 2 + _x, h * 0.5 + 25 , Color(255, 255 ,255, _Frame.Alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT );
		draw.SimpleText( " + " .. self.Upvotes, "Trebuchet15",w / 2 - _x, h * 0.5 + 25 , Color(255, 255 ,255, _Frame.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT );
		
	end 
	
	_UpvoteButton = vgui.Create( "DButton" , _Frame )
	local _baseAdj = 450 -92;
	_UpvoteButton:SetSize( _wMod * 35 , _hMod * 35)
	_UpvoteButton:SetPos( _Frame:GetWide() * .5 - _wMod * 35 , _Frame:GetTall() * 0.8 )
	_UpvoteButton:SetText( "+" )
	
	_DownVoteButton = vgui.Create( "DButton" , _Frame )
	
	_DownVoteButton:SetSize( _wMod * 35 , _hMod * 35 )
	_DownVoteButton:SetPos( _Frame:GetWide() *0.5 + _wMod * 5  , _Frame:GetTall() * 0.8  )
	_DownVoteButton:SetText( "-" )
	
	
	function _UpvoteButton:DoClick(k) 
		if LocalPlayer().__LastVote && !LocalPlayer():IsSuperAdmin() && LocalPlayer().__LastVote > CurTime() then return LocalPlayer():ChatPrint("You are on cooldown for voting messages!") end

		net.Start("sendUpvoteRequest")
			net.WriteInt( _index, 32 )
		net.SendToServer()
	
	end
	
	function _DownVoteButton:DoClick(k) 
		if LocalPlayer().__LastVote && !LocalPlayer():IsSuperAdmin() && LocalPlayer().__LastVote > CurTime() then return LocalPlayer():ChatPrint("You are on cooldown for voting messages!") end	
	
		net.Start("sendDownvoteRequest")
			net.WriteInt( _index, 32 )
		net.SendToServer()
		
	end
	_SignMenuFrameCache = _Frame;
end

net.Receive("sendClientSignCooldown", function( _l, _p ) 
	
	LocalPlayer().__LastVote = net.ReadInt(32)
	

end )

