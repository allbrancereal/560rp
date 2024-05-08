

local PANEL = {};

surface.CreateFont("RealtorFont", {
	size = ScreenScale(10), 
	weight = 1000, 
	antialias = true,
	shadow = false, 
	font = "Tahoma"
})

surface.CreateFont("RealtorFontSmall", {
	size = ScreenScale(5), 
	weight = 1000, 
	antialias = true,
	shadow = false, 
	font = "Tahoma"
})


local SCREEN_W, SCREEN_H = 3840, 2160;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

local _star = Material( "icon16/star.png" )
local _add = Material( "icon16/add.png" )
local _delete = Material( "icon16/delete.png" )
function PANEL:Init ( )
	self:SetTall(_hMod*150);

	self.Button = vgui.Create('DButton', self);
	self.Button:SizeToContents();
	self.Button:SetTall(_wMod*40);
	self.Button:SetWide(_hMod*120);
	self.Button:SetText('Purchase');

	self.VoucherButton = vgui.Create('DButton', self);
	self.VoucherButton:SizeToContents();
	self.VoucherButton:SetTall(_wMod*40);
	self.VoucherButton:SetWide(_hMod*190);
	self.VoucherButton:SetText('Voucher Purchase');
	self.VoucherButton:SetEnabled(false)
	self:SetMouseInputEnabled(true)
	self.OurLevel = 0;
	self.ReloadButtons = {}
	self.fileFormat = ( game.GetMap() == "rp_evocity_v33x" && "png" || "jpg" ) ;
end
function PANEL:UpdateLevel(OurTable)
	if self.OurID then
			
		local _propertyInvestment = LocalPlayer():GetPropertyInvestments();

		if _propertyInvestment[game.GetMap()] and _propertyInvestment[game.GetMap()][self.OurID] then

			self.OurLevel = _propertyInvestment[game.GetMap()][self.OurID];

		end
		
	end
	for k , v in pairs( self.ReloadButtons) do
		if v and ispanel(v) then
			v:Remove()
		end
	end
	_upgrade = vgui.Create('DButton', self);
	_upgrade:SetPos(_wMod*125 + (1*25),_hMod*105)
	_upgrade:SetTall(20);
	_upgrade:SetWide(20);
	_upgrade:SetText('');
	_upgrade:SetEnabled(false)
	_upgrade.Level = i;
	_upgrade.Panel = self;
	function _upgrade:Paint(w,h)
		
		surface.SetMaterial(_delete)
		surface.DrawTexturedRect(0,0,w,h)

	end

	function _upgrade:OnMousePressed(k)
		if self.Panel.OurID then
			if self.Panel.OurLevel-1 < 0 then
				return LocalPlayer():Notify("You can not withdraw fame investments that you do not own..")
			end
			net.Start("RequestInvest")
			net.WriteString(game.GetMap())
			net.WriteInt(self.Panel.OurID ,16)
			net.WriteBool(false)
			net.SendToServer()
			local _pnl = self.Panel
			timer.Simple(.5,function()
				if _pnl then
					_pnl:SetProperty(_pnl.OurID)
				end
			end)
		end
	end
	local _count = 1;

	for i=1,self.OurLevel do 
		_upgradedis = vgui.Create('DButton', self);
		_upgradedis:SetPos(_wMod*175 + (_count*25),_hMod*105)
		_upgradedis:SetTall(20);
		_upgradedis:SetWide(20);
		_upgradedis:SetText('');
		_upgradedis:SetEnabled(false)
		_upgradedis.Level = i;
		_upgradedis.Panel = self;
		function _upgradedis:Paint(w,h)
			
			surface.SetMaterial(_star)
			surface.DrawTexturedRect(0,0,w,h)

		end
		_count = _count + 1
		table.insert(self.ReloadButtons,_upgradedis)
	end
	_addup = vgui.Create('DButton', self);
	_addup:SetPos(_wMod*175 + (_count*25),_hMod*105)
	_addup:SetTall(20);
	_addup:SetWide(20);
	_addup:SetText('');
	_addup:SetEnabled(false)
	_addup.Level = i;
	_addup.Panel = self;
	function _addup:Paint(w,h)
		
		surface.SetMaterial(_add)
		surface.DrawTexturedRect(0,0,w,h)

	end
	function _addup:OnMousePressed(k)
		if self.Panel.OurID and LocalPlayer():canAffordBank(self.Panel.OurCost*fsrp.config.PropertyInvestmentMin) then
			if self.Panel.OurLevel+1 > fsrp.config.PropertyInvestmentMaxLevels then
				return LocalPlayer():Notify("You have already maximized the fame of this property.")
			end
			net.Start("RequestInvest")
			net.WriteString(game.GetMap())
			net.WriteInt(self.Panel.OurID ,16)
			net.WriteBool(true)
			net.SendToServer()
			local _pnl = self.Panel
			timer.Simple(.5,function()
				if _pnl then
					_pnl:SetProperty(_pnl.OurID)
				end
			end)
		else
			LocalPlayer():Notify("You cannot afford this investment.");
		end
	end
	_adduplb = vgui.Create('DLabel', self);
	_adduplb:SetPos(_wMod*225 + (_count*25),_hMod*105)
	_adduplb:SetTall(20);
	_adduplb:SetWide(400*_wMod);
	_adduplb:SetFont("RealtorFontSmall")
	_adduplb:SetText('Investing Fame');
	if self.Panel then
		_adduplb:SetText('Investing Fame - Cost $' .. self.Panel.OurCost*fsrp.config.PropertyInvestmentMin)
	end
	_adduplb:SetEnabled(false)
	table.insert(self.ReloadButtons,_upgrade)
	table.insert(self.ReloadButtons,_addup)
	table.insert(self.ReloadButtons,_adduplb)
end
function PANEL:PerformLayout ( )
	self.VoucherButton:SetPos(self:GetWide() - (_wMod*78) - self.Button:GetWide(), self:GetTall() - (_hMod*8) - self.Button:GetTall());
	self.Button:SetPos(self:GetWide() - (_wMod*210) - self.Button:GetWide(), self:GetTall() - (_hMod*8) - self.Button:GetTall());
end
local alpha= 0;
function PANEL:Paint ( )
	
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(150, 150, 150, 255));
	
	if self.OurMat then
		
		surface.SetMaterial(self.Mat);
		surface.SetDrawColor(0, 0, 0, 255);
		surface.DrawRect(_wMod*5,_hMod* 5, _wMod*132,_hMod* 132);
		surface.SetDrawColor(255, 255, 255, 255);
		surface.DrawTexturedRect(_wMod*6, _hMod*6, _wMod*128, _hMod*128);
	end
	if self.IsOwned then
		surface.SetDrawColor(255, 0, 0, 150);
		surface.DrawRect(6, 6, 64, 64);
	end
	
	draw.SimpleText(self.OurName, "RealtorFont",_wMod*150, 0, Color(255, 255, 255, 255));

	
	if self.OurCost > LocalPlayer():getBank() then
		draw.SimpleText("$" .. self.OurCost, "RealtorFont", self:GetWide() - 4, 0, Color(200, 0, 0, 255), 2);
	else
		draw.SimpleText("$".. self.OurCost, "RealtorFont", self:GetWide() - 4, 0, Color(255, 255, 255, 255), 2);
	end
	
	draw.SimpleText(self.OurDescription or 'ERROR', "RealtorFontSmall", _wMod*200, self:GetTall() * .4, Color(255, 255, 255, 255));
end
function PANEL:SetProperty ( ID )
	local OurTable = fsrp.PropertyTable[ID];
	
	local _inv = LocalPlayer():GetPropertyInvestments();
	local _mod = 0;
	if _inv[game.GetMap()] and _inv[game.GetMap()][ID] then
		_mod = (_inv[game.GetMap()][ID]*fsrp.config.SalePerLevel)/100
	end
	self.OurCost = OurTable.Cost-_mod*OurTable.Cost;
	self.OurName = OurTable.Name;
	self.OurDescription = OurTable.Description;
	self.OurID = ID;
	if OurTable.Mat then
	
		self.OurMat = OurTable.Mat;
		
		self.Mat =  Material( "properties/" .. self.OurMat );
		
	end
	
	self.IsOwned = false;
	local ProspectiveOwner = OurTable.PrimaryOwner && OurTable.PrimaryOwner[2] || nil;
	
	for k , v in pairs( player.GetAll() ) do
	
		if v:SteamID() == ProspectiveOwner then
		
			ProspectiveOwner = v;
			
		end
		
	end
	
	if ProspectiveOwner and ProspectiveOwner:IsValid() and ProspectiveOwner:IsPlayer() then
		self.IsOwned = true;
		self.WeOwn = LocalPlayer() == ProspectiveOwner;
	end

	if self.IsOwned then

		self.VoucherButton:SetEnabled(false)

		if !self.WeOwn then
			self.Button:SetEnabled(false);
			self.Button:SetText('Sold');
		else
			self.Button:SetText('Sell');
		end
	else
		local _rewardTable = LocalPlayer():GetDailyRewardTable();

		if _rewardTable and _rewardTable[2] > 0 then
			
			self.VoucherButton:SetEnabled(true)

		end

		if !LocalPlayer():canAffordBank(self.OurCost) then
			self.Button:SetEnabled(false);
		end
	end
	function self.VoucherButton.DoClick ( )
		if (LocalPlayer():getBank() > OurTable.Cost || self.WeOwn) then
			
			net.Start("buypropertyFromBank")
				net.WriteInt( self.OurID , 8 )
				net.WriteBool( true )
			net.SendToServer()
			
			self:GetParent():GetParent():GetParent():GetParent():Remove();
		end
	end
	
	function self.Button.DoClick ( )
		if (LocalPlayer():getBank() > OurTable.Cost || self.WeOwn) then
			
			net.Start("buypropertyFromBank")
				net.WriteInt( self.OurID , 8 )
				net.WriteBool( false )
			net.SendToServer()
			
			self:GetParent():GetParent():GetParent():GetParent():Remove();
		end
	end
	
	self:UpdateLevel(OurTable);
end

vgui.Register('property_panel', PANEL);