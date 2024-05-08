

local elementsToHide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true
}

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if (elementsToHide[ name ]) then return false end
end)


if !HUD then

	HUD = {}

end



function LoadHud() 

	

	if HUD.Selfie then

		HUD.Selfie:Remove()

	end

	

	local W = ScrW()

	local H = ScrH()

	

	local mdl = vgui.Create( "DModelPanel" )

	mdl:SetPos( 0, H - 400 )

	mdl:SetSize( 250, 500 )

	mdl:SetFOV( 12 )

	mdl:SetCamPos( Vector( 200, 0, 50 ) )

	mdl:SetLookAt( Vector( 0, 2, 45 ) )

	mdl:SetModel(LocalPlayer():GetModel())

	mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

	mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

	mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

	mdl:SetColor( Color( 200, 200, 200 ) )

	mdl:SetAnimated( false )																																							

	mdl.Angles = Angle( 0, 0, 0 )

	mdl:SetMouseInputEnabled(false)

	function mdl:LayoutEntity( Entity ) 

		

		local ID = LocalPlayer():Team()

		local mdlLOL = LocalPlayer():GetModel()

		

		
		if LocalPlayer().__sel_mdl && player_manager.TranslatePlayerModel( LocalPlayer().__sel_mdl ) == LocalPlayer():GetModel() then
			mdl:SetModel(player_manager.TranslatePlayerModel( LocalPlayer().__sel_mdl )) 
		else
			mdl:SetModel( LocalPlayer():GetModel() )
		end
		
		if LocalPlayer().__sel_skin then
		
			mdl.Entity:SetSkin( LocalPlayer():GetSkin() )
		
		end
		
		if LocalPlayer().__sel_bodygroups   then
		local groups = LocalPlayer().__sel_bodygroups;
		if ( groups == nil ) then groups = "" end
		local groups = string.Explode( " ", groups )
		for k = 0, mdl.Entity:GetNumBodyGroups() - 1 do
			mdl.Entity:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
		end
		end
		return 

	end
	HUD.Selfie = mdl

end

timer.Simple(1, function() LoadHud() end)

function GM:HUDPaint()

	//if LocalPlayer():Alive() && LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon():GetClass() && LocalPlayer():GetActiveWeapon():GetClass() == "gmod_camera" then return end


	

	//HUD:DrawChat()


end


