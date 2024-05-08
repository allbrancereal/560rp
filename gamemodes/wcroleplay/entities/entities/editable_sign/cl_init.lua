include("shared.lua")  

surface.CreateFont("SignFont", {
	size = 100, 
	weight = 1000, 
	antialias = true,
	shadow = false, 
	font = "Tahoma"	
})   
local function SignEditor ( _index )
	local W, H = 180, 120;
	//local Ent = LocalPlayer():GetEyeTrace().Entity
	local EntID = _index;
	
	LocalPlayer():setFlag("restrictInv", true)
	local DermaPanel = vgui.Create("DFrame")
	DermaPanel:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	DermaPanel:SetSize(W, H)
	DermaPanel:SetTitle("Sign Editor")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(true)
	DermaPanel:MakePopup()
	//DermaPanel:SetSkin('perp2');
	function DermaPanel:OnClose()
		LocalPlayer():setFlag("restrictInv", false)
	
	end
	
	SignText = vgui.Create("DTextEntry", DermaPanel);
    SignText:SetValue("");
	SignText:SetPos(10, 40);
	SignText:SetTall( 20 )
	SignText:SetWide( 160 )		
	
	local Button = vgui.Create('DButton', DermaPanel);
	Button:SetText('Set Text');
	Button:SetPos(60, 70);	
	function Button.DoClick ( )
		
		LocalPlayer():setFlag("restrictInv", false)
		net.Start( "sendSignText" )
			net.WriteInt( _index, 12 )
			net.WriteString( SignText:GetValue( ) )
		net.SendToServer( )
		
		DermaPanel:Close();
	end
end	
		
function ENT:Initialize( )	
    self:SetRenderBounds(Vector( -3000, -3000, -3000 ), Vector( 3000, 3000, 3000 ));
end  

net.Receive( "signEditor" , function( )

	local _entIndex = net.ReadInt( 12 );
	
	SignEditor( _entIndex );
	
end )
   
	
function ENT:DrawTranslucent( ) 
	//self:DrawModel()
	if self:GetPos():Distance(LocalPlayer():GetPos()) > 2000 then return; end

	local pos = self:LocalToWorld(self:OBBMaxs());
	local ang = self:GetAngles();
	
	//ang:RotateAroundAxis(ang:Right(), 90); 
    ang:RotateAroundAxis(ang:Up(), -90);
	//ang:RotateAroundAxis(ang:Forward(), -90);
	
	cam.Start3D2D( pos, ang, .2);
		surface.SetFont("SignFont")
		local ShopName = self:getFlag( 'sign_text' , "" );
		if ShopName == 0 then
			ShopName = 'Loading...';
		end
		Width, Height = surface.GetTextSize(ShopName)
		//Height = 15;
		//Width = 44;
		
		local xpos = (44 - Width)/2 - 10;
		local ypos = 0;

		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(xpos, ypos -5 , Width + 20, Height + 10)
		draw.SimpleText(ShopName, 'SignFont', 22, 50, Color(255, 255, 255, 255), 1, 1);
	cam.End3D2D();
end
