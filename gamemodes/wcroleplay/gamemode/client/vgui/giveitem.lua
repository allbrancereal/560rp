
local Frame

local function GiveItemPanelCreate()
	
	Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
	Frame:Center()
	Frame:SetTitle("Spawnlist")
	Frame:ShowCloseButton(false)
		LocalPlayer():setFlag("restrictInv", true)
	function Frame:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
	end
	
	Frame.List = vgui.Create("DPanelList", Frame)
	Frame.List:StretchToParent(5, 27, 5, 5)
	Frame.List:EnableVerticalScrollbar(true)
	Frame.List:EnableHorizontal(true)
	
	for i=1,1000 do
			//local v = ITEMLIST[i]
			//if(not v) then continue end
		local v = ITEMLIST[i];

		if v then
			local sub = vgui.Create("DPanel")
			sub:SetSize(73, 89)
			sub.Paint = function()
				surface.SetDrawColor(Color(100, 100, 100, 255))
				surface.DrawRect(2, 2, sub:GetWide() - 4, sub:GetTall() - 4)
				
				surface.SetTextColor(Color(255, 255, 255, 255))
				surface.SetFont("Default")
				local x, y = surface.GetTextSize(v.Name)
				
				surface.SetTextPos(5, 5)
				surface.DrawText(v.ID .. " " .. v.Name)
			end
			
			sub.spawnicon = vgui.Create("SpawnIcon", sub)
			sub.spawnicon:SetModel(v.Model)
			sub.spawnicon:SetPos(5, 20)
			sub.spawnicon.DoClick = function()
			
				net.Start("adminItemReq")
					net.WriteInt(  v.ID ,12)
				net.SendToServer()
				
				
			end
			
			Frame.List:AddItem(sub)

		end
	end
end

concommand.Add("+giveitempanel", function() if(not game.SinglePlayer() and not LocalPlayer():IsSuperAdmin()) then return end
	if(Frame) then Frame:Remove() 
		LocalPlayer():setFlag("restrictInv", false) end GiveItemPanelCreate() Frame:MakePopup() Frame:SetVisible(true) end)
concommand.Add("-giveitempanel", function() if(not game.SinglePlayer() and not LocalPlayer():IsSuperAdmin()) then return end
	Frame:SetVisible(false)
		LocalPlayer():setFlag("restrictInv", false) end)
