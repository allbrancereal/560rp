
dailyrotorewards = dailyrotorewards || {};

dailyrotorewards.config = {};
dailyrotorewards.config.rewardschedule = 1							// if the reward schedule isnt our current one we will not reward the current progress but reset and start from day 1
dailyrotorewards.config.currentcycle =1547088532 ;

dailyrotorewards.config.rewardtime 						= (3600*24); 	// Minutes per reward
dailyrotorewards.config.moneyreward 					= 30000; 		// Money per reward
dailyrotorewards.config.sendmoneytobank 				= false; 		// Decides if we add money to bank or not.
dailyrotorewards.config.amountofrewardsperday			= 1; 			// How many rewards should we give the player.
dailyrotorewards.config.extrarewardonweekend 			= 1; 			// How many rewards do we give the player extra on the weekend
dailyrotorewards.config.timeofflineforloyaltyreward 	= (3600*24)*7	// How long the player has to be offline for loyalty rewards to kick in
dailyrotorewards.config.norewards					 	= false			// disables distribution of rewards

// 740 - global weed boost
// 750 - rookie box for weed growing
// 751 - hat box
// 752 - survival kit
// 753 - computer kit
// 754 - furniture kit
// 755 - random weapon crate
// 756 - weed boost elixir
// 757 - car crate
// 758 - pandoras stone double or half money
// 759 - ak acessory pack
// 760 - bitcoin money double reward elixir
// 761 - mining kit
// 762 - double payday bonus hour elixir
// 763 - 
/*
LocalPlayer().LoyaltyRewards = {
	[1] = dailyrotorewards.config.rewardschedule; // schedule id
	[2] = 1; // property vouchers
	[3] = { 
		[1] = {
			1;	// attendance reward
			31321;	// Last Reward in UTC
			1;		// Amount of rewards earned
		};
		[2] = {
			0;	// org reward
			31321;	// Last Reward in UTC
			1;		// Amount of rewards earned
		};
		[3] = {
			1;	// loyalty reward
			31321;	// Last Reward in UTC
			1;		// Amount of rewards earned
		};
		[4] = {
			1;	// rookie reward
			31321;	// Last Reward in UTC
			1;		// Amount of rewards earned
		};
	};
};
*/
if CLIENT then
	
	_stampMaterial = Material("westcoastrp/wcstamp.png")

end

local function declareDailyRotoRewardFuncs()


	local _plyMeta = FindMetaTable('Player');

	function _plyMeta:GetDailyRewardTable()
		local _rewardString 			= self:getFlag("rotodailyreward","");
		local _rewardTable 				= util.JSONToTable( _rewardString );
		return _rewardTable;
	end
if SERVER then
	util.AddNetworkString("ShowDailyRewardNW")
end
	function _plyMeta:ShowDailyRewardBox(table)
		//PrintTable(table)
		
		if SERVER then
			net.Start("ShowDailyRewardNW")
			local _tosend = util.TableToJSON(table);
			net.WriteString(_tosend)
			net.Send(self)
		else
			unhashed = util.JSONToTable(table);
			local _tb = {[1] = true}
			local _revtbl = LocalPlayer():GetDailyRewardTable();
			local _allowfour =  (_revtbl && _revtbl[3] && _revtbl[3][4] && ( _revtbl[3][4][1] == 1 && true || false ));
			if _allowfour  == true then
				_tb[4] = true;
			end
			local _allowthree = (_revtbl && _revtbl[3] && _revtbl[3][3] && _revtbl[3][3][1] == 1 && true || false)

			if _allowthree == true then
				_tb[3] = true;
			end
			timer.Simple(10,function()
				local _allowtwo = (LocalPlayer():getFlag("organization",0) > 0)
				if _allowtwo == true  then
					_tb[2] = true;
				end
				local _newtb = {};
				for k=1,4 do
					if _tb[k] then
						_newtb[k] = true;
					end
				end
				ShowDailyRewardCalendar(_newtb)
				//print(table)
				local _count = 0
				for k , v in pairs(unhashed) do
					if v && istable(v) then
						_count = _count + #v
					end
				end
				if _count > 0 then
					ShowDailyRewardPopup(unhashed)
				end

			end)
		end

	end
	function _plyMeta:CanUsePropVoucher()
		local oncooldown, remaining, data = self:HasCooldown("propertyVoucher",3600); 
		local _rewardTable = self:GetDailyRewardTable();

		return ((!oncooldown && _rewardTable[2]>=1) == true) && true || false; 
	end
if CLIENT then

	net.Receive("ShowDailyRewardNW", function(_l,_p)
		LocalPlayer():ShowDailyRewardBox(net.ReadString())
	end)

	local SCREEN_W, SCREEN_H = 1920, 1080;

	local _w, _h = ScrW( ), ScrH( );

	local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
	local _rewardToShowClient = {
		[1] = dailyrotorewards.config.attendencerewards;	
		[2] = dailyrotorewards.config.organizationrewards; 
		[3] = dailyrotorewards.config.loyaltyreward;
		[4] = dailyrotorewards.config.rookierewards;
	}

	local _goldmodel	= "models/money/goldcoin.mdl"
	local _goldcampos = Vector(5.41, 5.41, 16.22);
	local _goldlookat = Vector(0, 0, -5.41);

	local _vouchermodel	= "models/props_c17/FurnitureShelf001b.mdl"
	local _vouchercampos = Vector(0, 0, 37.837837837838);
	local _voucherlookat = Vector(0, 0, 0);

	local _bindermodel	= "models/props_lab/binderblue.mdl";
	local _bindercampos = Vector(0, 0, 37.837837837838);
	local _binderlookat =Vector(0, 0, 0);
	
	local _rewardmodellookuptable = {
		[1]={
			mod =function() return _goldmodel end;
			cam =function() return _goldcampos end;
			look = function() return _goldlookat end;
		};
		[2]={
			mod = function(id) if ITEMLIST[id] then return ITEMLIST[id].Model end  end;
			cam =function(id) if ITEMLIST[id] then return ITEMLIST[id].CamPos end  end;
			look = function(id) if ITEMLIST[id] then return ITEMLIST[id].LookAt end  end;
		};
		[3]={
			mod =function() return _bindermodel end;
			cam =function() return _bindercampos end;
			look = function() return _binderlookat end;
		};
		[4]={
			mod =function() return _vouchermodel end;
			cam =function() return _vouchercampos end;
			look = function() return _voucherlookat end;
		};
		[5]={
			mod =function() return _bindermodel end;
			cam =function() return _bindercampos end;
			look = function() return _binderlookat end;
		};
		[6]={
			mod =function() return _bindermodel end;
			cam =function() return _bindercampos end;
			look = function() return _binderlookat end;
		};
	}


	local _rarityColors = {
		[0] = Color(255,255,255);
		[1] = Color(51, 204, 51);
		[2] = Color(0, 102, 255);
		[3] = Color(204, 0, 153);
		[4] = Color(255, 153, 51);
		[5] = Color(255, 204, 255);
	}

	surface.CreateFont("RewardPopupFont", {
		size = ScreenScale(5), 
		weight = 1000, 
		antialias = true,
		shadow = false, 
		font = "Default"
	})
	

	local function CreatePopup(DayPanel, rwd)
		local popup = vgui.Create("DFrame")
		_heightmin = 40
		_amountofitems = 1//istable(rwd) && #rwd || 1
		_rowheight = 100
		popup.DayPanel = DayPanel;
		popup:SetMouseInputEnabled(true);
		surface.SetFont("Default")
		popup:ShowCloseButton(false)
		popup:MakePopup()
		popup:SetTitle("")
		popup:SetSize(_wMod*180,_hMod*(_heightmin+(_rowheight*_amountofitems)))
		popup:SetPos(ScrW(),ScrH())
		
		function popup:Paint(w,h) 

			surface.SetDrawColor(56,56,56,255)							
			
			surface.DrawRect(0,0,w,h)

			
		end
		popup.toshowx =5// DayPanel.WeekendColor == true && _wMod*775 || _wMod*(575)
		popup.toshowy =5// DayPanel.Day >= 29 && (_hMod*350) || (_hMod*550/2.05);
		function popup:Think()
			if !IsValid(self.DayPanel) then
				self:Remove()					
			end		
				local _mx,_my = gui.MousePos();
				//_wMod*750,_hMod*550
				self:SetPos(_mx+(self.toshowx),_my+self.toshowy)
		end
		
		local _modelbackdrop = vgui.Create("DPanel", popup)
		popup.modelbackdrop = _modelbackdrop
		_modelbackdrop:SetSize(_wMod*50,_hMod*50)
		if ScrW() == 3840 && ScrH() == 2160 then
			_modelbackdrop:SetSize(_wMod*180,_hMod*150)
		end
	
		function _modelbackdrop:Paint(w,h)

			surface.SetDrawColor(127,127,127,127)					
			
			surface.DrawRect(0,0,w,h)

		end

		local _n = "Item";
		local _d = "Description that is way too long to be an actual description"
		local _c = "10000000";
		local _q = 0;
		if DayPanel.Reward[2]+1==2 then
			_n = ITEMLIST[DayPanel.Reward[3]].Name .. "(x".. DayPanel.Reward[4].. ")";
			_d = ITEMLIST[DayPanel.Reward[3]].Description;
			_c = "$"..ITEMLIST[DayPanel.Reward[3]].Cost;
			_q = ITEMLIST[DayPanel.Reward[3]].Quality;
		end

		local _jobNames = {
			[2] = "Police Officer",
			[3]= "Paramedic",
			[4] = "Mayor",
		}
		//print(DayPanel.Reward[3])

		// Reward Type, whether its money (1) or an item (2) or a skillpoint (3) or a free property voucher (4) or a job rank (5) or a tag (6)
		if DayPanel.Reward[2]+1==5 then
			_n = "Rank Upgrade for" .. _jobNames[DayPanel.Reward[3]] .. " (x" .. DayPanel.Reward[4] ..")";
			_d = "A rank upgrade for the ".. _jobNames[DayPanel.Reward[3]].." class.";
			_c = "'".._jobNames[DayPanel.Reward[3]].."'";
			_q = 5;
		end
		if DayPanel.Reward[2]+1==6 then
			_n = DayPanel.Reward[3] .. " Account Tag";
			_d = "A permanent tag that enhances your account.";
			_c = "'"..DayPanel.Reward[3]"'";
			_q = 5;
		end
		if DayPanel.Reward[2]+1==3 then
			_n = "Free Skill Points (x" .. tostring(DayPanel.Reward[4]) .. ")";
			_d = "Spendable Skill points that enhance your character.";
			_c = "x"..DayPanel.Reward[3];
			_q = 3;
		end
		if DayPanel.Reward[2]+1==4 then
			_n = "Free Property Voucher (x" .. tostring(DayPanel.Reward[4]) .. ")";
			_d = "Spendable Skill points that enhance your character.";
			_c = "x"..DayPanel.Reward[3];
			_q = 2;
		end
		if DayPanel.Reward[2]+1==1 then
			_n = "Money Reward ($" .. tostring(DayPanel.Reward[4]) .. ")";
			_d = "A chunk of money you receive to the bank.";
			_c = "$"..DayPanel.Reward[3];
			_q = 4;
		end

		_modelbackdrop.Model = vgui.Create("DModelPanel",_modelbackdrop)
		_modelbackdrop.Model:Dock(FILL)
		_modelbackdrop.Model:SetModel(DayPanel.modelToDisplay)
		_modelbackdrop.Model:SetCamPos(DayPanel.displayModelCamPos)
		_modelbackdrop.Model:SetLookAt(DayPanel.displayModelLookAt)
		local namewrap = vgui.Create( "DLabel", popup )
		local descwrap = vgui.Create( "DLabel", popup )
		local costwrap = vgui.Create( "DLabel", popup )
		namewrap:SetSize( _wMod*110,_hMod*popup:GetTall())
		namewrap:SetFont( "Default" )
		namewrap:SetText( _n)

		namewrap:SetTextColor(_rarityColors[_q])
		namewrap:SetWrap( true )
		descwrap:SetSize( _wMod*110,_hMod*popup:GetTall())
		descwrap:SetFont( "Default" )
		descwrap:SetText(_d)
		descwrap:SetTextColor(Color(255,255,255))
		descwrap:SetWrap( true )
		costwrap:SetSize( _wMod*110,_hMod*popup:GetTall())
		costwrap:SetFont( "Default" )
		costwrap:SetText( _c)
		costwrap:SetTextColor(Color(255,255,255))
		costwrap:SetWrap( true )
		if ScrW() == 3840 && ScrH() == 2160 then
			surface.SetFont("Default")
			local _texnw,_texnh = surface.GetTextSize(_n)
			local _texdw,_texdh = surface.GetTextSize(_n)
			local _texcw,_texch = surface.GetTextSize("$".._c)
			namewrap:SetPos(_wMod*90-(_texnw/2),_hMod*-190 )
			descwrap:SetPos(_wMod*45-(_texdw/2),_hMod*-80 )
			costwrap:SetPos(_wMod*90-(_texcw/2),_hMod*-180 )				
		else
			namewrap:SetPos(_wMod*57.5,_hMod*-50 )
			descwrap:SetPos(_wMod*57.5,0 )
			costwrap:SetPos(_wMod*1,_hMod*-25)
		end

		return popup
	end
	function ShowDailyRewardPopup(revtb)	
		//PrintTable(revtb)
		local Frame = vgui.Create("DFrame");
		Frame:SetSize(_wMod*400,_hMod*350)
		Frame:MakePopup()
		Frame:Center()
		Frame:ShowCloseButton(false)
		Frame:SetTitle("")
		function Frame:Paint(w,h)

			surface.SetDrawColor(56,56,56,128)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(25,25,25,128)
			surface.DrawRect(_wMod*5,_hMod*5,w-(_wMod*10),h-(_hMod*10))

		end


		surface.SetFont("RewardPopupFont")
		local _tx, _ty = surface.GetTextSize("You have received attendance rewards!")
		local namepanel = vgui.Create( "DPanel", Frame )
		namepanel:SetSize( (Frame:GetWide()/1.65), _hMod* 20 )
		namepanel:SetPos(_wMod*(325)-((_tx/2)*_wMod),_hMod*20)
		function namepanel:Paint(w,h)

			surface.SetDrawColor(128,128,128,128)
			surface.DrawRect(0,0,w,h)
		end
		
		local namewrap = vgui.Create( "DLabel", Frame )
		namewrap:SetSize( (Frame:GetWide()/1.5), _hMod* 20 )
		namewrap:SetPos(_wMod*(200)-((_tx/2)*_wMod),_hMod*20)
		if ScrW() == 3840 then
			namewrap:SetPos(_wMod*(325)-((_tx/2)*_wMod),_hMod*20)
		end
		
		namewrap:SetFont( "RewardPopupFont" )
		namewrap:SetText( "You have received attendance rewards!")

		namewrap:SetTextColor(Color(255,225,0,128))
		namewrap:SetWrap( false )

		local accept = vgui.Create( "DButton", Frame )
		accept:SetSize( _wMod*200, _hMod* 50 )
		accept:SetPos(_wMod*100,290 * _hMod)
		accept:SetText( "Acknowledge" )
		function accept:OnMousePressed(k)
			Frame:Remove()

		end
		local _rewardScrollBackground = vgui.Create("DPanel",Frame)
		_rewardScrollBackground:SetPos(_wMod*50, _hMod*75)
		_rewardScrollBackground:SetSize(_wMod*300,_hMod*200)
		function _rewardScrollBackground:Paint(w,h)

			surface.SetDrawColor(25,25,25,225)
			surface.DrawRect(0,0,w,h)
		end

		local _rewardScroll = vgui.Create("DScrollPanel",_rewardScrollBackground)
		_rewardScroll:Dock(FILL)
		_rewardScroll:SetPadding(5)
		/*

		DayPanel.WeekendColor = false;
		DayPanel.Day = 20;
		DayPanel.Reward = RewardInTargetTable
		DayPanel.modelToDisplay = _rewardmodellookuptable[v[2]+1][1](v[3])
		DayPanel.displayModelCamPos = _rewardmodellookuptable[v[2]+1][2](v[3])
		DayPanel.displayModelLookAt = _rewardmodellookuptable[v[2]+1][3](v[3])

		*/ 
		_rewardScroll.ActiveRewards = {};
		function _rewardScroll:AddReward(rewardcat,day)
			local DayPanel = vgui.Create("DPanel", _rewardScroll)
			DayPanel:SetSize(_rewardScroll:GetWide(),_hMod*50)
			DayPanel:Dock(TOP)
			function DayPanel:Paint(w,h)

				surface.SetDrawColor(56,56,56,128)
				
				
				surface.DrawRect(0,0,w,h)

			end

			local v = _rewardToShowClient[rewardcat][day];
			DayPanel.WeekendColor = false;
			DayPanel.Day = day;
			DayPanel.Reward = v
			local _n = "Item";
			local _d = "Description that is way too long to be an actual description"
			local _c = "10000000";
			local _q = 0;
			if DayPanel.Reward[2]+1==2 then
				_n = ITEMLIST[DayPanel.Reward[3]].Name .. "(x".. DayPanel.Reward[4].. ")";
				_d = ITEMLIST[DayPanel.Reward[3]].Description;
				_c = "$"..ITEMLIST[DayPanel.Reward[3]].Cost;
				_q = ITEMLIST[DayPanel.Reward[3]].Quality;
			end

			local _jobNames = {
				[2] = "Police Officer",
				[3]= "Paramedic",
				[4] = "Mayor",
			}
			if DayPanel.Reward[2]+1==5 then
				_n = "Rank Upgrade for" .. _jobNames[DayPanel.Reward[3]] .. " (x" .. DayPanel.Reward[4] ..")";
				_d = "A rank upgrade for the ".. _jobNames[DayPanel.Reward[3]].." class.";
				_c = "'".._jobNames[DayPanel.Reward[3]].."'";
				_q = 5;
			end
			if DayPanel.Reward[2]+1==6 then
				_n = DayPanel.Reward[3] .. " Account Tag";
				_d = "A permanent tag that enhances your account.";
				_c = "'"..DayPanel.Reward[3].."'";
				_q = 5;
			end
			if DayPanel.Reward[2]+1==3 then
				_n = "Free Skill Points (x" .. tostring(DayPanel.Reward[4]) .. ")";
				_d = "Spendable Skill points that enhance your character.";
				_c = "x"..DayPanel.Reward[3];
				_q = 3;
			end
			if DayPanel.Reward[2]+1==4 then
				_n = "Free Property Voucher (x" .. tostring(DayPanel.Reward[4]) .. ")";
				_d = "Spendable Skill points that enhance your character.";
				_c = "x"..DayPanel.Reward[3];
				_q = 2;
			end
			if DayPanel.Reward[2]+1==1 then
				_n = "Money Reward ($" .. tostring(DayPanel.Reward[3]) .. ")";
				_d = "A chunk of money you receive to the bank.";
				_c = "$"..DayPanel.Reward[3];
				_q = 4;
			end
			DayPanel.SubPanel = Frame

			DayPanel.modelToDisplay = _rewardmodellookuptable[(tonumber(v[2])+1)].mod(v[3])
			DayPanel.displayModelCamPos = _rewardmodellookuptable[(tonumber(v[2])+1)].cam(v[3])
			DayPanel.displayModelLookAt = _rewardmodellookuptable[(tonumber(v[2])+1)].look(v[3])
			DayPanel.RewardItemContains = ITEMLIST[v[3]] && ITEMLIST[v[3]].Contains || 1;
		

			local namewrap = vgui.Create( "DLabel", DayPanel )
			namewrap:SetSize( _wMod*400,_hMod*25)
			namewrap:SetPos(_wMod*55, _hMod*15)
			namewrap:SetFont( "RewardPopupFont" )
			namewrap:SetText( _n)

			namewrap:SetTextColor(_rarityColors[_q])
			namewrap:SetWrap( false )

			local _modeldisplayfade = vgui.Create("DPanel",DayPanel)
			local _modeldisplay = vgui.Create("DModelPanel",_modeldisplayfade)
			_modeldisplay:SetModel(DayPanel.modelToDisplay)
			_modeldisplay:SetCamPos(DayPanel.displayModelCamPos)
			_modeldisplay:SetLookAt(DayPanel.displayModelLookAt)
			_modeldisplayfade:SetSize(_wMod*50,_hMod*50)
			_modeldisplay:Dock(FILL)
			function _modeldisplayfade:Paint(w,h)

				surface.SetDrawColor(56,56,56,127)
				
				
				surface.DrawRect(0,0,w,h)

			end
			function _modeldisplay:Think()
				if vgui.GetHoveredPanel() == self and !self.Popup then
					self.Popup = CreatePopup(DayPanel,DayPanel.RewardItemContains)
				elseif vgui.GetHoveredPanel() != self then
					if self.Popup then
						self.Popup:Remove()
						self.Popup = nil;
					end
				end										
			end

		end
		function _rewardScroll:RefreshRewards()
			for k , v in pairs(_rewardScroll.ActiveRewards) do
				v:Remove()
			end
			for k , v in pairs(revtb) do
				for x,y in pairs(v) do
					_rewardScroll:AddReward(y[3],y[4])
				end
			end
		end
		

		_rewardScroll:RefreshRewards()

		return Frame;
	end
	function ShowDailyRewardCalendar(showingtabs)
		
		timer.Simple(1,function() 
			DrawActionBar()
			DrawWeaponWheel()
		end)
		RunConsoleCommand("mapview")
		local Frame = vgui.Create("DFrame");
		Frame:SetSize(_wMod*750,_hMod*550)
		Frame:MakePopup()
		Frame:Center()
		Frame:ShowCloseButton(false)
		Frame:SetTitle("")
		function Frame:Paint(w,h)

			surface.SetDrawColor(127,127,127,255)
			surface.DrawRect(0,0,w,h)
			surface.SetDrawColor(25,25,25,128)
			surface.DrawRect(_wMod*5,_hMod*5,w-(_wMod*10),h-(_hMod*10))

		end
		local FrameX , FrameY = Frame:GetSize();

		local SubPanel = vgui.Create("DPanel",Frame)
		Frame.SubPanel = SubPanel;
		SubPanel:SetPos(_wMod*5,_hMod*5)
		SubPanel:SetSize(FrameX-(_wMod*10),FrameY-(_hMod*10))
		function SubPanel:Paint(w,h)

			surface.SetDrawColor(56,56,56,128)
			surface.DrawRect(0,0,w,h)
			surface.SetFont("Default")

			surface.SetDrawColor(255,255,255,255)
			surface.SetTextPos(_wMod*5,_hMod*5)
			surface.DrawText("Daily Reward Calendar")

		end

		SubPanel.ExitButton = vgui.Create("DButton", SubPanel)
		SubPanel.ExitButton.SubPanel = SubPanel;
		SubPanel.ExitButton:SetSize(_wMod*50,_hMod*50)
		local SubPanelX , SubPanelY = SubPanel:GetSize();
		SubPanel.ExitButton:SetPos(SubPanelX-(_wMod*56),(_hMod*5))
		SubPanel.ExitButton.Frame = Frame;
		SubPanel.ExitButton:SetText("")
		function SubPanel.ExitButton:Paint(w,h)

			if self:IsHovered() then
				surface.SetDrawColor(25,25,25,128)				
			else
				surface.SetDrawColor(56,56,56,128)
			end
			surface.DrawRect(0,0,w,h)
			surface.SetFont("Default")
			local _x,_y=surface.GetTextSize("X")
			surface.SetTextColor(255,255,255,255)
			surface.SetTextPos(25-_x/2,25-_y/2)
			surface.DrawText("X")

		end
		function SubPanel.ExitButton:DoClick(k)
			if Frame then
				Frame:Close();
			end
		end
		SubPanel.ScrollParent = vgui.Create("DScrollPanel", SubPanel)
		SubPanel.ScrollParent:SetPos(_wMod*5,_hMod*105)
		SubPanel.ScrollParent:SetSize(SubPanelX -(10*_wMod), SubPanelY-(_hMod*110))
		
		SubPanel.CalGrid = vgui.Create("DPanel", SubPanel.ScrollParent)
		SubPanel.CalGrid:SetSize(SubPanelX , SubPanelY)
		//SubPanel.CalGrid:SetCols(7)
		//SubPanel.CalGrid:SetColWide(_wMod*85)
		//SubPanel.CalGrid:SetRowHeight(_hMod*110)
		SubPanel.CalGrid.ChildPanels = {};

		function SubPanel.CalGrid:Paint(w,h)

			surface.SetDrawColor(225,225,225,128)
			surface.DrawRect(0,0,w,h)

		end
		function SubPanel.CalGrid:SetActiveCalendar(number)
			for k , v in pairs(SubPanel.CalGrid.ChildPanels) do
				v:Remove() 
			end
			if !_rewardToShowClient[number] then return end
			local count = 0;
			local _count = 0;

			SubPanel.CalGrid:SetSize(SubPanelX ,((_hMod*21)*#_rewardToShowClient[number]))
			local _ourRewards = LocalPlayer():GetDailyRewardTable();
			local _collectedinnum = tonumber(_ourRewards[3][number][3])
			for k=1,31 do
				local v = _rewardToShowClient[number][k]
				local lastv = _rewardToShowClient[number][math.max(1,_collectedinnum+1)]

				if v then
					
					local DayPanel = vgui.Create("DPanel", SubPanel.CalGrid)
					DayPanel.Day = k;
					DayPanel:SetSize((_wMod*100),_hMod*125);
					DayPanel:SetPos(_wMod* ((count*100) +10) ,_hMod* ((_count*125)+10) )

					if k <= _collectedinnum or (k == _collectedinnum+1 and lastv[1] == false) then
						
					
						local StampPanel = vgui.Create("DPanel", DayPanel)
						StampPanel.Day = k;
						StampPanel:SetSize((_wMod*100),_hMod*100);
						StampPanel:SetPos(_wMod*20,_hMod*55 )
						local _add = 0
						
						if k == _collectedinnum then
							_add = 15
							StampPanel.DoAnim = true
							
						end

						function StampPanel:Paint(w,h)

							surface.SetDrawColor(255,255,255,255)
							if _stampMaterial then
								surface.SetMaterial(_stampMaterial)
								surface.DrawTexturedRect(_add/2,_add/2,w/2*math.max(1,(_add/10)),h/2*math.max(1,(_add/10)))
							end
							if StampPanel.DoAnim then
								_add = Lerp(0.05,_add,0);
								if _add <= 5 then
									StampPanel.DoAnim = false
									_add = 0
								end
							end
						end

					end
					

					table.insert(SubPanel.CalGrid.ChildPanels,DayPanel);
					DayPanel:SetMouseInputEnabled(true);
					DayPanel.Reward = v;
					DayPanel.SubPanel = SubPanel
					count = count +1;
					

					DayPanel.modelToDisplay = _rewardmodellookuptable[(tonumber(v[2])+1)].mod(v[3])
					DayPanel.displayModelCamPos = _rewardmodellookuptable[(tonumber(v[2])+1)].cam(v[3])
					DayPanel.displayModelLookAt = _rewardmodellookuptable[(tonumber(v[2])+1)].look(v[3])
					DayPanel.RewardItemContains = ITEMLIST[v[3]] && ITEMLIST[v[3]].Contains || 1;
					
					
					local _todaysdate = os.date("%e",os.time(  ))
					if count !=0 && count >=6 then
						DayPanel.WeekendColor = true;
					end
						
					if count !=0 && count %7==0 then
						_count = _count+1;
						count = 0;
					end

					local _modeldisplayfade = vgui.Create("DPanel",DayPanel)
					local _modeldisplay = vgui.Create("DModelPanel",_modeldisplayfade)
					//local _thinkdisplay = vgui.Create("DPanel",_modeldisplay)
					_modeldisplayfade.DayPanel = DayPanel
					_modeldisplay.DayPanel = DayPanel
					//_thinkdisplay.DayPanel = DayPanel
					local function CreateTruePopup()
						local popup = vgui.Create("DPanel",SubPanel)
						_heightmin = 40
						_amountofitems = istable(self.RewardItemContains) && #self.RewardItemContains || 1
						_rowheight = 100
						popup.DayPanel = DayPanel;
						popup:SetMouseInputEnabled(true);
						surface.SetFont("Default")
						
						popup:SetSize(_wMod*180,_hMod*(_heightmin+(_rowheight*_amountofitems)))
						popup:SetPos(ScrW(),ScrH())
						
						function popup:Paint(w,h) 

							surface.SetDrawColor(56,56,56,255)							
							
							surface.DrawRect(0,0,w,h)

							
						end
						popup.toshowx = DayPanel.WeekendColor == true && _wMod*775 || _wMod*(575)
						popup.toshowy = DayPanel.Day >= 29 && (_hMod*350) || (_hMod*550/2.05);
						function popup:Think()
							if !IsValid(self.DayPanel) then
								self:Remove()					
							end		
								local _mx,_my = gui.MousePos();
								//_wMod*750,_hMod*550
								self:SetPos(_mx-(self.toshowx),_my-self.toshowy)
						end
						
						local _modelbackdrop = vgui.Create("DPanel", popup)
						popup.modelbackdrop = _modelbackdrop
						_modelbackdrop:SetSize(_wMod*50,_hMod*50)
						if ScrW() == 3840 && ScrH() == 2160 then
							_modelbackdrop:SetSize(_wMod*180,_hMod*150)
						end
					
						function _modelbackdrop:Paint(w,h)

							surface.SetDrawColor(127,127,127,127)					
							
							surface.DrawRect(0,0,w,h)

						end
						local _n = "Item";
						local _d = "Description that is way too long to be an actual description"
						local _c = "10000000";
						local _q = 0;
						if DayPanel.Reward[2]+1==2 then
							_n = ITEMLIST[DayPanel.Reward[3]].Name .. "(x".. DayPanel.Reward[4].. ")";
							_d = ITEMLIST[DayPanel.Reward[3]].Description;
							_c = "$"..ITEMLIST[DayPanel.Reward[3]].Cost;
							_q = ITEMLIST[DayPanel.Reward[3]].Quality;
						end
						local _jobNames = {
							[2] = "Police Officer",
							[3]= "Paramedic",
							[4] = "Mayor",
						}

						// Reward Type, whether its money (1) or an item (2) or a skillpoint (3) or a free property voucher (4) or a job rank (5) or a tag (6)
						if DayPanel.Reward[2]+1==5 then
							_n = "Rank Upgrade for" .. _jobNames[DayPanel.Reward[3]] .. " (x" .. DayPanel.Reward[4] ..")";
							_d = "A rank upgrade for the ".. _jobNames[DayPanel.Reward[3]].." class.";
							_c = "'".._jobNames[DayPanel.Reward[3]].."'";
							_q = 5;
						end
						if DayPanel.Reward[2]+1==6 then
							_n = DayPanel.Reward[3] .. " Account Tag";
							_d = "A permanent tag that enhances your account.";
							_c = "'"..DayPanel.Reward[3].."'";
							_q = 5;
						end
						if DayPanel.Reward[2]+1==3 then
							_n = "Free Skill Points (x" .. tostring(DayPanel.Reward[4]) .. ")";
							_d = "Spendable Skill points that enhance your character.";
							_c = "x"..DayPanel.Reward[3];
							_q = 3;
						end
						if DayPanel.Reward[2]+1==4 then
							_n = "Free Property Voucher (x" .. tostring(DayPanel.Reward[4]) .. ")";
							_d = "Spendable Skill points that enhance your character.";
							_c = "x"..DayPanel.Reward[3];
							_q = 2;
						end
						if DayPanel.Reward[2]+1==1 then
							_n = "Money Reward ($" .. tostring(DayPanel.Reward[3]) .. ")";
							_d = "A chunk of money you receive to the bank.";
							_c = "$"..DayPanel.Reward[3];
							_q = 4;
						end
						_modelbackdrop.Model = vgui.Create("DModelPanel",_modelbackdrop)
						_modelbackdrop.Model:Dock(FILL)
						if DayPanel.modelToDisplay then
							_modelbackdrop.Model:SetModel(DayPanel.modelToDisplay)
							_modelbackdrop.Model:SetCamPos(DayPanel.displayModelCamPos)
							_modelbackdrop.Model:SetLookAt(DayPanel.displayModelLookAt)
						end
						local namewrap = vgui.Create( "DLabel", popup )
						local descwrap = vgui.Create( "DLabel", popup )
						local costwrap = vgui.Create( "DLabel", popup )
						namewrap:SetSize( _wMod*110,_hMod*popup:GetTall())
						namewrap:SetFont( "Default" )
						namewrap:SetText( _n)

						namewrap:SetTextColor(_rarityColors[_q])
						namewrap:SetWrap( true )
						descwrap:SetSize( _wMod*110,_hMod*popup:GetTall())
						descwrap:SetFont( "Default" )
						descwrap:SetText(_d)
						descwrap:SetTextColor(Color(255,255,255))
						descwrap:SetWrap( true )
						costwrap:SetSize( _wMod*110,_hMod*popup:GetTall())
						costwrap:SetFont( "Default" )
						costwrap:SetText( _c)
						costwrap:SetTextColor(Color(255,255,255))
						costwrap:SetWrap( true )
						if ScrW() == 3840 && ScrH() == 2160 then
							surface.SetFont("Default")
							local _texnw,_texnh = surface.GetTextSize(_n)
							local _texdw,_texdh = surface.GetTextSize(_n)
							local _texcw,_texch = surface.GetTextSize("$".._c)
							namewrap:SetPos(_wMod*90-(_texnw/2),_hMod*-190 )
							descwrap:SetPos(_wMod*45-(_texdw/2),_hMod*-80 )
							costwrap:SetPos(_wMod*90-(_texcw/2),_hMod*-180 )				
						else
							namewrap:SetPos(_wMod*57.5,_hMod*-50 )
							descwrap:SetPos(_wMod*57.5,0 )
							costwrap:SetPos(_wMod*1,_hMod*-25)
						end

						return popup
					end
					local _popup = nil;
					
					local _popup = nil;
					//_thinkdisplay.Paint = function(self,w,h) end;
					_modeldisplayfade:SetSize(_wMod*50,_hMod*50)
					_modeldisplayfade:SetPos(_wMod*50,0)
					local _modeldisplay = vgui.Create("DModelPanel",_modeldisplayfade)
					_modeldisplay:Dock(FILL)
					//_thinkdisplay:Dock(FILL)
					if DayPanel.modelToDisplay then
						_modeldisplay:SetModel(DayPanel.modelToDisplay)
						_modeldisplay:SetCamPos(DayPanel.displayModelCamPos)
						_modeldisplay:SetLookAt(DayPanel.displayModelLookAt)
					end
					
					_modeldisplay:SetText("")
					_modeldisplayfade:SetText("")
					_modeldisplay:SetMouseInputEnabled(true);
					function _modeldisplay:Think()

						if vgui.GetHoveredPanel() == self and !self.Popup then
							self.Popup = CreateTruePopup( )
						elseif vgui.GetHoveredPanel() != self then
							if self.Popup then
								self.Popup:Remove()
								self.Popup = nil;
							end
						end
												
					end
					
					function DayPanel:Paint(w,h)


						surface.SetDrawColor(56,56,56,128)
						if DayPanel.WeekendColor or DayPanel.Reward[1] == false then
							surface.SetDrawColor(255,223,0,127)
						end
						surface.DrawRect(0,0,w,h)
						surface.SetTextColor(255,255,255,255)
						surface.SetFont("Default")
						surface.SetTextPos(_wMod*8,_hMod*5)
						surface.DrawText(self.Day)

						surface.SetDrawColor(255,0,0,255)
						if tonumber(_todaysdate) == self.Day then
							surface.DrawLine(_wMod*2,_hMod*17,_wMod*20,_hMod*17)
							surface.DrawLine(_wMod*3,_hMod*18,_wMod*19,_hMod*18)
						end
					
					end
				
					//local _goldmodel	= "models/money/goldcoin.mdl"
					//local _goldcampos = Vector(5.41, 5.41, 16.22);
					//local _goldlookat = Vector(0, 0, -5.41);


					function _modeldisplayfade:Paint(w,h)

						if _collectedinnum >= DayPanel.Day then
							surface.SetDrawColor(56,128,56,255)						
						else
							surface.SetDrawColor(56,56,56,127)
						end
						
						surface.DrawRect(0,0,w,h)

					end
				end
			end

		end

		SubPanel.Tabs = {};
		local count = 0;
		local _tabTexts = {
			[1] = "Attendance Rewards",
			[2] = "Organization Rewards",
			[3] = "Loyalty Rewards",
			[4] = "Rookie Rewards",
		}
		if istable(showingtabs) then
			for k=1,4  do
				local v= showingtabs[k];
				if v then
					local tabbutton = vgui.Create("DButton",SubPanel) 
					tabbutton.TabNum = k;
					tabbutton:SetSize((_wMod*170),_hMod*80);
					tabbutton:SetPos(_wMod*5+ ((_wMod*170)*count), _hMod*20);
					tabbutton:SetText("")
					function tabbutton:OnMousePressed(k)

						SubPanel.CalGrid:SetActiveCalendar(tabbutton.TabNum)
	 
					end
					tabbutton._Text = _tabTexts[tabbutton.TabNum]

					function tabbutton:Paint(w,h)			

						if self:IsHovered() then
							surface.SetDrawColor(25,25,25,128)				
						else
							surface.SetDrawColor(56,56,56,128)
						end
						surface.DrawRect(0,0,w,h)

						local _x,_y = surface.GetTextSize(tabbutton._Text);
						surface.SetTextColor(255,255,255,255)
						surface.SetTextPos(w /2-_x/2 ,h /2-_y/2)					
						surface.SetFont("Default")
						surface.DrawText(tabbutton._Text);
					end
					SubPanel.Tabs[k] = tabbutton


					count = count+1;
				end
			
			end

			if #SubPanel.Tabs >0 then
				SubPanel.CalGrid:SetActiveCalendar(SubPanel.Tabs[1].TabNum)
			end
		end

		return Frame
	end

end

if SERVER then
	
	function _plyMeta:SetupDailyRewardTable(vouchers, rookie)
		if !rookie || !istable(rookie) then
			rookie =  {
					1;	// rookie reward
					os.time()-((3600*24)+1);// Last Reward in UTC
					0;		// Amount of rewards earned
				};

		end
		 local _orgReward = 0;
		 if self:getFlag("organization", 0) > 0 then
		 	_orgReward = 1;
		 end
		local LoyaltyRewards = {
			[1] = dailyrotorewards.config.rewardschedule; // schedule id
			[2] = 0; // property vouchers
			[3] = { 
				[1] = {
					1;	// attendance reward
					os.time()-((3600*24)+1);// Last Reward in UTC
					0;		// Amount of rewards earned
				};
				[2] = {
					_orgReward;	// org reward
					os.time()-((3600*24)+1);// Last Reward in UTC
					0;		// Amount of rewards earned
				};
				[3] = {
					0;	// loyalty reward
					os.time();// Last Reward in UTC
					0;		// Amount of rewards earned
				};
				[4] = rookie;
			};
		};
		
		self:setFlag("rotodailyreward",util.TableToJSON(LoyaltyRewards));

		local _p = self;
		
		timer.Simple(2,function()
			if IsValid(_p) and _p then
				_p:CheckDailyReward();
			end
		end)

		return false;
	end

	// Reward Type, whether its money (1) or an item (2) or a skillpoint (3) or a free property voucher (4) or a job rank (5) or a tag (6)
	RewardHandoutSwitch = {}
	RewardHandoutSwitch[1] = function (_p,amount,tobank) 
			if dailyrotorewards.config.norewards == true then return 0; end
			_p:addMoney(amount);
			return 0;
		end
	RewardHandoutSwitch[2] = function (_p,id,amount) 
			if dailyrotorewards.config.norewards == true then return 0; end
			for i=1, amount or 1 do
				_p:AddItemByID(id)
			end

			return 0; 
		end
	RewardHandoutSwitch[3] = function (_p,amount) 
			if dailyrotorewards.config.norewards == true then return 0; end
			_p:Notify("You have received x" .. amount .. " skill points from your daily reward.")
			_p:AddFreeSkillPoints(amount);
			return 0;
		end
	RewardHandoutSwitch[4] = function (_p, amount)
			if dailyrotorewards.config.norewards == true then return 0; end
			return amount;
		end
	RewardHandoutSwitch[5] = function (_p, job, ranks)
			if dailyrotorewards.config.norewards == true then return 0; end
			_p:SetJobRank(job,ranks);
			return 0;
		end
	RewardHandoutSwitch[6] = function (_p, newtag)
			if dailyrotorewards.config.norewards == true then return 0; end
			_p:AddTag(newtag,false) 
			return 0;
		end
	RewardHandoutSwitch.default = function(x) return 0 end

	local _RewardTables = {
		dailyrotorewards.config.attendencerewards;
		dailyrotorewards.config.organizationrewards;
		dailyrotorewards.config.loyaltyreward;
		dailyrotorewards.config.rookierewards;
	}
	local _timeRewardDelays = {
			[1] = (3600*24);
			[2] = (3600*24);
			[3] = (3600*24)*7;
			[4] = (3600*24);
		}
	local function handoutRotoReward( playerin, rewnum, tblin )

		return DailyRewardSwitch[rewnum](rewnum,playerin, tblin)
	end

	function _plyMeta:AddVoucher(num)
		local _rewardTable 				= self:GetDailyRewardTable();
		_rewardTable[2]=_rewardTable[2]+num
		
		self:setFlag("rotodailyreward", util.TableToJSON(_rewardTable) )
			self:SaveDailyReward()
	end

	function _plyMeta:UseVoucher()
		if self:CanUsePropVoucher() then
			local _rewardTable 				= self:GetDailyRewardTable();
			_rewardTable[2]=_rewardTable[2]-1
		end
		self:setFlag("rotodailyreward", util.TableToJSON(_rewardTable) )
			self:SaveDailyReward()
	end
	local _playerstoCheck = {};

	function _plyMeta:SkipDailyRewardWait()
		local _rewardTable = self:GetDailyRewardTable();
		if !_rewardTable then return ErrorNoHalt("Couldn't Skip Daily Reward Wait") end

		_rewardSchedule = _rewardTable[3]
		for k , v in pairs(_rewardSchedule) do
			_rewardSchedule[k][2] = os.time()-(3600*24);
		end
		_rewardTable[3] = _rewardSchedule;

		self:setFlag("rotodailyreward", util.TableToJSON(_rewardTable) )
		table.insert(_playerstoCheck,self);

		timer.Simple(1,function() for k , v in pairs(_playerstoCheck) do
				v:CheckDailyReward()
			end
			_playerstoCheck={}
		end)
 
	end
	
	function _plyMeta:CheckDailyReward(first)
		local _rewardTable 				= self:GetDailyRewardTable()

		if istable(_rewardTable) then
			
			local _ourSchedule 			= _rewardTable[1]; // schedule id;
			local _propertyVouchers 	= _rewardTable[2] // available vouchers
			local _rewardSchedule 		= _rewardTable[3] // reward time table

			if _ourSchedule != dailyrotorewards.config.rewardschedule then
				
				return self:SetupDailyRewardTable(_propertyVouchers ,_rewardSchedule[4]);
			end
			local _rewardstoshow 		= {};
			local rewardcount = 0;
			 
			for k=1,4 do
				local v=_rewardSchedule[k];
				local _active = v[1]
				local _lastGive = v[2];
				local _rcount = v[3] or 1;
				local _targetbl=_RewardTables[k];
				local _targetrcount = (_rcount+1);
				local _targetrcounttwo = (_rcount+2);

				if os.time() > (_lastGive+_timeRewardDelays[k]) then
					if !_rewardstoshow[k] then
						_rewardstoshow[k] = {}
					end
					local _inc = 1
					if _targetbl[1] == false then
						_inc = 2;	

					end
					_rewardSchedule[k][1] = 1
					_active = 1;
					if _active == 1 then
						local _rewardtype = _targetbl[_targetrcount][2]+1;

						/*RewardHandoutSwitch.Money
						RewardHandoutSwitch.Item
						RewardHandoutSwitch.Skillpoints
						RewardHandoutSwitch.Vouchers
						RewardHandoutSwitch.Jobrank
						RewardHandoutSwitch.Newtag*/
						local _func = RewardHandoutSwitch[_rewardtype]
 						local _rewardid, _rewardamount = _targetbl[_targetrcount][3],_targetbl[_targetrcount][4];

 						_vouchers = _func(self,_rewardid,_rewardamount);
						table.insert(_rewardstoshow[k],{_rewardid,_rewardamount,k,_targetrcount})

						_rewardSchedule[k][2] = os.time()
						_rewardSchedule[k][3] = _targetrcount;
						if _inc == 2 then
							local _rewardtype = _targetbl[_targetrcounttwo][2];
							local _func = RewardHandoutSwitch[_rewardtype]

 							local _rewardid, _rewardamount = _targetbl[_targetrcounttwo][3],_targetbl[_targetrcounttwo][4];

							table.insert(_rewardstoshow[k],{_rewardid,_rewardamount,k,_targetrcounttwo})

							_vouchers = _vouchers + _func(self,_rewardid,_reward);				
						
							_rewardSchedule[k][3] = _targetrcounttwo;
						end
						_propertyVouchers = _propertyVouchers + _vouchers
					end

					rewardcount = rewardcount +1;
				end

			end

			_rewardTable = {_ourSchedule,_propertyVouchers,_rewardSchedule};
			_rewardTable = util.TableToJSON(_rewardTable)
			self:setFlag("rotodailyreward", _rewardTable )
			
			if rewardcount > 0 or first then

				self:ShowDailyRewardBox(_rewardstoshow);

			end
			
			self:SaveDailyReward()
			
			return true

		else

			return self:SetupDailyRewardTable(0);
		end

		return false;
	end
	
end
end

dailyrotorewards.config.organizationrewards = {
	[1] = {
		false;	// Count as a day
		1; 		// Reward Type, whether its money (0) or an item (1) or a skillpoint (2) or a free property voucher (3) or a job rank (4) or a tag (5)
		30; 		// Value of the Reward / ID of the Item
		1; 		// Amount of the Item to give
	};
	[2] = {
		true;	
		1; 		
		41; 		
		3; 		
	};
	[3] = {
		true;	
		1; 		
		759; 		
		1; 		
	};
	[4] = {
		true;	
		0; 		
		75000; 		
		1; 		
	};
	[5] = {
		true;	
		2; 		
		5; 		
		1; 		
	};
	[6] = {
		true;	
		3; 		
		3; 		
		1; 		
	};
	[7] = {
		true;	
		1; 		
		39; 		
		3; 		
	};
	[8] = {
		true;	
		1; 		
		96; 		
		20; 		
	};
	[9] = {
		true;	
		1; 		
		752; 		
		1; 		
	};
	[10] = {
		true;	
		1; 		
		740; 		
		1; 		
	};
	[11] = {
		true;	
		1; 		
		755; 		
		2; 		
	};
	[12] = {
		true;	
		1; 		
		41; 		
		3; 		
	};
	[13] = {
		true;	
		1; 		
		758; 		
		1; 		
	};
	[14] = {
		true;	
		0; 		
		250000; 		
		1; 		
	};
	[15] = {
		true;	
		2; 		
		5; 		
		1; 		
	};
	[16] = {
		true;	
		1; 		
		32; 		
		3; 		
	};
	[17] = {
		true;	
		1; 		
		96; 		
		1; 		
	};
	[18] = {
		true;	
		1; 		
		752; 		
		3; 		
	};
	[19] = {
		true;	
		1; 		
		96; 		
		20; 		
	};
	[20] = {
		true;	
		1; 		
		740; 		
		3; 		
	};
	[21] = {
		true;	
		1; 		
		755; 		
		2; 		
	};
	[22] = {
		true;	
		1; 		
		41; 		
		5; 		
	};
	[23] = {
		true;	
		1; 		
		762; 		
		3; 		
	};
	[24] = {
		true;	
		0; 		
		750000; 		
		1; 		
	};
	[25] = {
		true;	
		2; 		
		5; 		
		1; 		
	};
	[26] = {
		true;	
		3; 		
		5; 		
		1; 		
	};
	[27] = {
		true;	
		1; 		
		763; 		
		5; 		
	};
	[28] = {
		true;	
		1; 		
		756; 		
		3; 		
	};
	[29] = {
		true;	
		1; 		
		757; 		
		1; 		
	};
	[30] = {
		true;	
		1; 		
		740; 		
		3; 		
	};
	[31] = {
		true;	
		1; 		
		755; 		
		3; 		 
	};
};
dailyrotorewards.config.loyaltyreward = {
	[1] = {
		false;	// Count as a day
		1; 		// Reward Type, whether its money (0) or an item (1) or a skillpoint (2) or a free property voucher (3) or a job rank (4) or a tag (5)
		329;	// Value of the Reward / ID of the Item
		1; 		// Amount of the Item to give
	};
	[2] = {
		true;	
		0; 		
		350000;	
		1; 		
	};
	[3] = {
		true;	
		3; 		
		3;	
		1; 		
	};
	[4] = {
		true;	
		1; 		
		755;	
		3; 		
	};
	[5] = {
		true;	
		1; 		
		758;	
		1; 		
	};
	[6] = {
		true;	
		2; 		
		5;	
		1; 		
	};
	[7] = {
		true;	
		1; 		
		44;	
		20; 		
	};
	[8] = {
		true;	
		1; 		
		756;	
		1; 		
	};
	[9] = {
		true;	
		1; 		
		43;	
		3; 		
	};
	[10] = {
		true;	
		1; 		
		757;	
		1; 		
	};
	[11] = {
		true;	
		0; 		
		600000;	
		1; 		
	};
	[12] = {
		true;	
		1; 		
		751;	
		1; 		
	};
	[13] = {
		true;	
		1; 		
		754;	
		3; 		
	};
	[14] = {
		true;	
		1; 		
		740;	
		3; 		
	};
	[15] = {
		true;	
		1; 		
		752;	
		3; 		
	};
	[16] = {
		true;	
		2; 		
		5;	
		1; 		
	};
	[17] = {
		true;	
		1; 		
		760;	
		1; 		
	};
	[18] = {
		true;	
		3; 		
		5;	
		1; 		
	};
	[19] = {
		true;	
		1; 		
		762;	
		1; 		
	};
	[20] = {
		true;	
		1; 		
		757;	
		1; 		
	};
	[21] = {
		true;	
		0; 		
		900000;	
		1; 		
	};
}

dailyrotorewards.config.attendencerewards = {
	[1] = {
		false;	// Count as a day
		3; 		// Reward Type, whether its money (0) or an item (1) or a skillpoint (2) or a free property voucher (3) or a job rank (4) or a tag (5)
		3; 		// Value of the Reward / ID of the Item
		3;		// Amount of the Item to give
	};
	[2] = {
		true;	
		1; 		
		761; 	
		1; 		
	};
	[3] = {
		true;
		1; 		
		31; 		
		5; 		
	};
	[4] = {
		true;	
		1; 		
		756; 	
		1; 	
	};
	[5] = {
		true;
		1; 		
		33; 
		3; 	
	};
	[6] = {
		true;	
		1; 	
		59; 
		1; 	
	};
	[7] = {
		true;	
		1; 		
		57; 	
		100; 	
	};
	[8] = {
		true;
		1; 	
		44; 
		5; 	
	};
	[9] = {
		true;
		1; 	
		79;
		1; 	
	};
	[10] = {
		true;	
		1; 	
		315; 
		1; 	
	};
	[11] = {
		true;	
		1; 	
		49; 	
		3; 	
	};
	[12] = {
		true;	
		1; 	
		37; 
		1; 	
	};
	[13] = {
		true;
		1; 		
		83; 	
		1; 		
	};
	[14] = {
		true;	
		1; 		
		107; 	
		3; 	
	};
	[15] = {
		true;
		1; 		
		105; 	
		1; 		
	};
	[16] = {
		true;	
		1; 	
		15; 	
		25; 	
	};
	[16] = {
		true;
		3; 	
		5; 		
		1; 		
	};
	[17] = {
		true;	
		2; 		
		2; 		
		1; 		
	};
	[18] = {
		true;	
		4; 		
		3; 	
		1; 	
	};
	[19] = {
		true;
		1; 		
		157; 
		1; 	
	};
	[20] = {
		true;	
		1; 	
		111; 	
		3; 		
	};
	[21] = {
		true;	
		1; 	
		48; 
		3; 	
	};
	[22] = {
		true;
		1; 	
		757; 	
		1; 		
	};
	[23] = {
		true;	
		2; 		
		5; 		
		1; 	
	};
	[24] = {
		true;	
		1; 		
		758; 	
		1; 		
	};
	[25] = {
		true;	
		1; 		
		740; 	
		1; 		
	};
	[26] = {
		true;	
		1; 		
		761; 	
		1; 		
	};
	[26] = {
		true;	
		0; 		
		120000; 
		1; 		
	};
	[27] = {
		true;	
		3; 		
		10; 	
		1; 		
	};
	[28] = {
		true;	
		1; 		
		384; 	
		1; 		
	};
	[29] = {
		true;	
		0; 		
		250000; 
		1; 		
	};
	[30] = {
		true;	
		1; 		
		86; 	
		50; 	
	};
	[31] = {
		true;	
		1; 	
		756; 	
		3; 		
	};
}
dailyrotorewards.config.rookierewards = {
	[1] = {
		false;	// Count as a day
		1; 		// Reward Type, whether its money (0) or an item (1) or a skillpoint (2) or a free property voucher (3) or a job rank (4) or a tag (5)
		750;	// Value of the Reward / ID of the Item
		1; 		// Amount of the Item to give
	};
	[2] = {
		true;	
		1; 		
		751;	
		1; 		
	};
	[3] = {
		true;	
		2; 		
		5;	
		1; 		
	};
	[4] = {
		true;	
		1; 		
		752;	
		1; 		
	};
	[5] = {
		true;	
		3; 		
		3;	
		1; 		
	};
	[6] = {
		true;	
		1; 		
		753;	
		1; 		
	};
	[7] = {
		true;	
		1; 		
		50;	
		1; 		
	};
	[8] = {
		true;	
		0; 		
		250000;	
		1; 		
	};
	[9] = {
		true;	
		1; 		
		754;	
		1; 	
	};
	[10] = {
		true;
		1; 		
		755;	
		1; 		
	};
	[11] = {
		true;	
		1; 	
		756;
		3; 	
	};
	[12] = {
		true;
		2; 
		5;
		1; 
	};
	[13] = {
		true;
		1; 	
		757;
		1; 	
	};
	[14] = {
		true;
		1; 	
		758;
		1; 	
	};
	[15] = {
		true;
		1; 	
		759;
		1; 	
	};
	[16] = {
		true;
		0; 	
		350000;
		1; 	
	};
	[17] = {
		true;
		1; 	
		760;
		1; 	
	};
	[18] = {
		true;
		3; 	
		5;
		1; 	
	};
	[19] = {
		true;
		4; 	
		2;
		1; 	
	};
	[20] = {
		true;
		1; 	
		751;
		1; 	
	};	
	[21] = {
		true;
		1; 	
		44;
		20; 	
	};
	[22] = {
		true;
		1; 	
		761;
		1; 	
	};
	[23] = {
		true;
		1; 	
		30;
		5; 	
	};
	[24] = {
		true;
		1; 	
		52;
		1; 	
	};
	[25] = {
		true;
		1; 	
		96;
		100; 	
	};
	[26] = {
		true;
		1; 	
		757;
		1; 	
	};
	[27] = {
		true;
		1; 	
		762;
		1; 	
	};
	[28] = {
		true;
		1; 	
		115;
		15; 	
	};
	[29] = {
		true;
		1; 	
		42;
		5; 	
	};
	[30] = {
		true;
		5; 	
		"donator";
		1; 	
	};
	[31] = {
		true;
		0; 	
		1000000;
		1; 	
	};
}

declareDailyRotoRewardFuncs();
