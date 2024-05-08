-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Vella"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.

net.Receive("verifyclientgender", function( _l , _p )
	
	local _b = net.ReadBool()
	togglePlayerModelmanager( _b )


end )
function NPC:onStart( bool )
	-- self:addText(<text>) adds text that comes from the NPC.
	local seen = bool || false;
	
	if !seen then
	
		self:addText("Hello there! Welcome to Vella's facials!")
		seen = true;
	elseif seen then
	
		self:addText("Is there anything else I can help you with?")
	
	end
	if (!LocalPlayer().__activeQuests || !LocalPlayer().__activeQuests[2]) || !LocalPlayer():IsOnQuest( 2 ) then
			self:send("StartQuestTut_2")
			
			self:addOption( "(Quest) Tutorial #2" , function ( )
			
				
				self:addText("We put a lot of work in to getting all the variation you need from our service. I will reward you with money if you use it!")
				
				self:addOption("Yes! That's easy!", function ( )
				
					
					togglePlayerModelmanager( true )
					
					self:addText( "Okay! Awesome")
					
					self:send( "StartQuestTut_2_Step2" )
					
					self:addOption("Thank you so much for this!", function()
							-- This code is inside a function that gets ran after pressing the option.
						self:addText("Bye! Have a Great day. Don't forget, you are always welcome to come back!")
							
						self:addLeave("<Leave>")
					end)
				end)
				
			end)
	else
	
	if LocalPlayer():canAfford(FACIAL_COST) || LocalPlayer():canAffordBank(FACIAL_COST) then
	
		self:addOption( "I would like a facial", function( )
		
		
			self:send("playermdlmanager", bool )
			self:addOption("See you later!", function()
					-- This code is inside a function that gets ran after pressing the option.
				self:addText("Bye! Have a Great day. Don't forget, you are always welcome to come back!")
					
				self:addLeave("<Leave>")
			end)
			
		end )
		
	end
	
	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("Hi! What can I do here?", function()
		-- This code is inside a function that gets ran after pressing the option.
		self:addText("Thank you for asking! You can change your model here, but you are limited to your gender!")

		self:addOption("Oh okay!", function()
			-- This code is inside a function that gets ran after pressing the option.
			self:reRun();
			
		end)
	
	end)
	self:addOption("See you later!", function()
			-- This code is inside a function that gets ran after pressing the option.
		self:addText("Bye! Have a Great day. Don't forget, you are always welcome to come back!")
			
		self:addLeave("<Leave>")
	end)
	end
end

function NPC:reRun()

	self:onStart( true );

end