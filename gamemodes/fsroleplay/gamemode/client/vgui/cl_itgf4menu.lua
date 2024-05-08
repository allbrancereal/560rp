
local _p = LocalPlayer()
local function drawTextOutlined(text,font,x,y,color,alignx,aligny,outline,coloro)
	surface.SetFont(font)
	local w, h = surface.GetTextSize(text)
	surface.SetTextColor(coloro)
	x, y, outline = math.floor( x - ((alignx or 0) * w)), math.floor(y - ((aligny or 0) * h )),math.floor(outline)
	for i = -outline, outline do
		for j = -outline, outline do
			surface.SetTextPos(x + i,y + j)
			surface.DrawText(text)
		end
	end
	surface.SetTextColor(color)
	surface.SetTextPos(x,y)
	surface.DrawText(text)
end

local drawRectMatCache = {}
local function drawRectMat(x,y,w,h,mat,color,overloadCache)
	if type(mat) == "string" and (not drawRectMatCache[mat] or overloadCache) then
		drawRectMatCache[mat] = Material(mat)
	end
	surface.SetDrawColor(color or color_white)
	surface.SetMaterial(type(mat) == "IMaterial" and mat or drawRectMatCache[mat])
	surface.DrawTexturedRect(x,y,w,h)
end

surface.CreateFont("ITG_F4MenuTitle", {
	font = "Trebuchet MS",
	size = 45,
	weight = 800,
	antialias = true
})

surface.CreateFont( "ITG_F4Menu", {
	font = "Open Sans",
	size = 20,
	weight = 1000
})

surface.CreateFont( "ITG_OpenBoxTitle", {
	font = "Open Sans",
	size = 22,
	weight = 1000
})

surface.CreateFont( "ITG_OpenBoxThin", {
	font = "Open Sans",
	size = 16,
	weight = 0
} )

surface.CreateFont( "ITG_OpenBoxAccept", {
	font = "Open Sans",
	size = 18,
	weight = 750
})

surface.CreateFont( "ITG_ChangeModelTitle", {
	font = "Open Sans",
	size = 22,
	weight = 1000
})

surface.CreateFont( "ITG_ChangeModel", {
	font = "Open Sans",
	size = 18,
	weight = 750
})

surface.CreateFont( "ITG_CommandsTitle", {
	font = "Open Sans",
	size = 22,
	weight = 1000
})
 
surface.CreateFont( "ITG_Commands", {
	font = "Open Sans",
	size = 20,
	weight = 1000
})

surface.CreateFont( "ITG_JobTitle", {
	font = "Open Sans",
	size = 24,
	weight = 1000
})

surface.CreateFont( "ITG_JobDes", {
	font = "Open Sans",
	size = 12,
	weight = 900
})

surface.CreateFont( "ITG_JobJoinButton", {
	font = "Open Sans",
	size = 30,
	weight = 1000
})

surface.CreateFont( "ITG_ShopTitle", {
	font = "Open Sans",
	size = 24,
	weight = 1000
})

surface.CreateFont( "ITG_ShopDes", {
	font = "Open Sans",
	size = 13,
	weight = 1000
})


surface.CreateFont( "ITG_ShopPrice", {
	font = "Open Sans",
	size = 23,
	weight = 1000
})

surface.CreateFont( "RP_ShopDifBoxCat", {
	font = "Open Sans",
	size = 16,
	weight = 1000
} )

surface.CreateFont( "ITG_ShopPurchase", {
	font = "Open Sans",
	size = 30,
	weight = 1000
})

surface.CreateFont( "ITG_ShopPurchase2", {
	font = "Open Sans",
	size = 25,
	weight = 1000
})

surface.CreateFont( "marlett_r", {
	font = "marlett",
	size = 25,
	weight = 1000
})

function OpenTextBox( text1, text2, cmd )
	local opentextboxbg = vgui.Create( "DFrame")
	opentextboxbg:SetSize(ScrW(),ScrH())
	opentextboxbg:SetTitle("")
	opentextboxbg:ShowCloseButton(false)
	opentextboxbg:SetDraggable(false)
	opentextboxbg.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,250))
	end
	opentextboxbg:MakePopup()

	local opentextboxmain = vgui.Create( "DFrame",opentextboxbg)
	opentextboxmain:SetSize(300,200)
	opentextboxmain:SetTitle("")
	opentextboxmain:SetPos(-500, ScrH() / 2 - 200)
	opentextboxmain:ShowCloseButton(false)
	opentextboxmain.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(45,45,45))
		draw.SimpleText(string.upper(text1),"ITG_OpenBoxTitle",24,20,Color(190,190,190))
	end
	opentextboxmain:MoveTo( ScrW() / 2 - 150, ScrH() / 2 - 200, 0.5, 0, 1 )
	
	local opentextboxlabel = vgui.Create("DLabel",opentextboxmain)
	opentextboxlabel:SetPos(28,54)
	opentextboxlabel:SetSize(opentextboxmain:GetWide() - 56,40)
	opentextboxlabel:SetWrap(true)
	opentextboxlabel:SetText(string.upper(text2))
	opentextboxlabel:SetFont("ITG_OpenBoxThin")
	opentextboxlabel:SetTextColor(Color(190,190,190))
	
	local opentextboxclose = vgui.Create("DButton",opentextboxmain)
	opentextboxclose:SetSize(32,32)
	opentextboxclose:SetPos(opentextboxmain:GetWide() - 38,6)
	opentextboxclose:SetText("r")
	opentextboxclose:SetFont("marlett")
	opentextboxclose:SetTextColor(Color(166,169,172))
	opentextboxclose.Paint = function() end
	opentextboxclose.DoClick = function()
		opentextboxmain:Close()
		opentextboxbg:Remove()
		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
	end
	opentextboxclose.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	opentextboxclose.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end

	local opentextboxmytext = vgui.Create("DTextEntry",opentextboxmain)
	opentextboxmytext:SetText("")
	opentextboxmytext:SetPos(opentextboxmain:GetWide() / 2 - 100,opentextboxmain:GetTall() - 80)
	opentextboxmytext:SetSize(200,20)
	opentextboxmytext.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(230,230,230))
		draw.RoundedBox(0,1,1,w-2,h-2,Color(255,255,255))
		self:DrawTextEntryText(Color(30,30,30),Color(149,240,193),Color(0,0,0))
	end

	local opentextboxyaccept = vgui.Create("DButton",opentextboxmain)
	opentextboxyaccept:SetSize(80,35)
	opentextboxyaccept:SetPos(opentextboxmain:GetWide() / 2 - 40,opentextboxmain:GetTall() - 44)
	opentextboxyaccept:SetText("Accept")
	opentextboxyaccept:SetFont("ITG_OpenBoxAccept")
	opentextboxyaccept:SetTextColor(Color(255,255,255))
	opentextboxyaccept.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(120,120,120))
		if self.Hovered then 
			draw.RoundedBoxEx(0,0,0,w,h,Color(135,135,135)) 
		end
	end
	opentextboxyaccept.DoClick = function()
		local amt = opentextboxmytext:GetValue()
		local str = cmd.." "..amt
		if amt then
			RunConsoleCommand("say", str)
		end
		opentextboxmain:Close()
		opentextboxbg:Close()
		textOpen = false

		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
	end
	opentextboxyaccept.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	opentextboxyaccept.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end

end

function OpenPlyBox(text1,text2,cmd)
	local openplyboxbg = vgui.Create("DFrame")
	openplyboxbg:SetSize(ScrW(),ScrH())
	openplyboxbg:SetTitle("")
	openplyboxbg:ShowCloseButton(false)
	openplyboxbg:SetDraggable(false)
	openplyboxbg.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,250))
	end
	openplyboxbg:MakePopup()

	local openplyboxmain = vgui.Create("DFrame",openplyboxbg)
	openplyboxmain:SetSize(300,200)
	openplyboxmain:SetTitle("")
	openplyboxmain:SetPos(-500,ScrH() / 2 - 200)
	openplyboxmain:ShowCloseButton(false)
	openplyboxmain.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(45,45,45))
		draw.SimpleText(string.upper(text1),"ITG_OpenBoxTitle",24,20,Color(190,190,190))
	end
	openplyboxmain:MoveTo( ScrW() / 2 - 150, ScrH() / 2 - 200, 0.5, 0, 1 )
	
	local openplyboxlabel = vgui.Create("DLabel",openplyboxmain)
	openplyboxlabel:SetPos(28,54)
	openplyboxlabel:SetSize(openplyboxmain:GetWide() - 56,40)
	openplyboxlabel:SetWrap(true)
	openplyboxlabel:SetText(string.upper(text2))
	openplyboxlabel:SetFont("ITG_OpenBoxThin")
	openplyboxlabel:SetTextColor(Color(190,190,190))
	
	local openplyboxclose = vgui.Create("DButton",openplyboxmain)
	openplyboxclose:SetSize( 32, 32 )
	openplyboxclose:SetPos(openplyboxmain:GetWide() - 38,6)
	openplyboxclose:SetText("r")
	openplyboxclose:SetFont("marlett")
	openplyboxclose:SetTextColor(Color(166,169,172))
	openplyboxclose.Paint = function() end
	openplyboxclose.DoClick = function()
		openplyboxmain:Close()
		openplyboxbg:Remove()
		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
	end
	openplyboxclose.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyboxclose.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end

	local openplyboxhl = vgui.Create("DComboBox",openplyboxmain)
	openplyboxhl:SetPos(openplyboxmain:GetWide() / 2 - 100, openplyboxmain:GetTall() - 74)
	openplyboxhl:SetSize(200,20)
	for k,v in pairs(player.GetAll()) do
		openplyboxhl:AddChoice(v:Name())
	end

	openplyboxhl.OnSelect = function(panel,index,value,data)
		target = string.Explode(" ", value)[1]
	end

	local openplyboxaccept = vgui.Create("DButton",openplyboxmain)
	openplyboxaccept:SetSize(80,35)
	openplyboxaccept:SetPos(openplyboxmain:GetWide() / 2 - 40,openplyboxmain:GetTall() - 44)
	openplyboxaccept:SetText("Accept")
	openplyboxaccept:SetFont("ITG_OpenBoxAccept")
	openplyboxaccept:SetTextColor(Color(255,255,255))
	openplyboxaccept.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(120,120,120))
		if self.Hovered then 
			draw.RoundedBoxEx(0,0,0,w,h,Color(135,135,135)) 
		end
	end
	openplyboxaccept.DoClick = function()
		local str = cmd.." "..target
		if target then
			RunConsoleCommand("say", str)
		end
		openplyboxmain:Close()
		openplyboxbg:Close()
		textOpen = false
		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
	end
	openplyboxaccept.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyboxaccept.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
end

function OpenPlyReasonBox(text1,text2,text3,cmd)
	local openplyreasonboxbg = vgui.Create("DFrame")
	openplyreasonboxbg:SetSize(ScrW(),ScrH())
	openplyreasonboxbg:SetTitle("")
	openplyreasonboxbg:ShowCloseButton(false)
	openplyreasonboxbg:SetDraggable(false)
	openplyreasonboxbg.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,250))
	end
	openplyreasonboxbg:MakePopup()

	local openplyreasonboxmain = vgui.Create("DFrame",openplyreasonboxbg)
	openplyreasonboxmain:SetSize(300,250)
	openplyreasonboxmain:SetTitle("")
	openplyreasonboxmain:SetPos(-500,ScrH() / 2 - 200)
	openplyreasonboxmain:ShowCloseButton(false)
	openplyreasonboxmain.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(45,45,45))
		draw.SimpleText(string.upper(text1),"ITG_OpenBoxTitle",24,20,Color(190,190,190))
	end
	openplyreasonboxmain:MoveTo(ScrW() / 2 - 150,ScrH() / 2 - 200,0.5,0,0.05)
	
	local openplyreasonboxlabel = vgui.Create("DLabel",openplyreasonboxmain)
	openplyreasonboxlabel:SetPos(28,54)
	openplyreasonboxlabel:SetSize(openplyreasonboxmain:GetWide() - 56,40)
	openplyreasonboxlabel:SetWrap(true)
	openplyreasonboxlabel:SetText(string.upper(text2))
	openplyreasonboxlabel:SetFont("ITG_OpenBoxThin")
	openplyreasonboxlabel:SetTextColor(Color(190,190,190))
	
	local openplyreasonboxclose = vgui.Create("DButton",openplyreasonboxmain)
	openplyreasonboxclose:SetSize(32,32)
	openplyreasonboxclose:SetPos(openplyreasonboxmain:GetWide() - 38,6)
	openplyreasonboxclose:SetText("r")
	openplyreasonboxclose:SetFont("marlett")
	openplyreasonboxclose:SetTextColor(Color(166,169,172))
	openplyreasonboxclose.Paint = function() end
	openplyreasonboxclose.DoClick = function()
		openplyreasonboxmain:Close()
		openplyreasonboxbg:Remove()
		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
	end
	openplyreasonboxclose.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyreasonboxclose.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end

	local target

	local openplyreasonboxhl = vgui.Create("DComboBox",openplyreasonboxmain)
	openplyreasonboxhl:SetPos(openplyreasonboxmain:GetWide() / 2 - 100,openplyreasonboxmain:GetTall() - 120)
	openplyreasonboxhl:SetSize(200,20)
	for k,v in pairs(player.GetAll()) do
		openplyreasonboxhl:AddChoice(v:Name())
	end

	openplyreasonboxhl.OnSelect = function(panel,index,value,data)
		target = string.Explode(" ", value)[1]
		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")

	end
	openplyreasonboxhl.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyreasonboxhl.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end

	local openplyreasonboxmytext = vgui.Create("DTextEntry",openplyreasonboxmain)
	openplyreasonboxmytext:SetText("")
	openplyreasonboxmytext:SetPos(openplyreasonboxmain:GetWide() / 2 - 100,openplyreasonboxmain:GetTall() - 74)
	openplyreasonboxmytext:SetSize(200,20)
	openplyreasonboxmytext.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(230,230,230))
		draw.RoundedBox(0,1,1,w-2,h-2,Color(255,255,255))
		self:DrawTextEntryText(Color(30,30,30),Color(149, 240, 193),Color(0,0,0))
	end
	openplyreasonboxmytext.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyreasonboxmytext.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyreasonboxmytext.DoClick = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end

	local openplyreasonboxaccept = vgui.Create("DButton",openplyreasonboxmain)
	openplyreasonboxaccept:SetSize(80,35)
	openplyreasonboxaccept:SetPos(openplyreasonboxmain:GetWide() / 2 - 40,openplyreasonboxmain:GetTall() - 44)
	openplyreasonboxaccept:SetText("Accept")
	openplyreasonboxaccept:SetFont("ITG_OpenBoxAccept")
	openplyreasonboxaccept:SetTextColor(Color(255,255,255))
	openplyreasonboxaccept.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(120,120,120))
		if self.Hovered then 
			draw.RoundedBoxEx(0,0,0,w,h,Color(135,135,135)) 
		end
	end
	openplyreasonboxaccept.DoClick = function()
		local amt = openplyreasonboxmytext:GetValue()
		local str = cmd.." "..target.." "..amt
		if amt and target then
			RunConsoleCommand("say", str)
		end
		openplyreasonboxmain:Close()
		openplyreasonboxbg:Close()
		textOpen = false
		surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
	end
	openplyreasonboxaccept.OnCursorEntered = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
	openplyreasonboxaccept.OnCursorExited = function()
		surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
	end
end

Texts = {}

Texts.Command = "say"

function RunCmd(...)
	local arg = {...}
	if Texts.Command:lower():find('say') then
		arg = table.concat(arg,' ')
	else
		arg = table.concat(arg,'" "')
	end
	RunConsoleCommand(Texts.Command,arg)
end

function RunEntCmd(...)
	local arg = {...}
	if Texts.Command:lower():find('say') then
		arg = table.concat(arg,' ')
	else
		arg = table.concat(arg,'" "')
	end
	RunConsoleCommand(Texts.Command, "/"..arg)
end

local function formatNumber(n)
	n = tonumber(n)
	if (!n) then
		return 0
	end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end

function darkrp_formatnumber(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    local sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end
local F4Up = false
if IsValid(f4menuframe) then f4menuframe:Remove() end

net.Receive("bindF1Menu", function( _len , _p )

	ITG_F4Menu()
	
end)
function ITG_F4Menu()

	
	if not IsValid(f4menuframe) then
		f4menuframe = vgui.Create("DFrame")
		f4menuframe:SetSize(1150, 750)
		f4menuframe:Center()
		f4menuframe:SetTitle("")
		f4menuframe:ShowCloseButton(false)
		f4menuframe:SetVisible(false)
		f4menuframe:MakePopup()
		f4menuframe.Paint = function(self,w,h)
			if input.IsKeyDown(KEY_F4) and F4Up then
				ITG_F4Menu()
			elseif not input.IsKeyDown(KEY_F4) then
				F4Up = true
			end
			draw.RoundedBox(0,0,0,w,h,Color(251,252,254,255))
        	//draw.DrawText("560Roleplay DarkRP", "ITG_F4MenuTitle", 12,0, Color(0,0,0,255))
        	draw.DrawText("560Roleplay Gamemode", "ITG_F4MenuTitle", 10,0, Color(16,160,220,255))
        	draw.DrawText("560Roleplay Gamemode", "ITG_F4MenuTitle", 8,0, Color(243,125,176,255))
        	//draw.DrawText("Cannabis Count: ".. _p():DrugWeed(), "ITG_Commands", 750,20, Color(255,255,255))
        	//draw.DrawText("Cash Count: $".. darkrp_formatnumber(ply:getDarkRPVar ("money")), "ITG_Commands", 500 ,20, Color(255,255,255))		
		end


		
		local f4menusidebar = vgui.Create("Panel",f4menuframe)
		f4menusidebar:SetPos( 0, 45 )
		f4menusidebar:SetSize( 135, f4menuframe:GetTall() - 45 )
		f4menusidebar.Paint = function(self,w,h) 
			draw.RoundedBoxEx(0,0,0,w,h,Color(251,252,254,255)) 
		end		

		local f4menuclosebutton = vgui.Create("DButton",f4menuframe)
		f4menuclosebutton:SetSize(46,45)
		f4menuclosebutton:SetPos(f4menuframe:GetWide() - 46,0)
		f4menuclosebutton:SetText("r")
		f4menuclosebutton:SetFont("marlett")
		f4menuclosebutton:SetTextColor(Color(166,169,172))
		f4menuclosebutton.Paint = function(self,w, h)
			draw.RoundedBox(0,0,0, w,h,Color(243,125,176,155))
		if self.Hovered then
			draw.RoundedBox(0,0,0, w,h,Color(243,125,176,255))
		end
		end
		f4menuclosebutton.DoClick = function()
			ITG_F4Menu()
			surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
		end
		f4menuclosebutton.OnCursorEntered = function()
				surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
		end
		f4menuclosebutton.OnCursorExited = function()
				surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
		end
		f4menuframe.tabs = {TabGeneral(),TabRules(),TabQuests()} for k, v in pairs(f4menuframe.tabs) do v:SetVisible(false) end f4menuframe.tabs[1]:SetVisible(true)

		local tabbuts = {}
		
		local function f4menubutton(t,m,p,c)
			local but = vgui.Create("DButton",f4menuframe) table.insert(tabbuts,but)
			but.id = #tabbuts
			but:SetPos(0, #tabbuts * 50)
			but:SetSize(125, 45)
			but:SetText("")
			but.Paint = function(self,w,h)
				draw.RoundedBoxEx(0,0,0,w,h,Color(243,125,176,155))
        		if f4menuframe.tabs[self.id]:IsVisible() then draw.RoundedBox(0,121,0,4,h,c) end
        		
        		draw.DrawText(string.upper(t),"ITG_F4Menu",p+1,12,Color(0,0,0))	
				draw.DrawText(string.upper(t),"ITG_F4Menu",p,12,Color(255,255,255))	
				if self.Hovered then 
					draw.RoundedBox(0,121,0,4,h,HSVToColor(math.abs(math.sin(CurTime() * 1.5) *335), 1, 1))  
				draw.RoundedBoxEx(0,0,0,w,h,Color(243,125,176,180))
				end
				drawRectMat(7,15,16,16,m)
			end
			but.DoClick = function(self) for k, v in pairs(f4menuframe.tabs) do v:SetVisible(false) end f4menuframe.tabs[self.id]:SetVisible(true)
				if t == "Website" then
					gui.OpenURL("http://560rp.com")
				end

				surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
			end
			but.OnCursorEntered = function()
				surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
			end
			but.OnCursorExited = function()
				surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
			end
			end
			
		f4menubutton("General","icon16/star.png",32,Color(1,223,58))
		f4menubutton("Rules", "icon16/dvd.png", 32, Color(210,214,80))
		f4menubutton("Quests", "icon16/world.png", 32, Color(210,214,80))
	end

	f4menuframe:SetVisible(not f4menuframe:IsVisible())
	F4Up = not f4menuframe:IsVisible()
	for k, v in pairs(f4menuframe.tabs) do 
		v:Update() 
	end
end

function TabGeneral()
	local panel = vgui.Create("DPanelList",f4menuframe)
	panel:SetPos(136, 45)
	panel:SetSize(f4menuframe:GetWide() - 136,f4menuframe:GetTall() - 45)
	panel:EnableVerticalScrollbar(true)
	panel:SetSpacing(5)
	panel:SetPadding(5)
	panel.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,75))
	end
	
	function panel:Update()
		self:Clear()

		local function commandcategory(t)
			local lab = vgui.Create("DPanel",self)
			lab:SetTall(40)
			function lab:Paint(w, h)
				draw.RoundedBoxEx(0,0,36,w,5,Color(65,65,65))
				drawTextOutlined(t,"ITG_CommandsTitle",w / 2,20, Color( 255, 255, 255 ),0.5,0.5,1,Color(0,0,0))
			end
			self:AddItem(lab)
		end

		local function commandbutton(t,c,f)
			local but = vgui.Create("DButton",self)
			but:SetTall(30)
			but:SetText("")
			but.DoClick = f

			function but:Paint(w,h)
				draw.RoundedBoxEx(0,0,0,w,h,c)
				surface.SetDrawColor(55,55,55,125)
				surface.SetTexture(surface.GetTextureID("gui/gradient_up"))
				surface.DrawTexturedRect(0,0,w,h)
				surface.SetDrawColor(0,0,0,100)
				surface.DrawOutlinedRect(0,0,w,h)	
				if self.Hovered then 
					draw.RoundedBoxEx(0,0,0,w,h,Color(255,255,255,50)) 
					surface.SetDrawColor(55,55,55,125)
					surface.SetTexture(surface.GetTextureID("gui/gradient_up"))
					surface.DrawTexturedRect(0,0,w,h)
					surface.SetDrawColor(0,0,0,100)
					surface.DrawOutlinedRect(0,0,w,h)					
				end
				drawTextOutlined(t,"ITG_Commands",w / 2 + 2,h / 2, Color( 255, 255, 255 ),0.5,0.5,1,Color(0,0,0))
			end
			self:AddItem(but)
			but.OnCursorEntered = function()
				surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
			end
			but.OnCursorExited = function()
				surface.PlaySound("560menu/menu_"..math.random(1,2)..".wav")
			end
		end
		
		local convar_check_clock = GetConVarNumber( "ig_24hourclock" );
		
		commandcategory("Social & Links")
		commandbutton("Workshop", Color(92,120,125,128), function(ply)
			surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
			gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=864214403")
			f4menuframe:Close()
		end)
		commandbutton("Donation", Color(92,120,125,128), function(ply)
			surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
			gui.OpenURL("http://560rp.com")
			f4menuframe:Close()
		end)
		commandbutton("Forum", Color(92,120,125,128), function(ply)
			surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
			gui.OpenURL("http://560rp.com")
			f4menuframe:Close()
		end)		
		
		commandcategory("Options")

		commandbutton("Third Person Menu", Color(92,120,125,128), function(ply)
			surface.PlaySound("560menu/menu_"..math.random(3,4)..".wav")
			RunConsoleCommand("hat_thirdperson")

			f4menuframe:Close()
		end)
		
		
	

	return panel
end

return panel
end


function TabRules( )

local Rules = {
"TBD",
}
local panel = vgui.Create("DPanelList",f4menuframe)
	panel:SetPos(136, 45)
	panel:SetSize(f4menuframe:GetWide() - 136,f4menuframe:GetTall() - 45)
	panel:EnableVerticalScrollbar(true)
	panel:SetSpacing(5)
	panel:SetPadding(5)
	panel.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,180))
	end
	
local _p = LocalPlayer()
	function panel:Update()
		self:Clear()

		local function ruleCategory(t)
			local lab = vgui.Create("DPanel",self)
			lab:SetTall(40)
			function lab:Paint(w, h)
				draw.RoundedBoxEx(0,0,36,w,5,Color(65,65,65))
				drawTextOutlined(t,"ITG_CommandsTitle",w * 0.01,10, Color( 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT,1,Color(0,0,0))
			end
			self:AddItem(lab)
		end

		local function ruleButton(t,c,f)
			local but = vgui.Create("DButton",self)
			but:SetTall(35)
			but:SetText("")
			but.DoClick = f
			function but:Paint(w,h)
				draw.RoundedBoxEx(0,0,0,w,h,c)
				surface.SetDrawColor(55,55,55,125)
				surface.SetTexture(surface.GetTextureID("gui/gradient_up"))
				surface.DrawTexturedRect(0,0,w,h)
				surface.SetDrawColor(0,0,0,100)
				surface.DrawOutlinedRect(0,0,w,h)	
				/*if self.Hovered then 
					draw.RoundedBoxEx(0,0,0,w,h,Color(255,255,255,50)) 
					surface.SetDrawColor(55,55,55,125)
					surface.SetTexture(surface.GetTextureID("gui/gradient_up"))
					surface.DrawTexturedRect(0,0,w,h)
					surface.SetDrawColor(0,0,0,100)
					surface.DrawOutlinedRect(0,0,w,h)						
				end */
				drawTextOutlined(t,"ITG_Commands",w * 0.01, 7, Color( 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT,1,Color(0,0,0))
			end
			self:AddItem(but)
		end

		ruleCategory("Test")
		ruleButton("WIP", Color(120,120,120), function(ply)	
		
	end)

	return panel
	end
	return panel
	end


function TabQuests( )

local panel = vgui.Create("DPanelList",f4menuframe)
	panel:SetPos(136, 45)
	panel:SetSize(f4menuframe:GetWide() - 136,f4menuframe:GetTall() - 45)
	panel:EnableVerticalScrollbar(true)
	panel:SetSpacing(5)
	panel:SetPadding(5)
	panel.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(25,25,25,180))
	end
	
local _p = LocalPlayer()
	function panel:Update()
		self:Clear()

		local function ruleCategory(t)
			local lab = vgui.Create("DPanel",self)
			lab:SetTall(40)
			function lab:Paint(w, h)
				draw.RoundedBoxEx(0,0,36,w,5,Color(65,65,65))
				drawTextOutlined(t,"ITG_CommandsTitle",w * 0.01,10, Color( 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT,1,Color(0,0,0))
			end
			self:AddItem(lab)
		end

		local function ruleButton(t,c,f)
			local but = vgui.Create("DButton",self)
			but:SetTall(35)
			but:SetText("")
			but.DoClick = f
			function but:Paint(w,h)
				draw.RoundedBoxEx(0,0,0,w,h,c)
				surface.SetDrawColor(55,55,55,125)
				surface.SetTexture(surface.GetTextureID("gui/gradient_up"))
				surface.DrawTexturedRect(0,0,w,h)
				surface.SetDrawColor(0,0,0,100)
				surface.DrawOutlinedRect(0,0,w,h)	
				/*if self.Hovered then 
					draw.RoundedBoxEx(0,0,0,w,h,Color(255,255,255,50)) 
					surface.SetDrawColor(55,55,55,125)
					surface.SetTexture(surface.GetTextureID("gui/gradient_up"))
					surface.DrawTexturedRect(0,0,w,h)
					surface.SetDrawColor(0,0,0,100)
					surface.DrawOutlinedRect(0,0,w,h)						
				end */
				drawTextOutlined(t,"ITG_Commands",w * 0.01, 7, Color( 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT,1,Color(0,0,0))
			end
			self:AddItem(but)
		end
		local _hasquests = false
		for k , v in pairs( QUEST_TABLE ) do
		
			if LocalPlayer().__activeQuests && LocalPlayer().__activeQuests[v.ID] then
			
				if !LocalPlayer():IsOnQuest( v.ID ) then
					_hasquests = true;
					ruleCategory( v.Name )
					ruleButton( v.Desc[#v.Desc], Color( 128,128,128, 255 ) , function( ) end )
					
				end
				
			end
			
		end
		if !_hasquests then
		
			ruleCategory("You currently do not have any quests!")
			
		end

	return panel
	end
	return panel
	end
