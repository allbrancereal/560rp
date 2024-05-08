



include('shared.lua')
local doOutline = false;

function ENT:Draw()
	self:DrawModel()
	

end

local OutlineEnts = {
	"fsrp_propitem";
	"furniture_lamp";
	"fsrpcomputer";
	"fsrpmonitor";
	"fsrp_craftable";
	"traffic_cone";
	"traffic_barrier";
	"cashregister";
}

hook.Add( "PreDrawHalos", "LALTHalo_Furniture", function()

	if doOutline then

		for k , v in pairs( OutlineEnts ) do
			
			local _ents = ents.FindByClass( v );
			local _entsInQ = {};

			for x , y in pairs( _ents )do 
				if y:getFlag("ownedBy", nil ) == LocalPlayer():SteamID() then
					table.insert( _entsInQ , y )	
				end
				
			end
			
				halo.Add( _entsInQ, Color( 87	,89,	97), 5, 5, 2 )
		end
		
	else

		local _ents = ents.FindByClass( 'fsrp_item' );
		halo.Add( _ents, Color( 87	,89,	97), 5, 5, 2 )
	end
	
end )

hook.Add("HUDPaint","AltHelp_Furniture", function()

	local _p =  LocalPlayer();

	if input.IsKeyDown(KEY_LALT) then
		
		doOutline = true
	else

		doOutline = false;

	end

	if _p == NULL then return end
	
	if _p && _p:GetEyeTrace() then 
			if _p:GetEyeTrace().Entity then
		local _ent = LocalPlayer():GetEyeTrace().Entity;
		local _class = IsValid(_ent) && _ent:GetClass() || nil;

		if doOutline &&
			 _class && 
				table.HasValue(OutlineEnts ,_class) &&
					_p:GetEyeTrace().Entity:getFlag("ownedBy", nil ) == _p:SteamID() then

					surface.SetFont("Trebuchet20")
					local x, y = surface.GetTextSize("Press E To Pick up!")

					surface.SetTextColor(255,255,255,255)
					surface.SetTextPos(ScrW()/2-(x/2),ScrH()/2-(y+10)) 

					surface.DrawText("Press E To Pick up!")	

			
		end
		end
			
	end

end)