-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Secretary Triss"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local talkedTo = false;
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	
	-- This code is inside a function that gets ran after pressing the option.
	if !talkedTo then
		self:addText("Welcome to the Airport!")
	elseif talkedTo then
		self:addText("What can I do for you?")
	end
	if LocalPlayer():getBankAccount() == 3 && LocalPlayer():getShares( 1 ).shares > 0 then
		
			self:BuisinessOwner()
		
	else	
		self:addOption("I am good, what is this place?", function()
			
			self:addText("This is the airport, You can manage this buisiness if you had a share!")
			
			self:addOption("How do I buy a buisiness share?", function()
			
				self:addText("Simple! Find the Mysterious Slav and buy a share off him, then you can come to me to buy more!")
				
				
				self:addOption("Where can I find him?", function ()
					self:addText("He is located somewhere near the stock market. Try finding a map around town!")
					
					
					self:addOption("Awesome! Thank you.", function ()
						
						self:addLeave("<Leave>")
					
					end)
						
				end)
				
				self:addOption("I will seek him out.", function ()
					
					self:addLeave("<Leave>")
				
				end)
				
			end )
			
			self:addOption("Oh okay! Thank you.", function ()
				
				self:addLeave("<Leave>")
			
			end)
			
		end )
		
		self:addOption("I am not interested in flying squirrels.", function()
			-- self:addLeave(<leave text>) adds a button that closes the dialogue.
			self:addLeave("<Leave>")
		end )
			
		
	end

end

function NPC:BuisinessOwner( )

	self:addOption("I would like to check...", function()
			
		self:addOption("My Net Worth.", function() 
		
			self:addText("Sure, your current net worth is $" .. LocalPlayer():getShares(1).value .. "!" )
			
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
			
			self:addText("Sure, your current amount of shares is x" .. LocalPlayer():getShares(1).shares .. "!" )
			
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
		self:addOption("My Buisiness Level.", function() 
			
			self:addText("Sure thing, the current level of your buisiness is: " .. LocalPlayer():getShares(1).level .. "!" )
			
			self:addText("Your XP is sitting at: " .. LocalPlayer():getShares(3).xp .. "!" )
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
		
	end )
	
	self:addOption( "I would like to buy some shares.", function() 
		
		self:onBuy()
		
	end )
	
	self:addOption("I am busy right now, please do not disturb me.", function()
		self:addText("Sure! Don't forget to come back!" )
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
	end )
		
end

function NPC:onBuy()
	
	local _newTbl = {}
	local _plyTbl = LocalPlayer():getShares(1);
	
	for k , v in pairs( BUISINESS_TABLE ) do
		if v.ID == 1 then 
		
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
		
		if LocalPlayer():canAffordBank( _newTbl.cost * v.amt ) && LocalPlayer():getShares( 1 ).shares + v.amt <= MAX_AIRPORT_SHARES then 
		
		self:addOption( v.name , function()
			
			net.Start("buyairportMarketShare")
				net.WriteInt( v.amt, 5  )
			net.SendToServer()
			
			self:addText( "You have bought x" .. v.amt .. " Airport Shares!" )
			
			self:addOption("I would like to buy more shares!", function()
				self:onBuy()
			end )
			
			self:addOption("Thank you!", function()
				self:addText("Sure! Don't forget to come back!" )
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