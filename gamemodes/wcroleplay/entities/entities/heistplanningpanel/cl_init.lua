include("shared.lua")  

function ENT:Initialize( )	
    self:SetRenderBounds(Vector( -3000, -3000, -3000 ), Vector( 3000, 3000, 3000 ));
end  

local _w, _h = ScrW( ), ScrH( );
local SCREEN_W, SCREEN_H = 2560, 1440;
local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

//
// Josh 'Acecool' Moser
// 
function draw.RoundedBorderedBox( cornerDepth, x, y, w, h, color, borderSize, borderColor )
	local _corners = ( isnumber( cornerDepth ) && cornerDepth > 0 && cornerDepth % 2 == 0 ) && true || false;
	return draw.RoundedBorderedBoxEx( cornerDepth, x, y, w, h, color, borderSize, borderColor, _corners, _corners, _corners, _corners );
end

//
// Helper-function which gives a "border" effect by drawing two objects over eachother - Josh 'Acecool' Moser
//
function draw.RoundedBorderedBoxEx( cornerDepth, x, y, w, h, color, borderSize, borderColor, topleft, topright, bottomleft, bottomright )
	draw.RoundedBoxEx( cornerDepth, x - borderSize, y - borderSize, w + borderSize * 2, h + borderSize * 2, borderColor, topleft, topright, bottomleft, bottomright );
	draw.RoundedBoxEx( cornerDepth, x, y, w, h, color, topleft, topright, bottomleft, bottomright );
end

function ENT:Draw( ) 
	if self:GetPos():Distance(LocalPlayer():GetPos()) > 2000 then return; end
	if self:getFlag( "planningPanelProperty" , nil ) != nil && fsrp.PropertyTable[self:getFlag( "planningPanelProperty" , nil )] then
		if !fsrp.PropertyTable[self:getFlag( "planningPanelProperty" , nil)].PrimaryOwner then
		
			return
			//if fsrp.PropertyTable[self:getFlag( "planningPanelProperty" , 1 )].PrimaryOwner[2] != LocalPlayer():SteamID() then return end
		else
			local _owner = player.GetBySteamID( fsrp.PropertyTable[self:getFlag( "planningPanelProperty" , nil)].PrimaryOwner[2] );
			
			if _owner != LocalPlayer() && _owner.heist && !_owner.heist.Players[LocalPlayer():SteamID()] then
			
				return
			
			end
		
		end
		
	end
	
	self:DrawModel()
	local pos = self:LocalToWorld(self:OBBMaxs());
	local ang = self:GetAngles();
	pos = pos + ang:Right() * 67.5 - ang:Forward() * 5
	//ang:RotateAroundAxis(ang:Right(), 90); 
    ang:RotateAroundAxis(ang:Up(), -90);
	
	//ang:RotateAroundAxis(ang:Forward(), -90);
	
	cam.Start3D2D( pos , ang, .2);
	
		surface.SetFont("Trebuchet20")
		local ShopName = "Heist Planning Panel"
		local Width, Height = surface.GetTextSize(ShopName)
		//Height = 15;
		//Width = 44;
		local _hModifier = _hMod * 100;
		
		draw.RoundedBorderedBox( 1, _wMod * -335,_hMod * - 22.5, _wMod * 710, _hMod * 475, Color(255,255,255), 5, Color(0,0,0) )
		surface.SetDrawColor(56, 56, 56, 128)
		surface.DrawRect(_wMod * -335 ,_hMod * -22.5 ,_wMod * 710  , _hMod * 60)
		surface.SetDrawColor(255, 255,255, 255) 
		//surface.DrawOutlinedRect( _wMod * -335,_hMod * - 22.5, _wMod * 710, _hMod * 475 )
		draw.SimpleText( ShopName, 'Trebuchet20', 0 , ( _hMod * 7.5 ) , Color(56, 56, 56, 255), 1, 1);
		surface.SetFont("Trebuchet24")
		
		draw.SimpleText( "Heist\t->\tDirection\t->\tSetup\t->\tMission" , 'Trebuchet24', _wMod * - 250, ( _hMod * 50 ) , Color(56, 56, 56, 255), 0, 0);
		
		surface.SetDrawColor( 56, 56 ,56 , 255 )
		surface.SetDrawColor(255, 255,255, 255) 
		
		//draw.RoundedBorderedBox( 1, _wMod * -335, _hMod * 39 , _wMod * 100 , _hMod * 25 , Color(255,255,255), 1, Color(0,0,0) )
	
	cam.End3D2D();
end
