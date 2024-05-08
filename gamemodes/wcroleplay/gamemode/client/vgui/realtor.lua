

	local SCREEN_W, SCREEN_H = 1920, 1080;

	local _w, _h = ScrW( ), ScrH( );

	local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

surface.CreateFont("RealtorFontSmall", {
	size = ScreenScale(8), 
	weight = 1000, 
	antialias = true,
	shadow = false, 
	font = "Tahoma"
})
function MakeRealtorScreen ( )	
	local W, H = _wMod*800, _hMod*600;
	
	local DermaPanel = vgui.Create("DFrame")
	DermaPanel:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	DermaPanel:SetSize(W, H)
	DermaPanel:SetTitle("")
	DermaPanel:SetVisible(true)
	DermaPanel:SetDraggable(false)
	DermaPanel:ShowCloseButton(true)
	function DermaPanel:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
	
	end 
	
	LocalPlayer():setFlag("restrictInv", true)
	local _vouchers =  "0";
	local _rewardTable = LocalPlayer():GetDailyRewardTable();
	if _rewardTable then
		_vouchers =  tostring(_rewardTable[2])
	end

	DermaPanel:SetAlpha(255);
	function DermaPanel:Paint(w,h)
		surface.SetDrawColor(56, 56, 56, 225);
		surface.DrawRect(5, 5, w, h);
		draw.SimpleText("Realtor's Office - Current Bank Money: $" .. math.Round(LocalPlayer():getBank(),0) .. " - Vouchers #" .. _vouchers, "RealtorFontSmall", _wMod*250, _hMod*10, Color(255, 255, 255, 255), 1);
	
	end
	local _but = vgui.Create("DButton",DermaPanel)
	_but:SetSize(_wMod*100,_hMod*30)
	_but:SetText("Zone Investment")
	_but:SetPos(_wMod*500,_hMod*5)
	function _but:OnMousePressed()
		DermaPanel:Remove()
		LocalPlayer():ShowZoneInvestmentMap()

	end
	
	local PropertySheet = vgui.Create("DPropertySheet", DermaPanel);
	PropertySheet:StretchToParent(5, _hMod*30, 5, 5);
	
	function PropertySheet:Paint(w,h)
		surface.SetDrawColor(25, 25, 25, 128);
		surface.DrawRect(5, 5, w, h);
	
	end
	local PropertySheetPanels = {};
	
	for k, v in pairs( fsrp.PropertyTable ) do
			
		if !PropertySheetPanels[v.Category] && v.Category != "" then
			PropertySheetPanels[v.Category] = vgui.Create("DPanelList");
			PropertySheetPanels[v.Category]:EnableHorizontal(false)
			PropertySheetPanels[v.Category]:EnableVerticalScrollbar(true)
			PropertySheetPanels[v.Category]:StretchToParent(5, 30, 5, 5);
			PropertySheetPanels[v.Category]:SetPadding(5);
			PropertySheetPanels[v.Category]:SetSpacing(5);
		end
	    
		IsOwned = false;
		local ProspectiveOwner = v.PrimaryOwner && v.PrimaryOwner[2] || nil;
		
		for _,x in pairs(player.GetAll() ) do
		
			if x:SteamID() == ProspectiveOwner then
			
				ProspectiveOwner = x
				
			end
			
		end
	
		if ProspectiveOwner and ProspectiveOwner:IsValid() and ProspectiveOwner:IsPlayer() then
			IsOwned = true;
			WeOwn = LocalPlayer() == ProspectiveOwner;
		end	
		
		if v.ID != 0 then
		
			if IsOwned and WeOwn then
				local NewMenu = vgui.Create('property_panel', PropertySheetPanels[v.Category]);
				 NewMenu:SetProperty(k);	
				PropertySheetPanels[v.Category]:AddItem(NewMenu);
			elseif !IsOwned then
				local NewMenu = vgui.Create('property_panel', PropertySheetPanels[v.Category]);
				NewMenu:SetProperty(k);		
				PropertySheetPanels[v.Category]:AddItem(NewMenu);		
			end
			
		end
		
	end
	
	for k, v in pairs(PropertySheetPanels) do
		PropertySheet:AddSheet(k, v)
	end

	DermaPanel:MakePopup();
end
