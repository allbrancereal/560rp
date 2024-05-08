
/*
fsrp.config.PropertyInvestmentMin = 20// 5 times the property value to invest in it.
fsrp.config.PropertyInvestmentReturn = 12.5// 5 times the property value to invest in it
fsrp.config.PropertyInvestmentMaxLevels = 4 // how many times can a property return investment
fsrp.config.PropertyIncome = 5 // percent of the property worth to return per upgrade level
fsrp.config.PropertyMinPricePerc = 25 // percent of the property worth to return per upgrade level
fsrp.config.SalePerLevel = 10 // percent of the property worth to return per upgrade level
*/
if SERVER then
	util.AddNetworkString("RequestInvest")

	net.Receive("RequestInvest",function(_l,_p)

		local _m = net.ReadString();
		local _id = net.ReadInt(16);
		local _shouldinvest = net.ReadBool()


		if _shouldinvest == true then
			
			_p:InvestIntoProperty(_m,_id)

		else

			_p:WithdrawPropertyInvestment(_m,_id)

		end
	end)
end

local _pMeta = FindMetaTable('Player');

function _pMeta:GetPropertyInvestments()

	return self:getFlag("propertyinvestments",{});

end

function _pMeta:CalculatePropertyIncome()
	local _propertyinvestments = self:GetPropertyInvestments();
	local _income = 0;
	local _lv = 0;
	for x, y in pairs(_propertyinvestments) do
		for k , v in pairs( y ) do
			local _property = fsrp.PropertyPackages[x][v];
			if _property then
				local _sca = fsrp.config.PropertyIncome/100;
				local _upgradelevel = v
				_income = _income + (_property.Cost*_sca)*_upgradelevel
				_lv = _lv + _upgradelevel
			end
		end
	end

	return _income,_lv;
end


function _pMeta:InvestIntoProperty(map,id)

	local _propertyinvestments = self:GetPropertyInvestments();

	local _prop = fsrp.PropertyPackages[map]

	if !_prop && !_prop[id] && !_prop[id].Cost then
		return self:Notify("The property you are trying to invest is currently under development.")
	end

	if !_propertyinvestments[map] then
		_propertyinvestments[map] = {};
	end 

	local _cost = _prop[id].Cost*fsrp.config.PropertyInvestmentMin;

	if !_propertyinvestments[map][id] then
		
		if self:canAffordBank(_cost) then
			_propertyinvestments[map][id] = 1;
			self:addBank(_cost*-1);
			self:setFlag("propertyinvestments",_propertyinvestments)
			self:FullNWSync()
			self:SavePermanentData(util.TableToJSON(self:getFlag("propertyinvestments" , {} )),  "PropertyInvestments")
			self:Notify("You have sucessfully invested into " .. _prop[id].Name .. " for $" .. _cost .." to level 1.");
		else
			self:Notify("You cannot afford this investment!")
		end

	else
		if self:canAffordBank(_cost) then
			self:addBank(_cost*-1);
			local _aminvestments = _propertyinvestments[map][id];

			if _aminvestments+1 > fsrp.config.PropertyInvestmentMaxLevels then
				return self:Notify("You have invested the maximum amount of times in to this property.");
			end

			_propertyinvestments[map][id] = _aminvestments +1;

			self:Notify("You have sucessfully invested into " .. _prop[id].Name .. " for $" .. _cost .." to level " .. _aminvestments+1 ..".");
			self:setFlag("propertyinvestments",_propertyinvestments)
			self:SavePermanentData(util.TableToJSON(self:getFlag("propertyinvestments" , {} )),  "PropertyInvestments")
			self:FullNWSync()
		else
			self:Notify("You cannot afford this investment!")
		end
	end

end

function _pMeta:WithdrawPropertyInvestment(map,id)

	local _propertyinvestments = self:GetPropertyInvestments();

	local _prop = fsrp.PropertyPackages[map];

	if !_prop && !_prop[id] && !_prop[id].Cost then
		return self:Notify("The property you are trying to invest is currently under development.")
	end
	if !_propertyinvestments[map] then
		_propertyinvestments[map] = {};
	end 
	local _zone =fsrp.FindZoneByProperty(map,id);
	local _zoneinv = self:GetZoneInvestments();
	if _zoneinv and _zoneinv[map] and _zoneinv[map][zone] then
		return self:Notify("Zone Investment establishments are permanent and may not be refunded.")
	end

	if _propertyinvestments[map][id] then	
		local _cost = _prop[id].Cost*fsrp.config.PropertyInvestmentReturn;
		local _aminvestments = _propertyinvestments[map][id];
		if _aminvestments > 0 then
			if _aminvestments-1 < 0 then
				return self:Notify("You may not withdraw any investments from this property.");
			end

			_propertyinvestments[map][id] = _aminvestments -1;
			self:addBank(_cost);
			self:Notify("You have sucessfully withdrawn your investment from " .. _prop[id].Name .. " and received $".. _cost.." to level ".. _aminvestments-1 .. ".");
			self:setFlag("propertyinvestments",_propertyinvestments)
			self:SavePermanentData(util.TableToJSON(self:getFlag("propertyinvestments" , {} )),  "PropertyInvestments")
			self:FullNWSync()
		end
	end

end


function _pMeta:LoadPropertyInvestmentData()
	local _data = self:GetPermanentData( "PropertyInvestments") || "";

	local _tb = util.JSONToTable( _data );

	if istable(_tb ) then
		
		self:setFlag( "propertyinvestments", _tb )

	end
	_data = self:GetPermanentData( "ZoneInvestments") || "";

	_tb = util.JSONToTable( _data );

	if istable(_tb ) then
		
		self:setFlag( "zoneinvestments", _tb )
	end
		self:FullNWSync();

end
function _pMeta:CanEstablishInvestmentZone(map,zone)

	local _inv = self:GetPropertyInvestments();
	local _zone = fsrp.config.InvestmentZones[map][zone]
	local _false =0;
	for k , v in pairs(_zone.Properties) do
		if _inv && _inv[map] && _inv[map][v] && _inv[map][v] == 3 then
			
		else
			_false = _false+1;
		end
	end

	return (_false==0&&true||false);
end
function _pMeta:CountInvestmentZoneAcquisition(map,zone)

	local _inv = self:GetPropertyInvestments();
	local _zone = fsrp.config.InvestmentZones[map][zone]
	local _false =0;
	for k , v in pairs(_zone.Properties) do
		if _inv && _inv[map] && _inv[map][v] && _inv[map][v] == 3 then
			
		else
			_false = _false+1;
		end
	end

	return (_false);
end

function _pMeta:GetZoneInvestments()

	return self:getFlag("zoneinvestments",{});

end
function _pMeta:HasAnyOccupyingZone()
	local _zoneinv = self:GetZoneInvestments();
	return (#_zoneinv>0)
end
function _pMeta:HasOccupyingZone(map,zone)
	local _zoneinv = self:GetZoneInvestments();
	if _zoneinv[map] and _zoneinv[map][zone] then
		return true
	end
	return false
end

function fsrp.FindZoneByProperty(map,prop)
	local _zoneinv = fsrp.config.InvestmentZones[map]
	local _found = false
	for k , v in pairs(_zoneinv) do
		if table.HasValue(v.Properties,prop) then
			_found = true;
		end
	end
	return _found
end
function fsrp.DoesPropertyBelongToOccupyingZone(map,zone,prop)
	local _zoneinv = fsrp.config.InvestmentZones[map][zone]

	if _zoneinv and table.HasValue(_zoneinv.Properties,prop) then
		return true
	end
	return false
end

function _pMeta:EstablishInvestmentZone(map,zone)
	local _inv = self:GetPropertyInvestments();
	local _zoneinv = self:GetZoneInvestments();
	local _zone = fsrp.config.InvestmentZones[map][zone]
	local _canestablish = self:CanEstablishInvestmentZone(map,zone);
	if _canestablish == true then
		
		if !self:canAffordBank(_zone.StartingInvestment) then
			return self:Notify("You can not afford the starting investment for the Investment Zone.")
		end
		if !_zoneinv[map] then
			_zoneinv[map] = {}
		end
		if _zoneinv[map][zone] then
			return self:Notify("You already have this zone occupied!")
		end
		local cost = _zone.StartingInvestment
		_zoneinv[map][zone] = _zone.StartingInvestment
		self:addBank(cost*-1)
		self:setFlag("zoneinvestments",_zoneinv)
		self:SavePermanentData(util.TableToJSON(self:getFlag("zoneinvestments" , {} )),  "ZoneInvestments")
		self:FullNWSync()
	else
		return self:Notify("You do not have enough investments to establish this investment zone.")
	end
end

function _pMeta:AddZoneInvestment(map,zone,cost)
	local _inv = self:GetPropertyInvestments();
	local _zoneinv = self:GetZoneInvestments();
	local _zone = fsrp.config.InvestmentZones[map][zone]
	
	if !self:canAffordBank(cost) then
		return self:Notify("You can not afford this investment for the Zone.")
	end
	if !_zoneinv[map] then
		_zoneinv[map] = {}
	end
	if !_zoneinv[map][zone] then
		return self:Notify("You must establish this investment zone before contributing to it.")
	end
	
	_zoneinv[map][zone] = cost+_zoneinv[map][zone]
	self:setFlag("zoneinvestments",_zoneinv)
	self:SavePermanentData(util.TableToJSON(self:getFlag("zoneinvestments" , {} )),  "ZoneInvestments")
	self:FullNWSync()
	
end
function _pMeta:MakeZoneInvestment(map,zone,cost)
	local _inv = self:GetPropertyInvestments();
	local _zoneinv = self:GetZoneInvestments();
	local _zone = fsrp.config.InvestmentZones[map][zone]

	if !self:canAffordBank(cost) then
		return self:Notify("You can not afford this investment for the Zone.")
	end
	if !_zoneinv[map] then
		_zoneinv[map] = {}
	end
	if !_zoneinv[map][zone] then
		return self:Notify("You must establish this investment zone before contributing to it.")
	end

	self:addBank(cost*-1)
	_zoneinv[map][zone] = cost+_zoneinv[map][zone]
	self:setFlag("zoneinvestments",_zoneinv)
	self:SavePermanentData(util.TableToJSON(self:getFlag("zoneinvestments" , {} )),  "ZoneInvestments")
	self:FullNWSync()
	
end
if SERVER then

	util.AddNetworkString("RequestZoneInvestment")

	net.Receive("RequestZoneInvestment",function(_l,_p)
		local _m = net.ReadString()
		local _z = net.ReadInt(8);

		local _inv = _p:GetPropertyInvestments();
		local _zoneinv = _p:GetZoneInvestments();
		if fsrp.config.InvestmentZones[_m][_z] then
			local _zone = fsrp.config.InvestmentZones[_m][_z]


			if !_zoneinv[_m] and !_zoneinv[_m][_z] then
				
				local cost = _zone.StartingInvestment;
				if !_p:canAffordBank(cost) then
					return _p:Notify("You can not afford this investment for the Zone.")
				end

				_p:EstablishInvestmentZone(_m,_z)
			elseif _zoneinv[_m] and _zoneinv[_m][_z] then
				local _c = net.ReadInt(32);
				if !_p:canAffordBank(_c) then
					return _p:Notify("You can not afford this investment for the Zone.")
				end

				_p:MakeZoneInvestment(_m,_z,_c)
			end
		end
	end)

end
if CLIENT then
	

	local SCREEN_W, SCREEN_H = 3840, 2160;

	local _w, _h = ScrW( ), ScrH( );
	local _starm = Material( "icon16/star.png" )
	local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
	local Mats = {
		["rp_downtown_tits_v2"] = Material("westcoastrp/downtownmap.png");
	}
	function _pMeta:ShowZoneInvestmentMap()

		if LocalPlayer().ZoneInvestmentMap then
			LocalPlayer().ZoneInvestmentMap:Remove()
		end
		local Frame = vgui.Create("DFrame")
		LocalPlayer().ZoneInvestmentMap = Frame
		Frame:SetSize(_wMod*1200,_hMod*1000)
		Frame:MakePopup()
		Frame:Center()
		Frame:SetTitle("")
		Frame:ShowCloseButton(false)
		Frame:SetDraggable(false)
		function Frame:Paint(w,h) 

			surface.SetDrawColor(56,56,56,255)
			surface.DrawRect(0,0,w,h)		
			draw.SimpleText("Investments","RealtorFont",_wMod*1,0, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT )	

		end
		function Frame:OnRemove()
			LocalPlayer().ZoneInvestmentMap = nil;

		end
		
		Frame.CloseBut = vgui.Create("DButton",Frame)
		local CloseBut = Frame.CloseBut;
		CloseBut:SetPos(Frame:GetWide()-_wMod*160,0)
		CloseBut:SetSize(_wMod*150,_hMod*50)
		CloseBut:SetText("")
		function CloseBut:OnMousePressed(k)

			Frame:Close()

		end
		function CloseBut:Paint(w,h) 

			surface.SetDrawColor(255,56,56,225)
			surface.DrawRect(0,0,w,h)	
			draw.SimpleText("X","RealtorFontSmall",w/2,h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		

		end
		Frame.MapToggle = vgui.Create("DButton",Frame)
		local MapToggle = Frame.MapToggle;
		MapToggle:SetPos(Frame:GetWide()-_wMod*320,0)
		MapToggle:SetSize(_wMod*150,_hMod*50)
		MapToggle:SetText("")
		function MapToggle:OnMousePressed(k)

			Frame:MakeZoneDisplay()

		end
		function MapToggle:Paint(w,h) 

			if self:IsHovered() then
				surface.SetDrawColor(225,255,225,225)
			else
				surface.SetDrawColor(128,128,128,255)
			end
			surface.DrawRect(0,0,w,h)	

			local _text = "Downtown";
			draw.SimpleText(_text,"RealtorFontSmall",w/2,h/2, Color(56,56,56),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		

		end

		Frame.Map = vgui.Create("DPanel",Frame)
		local Map = Frame.Map
		Map.Map = "rp_downtown_tits_v2";
		Map.Frame = Frame;
		Map:SetSize(_wMod*800,_hMod*1000)
		function Map:Paint(w,h) 

			if Mats[self.Map] then			
				surface.SetDrawColor(255,255,255)
				surface.SetMaterial( Mats[self.Map] )
				surface.DrawTexturedRect(0,_hMod*50,w,h-_hMod*50)
			end
			

		end
		local _zoneinv = LocalPlayer():GetPropertyInvestments();
		local _zones = LocalPlayer():GetZoneInvestments();
		Frame.ToClearButtons = {};
		Frame.ActiveZone = 1;
		function Frame:UpdateActiveZone()
			if self.Map and self.Map.Map and self.ActiveZone then
				local ActiveZonePanel = vgui.Create("DPanel",self)
				local _zone = fsrp.config.InvestmentZones[self.Map.Map][self.ActiveZone];

				self.ActiveZonePanel = ActiveZonePanel;
				ActiveZonePanel:SetPos(self:GetWide()-_wMod*400,_hMod*50)
				ActiveZonePanel:SetSize(_wMod*400,_hMod*950)

				ActiveZonePanel.ZoneInformationPanel = vgui.Create("DPanel",ActiveZonePanel);
				local _ZoneInfoPanel = ActiveZonePanel.ZoneInformationPanel;
				_ZoneInfoPanel:SetSize(ActiveZonePanel:GetWide(),_hMod*300);

				_ZoneInfoLabel = vgui.Create("DLabel",_ZoneInfoPanel)
				_ZoneInfoLabel:SetWrap(true)
				_ZoneInfoLabel:SetPos(_wMod*5,_hMod*-15)
				_ZoneInfoLabel:SetSize(_wMod*320,_hMod*100)
				_ZoneInfoLabel:SetText(_zone.Name);
				_ZoneInfoLabel:SetColor(Color(56,56,56,255))
				_ZoneInfoLabel:SetFont("RealtorFontSmall")

				_zoneinv = LocalPlayer():GetPropertyInvestments();
				_zones = LocalPlayer():GetZoneInvestments();
				
					
					_ZoneDescLabel = vgui.Create("DLabel",_ZoneInfoPanel)
					_ZoneDescLabel:SetWrap(true)
					_ZoneDescLabel:SetPos(_wMod*10,_hMod*50)
					_ZoneDescLabel:SetSize(_wMod*390,_hMod*100)
				if !_zones[self.Map.Map] || (_zones[self.Map.Map] and !_zones[self.Map.Map][self.ActiveZone]) then

					local _count = LocalPlayer():CountInvestmentZoneAcquisition(self.Map.Map,self.ActiveZone);
					if _count > 0 then
						
						_ZoneDescLabel:SetText("Once you invest in all properties in this zone, you can invest in the zone itself.");
					else
						if LocalPlayer():canAffordBank(_zone.StartingInvestment) then
							_ZoneDescLabel:SetText("This zone is ready to be developed.")
						else
							_ZoneDescLabel:SetText("This zone is ready to be developed once you acquired enough funds.")
						end
					end

					if _count == 0 and  LocalPlayer():canAffordBank(_zone.StartingInvestment) then
						
						local _but = vgui.Create("DButton",_ZoneInfoPanel)
						_but:SetSize(_ZoneInfoPanel:GetWide(),_hMod*50)
						_but:SetPos(0,_ZoneInfoPanel:GetTall()-_hMod*50)
						_but:SetText("")
						function _but:OnMousePressed()

							if LocalPlayer():canAffordBank(_zone.StartingInvestment) then
								

									net.Start("RequestZoneInvestment")
										net.WriteString(Frame.Map.Map)
										net.WriteInt(Frame.ActiveZone,8)
									net.SendToServer()

							end
							timer.Simple(.5,function()
								Frame:MakeZoneDisplay()
							end)
							
						end
						function _but:Paint(w,h)

							if self:IsHovered() then
								surface.SetDrawColor(255,255,255)
							else
								surface.SetDrawColor(56,56,56)
							end
							surface.DrawRect(0,0,w,h)
							draw.SimpleText("Establish Development","RealtorFontSmall",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
							
						end
					
					end

				elseif _zones[self.Map.Map] && _zones[self.Map.Map][self.ActiveZone] then
					_ZoneDescLabel:SetText("You have invested in this zone and will gain all its benefits.")

					
					local _but = vgui.Create("DButton",_ZoneInfoPanel)
					_but.Slider = vgui.Create("DNumSlider",_ZoneInfoPanel)
					local _slider = _but.Slider;
					_ZoneCostLB = vgui.Create("DLabel",_ZoneInfoPanel)
					_ZoneCostLB:SetWrap(true)
					_ZoneCostLB:SetPos(_wMod*15,_hMod*120)
					_ZoneCostLB:SetSize(_wMod*320,_hMod*100)
					_ZoneCostLB:SetText("Cost: ($)");
					_ZoneCostLB:SetColor(Color(56,56,56,255))
					_ZoneCostLB:SetFont("RealtorFontSmall")

					_slider:SetPos(_wMod*-250,_ZoneInfoPanel:GetTall()-_hMod*100)
					_slider:SetSize(_wMod*600,_hMod*25)
					_slider:SetMin(0)
					_slider:SetText("$")
					_slider:SetDecimals( 0 )
					_but:SetText("")	
					_slider:SetMax(LocalPlayer():getBank())
					_but:SetSize(_ZoneInfoPanel:GetWide(),_hMod*50)
					_but:SetPos(0,_ZoneInfoPanel:GetTall()-_hMod*50)
					function _but:OnMousePressed()

						if LocalPlayer():canAffordBank(_but.Slider:GetValue()) then
								net.Start("RequestZoneInvestment")
									net.WriteString(Frame.Map.Map)
									net.WriteInt(Frame.ActiveZone,8)
									net.WriteInt(_but.Slider:GetValue(),32)
								net.SendToServer()
							
						else
							LocalPlayer():Notify("You cannot afford this investment.")
						end
							timer.Simple(.5,function()
								Frame:MakeZoneDisplay()
							end)
						
					end
					function _but:Paint(w,h)

						if self:IsHovered() then
							surface.SetDrawColor(255,255,255)
						else
							surface.SetDrawColor(56,56,56)
						end
						surface.DrawRect(0,0,w,h)
						draw.SimpleText("Invest in Development","RealtorFontSmall",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
						
					end
				end
					_ZoneDescLabel:SetColor(Color(56,56,56,255))
					_ZoneDescLabel:SetFont("RealtorFontSmall")

			
				ActiveZonePanel.ZonePropertyPanel = vgui.Create("DPanel",ActiveZonePanel);
				local ZonePropertyPanel = ActiveZonePanel.ZonePropertyPanel;
				ZonePropertyPanel:SetSize(ActiveZonePanel:GetWide(),ActiveZonePanel:GetTall() - _hMod*300);
				ZonePropertyPanel:SetPos(0,_hMod*300)
				function ZonePropertyPanel:Paint(w,h)
					surface.SetDrawColor(25,25,25)
					surface.DrawRect(0,0,w,h)

				end;

				local ZonePropertyList = vgui.Create("DScrollPanel", ZonePropertyPanel)
				ZonePropertyList:Dock(FILL)

				for k , v in pairs( fsrp.PropertyPackages[self.Map.Map] ) do
					if table.HasValue(_zone.Properties,v.ID) then
						
						local _Prop = ZonePropertyList:Add("DPanel");
						_Prop:Dock(TOP)
						_Prop:SetTall(_hMod*150)
						_PropLb = vgui.Create("DLabel",_Prop)
						_PropLb:SetWrap(true)
						_PropLb:SetPos(_wMod * 15,_wMod*-15)
						_Prop:DockMargin(0,_hMod*5,0,_hMod*5);
						_Prop:DockPadding(0,_hMod*5,0,_hMod*5);
						if v.Mat then
						
							local OurMat = v.Mat;
							local Mat =   Material( "properties/" .. OurMat );
							_Prop.Mat = Mat;	
						end

						_PropLb:SetSize(_wMod*320,_hMod*100)
						_PropLb:SetText(v.Name);
						_PropLb:SetFont("RealtorFontSmall")
						function _Prop:Paint(w,h)
							surface.SetDrawColor(56,56,56)
							surface.DrawRect(0,0,w,h)

							if self.Mat then
								surface.SetDrawColor(255,255,255)
								surface.SetMaterial(self.Mat)
								surface.DrawTexturedRect(_wMod*30,_hMod*75,_wMod*64,_hMod*64)
							end
						end

						for i =1,fsrp.config.PropertyInvestmentMaxLevels do
							local _star = vgui.Create("DPanel", _Prop)
							_star:SetPos(_wMod*(90 + (i*37)),_hMod*90 )
							_star:SetSize(_wMod*32,_hMod*32)
							_star.Active = false;
							local _am = 0;
							if _zoneinv[self.Map.Map] and _zoneinv[self.Map.Map][v.ID] then	
								_am =_zoneinv[self.Map.Map][v.ID]	
							end			
							if _am >= i then
								_star.Active = true;	
							end
							function _star:Paint(w,h)
								
								if self.Active == true then
									surface.SetDrawColor(255,255,255);
								else
									surface.SetDrawColor(128,128,128)
								end
								surface.SetMaterial(_starm)
								surface.DrawTexturedRect(0,0,w,h)

							end
							
						end
		
					end
				end 
				table.insert(Frame.ToClearButtons,ActiveZonePanel)
			end
		end
		
		function Frame:MakeZoneDisplay()
			for k , v in pairs(Frame.ToClearButtons) do 
				if v and ispanel(v) then
					v:Remove()
				end
			end
			_zones = LocalPlayer():GetZoneInvestments();
			Frame.ToClearButtons = {};
		Frame.IndustrialDev = vgui.Create("DButton",Frame.Map)
				local IndustrialDev = Frame.IndustrialDev;
				IndustrialDev:SetPos(_wMod*10, _hMod*100)
				IndustrialDev:SetSize(_wMod*990,_hMod*800 )
				IndustrialDev:SetText("")
				IndustrialDev.Zone= 1;
				IndustrialDev.Frame = Frame;
				IndustrialDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,IndustrialDev.Zone);
				IndustrialDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][IndustrialDev.Zone].Name);
				IndustrialDev.ZoneInfo =  fsrp.config.InvestmentZones[Frame.Map.Map][IndustrialDev.Zone]
				function IndustrialDev:OnMousePressed(k)

					Frame.ActiveZone = self.Zone;
					IndustrialDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,self.Zone);
					IndustrialDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][self.Zone].Name);
					Frame:MakeZoneDisplay()

				end
				table.insert(Frame.ToClearButtons,IndustrialDev)
				function IndustrialDev:Paint(w,h) 


					surface.SetDrawColor(255,170,56,225)
					surface.DrawRect(_wMod*290,_hMod*250,_wMod*200,_hMod*250)	
					surface.DrawRect(0,0,_wMod*200,_hMod*250)

					if self.AcquisitionCount == 0 then
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial(_stampMaterial)
						surface.DrawTexturedRect(_wMod*200/4,_hMod*10,_wMod*100,_hMod*100)
					end	
					if self.Frame.Map.Map then
						if _zoneinv[self.Frame.Map.Map] and !_zoneinv[self.Frame.Map.Map][self.Zone] or !_zoneinv[self.Frame.Map.Map] then
							draw.SimpleText("$" .. self.ZoneInfo.StartingInvestment,"RealtorFontSmall",_wMod*200/2,_hMod*250/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
							draw.SimpleText("$" .. self.ZoneInfo.StartingInvestment,"RealtorFontSmall",_wMod*690/2+_wMod*45,_hMod*250/1.5+_hMod*250, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						elseif _zoneinv[self.Frame.Map.Map] and _zoneinv[self.Frame.Map.Map][self.Zone] then

							draw.SimpleText("$" .. _zoneinv[self.Frame.Map.Map][self.Zone],"RealtorFontSmall",_wMod*690/2+_wMod*45,_hMod*250/1.5+_hMod*250, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						
						end	
						draw.SimpleText(self.ZoneTextSplit[1],"RealtorFontSmall",_wMod*200/2,_hMod*250/3, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						draw.SimpleText(self.ZoneTextSplit[2],"RealtorFontSmall",_wMod*200/2,_hMod*250/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		

						draw.SimpleText(self.ZoneTextSplit[1],"RealtorFontSmall",_wMod*690/2+_wMod*45,_hMod*250/3+_hMod*250, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						draw.SimpleText(self.ZoneTextSplit[2],"RealtorFontSmall",_wMod*690/2+_wMod*45,_hMod*250/2+_hMod*250,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
					end


				end

				Frame.SuburbanDev = vgui.Create("DButton",Frame.Map)
				local SuburbanDev = Frame.SuburbanDev;
				SuburbanDev:SetPos(_wMod*60, _hMod*700)
				SuburbanDev:SetSize(_wMod*400,_hMod*250)
				SuburbanDev:SetText("")
				SuburbanDev.Zone= 2;
				SuburbanDev.Frame = Frame;
				SuburbanDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,SuburbanDev.Zone);
				SuburbanDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][SuburbanDev.Zone].Name);
				SuburbanDev.ZoneInfo =  fsrp.config.InvestmentZones[Frame.Map.Map][SuburbanDev.Zone]
				function SuburbanDev:OnMousePressed(k)

					Frame.ActiveZone = self.Zone;
					SuburbanDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,self.Zone);
					SuburbanDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][self.Zone].Name);
					Frame:MakeZoneDisplay()

				end
				function SuburbanDev:Paint(w,h) 

					surface.SetDrawColor(100,200,25,225)
					surface.DrawRect(0,0,w,h)	
					if self.AcquisitionCount == 0 then
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial(_stampMaterial)
						surface.DrawTexturedRect(_wMod*200/4,_hMod*10,_wMod*100,_hMod*100)
					end	
					if self.Frame.Map.Map then
						if _zones[self.Frame.Map.Map] and !_zones[self.Frame.Map.Map][self.Zone] or !_zones[self.Frame.Map.Map] then
							draw.SimpleText("$" .. self.ZoneInfo.StartingInvestment,"RealtorFontSmall",w/2,h/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						elseif _zones[self.Frame.Map.Map] and _zones[self.Frame.Map.Map][self.Zone] then

							draw.SimpleText("$" .. _zoneinv[self.Frame.Map.Map][self.Zone],"RealtorFontSmall",w/2,h/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						
						end	
						draw.SimpleText(self.ZoneTextSplit[1],"RealtorFontSmall",w/2,h/3, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						draw.SimpleText(self.ZoneTextSplit[2],"RealtorFontSmall",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
					end
				end
				table.insert(Frame.ToClearButtons,SuburbanDev)
				Frame.UrbanDev = vgui.Create("DButton",Frame.Map)
				local UrbanDev = Frame.UrbanDev;
				UrbanDev:SetPos(_wMod*60, _hMod*275)
				UrbanDev:SetSize(_wMod*600,_hMod*350)
				UrbanDev:SetText("")
				UrbanDev.Zone= 3; 
				UrbanDev.Frame = Frame;
				UrbanDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,UrbanDev.Zone);
				UrbanDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][UrbanDev.Zone].Name);
				UrbanDev.ZoneInfo =  fsrp.config.InvestmentZones[Frame.Map.Map][UrbanDev.Zone]
				function UrbanDev:OnMousePressed(k)

					Frame.ActiveZone = self.Zone;
					UrbanDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,self.Zone);
					UrbanDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][self.Zone].Name);
					Frame:MakeZoneDisplay()

				end
				function UrbanDev:Paint(w,h) 

					surface.SetDrawColor(25,128,225,225)
					surface.DrawRect(_wMod*150,_hMod*7,_wMod*600,_hMod*70)	
					surface.DrawRect(_wMod*50,_hMod*77,_wMod*190,h)	
					if self.AcquisitionCount == 0 then
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial(_stampMaterial)
						surface.DrawTexturedRect(_wMod*100,_hMod*220,_wMod*100,_hMod*100)
					end	
					if self.Frame.Map.Map then
						if _zoneinv[self.Frame.Map.Map] and !_zoneinv[self.Frame.Map.Map][self.Zone] or !_zoneinv[self.Frame.Map.Map] then
							draw.SimpleText("$" .. self.ZoneInfo.StartingInvestment,"RealtorFontSmall",_wMod*150,_hMod*214, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						elseif _zoneinv[self.Frame.Map.Map] and _zoneinv[self.Frame.Map.Map][self.Zone] then

							draw.SimpleText("$" .. _zoneinv[self.Frame.Map.Map][self.Zone],"RealtorFontSmall",_wMod*150,_hMod*214, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						
						end	
						draw.SimpleText(self.ZoneTextSplit[1],"RealtorFontSmall",_wMod*150,_hMod*350/2.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						draw.SimpleText(self.ZoneTextSplit[2],"RealtorFontSmall",_wMod*150,_hMod*350/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
					end
				end
				table.insert(Frame.ToClearButtons,UrbanDev)
				Frame.GhettoDev = vgui.Create("DButton",Frame.Map)
				local GhettoDev = Frame.GhettoDev;
				GhettoDev:SetPos(_wMod*500, _hMod*60)
				GhettoDev:SetSize(_wMod*280,_hMod*540)
				GhettoDev:SetText("")
				GhettoDev.Zone= 4;
				GhettoDev.Frame = Frame;
				GhettoDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,GhettoDev.Zone);
				GhettoDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][GhettoDev.Zone].Name);
				GhettoDev.ZoneInfo =  fsrp.config.InvestmentZones[Frame.Map.Map][GhettoDev.Zone]
				function GhettoDev:OnMousePressed(k)

					Frame.ActiveZone = self.Zone;
					GhettoDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,self.Zone);
					GhettoDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][self.Zone].Name);
					Frame:MakeZoneDisplay()

				end
				function GhettoDev:Paint(w,h) 

					surface.SetDrawColor(170,170,255,225)
					surface.DrawRect(0,0,w,h)	
					if self.AcquisitionCount == 0 then
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial(_stampMaterial)
						surface.DrawTexturedRect(_wMod*200/2,_hMod*50,_wMod*100,_hMod*100)
					end	
					if self.Frame.Map.Map then
						if _zoneinv[self.Frame.Map.Map] and !_zoneinv[self.Frame.Map.Map][self.Zone] or !_zoneinv[self.Frame.Map.Map] then
							draw.SimpleText("$" .. self.ZoneInfo.StartingInvestment,"RealtorFontSmall",w/2,h/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						elseif _zoneinv[self.Frame.Map.Map] and _zoneinv[self.Frame.Map.Map][self.Zone] then

							draw.SimpleText("$" .. _zoneinv[self.Frame.Map.Map][self.Zone],"RealtorFontSmall",w/2,h/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						end	
						draw.SimpleText(self.ZoneTextSplit[1],"RealtorFontSmall",w/2,h/3, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						draw.SimpleText(self.ZoneTextSplit[2],"RealtorFontSmall",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
					end
				end
				table.insert(Frame.ToClearButtons,GhettoDev)
				Frame.UptownDev = vgui.Create("DButton",Frame.Map)
				local UptownDev = Frame.UptownDev;
				UptownDev:SetPos(_wMod*280, _hMod*60)
				UptownDev:SetSize(_wMod*220,_hMod*220)
				UptownDev:SetText("")
				UptownDev.Zone= 5;
				UptownDev.Frame = Frame;
				UptownDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,UptownDev.Zone);
				UptownDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][UptownDev.Zone].Name);
				UptownDev.ZoneInfo =  fsrp.config.InvestmentZones[Frame.Map.Map][UptownDev.Zone]
				function UptownDev:OnMousePressed(k)

					Frame.ActiveZone = self.Zone;
					UptownDev.AcquisitionCount = LocalPlayer():CountInvestmentZoneAcquisition(Frame.Map.Map,self.Zone);
					UptownDev.ZoneTextSplit = string.Explode(" ", fsrp.config.InvestmentZones[Frame.Map.Map][self.Zone].Name);
					Frame:MakeZoneDisplay()

				end
				function UptownDev:Paint(w,h) 

					surface.SetDrawColor(255,170,170,225)
					surface.DrawRect(0,0,w,h)	
					if self.AcquisitionCount == 0 then
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial(_stampMaterial)
						surface.DrawTexturedRect(_wMod*200/2,_hMod*25,_wMod*100,_hMod*100)
					end	
					if self.Frame.Map.Map then
						if _zoneinv[self.Frame.Map.Map] and !_zoneinv[self.Frame.Map.Map][self.Zone] or !_zoneinv[self.Frame.Map.Map] then
							draw.SimpleText("$" .. self.ZoneInfo.StartingInvestment,"RealtorFontSmall",w/2,h/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						elseif _zoneinv[self.Frame.Map.Map] and _zoneinv[self.Frame.Map.Map][self.Zone] then

							draw.SimpleText("$" .. _zoneinv[self.Frame.Map.Map][self.Zone],"RealtorFontSmall",w/2,h/1.5, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						end	
						draw.SimpleText(self.ZoneTextSplit[1],"RealtorFontSmall",w/2,h/3, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )	
						draw.SimpleText(self.ZoneTextSplit[2],"RealtorFontSmall",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER )		
					end
				end
				table.insert(Frame.ToClearButtons,UptownDev)
			

			

			Frame:UpdateActiveZone()

		end
		Frame:MakeZoneDisplay()

		return Frame
	end


end