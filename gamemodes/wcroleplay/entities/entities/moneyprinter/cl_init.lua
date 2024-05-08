



include('shared.lua')
local doOutline = false;
--[[
	
3D2D VGUI Wrapper
Copyright (c) 2015-2017 Alexander Overvoorde, Matt Stevens
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]--

local origin = Vector(0, 0, 0)
local angle = Angle(0, 0, 0)
local normal = Vector(0, 0, 0)
local scale = 0
local maxrange = 0

-- Helper functions

local function getCursorPos()
	local p = util.IntersectRayWithPlane(LocalPlayer():EyePos(), LocalPlayer():GetAimVector(), origin, normal)

	-- if there wasn't an intersection, don't calculate anything.
	if not p then return end
	if WorldToLocal(LocalPlayer():GetShootPos(), Angle(0,0,0), origin, angle).z < 0 then return end

	if maxrange > 0 then
		if p:Distance(LocalPlayer():EyePos()) > maxrange then
			return
		end
	end

	local pos = WorldToLocal(p, Angle(0,0,0), origin, angle)

	return pos.x, -pos.y
end

local function getParents(pnl)
	local parents = {}
	local parent = pnl:GetParent()
	while parent do
		table.insert(parents, parent)
		parent = parent:GetParent()
	end
	return parents
end

local function absolutePanelPos(pnl)
	local x, y = pnl:GetPos()
	local parents = getParents(pnl)
	
	for _, parent in ipairs(parents) do
		local px, py = parent:GetPos()
		x = x + px
		y = y + py
	end
	
	return x, y
end

local function pointInsidePanel(pnl, x, y)
	local px, py = absolutePanelPos(pnl)
	local sx, sy = pnl:GetSize()

	if not x or not y then return end

	x = x / scale
	y = y / scale

	return pnl:IsVisible() and x >= px and y >= py and x <= px + sx and y <= py + sy
end

-- Input

local inputWindows = {}
local usedpanel = {}

local function isMouseOver(pnl)
	return pointInsidePanel(pnl, getCursorPos())
end

local function postPanelEvent(pnl, event, ...)
	if not IsValid(pnl) or not pnl:IsVisible() or not pointInsidePanel(pnl, getCursorPos()) then return false end

	local handled = false
	
	for i, child in pairs(table.Reverse(pnl:GetChildren())) do
		if not child:IsMouseInputEnabled() then continue end
		
		if postPanelEvent(child, event, ...) then
			handled = true
			break
		end
	end
	
	if not handled and pnl[event] then
		pnl[event](pnl, ...)
		usedpanel[pnl] = {...}
		return true
	else
		return false
	end
end

-- Always have issue, but less
local function checkHover(pnl, x, y, found)
	if not (x and y) then
		x, y = getCursorPos()
	end

	local validchild = false
	for c, child in pairs(table.Reverse(pnl:GetChildren())) do
		if not child:IsMouseInputEnabled() then continue end
		
		local check = checkHover(child, x, y, found or validchild)

		if check then
			validchild = true
		end
	end

	if found then
		if pnl.Hovered then
			pnl.Hovered = false
			if pnl.OnCursorExited then pnl:OnCursorExited() end
		end
	else
		if not validchild and pointInsidePanel(pnl, x, y) then
			pnl.Hovered = true
			if pnl.OnCursorEntered then pnl:OnCursorEntered() end

			return true
		else
			pnl.Hovered = false
			if pnl.OnCursorExited then pnl:OnCursorExited() end
		end
	end

	return false
end

-- Mouse input

hook.Add("KeyPress", "VGUI3D2DMousePress", function(_, key)
	if key == IN_USE then
		for pnl in pairs(inputWindows) do
			if IsValid(pnl) then
				origin = pnl.Origin
				scale = pnl.Scale
				angle = pnl.Angle
				normal = pnl.Normal

				local key = input.IsKeyDown(KEY_LSHIFT) and MOUSE_RIGHT or MOUSE_LEFT
				
				postPanelEvent(pnl, "OnMousePressed", key)
			end
		end
	end
end)

hook.Add("KeyRelease", "VGUI3D2DMouseRelease", function(_, key)
	if key == IN_USE then
		for pnl, key in pairs(usedpanel) do
			if IsValid(pnl) then
				origin = pnl.Origin
				scale = pnl.Scale
				angle = pnl.Angle
				normal = pnl.Normal

				if pnl["OnMouseReleased"] then
					pnl["OnMouseReleased"](pnl, key[1])
				end

				usedpanel[pnl] = nil
			end
		end
	end
end)

function vgui.Start3D2D(pos, ang, res)
	origin = pos
	scale = res
	angle = ang
	normal = ang:Up()
	maxrange = 0
	
	cam.Start3D2D(pos, ang, res)
end

function vgui.MaxRange3D2D(range)
	maxrange = isnumber(range) and range or 0
end

function vgui.IsPointingPanel(pnl)
	origin = pnl.Origin
	scale = pnl.Scale
	angle = pnl.Angle
	normal = pnl.Normal

	return pointInsidePanel(pnl, getCursorPos())
end

local Panel = FindMetaTable("Panel")
function Panel:Paint3D2D()
	if not self:IsValid() then return end
	
	-- Add it to the list of windows to receive input
	inputWindows[self] = true

	-- Override gui.MouseX and gui.MouseY for certain stuff
	local oldMouseX = gui.MouseX
	local oldMouseY = gui.MouseY
	local cx, cy = getCursorPos()

	function gui.MouseX()
		return (cx or 0) / scale
	end
	function gui.MouseY()
		return (cy or 0) / scale
	end
	
	-- Override think of DFrame's to correct the mouse pos by changing the active orientation
	if self.Think then
		if not self.OThink then
			self.OThink = self.Think
			
			self.Think = function()
				origin = self.Origin
				scale = self.Scale
				angle = self.Angle
				normal = self.Normal
				
				self:OThink()
			end
		end
	end
	
	-- Update the hover state of controls
	local _, tab = checkHover(self)
	
	-- Store the orientation of the window to calculate the position outside the render loop
	self.Origin = origin
	self.Scale = scale
	self.Angle = angle
	self.Normal = normal
	
	-- Draw it manually
	self:SetPaintedManually(false)
		self:PaintManual()
	self:SetPaintedManually(true)

	gui.MouseX = oldMouseX
	gui.MouseY = oldMouseY
end

function vgui.End3D2D()
	cam.End3D2D()
end
------
local _Star = Material("icon16/star.png")
local sampleFrame = vgui.Create( "DFrame" )
sampleFrame:SetPos( 0, 15 )
sampleFrame:SetSize( 150, 100 )
sampleFrame:ParentToHUD()
sampleFrame:ShowCloseButton(false)
sampleFrame:SetTitle("")
sampleFrame:SetVisible(false)
function sampleFrame:Paint(w,h) 
	if self.Ent then
		for i=1,fsrp.config.Printer.MaxPrintSpeed do
			surface.SetMaterial(_Star)
			if self.Ent:getFlag("speed",0) >= i then		
				surface.SetDrawColor(255,255,255)
			else
				surface.SetDrawColor(128,128,128)
			end
			surface.DrawTexturedRect(6+i*20,0,15,15)
			//draw.RoundedBox(1, 6+i*20, 0, 15,15, Color(56,56,56))
			
		end
	end
end

sampleFrameUpgradeButMinus = vgui.Create("DButton",sampleFrame)
sampleFrameUpgradeButMinus:SetSize(50,25)
sampleFrameUpgradeButMinus:SetPos(15,25)
sampleFrameUpgradeButMinus:SetText("")
function sampleFrameUpgradeButMinus:Paint(w,h) 
	draw.RoundedBox(1, 0, 0, w,h, Color(56,56,56))
	surface.SetTextColor(255,255,255)
	surface.SetTextPos(23,5)
	surface.DrawText("-")
end
sampleFrameUpgradeButMinus.Frame = sampleFrame
function sampleFrameUpgradeButMinus:OnMousePressed()

	local _lastbuy = LocalPlayer():HasCooldown("MPCommand");
	if _lastbuy == true then return end
	net.Start("sendMPCommand")
	net.WriteInt(2,8)
	net.WriteInt(self.Frame.Ent:EntIndex(),16)
	net.SendToServer()
end

sampleFrameUpgradeButPlus = vgui.Create("DButton",sampleFrame)
sampleFrameUpgradeButPlus:SetSize(50,25)
sampleFrameUpgradeButPlus:SetPos(65,25)
sampleFrameUpgradeButPlus:SetText("")
function sampleFrameUpgradeButPlus:Paint(w,h) 
	draw.RoundedBox(1, 0, 0, w,h, Color(56,56,56))
	surface.SetTextColor(255,255,255)
	surface.SetTextPos(23,5)
	surface.DrawText("+")
end
sampleFrameUpgradeButPlus.Frame = sampleFrame
function sampleFrameUpgradeButPlus:OnMousePressed()
	local _lastbuy = LocalPlayer():HasCooldown("MPCommand");
	if _lastbuy == true then return end
	net.Start("sendMPCommand")
	net.WriteInt(1,8)
	net.WriteInt(self.Frame.Ent:EntIndex(),16)
	net.SendToServer()
end

sampleFrameOn = vgui.Create("DButton",sampleFrame)
sampleFrameOn:SetSize(50,25)
sampleFrameOn:SetPos(15,55)
sampleFrameOn:SetText("")
sampleFrameOn._Text = "";
function sampleFrameOn:Paint(w,h) 
	draw.RoundedBox(1, 0, 0, w,h, Color(56,56,56))
	surface.SetTextColor(255,255,255)
	surface.SetTextPos(16,5)
	surface.DrawText(self._Text)
end
sampleFrame.On = sampleFrameOn;

function sampleFrame:Update()
	sampleFrame:SetVisible(true)
	if self.Ent then
		sampleFrameOn._Text = (self.Ent:getFlag("on",false) == true && "On" || "Off") 
	end
end
sampleFrameOn.Frame = sampleFrame
function sampleFrameOn:OnMousePressed()
	local _lastbuy = LocalPlayer():HasCooldown("MPCommand");
	if _lastbuy == true then return end
	net.Start("sendMPCommand")
	net.WriteInt(3,8)
	net.WriteInt(self.Frame.Ent:EntIndex(),16)
	net.SendToServer()
end
/*
sampleFramePocketBut = vgui.Create("DButton",sampleFrame)
sampleFramePocketBut:SetSize(50,25)
sampleFramePocketBut:SetPos(65,55)
sampleFramePocketBut:SetText("")
function sampleFramePocketBut:Paint(w,h) 
	draw.RoundedBox(1, 0, 0, w,h, Color(56,56,56))
	surface.SetTextColor(255,255,255)
	surface.SetTextPos(10,5)
	surface.DrawText("Pocket")
end

sampleFramePocketBut.Frame = sampleFrame
function sampleFramePocketBut:OnMousePressed()
	net.Start("sendMPCommand")
	net.WriteInt(4,8)
	net.WriteInt(self.Frame.Ent:EntIndex(),16)
	net.SendToServer()
end
*/
local printTime = fsrp.config.Printer.Time; -- time per print
function ENT:Draw()
	self:DrawModel()

	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Forward()*15 + ang:Up() * 8 + ang:Right() * 12.5
	ang:RotateAroundAxis(ang:Forward(),-90)
	ang:RotateAroundAxis(ang:Up(),180)
	ang:RotateAroundAxis(ang:Right(),90)
	if ( LocalPlayer():GetPos( ):Distance(  pos ) <= ( 300 ) ) then

		cam.Start3D2D(pos,Angle(ang.p,ang.y,ang.r),0.25) 
			local _on = "Status: ".. (self:getFlag("on",false) == true && "On" || "Off")
			local _heat = "Heat: ".. self:getFlag("heat",0) .. "%"
			local _supply = "Supply: ".. self:getFlag("supply",0)
			local _tl = (CurTime())-(self:getFlag("lasttime",CurTime())+(printTime-self:getFlag("speed",0)));
			local _cdtime = "Time Left: " .. math.Round((_tl*-1),1)
			draw.SimpleTextOutlined(_on,"Trebuchet24",2,-75,self:getFlag("on",false )== false && Color(200,155,155) || Color(155,200,155) ,TEXT_ALIGN_LEFT,1,1,Color(0,0,0))
			draw.SimpleTextOutlined(_heat,"Trebuchet24",2,-50,Color(224,224,224),TEXT_ALIGN_LEFT,1,1,Color(0,0,0))
			draw.SimpleTextOutlined(_supply,"Trebuchet24",2,-25,Color(224,224,224),TEXT_ALIGN_LEFT,1,1,Color(0,0,0))
			if self:getFlag("on",false) == true then
				draw.SimpleTextOutlined(_cdtime ,"Trebuchet24",2,0,Color(224,224,224),TEXT_ALIGN_LEFT,1,1,Color(0,0,0))
			end
		cam.End3D2D()
		vgui.Start3D2D(pos+ang:Up()*2 ,Angle(ang.p,ang.y,ang.r),0.25) 
			sampleFrame.Ent = self;
			sampleFrame:Update()
			sampleFrame:Paint3D2D()
		vgui.End3D2D()
	end

end

