

local PANEL = {};
--local blackOut = 255;
local cinematicAlpha = 255;
local topSlider = 100;
local bottomSlider = 100;
local defaultColor = 0;

surface.CreateFont("IntroTextBig", {
	size = ScreenScale(70), 
	weight = 100, 
	antialias = true,
	shadow = true, 
	font = "Trebuchet MS"
})
surface.CreateFont("IntroTextSmall", {
	size = ScreenScale(15), 
	weight = 100, 
	antialias = true,
	shadow = true, 
	font = "Trebuchet MS"
})
surface.CreateFont("IntroTextSuperSmall", {
	size = ScreenScale(10), 
	weight = 100, 
	antialias = true,
	shadow = true, 
	font = "Trebuchet MS"
})

function PANEL:Init ( )
	self:SetMouseInputEnabled( false );
	self:MoveToFront()
	self.ThankYouPerson = "Boggle Crunch"//fsrp.specialThanks[math.random(#fsrp.specialThanks)] or "Tibba";
	
end;

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
end;
 

local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
function PANEL:Paint ( )	
	// Center Cinematic Text
	surface.SetDrawColor(0,0,0,cinematicAlpha)
	surface.DrawRect(0,0,ScrW(), ScrH())
	draw.SimpleText("Welcome to the West Coast", "IntroTextBig", ScrW()/2, ScrH()/2-25, Color(255, 255, 255, cinematicAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText("Special thanks to: " .. (self.ThankYouPerson != nil and self.ThankYouPerson or "Tibba") , "IntroTextSmall", ScrW()/2, (ScrH()/2)+50, Color(255, 255, 255, cinematicAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText("Created by Tibba" , "IntroTextSuperSmall", ScrW()/2, (ScrH()/2)+75*_hMod, Color(255, 255, 255, cinematicAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		
end;
local cachedTime = 0;

function PANEL:Think()

	if CurTime() > cachedTime then
	
	cinematicAlpha = Lerp( 0.01, cinematicAlpha , 0 )
	
	
	if defaultColor > 99 then
	
		self:Remove();
		
		LocalPlayer():Notify("Press F1 to Access the Main Menu (Check out the MOTD)")
		LocalPlayer():Notify("Press F2 to Access the Property Menu when looking at a door!")
		LocalPlayer():Notify("Press F4 to Access the Buddy Menu!")
	end;
		cachedTime = CurTime()+0.01
	end
end;



vgui.Register("cinematicintro", PANEL);