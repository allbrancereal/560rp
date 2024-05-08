
local SCREEN_W, SCREEN_H = 3840, 2160;

local _w, _h = ScrW( ), ScrH( );
local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
_wMod = _wMod*2;
_hMod = _hMod*2;
local _p = LocalPlayer();

local _missionTypeTable = {
	[1] = fsrp.config.SupplyMissions;
	[2] = fsrp.config.InitMissions;
	[3] = fsrp.config.DeliveryMissions;
}

	surface.CreateFont( "RobberyTextSmall", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = ScreenScale(7),
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
	surface.CreateFont( "RobberyTextSuperSmall", {
		font = "Trebuchet MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = ScreenScale(6),
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
local function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function BusinessMissionSelection(BusinessType, MissionType)
	_p = LocalPlayer()

	_missionTypeTable = {
		[1] = fsrp.config.SupplyMissions;
		[2] = fsrp.config.InitMissions;
		[3] = fsrp.config.DeliveryMissions;
	}
	_missiontypeLang = {
		[1] = "Supply";
		[2] = "";
		[3] = "Deliver";
	}
	local _data = LocalPlayer():GetBusiness();
	local _found = false;
	local _businessproperty = {};
	for k , v in pairs(fsrp.I_BusinessPropertyTable) do

		if v.BusinessInformation.Tag == _data[BusinessType][2] then
			_found = true;
			_businessproperty =v;
		end
	end
	if _found == false then
		return _p:Notify("There are no missions currently available for your business.")
	end
	local _businessTypeInformation = fsrp.config.IllegalBusinessTypes[_businessproperty.BusinessInformation.Type];
	local _missions = _missionTypeTable[MissionType]

	local _lang = _missiontypeLang[MissionType]
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(_wMod*600,_hMod*500);
	Frame:Center()
	Frame:MakePopup()
	Frame:ShowCloseButton(false)
	Frame:SetTitle("")
	function Frame:Paint(w,h)
		surface.SetDrawColor(25,25,25,225)
		surface.DrawRect(0,0,w,h)
		surface.DrawRect(0,0,w,_hMod*30)
		draw.SimpleText("Mission Selection - " .. _businessTypeInformation.Name .. " at the " .. _businessproperty.Name ,"RobberyText",_wMod*15,_hMod*2.5,Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
	end
	local CloseButton = vgui.Create("DButton",Frame)
	CloseButton:SetSize(_wMod*90,_hMod*30)
	CloseButton:SetText("")
	CloseButton:SetPos(Frame:GetWide()-_wMod*100,0)
	function CloseButton:Paint(w,h)
		surface.SetDrawColor(255,255,255,225)
		if self:IsHovered() then
			surface.SetDrawColor(255,225,225,225)
		end
		
		surface.DrawRect(0,0,w,h)
	end
	function CloseButton:OnMousePressed(k)
		Frame:Close()
	end
	Frame.CloseButton = CloseButton;

	local ExplainText = vgui.Create("DLabel",Frame)
	ExplainText:SetSize(Frame:GetWide()-_wMod*20,_hMod*130)
	ExplainText:SetText("This is the mission selection menu. It will change based on what type of mission you are undertaking (Supply, Delivery, Laundering). Try to only supply when you are low on stock and only deliver when you have lots of stock. Remember that laundering money makes you vulnerable to other player attacks. Keep in mind you may have to go to Evo-City.")
	ExplainText:SetPos(_wMod*10,0)
	ExplainText:SetWrap(true)
	ExplainText:SetFont("RobberyTextSuperSmall")
	local MissionScrollPanel = vgui.Create("DPanel",Frame)
	MissionScrollPanel:SetPos(_wMod*10,_hMod*125)
	MissionScrollPanel:SetSize(Frame:GetWide()-_wMod*20,Frame:GetTall()-_hMod*135)
	Frame.MissionScrollPanel = MissionScrollPanel
	function MissionScrollPanel:Paint(w,h)
		surface.SetDrawColor(56,56,56,225)
		surface.DrawRect(0,0,w,h)
	end
	local MissionScroll = vgui.Create("DScrollPanel",MissionScrollPanel)
	MissionScroll:Dock(FILL)
	Frame.MissionScroll = MissionScroll

	for k, v in pairs(_missions) do

		local _miss = vgui.Create("DPanel",MissionScroll)	
		_miss:SetTall(_hMod*145)	
		_miss:Dock(TOP)
		_miss.loc = BonfireTaxis.Config[v.location[1]][v.location[2]].name;
		_miss.city = v.location[1] == "rp_evocity_v33x" && "Evo-City" || "Downtown";
		_miss.mat = BonfireTaxis.Config[v.location[1]][tonumber(v.location[2])].mat;
		
		function _miss:Paint(w,h)
			surface.SetDrawColor(56,56,56,225)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,225)
			surface.SetMaterial(self.mat);
			surface.DrawTexturedRect(0,0,_wMod*200,h)
			draw.SimpleText( _lang .. " " .. _businessTypeInformation.Name .. " from " .. self.loc .. " in " .. self.city ,"RobberyTextSmall",_wMod*210,_hMod*2.5,Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			draw.SimpleText( "Product Worth: $" .. comma_value(_businessTypeInformation.SupplySellWorth)  ,"RobberyTextSmall",_wMod*210,_hMod*27.5,Color(225,255,225,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			
			if MissionType == 3 then
				draw.SimpleText( "Potential Buyers:" ,"RobberyTextSuperSmall",_wMod*210,_hMod*52.5,Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			end
			
		end

		local _count = 1;
		if MissionType == 3 then
			for x ,y in pairs( _businessTypeInformation.LaunderNPCs ) do
				if cnQuests[y]  then

					local _niconp = vgui.Create("DPanel",_miss)
					_niconp:SetPos(_wMod*196 + (_count*34), _hMod*72)
					_niconp:SetSize(_wMod*32,_hMod*32)
					local _nicon = vgui.Create("DModelPanel",_niconp)
					_nicon:Dock(FILL)

					_nicon:SetModel( tostring( cnQuests[y].model) )


					_count = _count +1
				end
			end
		end
		

		local _missconfirm = vgui.Create("DButton", _miss)
		_missconfirm:SetSize(MissionScrollPanel:GetWide(),_hMod*25)
		_missconfirm:SetPos(0,_miss:GetTall()-_hMod*25)
		_missconfirm:SetText("Select " .. _lang .. " Mission")
		function _missconfirm:Paint(w,h)
			surface.SetDrawColor(255,255,255,225)
			if self:IsHovered() then
				surface.SetDrawColor(225,255,225,225)
			end
			
			surface.DrawRect(0,0,w,h)
		end
		_missconfirm.t = k;
		function _missconfirm:OnMousePressed(k)

			local _business = BusinessType;
			local _typetosend = self.t
			net.Start("BusinessMissionSelection")
				net.WriteInt(_business,8)
				net.WriteInt(MissionType,8)
				net.WriteString(_typetosend)
			net.SendToServer()
			Frame:Close()
		end
	end

	_p.MissionSelection = Frame
	return Frame;
end

function BusinessUpgradePanel(BusinessType)
	_p = LocalPlayer()

	local _data = LocalPlayer():GetBusiness();
	local _found = false;
	local _businessproperty = {};
	for k , v in pairs(fsrp.I_BusinessPropertyTable) do

		if v.BusinessInformation.Tag == _data[BusinessType][2] then
			_found = true;
			_businessproperty =v;
		end
	end
	if _found == false then
		return _p:Notify("There are no missions currently available for your business.")
	end
	local _businessTypeInformation = fsrp.config.IllegalBusinessTypes[_businessproperty.BusinessInformation.Type];

	local Frame = vgui.Create("DFrame")
	Frame:SetSize(_wMod*600,_hMod*500);
	Frame:Center()
	Frame:MakePopup()
	Frame:ShowCloseButton(false)
	Frame:SetTitle("")
	function Frame:Paint(w,h)
		surface.SetDrawColor(25,25,25,225)
		surface.DrawRect(0,0,w,h)
		surface.DrawRect(0,0,w,_hMod*30)
		draw.SimpleText("Upgrade Selection - " .. _businessTypeInformation.Name .. " at the " .. _businessproperty.Name ,"RobberyText",_wMod*15,_hMod*2.5,Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
	end
	local CloseButton = vgui.Create("DButton",Frame)
	CloseButton:SetSize(_wMod*90,_hMod*30)
	CloseButton:SetText("")
	CloseButton:SetPos(Frame:GetWide()-_wMod*100,0)
	function CloseButton:Paint(w,h)
		surface.SetDrawColor(255,255,255,225)
		if self:IsHovered() then
			surface.SetDrawColor(255,225,225,225)
		end
		
		surface.DrawRect(0,0,w,h)
	end
	function CloseButton:OnMousePressed(k)
		Frame:Close()
	end
	Frame.CloseButton = CloseButton;

	local ExplainText = vgui.Create("DLabel",Frame)
	ExplainText:SetSize(Frame:GetWide()-_wMod*20,_hMod*130)
	ExplainText:SetText("You may upgrade your businesses here. You can upgrade from anywhere, it will take money from your person.")
	ExplainText:SetPos(_wMod*10,0)
	ExplainText:SetWrap(true)
	ExplainText:SetFont("RobberyTextSuperSmall")
	local MissionScrollPanel = vgui.Create("DPanel",Frame)
	MissionScrollPanel:SetPos(_wMod*10,_hMod*125)
	MissionScrollPanel:SetSize(Frame:GetWide()-_wMod*20,Frame:GetTall()-_hMod*135)
	Frame.MissionScrollPanel = MissionScrollPanel
	function MissionScrollPanel:Paint(w,h)
		surface.SetDrawColor(56,56,56,225)
		surface.DrawRect(0,0,w,h)
	end
	local MissionScroll = vgui.Create("DScrollPanel",MissionScrollPanel)
	MissionScroll:Dock(FILL)
	Frame.MissionScroll = MissionScroll

	local _ourmat = nil
	local _pre = "fsrp";
	local _fileformat = ( game.GetMap() == "rp_evocity_v33x" && "png" || "jpg" ) ;
	local _mattouse = nil;

	if _businessproperty.Mat then
	
		_ourmat = _businessproperty.Mat;
		
		_mattouse =  Material( "/properties/" .. _ourmat );
		
	end
	local _upgrades = _businessproperty.BusinessInformation.Upgrades

	for k , v in pairs(_upgrades) do
		if !_data[BusinessType][6][k] then
			
		local _miss = vgui.Create("DPanel",MissionScroll)	
		_miss:SetTall(_hMod*145)	
		_miss:Dock(TOP)
		function _miss:Paint(w,h)
			surface.SetDrawColor(56,56,56,225)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(255,255,255,225)
			surface.SetMaterial(_mattouse);
			surface.DrawTexturedRect(0,0,_wMod*200,h)
			draw.SimpleText( v.Name,"RobberyTextSmall",_wMod*210,_hMod*2.5,Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			draw.SimpleText( "Upgrade Cost: $" .. comma_value(v.Cost)  ,"RobberyTextSmall",_wMod*210,_hMod*27.5,Color(225,255,225,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			
			
		end
		local _desclabel = vgui.Create("DLabel",_miss)	
		_desclabel:SetPos(_wMod*210,_hMod*2.5)	
		_desclabel:SetSize(_wMod*350,_hMod*145)
		_desclabel:SetFont("RobberyTextSuperSmall")
		_desclabel:SetWrap(true)
		_desclabel:SetText(v.Description)
	

		local _missconfirm = vgui.Create("DButton", _miss)
		_missconfirm:SetSize(MissionScrollPanel:GetWide(),_hMod*25)
		_missconfirm:SetPos(0,_miss:GetTall()-_hMod*25)
		_missconfirm:SetText("Select Upgrade")
		function _missconfirm:Paint(w,h)
			surface.SetDrawColor(255,255,255,225)
			if self:IsHovered() then
				surface.SetDrawColor(225,255,225,225)
			end
			
			surface.DrawRect(0,0,w,h)
		end
		_missconfirm.t = k;
		function _missconfirm:OnMousePressed(k)

			local _business = BusinessType;
			local _typetosend = self.t
			net.Start("BusinessMissionSelection")
				net.WriteInt(_business,8)
				net.WriteInt(2,8)
				net.WriteString(_typetosend)
				net.WriteInt(self.t,8)
			net.SendToServer()
			Frame:Close()
		end
		
	end
end
	_p.UpgradePanel = Frame
	return Frame;
end
/*
concommand.Add("showmissionselection",function(ply,cmd,args,argStr)
	_p = LocalPlayer()
	if !_p:IsAdmin() then return end

	if _p.MissionSelection && IsValid( _p.MissionSelection ) && ispanel(_p.MissionSelection) then
		_p.MissionSelection:Close()
	end
	local _b = 1
	local _m = 1
	local _mt = "dtv" 
	if args[1] and args[2] and args[3] then
		_b = args[1]
		_m = args[2]
		_mt = args[3]
	end
	BusinessUpgradePanel(_b,_m,_mt)
end)
*/

