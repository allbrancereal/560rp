
fsrp.devprint("[560Roleplay] - Fetching Clientside Utility File" )

function draw.Box(x, y, w, h, col)
	surface.SetDrawColor(col)
	surface.DrawRect(x, y, w, h)
end

function draw.OutlinedBox(x, y, w, h, col, bordercol)
	surface.SetDrawColor(col)
	surface.DrawRect(x + 1, y + 1, w - 2, h - 2)
	surface.SetDrawColor(bordercol)
	surface.DrawOutlinedRect(x, y, w, h)
end

local blur = Material('pp/blurscreen')
function draw.Blur(panel, amount) -- Thanks nutscript
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255, _alpha)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat('$blur', (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

fsrp.devprint("[560Roleplay] - Accquired Clientside Utility File" )
