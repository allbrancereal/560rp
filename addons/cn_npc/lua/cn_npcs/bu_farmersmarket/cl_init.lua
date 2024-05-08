-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Secretary D.va"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local talkedTo = false;
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	
	-- This code is inside a function that gets ran after pressing the option.
	if !talkedTo then
		self:addText("Hello! Welcome to the Farmers Market! What can I help you with?")
	elseif talkedTo then
		self:addText("What can I do for you?")
	end

	if LocalPlayer():getBankAccount() == 3 && LocalPlayer():getShares( 4 ).shares > 0  then
		self:FarmersMarketBuisinessOwner()
	else
		self:addOption("What is this place?", function()
				
				self:addText("This is the Farmers Market, You can manage this buisiness if you owned a share!")
				
				self:addOption("What do you mean manage the buisiness?" , function( )
					self:addText("You can manage this buisiness if you owned a initial share. You can get one from the Mysterious Slav!")
				
					self:addOption("Lets talk about something else.", function ()
					
						talkedTo = true;
						self:onStart()
					
					end)
					self:addOption("I am not interested, but Thank you.", function ()
					
						self:addLeave("<Leave>")
					
					end)
				end)
				
				
		end )
			
		self:addOption("(Gender) You're cute!", function()
		
			talkedTo = true;
			if LocalPlayer():getGender() == 1 then
				self:addText("Thank you! You are super pretty yourself!")
				
				self:addOption( "Can you help me?", function()
				
					self:onStart()
				
				end )
			else
				self:addText("That's mildly creepy.")
				
				self:addOption( "That's rude I was just wanting to complement you!", function()
					
					self:addText( "Can you just please go away?" )
					
					self:addLeave("<Leave>")
				
				end )
			end
			
		
		end)
		self:addOption("I am not interested in Bartering squirrels.", function()
			-- self:addLeave(<leave text>) adds a button that closes the dialogue.
			self:addLeave("<Leave>")
		end )
	end

end

function NPC:FarmersMarketBuisinessOwner()


	self:addOption("I would like to check...", function()
			
		self:addOption("My Net Worth.", function() 
		
			self:addText("Sure, your current net worth is $" .. LocalPlayer():getShares(4).value .. "!" )
			
			self:addOption("I would like to check out something else", function()
				talkedTo = true
				self:onStart()
				
			end )
			
			self:addOption("Thank you, I have to go.", function()
				
				self:addText("Sure! Don't forget to come back!" )
				-- self:addLeave(<leave text>) adds a button that closes the dialogue.
				self:addLeave("<Leave>")
			
			end )
			
		end )	
		
		self:addOption("My Buisiness Level.", function() 
			
			self:addText("Sure thing, the current level of your buisiness is: " .. LocalPlayer():getShares(4).level .. "!" )
			self:addText("Your XP is sitting at: " .. LocalPlayer():getShares(4).xp .. "!" )
			
			self:addOption("I would like to check out something else.", function()
				talkedTo = true
				self:onStart()
				
			end )
			
			self:addOption("Thank you, I have to go.", function()
				
				self:addText("Sure! Don't forget to come back!" )
				-- self:addLeave(<leave text>) adds a button that closes the dialogue.
				self:addLeave("<Leave>")
			
			end )
			
		end )
		self:addOption("The Amount of shares I own.", function() 
			
			self:addText("Sure, your current amount of shares is x" .. LocalPlayer():getShares(4).shares .. "!" )
			
			self:addOption("I would like to check out something else", function()
				talkedTo = true
				self:onStart()
				
			end )
			
			self:addOption("Thank you, I have to go.", function()
				
				self:addText("Sure! Don't forget to come back!" )
				-- self:addLeave(<leave text>) adds a button that closes the dialogue.
				self:addLeave("<Leave>")
			
			end )
			
		end )
		
	end )
	
	self:addOption( "I would like to buy some shares.", function() 
		
		self:onBuyFarmersMarket()
		
	end )
	
	self:addOption("I am busy right now, please do not disturb me.", function()
		self:addText("Sure! Don't forget to come back!" )
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
	end )
		
end

function NPC:onBuyFarmersMarket()
	local _newTbl = {}
	local _plyTbl = LocalPlayer():getShares(4);
	
	for k , v in pairs( BUISINESS_TABLE ) do
		if v.ID == 4 then 
		
			_newTbl.cost = v.Price
			_newTbl.shares = v.Shares
			
		end
		
	end
	
	local shareBuyTbl = {

		{name = "1x Share",amt = 1 },
		{name = "5x Shares" ,amt = 5 },
		{name = "10x Shares" ,amt = 10 },
		}
	
	self:addText("Sure, your current amount of shares is x" .. _plyTbl.shares .. "!" )
		
	for k , v in pairs( shareBuyTbl ) do
		
		if LocalPlayer():canAffordBank( _newTbl.cost * v.amt ) && LocalPlayer():getShares( 4 ).shares + v.amt <= MAX_FARMER_SHARES then 
		
		self:addOption( v.name , function()

			net.Start("buyfarmersMarketShare")
				net.WriteInt( v.amt, 5  )
			net.SendToServer()
				
			self:addText( "You have bought x" .. v.amt .. " Farmers Shares!" )
			
			self:addOption("I would like to buy more shares!", function()
				self:onBuyFarmersMarket()
			end )
			
			self:addOption("Thank you!", function()
				self:addText("Sure! Come back soon boss. We got a midnight release of John Wick!" )
				self:addLeave("<Leave>")
			end )
			
		end )
			
		end
		
	end
	
	self:addOption("I have changed my mind.", function()
		self:addText("Sure! Don't forget to come back!" )
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
	end )



end