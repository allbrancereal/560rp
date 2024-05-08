
local TableOfPlayers = TableOfPlayers || {};

if SERVER then
	// sv player
	local function CalcFine(LawsBroken)
		local Total = 0;
		for k,v in pairs(LawsBroken) do
			Total = Total + fsrp.config.Laws[tonumber(v)][2];
		end
		return Total;
	end
	util.AddNetworkString("SendFine")
	function FinePlayer (ToFine, String, Officer)
		local Fine = tonumber(CalcFine(string.Explode(":",String)));
		if Fine <= 0 then return ; end
		if !ToFine:IsPlayer() or !ToFine:IsValid() then return ; end
		if Officer:Team() != TEAM_POLICE then return  end
		if ToFine:GetPos():Distance(Officer:GetPos()) > 200 then return ; end

		if ToFine:getMoney() < Fine then
			Officer:Notify(ToFine:getFirstName() .. ' does not have enough money!');
			return false;
		end

		net.Start("SendFine")
			net.WriteBool(true)
			net.WriteString(String)
			net.WriteInt(Officer:EntIndex(),16)
		net.Send(ToFine)
	end


	net.Receive("SendFine",function(_l,_p)
		local _com = net.ReadBool()
		local _finestring = net.ReadString()
		local _player = net.ReadInt(16)
		if _com == false then
			FinePlayer(player.GetAll()[_player],_finestring,_p)
		else
			local _accept = net.ReadBool()
			if _accept == true then

				local _cost = tonumber(CalcFine(string.Explode(":",_finestring)));
				local _tp = player.GetAll()[_player];
				if !_p:canAfford(_cost) then return _tp:Notify("The fine has been declined because the criminal has no money.") end
				_p:addMoney(_cost*-1)
				//_p:AddReputation(1,10)
				_p:Notify("You have paid your fine. Any stars have been cleared")
				_p:SetStars(0)
				_tp:Notify("The fine has been paid, you have received a 20% commision of $" .. _cost*0.2 .. ".");
				_tp:addMoney(_cost*0.2)
			else
				_p:Notify("You have denied your fine.")
				_p:AddStars(3);
				_tp:Notify("The criminal has denied their fine and therefore been wanted.")
			end
				
		end
	end)
else
surface.CreateFont("awdawdwa", {size = 30,weight = 900,antialias = true,shadow = false,font = "coolvetica"})
surface.CreateFont ("awdawdwaawdawd", {size = 20,weight = 400,antialias = true,shadow = false,font = "coolvetica"})

			local Alpha = 255;
	
	function CreateDataBox(text1, text2)
		draw.RoundedBox(0,0, i, 150, 20,Color(46,46,46,2*Alpha))
		surface.SetDrawColor(0,0,0,2*Alpha)
		surface.DrawOutlinedRect(0, i, 150, 20)		
		
		draw.RoundedBox(0,180, i, 120, 20,Color(46,46,46,2*Alpha))
		surface.SetDrawColor(0,0,0,2*Alpha)
		surface.DrawOutlinedRect(180, i, 120, 20)		
		
		draw.DrawText(text1, "awdawdwaawdawd", 75, i, Color(255, 255, 255,2* Alpha), TEXT_ALIGN_CENTER )
		draw.DrawText(text2, "awdawdwaawdawd", 245, i, Color(0, 255, 0, 2*Alpha), TEXT_ALIGN_CENTER )
		i = i + 30
	end

	function DrawScoreBoard()
		if LocalPlayer():GetPos():Distance( Vector(-918.169434, 2279.620850, 39.723782)  ) > 3000 then return end
		local dist =  Vector(-918.169434, 2279.620850, 39.723782):Distance(LocalPlayer():GetPos());
		
		if (dist <= 450) then
			Alpha = 255;
					
			if (dist >= 300) then
				local moreDist = 450 - dist;
				local percOff = moreDist / (450 - 300);
						
				Alpha = 255 * percOff;
			end
			local alphaF2 = 255;
					
			if (dist >= 200) then
				local moreDist = 350 - dist;
				local percOff = moreDist / (450 - 300);
						
				alphaF2 = 255 * percOff;
			end
		i = 0
		local offset = Vector( 0, 0, 85 )
		local ang = Angle(0, -90, 0)
		local pos = Vector(-935.169434, 2279.620850, -50.723782) + offset + ang:Up()
		 
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )
		cam.Start3D2D(pos, ang, 0.5 )
		
			draw.RoundedBox(0,-45, -30, 385, 20,Color(28,28,28,2*Alpha))
			draw.RoundedBox(0,-45, -50, 385, 20,Color(46,46,46,2*Alpha))
			surface.SetDrawColor(0,0,0,Alpha)
			surface.DrawOutlinedRect(-45, -50, 385, 40)	
			draw.DrawText("Bank of America - Richest", "awdawdwa", 148, -45, Color(255, 0, 0, 2*Alpha), TEXT_ALIGN_CENTER )
			draw.DrawText("Bank of America - Richest", "awdawdwa", 148, -46, Color(0, 0, 255,2* Alpha), TEXT_ALIGN_CENTER )
	
			local _LeaderboardTable = LocalPlayer():getFlag("leaderboardTable_Money", nil);
			
			for k,v in pairs( _LeaderboardTable ) do
				CreateDataBox(v.name, "$"..v.bank)
			end
		cam.End3D2D()
		
		end
	end
	hook.Add( "PostDrawOpaqueRenderables", "DrawScoreBoard", DrawScoreBoard )

	local function NewCollapsible (Title,Owner)
		local CollapsibleCat = vgui.Create("DCollapsibleCategory", Owner)
		CollapsibleCat:SetExpanded(0)
		CollapsibleCat:SetLabel(Title)
		local CategoryList = vgui.Create("DPanelList")
		CategoryList:SetAutoSize(true)
		CategoryList:SetSpacing(5)
		CategoryList:EnableHorizontal(false)
		CategoryList:EnableVerticalScrollbar(true) 
		CategoryList:SetAlpha(100);
		CategoryList:SetPadding(5);
		CollapsibleCat:SetContents(CategoryList)
		Owner:AddItem(CollapsibleCat)
		return CategoryList;
	end

	local function ResetFineMenu()
		for k,v in pairs(fsrp.config.Laws) do
			RunConsoleCommand("wcrp_f_" .. k , "0");
		end
	end


	local function BuildFineString()
		local String = '';
		for k,v in pairs(LocalPlayer().LawsSelected) do
			if v:GetInt() == 1 then
				String = String .. ':' .. k;
			end
		end
		String = string.sub(String,2);
		return String;
	end

	function MakeFineMenu()
		local Offender = LocalPlayer():GetEyeTrace().Entity;
		if (!Offender:IsPlayer() or !Offender:IsValid()) and !LocalPlayer():IsDev() then return false; end
		
		local W, H = 400, 300;
		
		local DermaPanel = vgui.Create("DFrame")
		DermaPanel:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
		DermaPanel:SetSize(W, H)
		DermaPanel:SetTitle("Fine")
		DermaPanel:SetVisible(true)
		DermaPanel:SetDraggable(false)
		DermaPanel:ShowCloseButton(true)
		DermaPanel:MakePopup()

		local DermaList = vgui.Create( "DPanelList", DermaPanel )
		DermaList:SetPos( 5,30 )
		DermaList:SetPadding( 5 )
		DermaList:SetSize( 390,235)
		DermaList:SetSpacing( 5 )
		DermaList:EnableHorizontal( false )
		DermaList:EnableVerticalScrollbar( true )
		if !LocalPlayer().LawsSelected then
			LocalPlayer().LawsSelected={}
		end
		for k,v in pairs(fsrp.config.LawSections) do
			local NewCollaps = NewCollapsible(v,DermaList);
		
			for k2,v2 in pairs(fsrp.config.Laws) do
				if v2[3] == k then
					local Category1 = vgui.Create( "DCheckBoxLabel" )
					Category1:SetText( v2[1]) 
					Category1:SetConVar( "wcrp_f_" .. k2 )
					Category1:SetValue( LocalPlayer().LawsSelected[k2]:GetInt() )
				
					Category1:SizeToContents()
					NewCollaps:AddItem( Category1 )
				end
			end
		end

		
		local DermaButton1 = vgui.Create( "DButton" )
		DermaButton1:SetParent( DermaPanel ) -- Set parent to our "DermaPanel"
		DermaButton1:SetText( "Reset" )
		DermaButton1:SetPos( 5, 270 )
		DermaButton1:SetSize( 60, 25 )
		DermaButton1.DoClick = function ()
			ResetFineMenu();
		end
		
		local DermaButton2 = vgui.Create( "DButton" )
		DermaButton2:SetParent( DermaPanel )
		DermaButton2:SetText('Close');
		DermaButton2:SetPos(335,270);	
		DermaButton2:SetSize( 60, 25 )
		function DermaButton2.DoClick ( )
			DermaPanel:Close();
		end
		
		local DermaButton3 = vgui.Create( "DButton" )
		DermaButton3:SetParent( DermaPanel )
		DermaButton3:SetText('Print');
		DermaButton3:SetPos(265,270);	
		DermaButton3:SetSize( 60, 25 )
		function DermaButton3.DoClick ( )
			local String = BuildFineString();
			net.Start("SendFine")
				net.WriteBool(false)
				net.WriteString(String)
				net.WriteInt(Offender:EntIndex(),16)
			net.SendToServer()
			DermaPanel:Close();
		end
		
		local TestingPanel = vgui.Create( "DPanel", DermaPanel )
		TestingPanel:SetPos(70,270);
		TestingPanel:SetSize(190,25);
		TestingPanel.Paint = function()
			surface.SetDrawColor( 50, 50, 50, 255 )
			surface.DrawRect( 0, 0, 190, 25 )
		end

		
		myLabel= vgui.Create("DLabel", DermaPanel)
		myLabel:SetPos(130,275);
		myLabel:SetText('Total')
		myLabel:SizeToContents()
		function myLabel:PaintOver() 
			local Total = 0;
			for k,v in pairs(fsrp.config.Laws) do
				if LocalPlayer().LawsSelected[k]:GetInt() == 1 then
					Total = Total + v[2];
				end
			end 
			self:SetText('Total: $' .. Total .. '');
			self:SizeToContents();
		end
		
		LocalPlayer().FineMenu = DermaPanel;
	end

	local function CalcFine(LawsBroken)
		local Total = 0;
		for k,v in pairs(LawsBroken) do
			Total = Total + fsrp.config.Laws[tonumber(v)][2];
		end
		return Total;
	end
	function MakeFineReceiveMenu (UID,String)
		local LawsBroken = string.Explode(":",String);
		local FineTotal = CalcFine(LawsBroken);
		local Officer = UID;
		if !Officer:IsPlayer() or !Officer:IsValid() then return false; end
		
		local W, H = 400, 300;
		
		local DermaPanel = vgui.Create("DFrame")
		DermaPanel:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
		DermaPanel:SetSize(W, H)
		DermaPanel:SetTitle("Fine")
		DermaPanel:SetVisible(true)
		DermaPanel:SetDraggable(false)
		DermaPanel:ShowCloseButton(false)
		DermaPanel:MakePopup()
		local DermaList = vgui.Create( "DPanelList", DermaPanel )
		DermaList:SetPos( 5,30 )
		DermaList:SetPadding( 5 )
		DermaList:SetSize( 390,215)
		DermaList:SetSpacing( 5 )
		DermaList:EnableHorizontal( false )
		DermaList:EnableVerticalScrollbar( true )
		
		for k,v in pairs(fsrp.config.LawSections) do
			local NewCollaps = nil;
		
			for k2,v2 in pairs(LawsBroken) do
				if fsrp.config.Laws[tonumber(v2)][3] == k then
					if NewCollaps == nil then
						NewCollaps = NewCollapsible(v,DermaList);
					end
					myLabel= vgui.Create("DLabel", NewCollaps)
					myLabel:SetText(fsrp.config.Laws[tonumber(v2)][1])
					myLabel:SizeToContents()
					NewCollaps:AddItem( myLabel )
				end
			end
		end
		
		local DermaButton2 = vgui.Create( "DButton" )
		DermaButton2:SetParent( DermaPanel )
		DermaButton2:SetText('Deny');
		DermaButton2:SetPos(335,260);	
		DermaButton2:SetSize( 60, 25 )
		function DermaButton2.DoClick ( )
			DermaPanel:Close();
			net.Start("SendFine")
				net.WriteBool(true)
				net.WriteString(String)
				net.WriteInt(Officer:EntIndex(),16)
				net.WriteBool(false)
			net.SendToServer()
		end
		
		local DermaButton3 = vgui.Create( "DButton" )
		DermaButton3:SetParent( DermaPanel )
		DermaButton3:SetText('Pay');
		DermaButton3:SetPos(265,260);	
		DermaButton3:SetSize( 60, 25 )
		function DermaButton3.DoClick ( )
			net.Start("SendFine")
				net.WriteBool(true)
				net.WriteString(String)
				net.WriteInt(Officer:EntIndex(),16)
				net.WriteBool(true)
			net.SendToServer()
			DermaPanel:Close();
		end
		
		local TestingPanel = vgui.Create( "DPanel", DermaPanel )
		TestingPanel:SetPos(5,250);
		TestingPanel:SetSize(255,45);
		TestingPanel.Paint = function()
			surface.SetDrawColor( 50, 50, 50, 255 )
			surface.DrawRect( 0, 0, 255, 45 )
		end

		
		myLabel= vgui.Create("DLabel", DermaPanel)
		myLabel:SetPos(10,255);
		myLabel:SetText('Officer: ' .. Officer:Nick())
		myLabel:SetSize(245,20);
		
		myLabel= vgui.Create("DLabel", DermaPanel)
		myLabel:SetPos(10,275);
		myLabel:SetText('Total: $' .. tostring(FineTotal) .. '')
		myLabel:SetSize(245,20);
		
		LocalPlayer().FineReceiveMenu = DermaPanel;
	end


	net.Receive("SendFine",function(_l,_p)

		local _com = net.ReadBool()
		local _finestring = net.ReadString()
		local _player = net.ReadInt(16)
		print(_player)
		if _com == true then
			MakeFineReceiveMenu(player.GetAll()[_player],_finestring);
		else
			MakeFineMenu()
		end
		
	end)
	if CLIENT then
		//PrintTable(fsrp.config.Laws)
		LocalPlayer().LawsSelected = {}
		for k,v in pairs(fsrp.config.Laws) do
			if k then
				LocalPlayer().LawsSelected[k] = CreateClientConVar("wcrp_f_" .. k , "0",false, false);
			end
		end
	
	end
end