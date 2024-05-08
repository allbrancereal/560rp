
NPC = NPC or {}
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Plastic Surgeon Dr. Rina Gading"
NPC.model = "models/virtual_youtuber/sister_cleaire/sister_cleaire_npc.mdl"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
NPC.reputation =2;

local str = "";
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hey there! Welcome to Gender-Switcho-Rama! You can change your gender ez-pz here!") 
	if LocalPlayer():Team() == TEAM_CIVILLIAN then

	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	
	self:addOption("Hello! How much would one of these operations cost?", function()
		-- This code is inside a function that gets ran after pressing the option.
		self:addText("We are happy to spike your interest, a operation is merely the price of " .. fsrp.config.SexChangeCost .. "$" )

		if LocalPlayer():canAffordBank( fsrp.config.SexChangeCost ) then
			
			if LocalPlayer():getGender() == 1 then
			
				str = "Man!";
				
			else
			 
				str = "Girl!";
				
			end
			
			self:addOption( "Yes! Make me a " .. str , function( )
				
				--[[timer.Simple( 5, function()
				self:addText("Your operation should be done!") 
				
					self:addOption( "Thank you for this." , function( )
					
						self:send( "AttemptSexChange" )
						self:addLeave("<Leave>")
						
						
					end)
				
				end)]]--
				self:confirmOperation( str )
				
			end )
			

			self:addOption("I haven't got the time for this operation.", function()
			-- This code is inside a function that gets ran after pressing the option.
				self:addText("Alright, You can always come back!")
			
			self:addLeave("<Leave>")
		
			end)	
			
		else
				
			-- self:addLeave(<leave text>) adds a button that closes the dialogue.

			self:addOption("I haven't got the time for this.", function()
			-- This code is inside a function that gets ran after pressing the option.
				self:addText("That's okay, You can always come back!")
			
			self:addLeave("<Leave>")
		
			end)
		
		end
		
	end)
	end
	
	self:DoAnythingElse()

	self:addLeave("I've got no time for this. <Leave>")
	

end

function NPC:DoAnythingElse()
	
		
		local _p = LocalPlayer();
		
		local _skillTable = _p:GetSkillTable()
		
		local _TotalPoints = 0;
			
		for k , v in pairs( _skillTable ) do
			
			_TotalPoints = _TotalPoints + v;
			
		end
		
		if _p:CanBuySkillPoint() then
		
		
			if _TotalPoints > 0 then
				
				self:addText("Skillpoints, please")
				
				self:DoAcquireSkill()
						
			
			else

				if _p:canAfford( skillpoint_Helper_GetSkillpointCost( _p ) ) || _p:canAffordBank( skillpoint_Helper_GetSkillpointCost( _p ) ) then
				
					self:addOption("Please give me a skill point ($" .. skillpoint_Helper_GetSkillpointCost( _p ) .. ")" , function ( )
					
						self:send( "AcquireSkillpoints" )
					
					end )					
					
				end
				
				
			
			end
	
		
		
		end
		
	

end

function NPC:confirmOperation(str)
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
		draw.SimpleText("Operation Confirmation","fsrp.vgui_createplayer",24,20,Color(190,190,190))
	end
	opentextboxmain:MoveTo( ScrW() / 2 - 150, ScrH() / 2 - 200, 0.5, 0, 1 )
	
	local opentextboxlabel = vgui.Create("DLabel",opentextboxmain)
	opentextboxlabel:SetPos(28,54)
	opentextboxlabel:SetSize(opentextboxmain:GetWide() - 56,40)
	opentextboxlabel:SetWrap(true)
	opentextboxlabel:SetText("Please type yes to confirm your operation." )
	opentextboxlabel:SetFont("fsrp.vgui_createplayer")
	opentextboxlabel:SetTextColor(Color(190,190,190))
	
	local opentextboxclose = vgui.Create("DButton",opentextboxmain)
	opentextboxclose:SetSize(32,32)
	opentextboxclose:SetPos(opentextboxmain:GetWide() - 38,6)
	opentextboxclose:SetText("r")
	opentextboxclose:SetFont("marlett")
	opentextboxclose:SetTextColor(Color(166,169,172))
	opentextboxclose.Paint = function() end
	opentextboxclose.DoClick = function()
		
		
		self:addOption( "I've actually changed my mind." , function( )
					
			self:addLeave("<Leave>")
						
						
		end)
		
		opentextboxmain:Close()
		opentextboxbg:Remove()
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
	opentextboxyaccept:SetFont("fsrp.vgui_createplayer")
	opentextboxyaccept:SetTextColor(Color(255,255,255))
	opentextboxyaccept.Paint = function(self,w,h)
		draw.RoundedBoxEx(0,0,0,w,h,Color(120,120,120))
		if self.Hovered then 
			draw.RoundedBoxEx(0,0,0,w,h,Color(135,135,135)) 
		end
	end
	opentextboxyaccept.DoClick = function()
	
		if string.lower( opentextboxmytext:GetValue() ) == "yes" then
			
			self:addText("Your operation should be done!") 
		
			self:addOption( "Thank you for this." , function( )
			
				self:send( "AttemptSexChange" )
				self:addLeave("<Leave>")
				
				
			end)
				
			opentextboxmain:Close()
			opentextboxbg:Close()
			textOpen = false
		end
		

	end

end


function NPC:DoAcquireSkill()

	local _p = LocalPlayer();
	
	self:addOption("Okay, sure. Give me more.. ($" .. skillpoint_Helper_GetSkillpointCost( _p ) .. ")" , function ( )
					
		self:send( "AcquireSkillpoints" )
						
		self:AnotherSkillpoint( _p )
					
	end )		
			
	self:addLeave( "<Leave>" )
					
end

function NPC:AnotherSkillpoint( _p )


	self:addOption("Okay, sure. Give me more.. ($" .. skillpoint_Helper_GetSkillpointCost( _p ) .. ")" , function ( )
					
		self:send( "AcquireSkillpoints" )
						
		self:addLeave( "<Leave>" )
					
	end )	
	
end