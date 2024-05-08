-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Cinema Secretary Aisa"
NPC.model = "models/player/asia_heleana.mdl"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local talkedTo = false;
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	
	-- This code is inside a function that gets ran after pressing the option.
	if !talkedTo then
		self:addText("Hello! Welcome to the Cinema! I'm Aisa!")
	elseif talkedTo then
		self:addText("What can I do for you?")
	end
	
	if LocalPlayer():getBankAccount() == 3 && LocalPlayer():getShares( 3 ).shares > 0  then
		self:CinemaBuisinessOwner()
	else 
		
		
			
		self:addOption("I am good, what is this place?", function()
			
			self:addText("This is the Cinema, You can manage this buisiness if you had a share!")
			
			self:addOption( "What do you mean 'had a share!' !?", function( )
			
				self:addText("You can purchase a initial share from the Mysterious Slav if you have a Buisiness banking account")
				
				
				self:addOption( "Cool! I am not interested though.", function( )
				
					self:addLeave("<Leave>")
				end)
			
			end )
			
			self:addOption("Thank you. I will be on my way.", function ()
			
				self:addLeave("<Leave>")
			
			end)
			
		end )
		
		self:addOption("I am not interested in watching squirrels.", function()
			-- self:addLeave(<leave text>) adds a button that closes the dialogue.
			self:addLeave("<Leave>")
		end )
			
	end

end

function NPC:CinemaBuisinessOwner()


	self:addOption("I would like to check...", function()
			
		self:addOption("My Net Worth.", function() 
		
			self:addText("Sure, your current net worth is $" .. LocalPlayer():getShares(3).value .. "!" )
			
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
			
			self:addText("Sure thing, the current level of your buisiness is: " .. LocalPlayer():getShares(3).level .. "!" )
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
		
		self:addOption("The Amount of shares I own.", function() 
			
			self:addText("Sure, your current amount of shares is x" .. LocalPlayer():getShares(3).shares .. "!" )
			
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
		
		self:onBuyCinema()
		
	end )
	
	self:addOption("I am busy right now, please do not disturb me.", function()
		self:addText("Sure! Don't forget to come back!" )
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
	end )
		
end

function NPC:onBuyCinema()
	local _newTbl = {}
	local _plyTbl = LocalPlayer():getShares(3);
	
	for k , v in pairs( BUSINESS_TABLE ) do
		if v.ID == 3 then 
		
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
		
		if LocalPlayer():canAffordBank( _newTbl.cost * v.amt ) && LocalPlayer():getShares( 3 ).shares + v.amt <= fsrp.config.MaxCinemaShares then 
		
		self:addOption( v.name , function()

			net.Start("buycinemachainMarketShare")
				net.WriteInt( v.amt, 5  )
			net.SendToServer()
			
			self:addText( "You have bought x" .. v.amt .. " Cinema Shares!" )
			
			self:addOption("I would like to buy more shares!", function()
				self:onBuyCinema()
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