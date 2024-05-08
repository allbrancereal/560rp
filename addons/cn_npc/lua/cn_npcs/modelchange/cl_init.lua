-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Facial Specialist Katrina"

NPC.model = "models/captainbigbutt/vocaloid/tda_kenzie.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

NPC.reputation =5;
-- This is the function that gets called when the player presses <E> on the NPC.

function NPC:onStart( bool )
	-- self:addText(<text>) adds text that comes from the NPC.
	local seen = bool || false;
	
	local _p = LocalPlayer()
	if !seen then
	
		self:addText("Hello there! Welcome to Vella's facials! $"..fsrp.config.FacialCost  .. " for a facial.")
		seen = true;
	elseif seen and ((LocalPlayer():canAfford(fsrp.config.FacialCost)) and LocalPlayer():canAffordBank(fsrp.config.FacialCost)) then
	
		self:addText("Is there anything else I can help you with? We charge $"  .. fsrp.config.FacialCost  .. " for a facial.")
	
	end
	
	if LocalPlayer():IsDonator() then
	
		self:addOption("I would like to change my physgun color", function()
		
			SelectPhysColor()
			self:addText("Sure that would cost about $" .. fsrp.config.PhysgunColorPrice .. " for the change.")
			
			
			
			self:addLeave("<Leave> Thank you very much")
			
			
		end)
	
	end
	
	if !LocalPlayer():IsOnQuest( 2 ) then
			self:send("StartQuestTut_2")
			
			self:addOption( "(Quest) Tutorial #2" , function ( )
			
				
				self:addText("We put a lot of work in to getting all the variation you need from our service. I will reward you with money if you use it!")
				
				self:addOption("Yes! That's easy!", function ( )
				
					self:addOption("Thank you so much for this!", function()
					self:send("requestModelChange")
					
					self:close()
					
					self:send( "StartQuestTut_2_Step2" )
					
							-- This code is inside a function that gets ran after pressing the option.
						self:addText("Bye! Have a Great day. Don't forget, you are always welcome to come back!")
							
						self:addLeave("<Leave>")
					end)
				end)
				
			end)
	else
	
	if !LocalPlayer():IsDonator() and LocalPlayer():canAfford(fsrp.config.FacialCost) || LocalPlayer():canAffordBank(fsrp.config.FacialCost) then
	
		self:addOption( "I would like a facial", function( )
		
		
				self:send("requestModelChange")

		self:close()
		
			
		end )
		
		self:addLeave("<Leave> No thank you.")
	else
	
		self:addText( "Looks like you can't afford a facial ($1000)" )
		
		self:addLeave("<Leave> I guess I can't.")
	end
	
	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("Hi! What can I do here?", function()
		-- This code is inside a function that gets ran after pressing the option.
		self:addText("Thank you for asking! You can change your model here, but you are limited to your gender! It costs $1000.")
		self:addText("You can also get a phys-gun color change if you are a donator!")

		self:addOption("Oh okay!", function()
			-- This code is inside a function that gets ran after pressing the option.
			self:reRun();
			
		end)
	
	end)
	
	end
end

function NPC:reRun()

	self:onStart( true );

end