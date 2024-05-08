
NPC = NPC or {}
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Cirilla (Medic)"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

local str = "";
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	
		self:addText("Hey there! How are you?") 

	local _hp = LocalPlayer():Health();
		
	if _hp == 100 then
	
		self:addOption("Hi! I am doing great!", function()
		
			self:addText( "That is great to hear! Well I have to get back to work!" )
			
			
			self:addOption("I will let you work then!", function()
			
				self:addLeave("<Leave>")
				
			end)
			
		end )
		
	elseif _hp >= 75 && _hp <= 99 then
	
	
		self:addOption("Hi! I seem to have a little bruise..", function()
		
			self:addText( "Let me see that! I can help you patch that up!" )
			
			
			self:addOption("Thank you so much!", function()
							
				self:send("resetHP")
			
				timer.Simple( 3, function( )
			
					self:addLeave("<Leave>")
				
				end)
				
			end)
			
			self:addOption("I don't think I have the time or money to do this!", function()
				
				self:addText( "The procedures are less than $" .. HEALTH_RESET_COST .. "!-(Whoosh)" )
				
				self:addLeave("<Leave>")
				
			end)
				
			
		end )
	
	elseif _hp <= 74 && _hp >=51 then

		self:addOption("Hi! I feel horrible, can you diagnose me?", function()
		
			self:addText( "Sure, lets get you to Admitting!" )
			
			
			self:addOption("Thank you!", function()
			
				self:send("resetHP")
			
				timer.Simple( 5, function( )
					
					self:addLeave("<Leave>")
				
				end )
				
			end)
			
			self:addOption("I do not want to let any radical work on my body!", function()
				
				self:addText( "Oh." )
				
				self:addLeave("<Leave>")
				
			end)
				
			
		end )
		
	elseif _hp <= 50 && _hp > 0 then
	
		self:addOption("Hi! <Argh> I need some help.", function()
		
			self:addText( "Oh no, We have to get you to Emergency right now!" )
			
			self:send("resetHP")
			
			timer.Simple( 10, function( )
				self:addText( "You should be all good now, you will be charged on your next payday!" )

				self:addOption("Okay!", function()
			
				self:send("nextPaydayHealMoney")
				
				self:addLeave("<Leave>")
				
				end )
				
			end )
				
		end )
		
	end
	
end

