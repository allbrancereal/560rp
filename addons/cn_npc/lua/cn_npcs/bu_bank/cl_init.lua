-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Secretary Yennefer"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local talkedTo = false;
local _i = 1;
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	
	-- This code is inside a function that gets ran after pressing the option.
	if !talkedTo then
		self:addText("Welcome to the Bank! How are you? (Yennefer Smiles)")
	elseif talkedTo then
		self:addText("What can I do for you?")
	end
	if !LocalPlayer().__activeQuests[1] || !LocalPlayer():IsOnQuest( 1 ) then
	
			self:addOption( "(Quest) Tutorial #1" , function ( )
			
				
				self:addText("So you would like to know how I can reward you?")
				
				self:addOption("Yes! What would you like me to do?", function ( )
				
					self:send( "questTut_1" )
					
					self:addText( "Simple! You just have to make a bank account and I will reward you with some cash!")
					
					self:addOption( "I will do that! Thank you (Smile)", function ( )
						self:send( "questTut_1_step_2" )
						self:MakeBankAccount( 0 )
					
					end )
					
					self:addOption("I am not interested. Thank you for the forum.", function ()
							self:addText("Come back any time you want!")
							self:addLeave("<Leave>")
							
					end)
				end)
				
			end)
			
	end
	
	if LocalPlayer():getBankAccount() > 0 then
		
		if LocalPlayer():getMoney() >= 100 || LocalPlayer():getBank() >= 100 then
			if _i == 1 then
			
			self:addOption( "I would like to get some banking done.", function ( )
				talkedTo = true;
				self:CheckBank()
				
			end )
			
			else	
			
			self:addOption( "I would like to get some banking done.", function ( )
				talkedTo = true;
				self:CheckBankProceed(0)
				
			end )
			
			end
		end
		
		
		if LocalPlayer():canAffordBank( 25000 ) then
		
			self:addOption( "I would like to change my bank account (Cost: $25000)", function ( )
				talkedTo = true;
				self:MakeBankAccount( 1 )
				
				self:addOption("Nevermind.", function()
					-- self:addLeave(<leave text>) adds a button that closes the dialogue.
					self:onStart()
				end )
		
			end )
			
		end
	end
	
		if LocalPlayer():getBankAccount() == 3 && LocalPlayer():getShares( 2 ).shares >0 then
			
			
			self:BuisinessOwner()
			
		end
		
		
		
		
	
		local _str = "I am good, what is this place?";
		self:addOption( _str , function()
			talkedTo = true;
			
			self:addText("This is the bank, You can manage this buisiness if you were the owner or make deposits and take out cash!")
			self:addText("Would you like to make an account?")
					
			self:addOption( "Why do I need to make an account?" , function( )
			
				self:addText("You need to make a bank account to manage what type of transactions you do.")
				
				
					self:addOption( "I would like to open a bank account.", function()
						self:MakeBankAccount( 0 )
					
					end )
					
					self:addOption("I am not interested. Thank you for the forum.", function ()
						self:addText("Come back any time you want to make an account!")
						self:addLeave("<Leave>")
						
					end)
					
				end )
				
			end )
			
			self:addOption( "How can I buy a share?", function ()
				self:addText( "You can buy a share by visiting the Mysterious Slav at the Stock Exchange. You also are required to own a Buisiness Account." )
				
				
				self:addOption("I would like some more information.", function()
				
					self:onStart()
					
				end)
				
				self:addOption( "I would like to open a account then.", function()
					self:MakeBankAccount( 0 )
					
				end)
			
			
			end )
		
	
			
			self:addOption("Oh okay! Thank you, but no thank you.", function ()
				self:addText("Come back any time you want to make an account!")
				self:addLeave("<Leave>")
				
			end)
end

function NPC:addDText( s , t )

	timer.Simple( t , function ( )
	
		self:addText( s )
		
	end)
	
end

function NPC:MakeBankAccount( int )
	if int == 0 then
	
		self:addText( "Oh okay! We have three different types of bank accounts here, Smart Savings, Chequing Supreme and Buisiness." )
	
	else
		
		self:addText( "Sure what other account would you like to know about?" )
		
	end
	
	self:addOption( "Tell me more about.." , function ( )
	
		if LocalPlayer():getBankAccount() != 1 then
			self:addOption( "The Smart Savings account.", function ( )
				self:smartSavings()
			end )
		end
		if LocalPlayer():getBankAccount() != 2 then
			self:addOption( "The Chequing Supreme account.", function ( )

				self:chequingSupreme()
			end )
		end
		if LocalPlayer():getBankAccount() != 3 then
			self:addOption( "The Buisiness account.", function ( )
			
				self:buisinessAccount()
			end )
		end
	end)

end
function NPC:smartSavings()
		
		self:addText( "Sure enough our smart savings account is for those who take out rarely but want lots of interest paid every payday!" )
			
		self:addDText( "You make 0.2% of your bank account each payday, and you pay $15 of your cheque to us.", 2)
		self:addDText( "Withdrawing cash costs you 7.5% of the amount.", 4)
		
		timer.Simple( 4, function()
			self:addOption( "I would like to chose this account", function( )
				self:AccquireAccount( 1 )
			end )
			
			self:addOption( "I would like to know about another account" , function ( )
				self:MakeBankAccount( 1 )	
			end)
		end)
end
function NPC:chequingSupreme()
		
		self:addText( "Sure enough our chequing supreme account is for those who buy lots!" )
			
		self:addDText( "You make 0.1% of your bank account each payday, and you pay $10 of your cheque to us.", 2)
		self:addDText( "Withdrawing cash costs you 0% of the amount.", 4)
		
		timer.Simple( 4, function()
			self:addOption( "I would like to chose this account", function( )
				self:AccquireAccount( 2 )
			end )
			
			self:addOption( "I would like to know about another account" , function ( )
				self:MakeBankAccount( 1 )	
			end)
		end)
		
end
function NPC:buisinessAccount()
		
		self:addText( "Our Buisiness account is for investors looking to make profit with their cash!" )
			
		self:addDText( "You make 0.2% of your bank account each payday, and you pay $30 of your cheque to us.", 2)
		self:addDText( "Withdrawing cash costs you 5% of the amount.", 4)
		
		timer.Simple( 4, function()
			self:addOption( "I would like to chose this account", function( )
				self:AccquireAccount( 3 )
			end )
			
			self:addOption( "I would like to know about another account" , function ( )
				self:MakeBankAccount( 1 )	
			end)
		end)
		
end

function NPC:AccquireAccount( int )

	self:addText("We can set that up for you, just give me a second to get your information in our database")
	
	self:send("setbankaccountType", int )
	self:addDText("Ok we are done.", 1)
	timer.Simple( 2, function()
		self:onStart( )
	end )
	

end
function NPC:SucceedTransfer( bool )
	local _t
	if bool then
		_t = "deposited"
	elseif !bool then
		_t = "withdrawn"
	end

	self:addText( "Awesome! We have successfully " .. _t .. " your money. Is there anything else we can do for you?" )

	self:addOption( "I would like to do something else.", function( )
	
		self:onStart()
		
	end )
	
	self:addOption("Thank you, I have to go.", function()
						
		self:addText("Sure! Please check out what we can do for you!" )
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
					
	end )
	
end

function NPC:CheckBank( )
	self:addText("Okay please let me get your information.")
	
	self:addOption( "<Proceed>", function( )
	
		self:addText("Awesome! Thank you, I will be just a second.")
		
		self:CheckBankProceed( _i )
		_i = 0;
	end )


end

function NPC:CheckBankProceed( int )
	local _typeac = "";

	if int == 1 then
		timer.Simple( 2, function()
		
			self:addText("Okay here we go, your current balance in your bank is $" .. LocalPlayer():getBank( ) .. ".")
			
			if LocalPlayer():getBankAccount() == 1 then
			
				_typeac = "You have a Smart Savings Account.";
				
			elseif LocalPlayer():getBankAccount() == 2 then			
				_typeac = "You have a Chequing Supreme Account.";
				
			elseif LocalPlayer():getBankAccount() == 3 then			
				_typeac = "You have a Buisiness Account.";
				
			end
				self:addText(_typeac );

			timer.Simple( 2 , function()
			
				self:addText("What would you like to do? (You have $" .. LocalPlayer():getMoney() .. ")")
				
				self:addOption( "I would like to deposit..", function( )
					local depTbl = { 
						{name = "$1,000", amt = 1000},
						{name = "$10,000", amt = 10000},
						{name = "$25,000", amt = 25000},
						{name = "$50,000", amt = 50000},		
						{name = "$100,000", amt = 100000},		
					}
					for k , v in pairs( depTbl ) do
					
						if LocalPlayer():canAfford( v.amt )  then
						
							self:addOption( v.name , function ( )
								
								self:send("transferMoney", v.amt, true )
								self:SucceedTransfer( true )
								
						
							end)
						
						end
						
					end
			
					self:addOption("All my money.", function()
						
						self:addText("Sure! Lets get that going!" )
						
						self:send("transferallMoney", true)
						self:SucceedTransfer( true )
					
					end )
			
					self:addOption("Thank you, but I have changed my mind.", function()
						
						self:addText("Sure! Don't forget to come back!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
					end )
				
				end)
				
				self:addOption( "I would like to withdraw.." , function ()
					local _act = LocalPlayer():getBankAccount() || 0;
					if _act == 0 then
						return self:Notify("You need to create a bank account to make transactions!");
					elseif _act == 1 then
						_interest = 0.25
					elseif _act == 2 then
						_interest = 0.05
					elseif _act == 3 then
						_interest = 0.1
					end
					
					if LocalPlayer():canAffordBank( 100000 * _interest + 100000 ) then
						self:addOption("$100,000.", function()
							
							self:addText("I have to get my manager to help me with this. Consider this withdrawal done!" )
							
							self:send("transferMoney", 100000, false )
							self:SucceedTransfer( false )
						
						end )
					end
					if LocalPlayer():canAffordBank( 50000 * _interest + 50000 ) then
						self:addOption("$50,000.", function()
							
							self:addText("Wow that is a big amount! I will immediately get to it!" )
							
							self:send("transferMoney", 50000, false )
							self:SucceedTransfer( false )
						
						end )
					end
					
					if LocalPlayer():canAffordBank( 25000 * _interest + 25000 ) then
						self:addOption("$25,000.", function()
							
							self:addText("Wow that is a quite the amount! I will get to it!" )
							
							self:send("transferMoney", 25000, false )
							self:SucceedTransfer( false )
						
						end )
					end
			
					
					if LocalPlayer():canAffordBank( 10000 * _interest + 10000 ) then
						self:addOption("$10,000.", function()
							
							self:addText("On it! Consider it done." )
							
							self:send("transferMoney", 10000, false )
							self:SucceedTransfer( false )
						
						end )
					end
					
					
					if LocalPlayer():canAffordBank( 5000 * _interest + 5000 ) then
						self:addOption("$5,000.", function()
							
							self:addText("Yes. Thank you for working with us!" )
							
							self:send("transferMoney", 5000, false )
							self:SucceedTransfer( false )
						
						end )
					end
					
					
					if LocalPlayer():canAffordBank( 1000 * _interest + 1000 ) then
						self:addOption("$1,000.", function()
							
							self:addText("We appreciate your buisiness with the bank." )
							
							self:send("transferMoney", 1000, false )
							self:SucceedTransfer( false )
						
						end )
					end
					
					self:addOption("All my money.", function()
						
						self:addText("Sure! Lets get that going!" )
						
						self:send("transferallMoney", false)
						self:SucceedTransfer( false )
					
					end )
			
					self:addOption("I have changed my mind.", function()
						
						self:addText("Sure! Don't forget to come back! We offer increased rewards for people who sign up with us!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
					end )
				
				end)
				
				self:addOption("Thank you, I have to go.", function()
						
						self:addText("Sure! That's fine! We have plenty customers so we are ready to help you with your banking!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
				end )
			
			end )
			
		
		end )
		else
		
			self:addText("Your current balance in your bank is $" .. LocalPlayer():getBank( ) .. ".")
			
			if LocalPlayer():getBankAccount() == 1 then
			
				_typeac = "You have a Smart Savings Account.";
				
			elseif LocalPlayer():getBankAccount() == 2 then			
				_typeac = "You have a Chequing Supreme Account.";
				
			elseif LocalPlayer():getBankAccount() == 3 then			
				_typeac = "You have a Buisiness Account.";
				
			end
				self:addText(_typeac );

			timer.Simple( 1 , function()
			
				self:addText("What would you like to do? (You have $" .. LocalPlayer():getMoney() .. ")")
				
				self:addOption( "I would like to deposit..", function( )
					local depTbl = { 
						1000,
						25000,
						50000,
						100000					
					}
					for k , v in pairs( depTbl ) do
					
						if LocalPlayer():canAfford( v ) then
						
							self:addOption( "$" .. v , function ( )
								
								self:send("transferMoney", v, true )
								self:SucceedTransfer( true )
								
						
							end)
						
						end
						
					end
			
					self:addOption("All my money.", function()
						
						self:addText("Sure! Lets get that going!" )
						
						self:send("transferallMoney", true)
						self:SucceedTransfer( true )
					
					end )
			
					self:addOption("Thank you, but I have changed my mind.", function()
						
						self:addText("Sure! Don't forget to come back!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
					end )
				
				end)
				
				self:addOption( "I would like to withdraw.." , function ()
					local depTbl = { 
						1000,
						25000,
						50000,
						100000					
					}
					for k , v in pairs( depTbl ) do
						
						if LocalPlayer():canAffordBank( v ) then
						
							self:addOption( "$" .. v , function ( )
								
								self:send("transferMoney", v, false )
								self:SucceedTransfer( false )
						
							end)
						
						end
						
						
					end
				
			
					self:addOption("All my money.", function()
						
						self:addText("Sure! Lets get that going!" )
						
						self:send("transferallMoney", false)
						self:SucceedTransfer( false )
					
					end )
			
					self:addOption("I have changed my mind.", function()
						
						self:addText("Sure! Don't forget to come back! We offer increased rewards for people who sign up with us!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
					end )
				
				end)
				
				self:addOption("Thank you, I have to go.", function()
						
						self:addText("Sure! That's fine! We have plenty customers so we are ready to help you with your banking!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
				end )
			
			end )
			
		
		end
	end

function NPC:BuisinessOwner( )

	self:addOption("(Buisiness) I would like to check...", function()
			
		self:addOption("My Net Worth.", function() 
		
			self:addText("Sure, your current net worth is $" .. LocalPlayer():getShares(2).value .. "!" )
			
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
			
			self:addText("Sure thing, the current level of your buisiness is: " .. LocalPlayer():getShares(2).level .. "!" )
			
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
			
			self:addText("Sure, your current amount of shares is x" .. LocalPlayer():getShares(2).shares .. "!" )
			
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
	
	self:addOption( "(Buisiness) I would like to buy some shares.", function() 
		
		self:onBuy()
		
	end )
	
end

function NPC:onBuy()
	
	local _newTbl = {}
	local _plyTbl = LocalPlayer():getShares(1);
	
	for k , v in pairs( BUISINESS_TABLE ) do
		if v.ID == 2 then 
		
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
		
		if LocalPlayer():canAffordBank( _newTbl.cost * v.amt )&& LocalPlayer():getShares( 2).shares + v.amt <= MAX_BANK_SHARES then 
		
		self:addOption( v.name , function()

			net.Start("buybankMarketShare")
				net.WriteInt( v.amt, 5  )
			net.SendToServer()
			
			self:addText( "You have bought x" .. v.amt .. " Bank Shares!" )
			
			self:addOption("I would like to buy more shares!", function()
				self:onBuy()
			end )
			
			self:addOption("Thank you!", function()
				self:addText("Sure! Don't forget to come back!" )
				self:addLeave("<Leave>")
			end )
			
		end )
		else
		
			LocalPlayer():Notify("You do not have enough money to buy any shares!");
			break;
		end
		
	end
	
	self:addOption("I have changed my mind.", function()
		self:addText("Sure! Don't forget to come back!" )
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
	end )
	
end