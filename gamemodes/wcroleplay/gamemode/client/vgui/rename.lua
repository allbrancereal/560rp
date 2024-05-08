
fsrp = fsrp || {}
function fsrp.IsValidName ( first, last, skipFirstLast )
	local first = string.lower(first);
	local last = string.lower(last);

	if (!skipFirstLast) then
		if (!fsrp.IsValidPartialName(first)) then return false; end
		if (!fsrp.IsValidPartialName(last)) then return false; end
	end
	
	if (first == "john" && last == "doe") then return false end
	
	
	for k, v in pairs(fsrp.config.InvalidRPNames) do
			if (first == v || last == v) then
				
				return false;
			end
		
	end
	
	
	return true;
end

local FRAMEAlpha = 0;


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

local FRAME;

net.Receive("showNameChangeMenu", function( _l, _p )
	
	CreateNameMenu( net.ReadBool( ) )
	
end )

	
function CreateNameMenu( ispaid )
	
	local shouldPayForNameChange = ispaid || false;

	
	local _p = LocalPlayer();

	if FRAME then
	
		FRAME:Remove()
		
	end

	FRAME = vgui.Create( "DFrame" )
	
	FRAME:SetSize( _wMod * 1200 , _hMod * 500 )
	//FRAME:SetSize( ScrW() - 25 , _hMod * 1080 )
	
	FRAME:ShowCloseButton( shouldPayForNameChange )
	//FRAME:ShowCloseButton( true )
	FRAME:SetDraggable(true)
	FRAME:SetTitle("Who are you?")
	FRAME:Center()
	//FRAME:SetPos( 15 , _hMod )
	
	LocalPlayer():setFlag("restrictInv", true)
	FRAME:MakePopup()
	
	local W, H = FRAME:GetWide() /2, FRAME:GetTall();
	
	function FRAME:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, FRAMEAlpha )
		surface.DrawRect( 0, 0 , w , h )
		
	end
	
	function FRAME:OnClose( )
	
		LocalPlayer():setFlag("restrictInv", false)
		FRAME.DoCloseAnim = true;
		FRAME.DoBeginning = true;
		FRAMEAlpha = 0;
		
		hook.Remove("Think", "MonColors");

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
	

	local playerNameText = vgui.Create("DPanel",FRAME)
    playerNameText:SetPos( 25 , 25)
    playerNameText:SetSize( FRAME:GetWide(), 75 )
	
    playerNameText.Paint = function(w, h)
        //draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(0,0,0,200))	
        //surface.SetDrawColor(0,0,0,255)
        //surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())		
		if firstName && lastName then
			
			if firstName:GetValue() == "John" && lastName:GetValue() == "Doe" then
				draw.DrawText( "Welcome to West Coast Roleplay " .. LocalPlayer():Nick()  ,"fsrp.vgui_createplayer_name", W,0,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			else
				draw.DrawText("Welcome to West Coast Roleplay " ..  string.sub( firstName:GetValue() , 1, 15) .. " " .. string.sub( lastName:GetValue() ,1,15) ,"fsrp.vgui_createplayer_name",W,0,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			end
		end
		local padding = 160
		
   end	

		
		local PanelSize = W * .5 - 7.5;
		local _pCache_1 = vgui.Create("DPanelList", FRAME);
		_pCache_1:EnableHorizontal(false)
		_pCache_1:EnableVerticalScrollbar(true)
		_pCache_1:StretchToParent(5, 30, 5, 5);
		_pCache_1:SetPos(FRAME:GetWide()/2-150, 75);
		_pCache_1:SetSize(300, 150);
		
		_pCache_1:SetPadding(5);
		
		local _pCache_2 = vgui.Create("DPanelList", FRAME);
		_pCache_2:EnableHorizontal(false)
		_pCache_2:EnableVerticalScrollbar(true)
		_pCache_2:SetPos(5, 30);
		_pCache_2:SetSize(120, 150);
		_pCache_2:SetPadding(5);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("Character's First Name:");
		_pCache_1:AddItem(firstNamel);
		
		firstName = vgui.Create("DTextEntry", _pCache_1);
		firstName:SetPos(80, 30);
		firstName:SetSize(100, 20);
		firstName:SetText("");
		
		_pCache_1:AddItem(firstName);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("");
		_pCache_1:AddItem(firstNamel);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("Character's Last Name:");
		_pCache_1:AddItem(firstNamel);
		
		lastName = vgui.Create("DTextEntry", _pCache_1);
		lastName:SetPos(80, 30);
		lastName:SetSize(100, 20);
		lastName:SetText("");
		_pCache_1:AddItem(lastName);
		
		local firstNamel = vgui.Create("DLabel", _pCache_1);
		firstNamel:SetPos(80, 30);
		firstNamel:SetSize(100, 20);
		firstNamel:SetText("");
		_pCache_1:AddItem(firstNamel);
		
		SubmitButton = vgui.Create("DButton", _pCache_1);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText("Create User");
		
		_pCache_1:AddItem(SubmitButton);
		
		local function MonitorColors ( wantReturn )
			local firstNamex = firstName:GetValue();
			local lastNamex = lastName:GetValue();

			local anyInvalid = false;
			
			if !fsrp.IsValidPartialName(firstNamex) then
				firstName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				firstName:SetTextColor(Color(0, 0, 0, 255));
			end
	
			if !fsrp.IsValidPartialName(lastNamex) then
				lastName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			else
				lastName:SetTextColor(Color(0, 0, 0, 255));
			end
			
			if (!fsrp.IsValidName(firstNamex, lastNamex, true)) then
				lastName:SetTextColor(Color(255, 0, 0, 255));
				firstName:SetTextColor(Color(255, 0, 0, 255));
				anyInvalid = true;
			end
			
			if (anyInvalid) then
				SubmitButton:SetEnabled(false);
			else
				SubmitButton:SetEnabled(true);
			end
			
			if (wantReturn) then
				return !anyInvalid;
			end
		end
		hook.Add('Think', 'MonColors', MonitorColors);
		
		function SubmitButton:DoClick ( )
			
			hasEntered = true;
				
				local NetFName = string.sub(firstName:GetValue(), 1, 15)
				local NetLName = string.sub(lastName:GetValue(), 1, 15)
				
				net.Start( "fsrp.sendUsYourName" )
					net.WriteString( NetFName )
					net.WriteString( NetLName )
					net.WriteBool( shouldPayForNameChange )
				net.SendToServer()
				hook.Remove("Think", "MonColors");
		LocalPlayer():setFlag("restrictInv", false)
				FRAME:Remove();
				
			end
		
		

end