if not file.Exists( "materials/burger/darksouls/blackbar.vmt", "GAME" ) then return end




local endtime = 0

local text = Material("burger/darksouls/youdiedtext")
local back = Material("burger/darksouls/blackbar")
local text_Lit = Material("darksouls/bonfirelit.png")
local latch = false
local alpha = 255

local delay = 1

function CLIENTPlayerDeath()


	
	
	if not latch and not LocalPlayer():Alive() then
		starttime = CurTime()
		alpha = 255
		latch = true
		timer.Simple(0.8,function() LocalPlayer():EmitSound("darksouls/death.mp3") end)	
	end

	if LocalPlayer():Alive() && latch == true then
	
		 latch = false
		 
	end
	
	if not LocalPlayer():Alive() then

		local timepassed = math.abs(CurTime() - starttime ) - delay;
		
		if timepassed > 0 and timepassed < 10 then
	
			local mul1 = 0.5 + math.min(timepassed/10,0.1)
		
			if timepassed < 4 and timepassed > 6 then
				alpha = (timepassed-4) * (255/2)
			else
				alpha = 255 - (timepassed-3) * (255/0.75)
			end
			
			if timepassed then
				alpha2 = (timepassed) * (255/0.5)
			end
			
			if timepassed > 4 then
				alpha2 = 255 - (timepassed-4) * (255/4)
			end
				
			surface.SetDrawColor( 255, 255, 255, math.Clamp(alpha2,0,255) )
			surface.SetMaterial( back )
			surface.DrawTexturedRectRotated( ScrW()/2, ScrH()/2, ScrW() , ScrW()/4 ,0 )
			
			surface.SetDrawColor( 255, 255, 255, math.Clamp(alpha,0,200) )
			surface.SetMaterial( text )
			surface.DrawTexturedRectRotated( ScrW()/2, ScrH()/2, 1024*mul1 , (128+80)*mul1,0 )
		
		end
		
	end
	 

end

hook.Add("HUDPaint","Dark Souls Clientside Player Death",CLIENTPlayerDeath)

function HideDamage( Name )

	if Name == "CHudDamageIndicator" and not LocalPlayer():Alive() then
		return false
	end
 
end

hook.Add( "HUDShouldDraw", "Dark Souls Hide Damage", HideDamage )

--[[

[media]http://www.youtube.com/watch?v=JAWS-Ctv0dw[/media]

[quote]
Dark Souls Death Message for Garrysmod sounds ripped from Dark Souls, textures custom made. 

Dark Souls was developed by FromSoftware, Published by BANDAI NAMCO Games. 

If you install this on your server, players who do not have this addon installed will not be able to see or hear it it unless you use resource.AddWorkshop or tell your clients to install this addon. 

I am aware that there is another Dark Souls Death Message on the workshop, this is not a copy or a reupload of that addon. If you need proof, you can view the code on github [URL="https://github.com/BurgerLUA/DarkSoulsDeath"]here[/URL]
[/quote]

[URL="http://steamcommunity.com/sharedfiles/filedetails/?id=373858511"][img]http://i.imgur.com/S7kzKcc.png[/img][/URL]

--]]

