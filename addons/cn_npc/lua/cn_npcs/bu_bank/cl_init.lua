
NPC.reputation =3;
NPC.model = "models/captainbigbutt/vocaloid/tda_kenzie.mdl"
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Bank Secretary Elizabeth"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local talkedTo = false;
local _i = 1;
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	local _acnt =  LocalPlayer():getBankAccount();
	
	-- This code is inside a function that gets ran after pressing the option.
	if !talkedTo then
		self:addText("Welcome to the Bank! How are you? (Elizabeth Smiles)")
	elseif talkedTo then
		self:addText("What can I do for you?")
	end
	local _finished, _lfinished = LocalPlayer():FinishedQuest( 1 );

	if !_finished && LocalPlayer():getBankAccount() < 1 then
					
								
				self:addOption("Quest 1", function ( )
				
					self:send( "questTut_1" )
					
					self:addText( "Make a bank account and I will reward you with cash.")
					
					self:addOption( "I will do that! Thank you (Smile)", function ( )
						self:send( "questTut_1_step_2" )
						
						timer.Simple(1,function()
							if !self then return end
							self:MakeBankAccount( 0 )
						end)
					end )
					
					self:addOption("I am not interested. Thank you for the forum.", function ()
							self:addText("Come back any time you want!")
							self:addLeave("<Leave>")
							
					end)
				end)
				
	end
			
	
	
	if _acnt > 0 then
		
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
		
		
		if LocalPlayer():canAffordBank( fsrp.config.BankAccountChangeCost ) then
		
			self:addOption( "I would like to change my bank account (Cost: $" .. fsrp.config.BankAccountChangeCost .. ")", function ( )
				talkedTo = true;
					self:MakeBankAccount( 1 )
				
				self:addOption("Nevermind.", function()
					-- self:addLeave(<leave text>) adds a button that closes the dialogue.

					self:onStart()
				
				end )
		
			end )
			
		end
	end
	
			
		if _acnt == 3 then
		
			self:addOption( "How can I buy a investment?", function ()
				timer.Simple(1,function()
					if !self then return end
				self:addText( "You can buy a investment at the realtor, this will generate passive income." )
				
				
				self:addOption("I would like some more information.", function()
					
					timer.Simple(1,function()
						if !self then return end
					self:onStart()
					end)
				end )
			
				self:addLeave("<Leave> Ok. thank you!")
				end)
			
			end )
		
		end
		
		
		self:addLeave("<Leave> No, thank you.")
end


function NPC:addDText( s , t )

	
	self:addText( s )
		
	
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

				timer.Simple(1,function()
					if !self then return end
					self:smartSavings()
				end)

			end )
		end
		if LocalPlayer():getBankAccount() != 2 then
			self:addOption( "The Chequing Supreme account.", function ( )

				timer.Simple(1,function()
					if !self then return end
					self:chequingSupreme()
				end)
			end )
		end
		if LocalPlayer():getBankAccount() != 3 then
			self:addOption( "The Buisiness account.", function ( )
			
				timer.Simple(1,function()
					if !self then return end
					self:buisinessAccount()
				end)
			end )
		end
	
end)
end
function NPC:smartSavings()
		
		self:addText( "You make " .. ((fsrp.config.atmfeesurcharge[1][1])*100).."% of your bank account each payday, and you pay $" .. fsrp.config.atmfeesurcharge[1][3].." of your cheque to us. Withdrawing cash costs you "..((fsrp.config.atmfeesurcharge[1][2])*100).."% of the amount.")
		
			self:addOption( "I would like to chose this account", function( )
				self:AccquireAccount( 1 )
			end )
			
			self:addOption( "I would like to know about another account" , function ( )
				self:MakeBankAccount( 1 )	
			end)
end
function NPC:chequingSupreme()
		
			
			self:addText( "You make " .. ((fsrp.config.atmfeesurcharge[2][1])*100).."% of your bank account each payday, and you pay $" .. fsrp.config.atmfeesurcharge[2][3].." of your cheque to us. Withdrawing cash costs you " .. ((fsrp.config.atmfeesurcharge[2][2])*100).."% of the amount.")
		
			self:addOption( "I would like to chose this account", function( )
				self:AccquireAccount( 2 )
			end )
			
			self:addOption( "I would like to know about another account" , function ( )
				self:MakeBankAccount( 1 )	
			end)
		
end

function NPC:buisinessAccount()
					
		self:addText( "You make "..((fsrp.config.atmfeesurcharge[3][1])*100).."% of your bank account each payday, and you pay $" .. fsrp.config.atmfeesurcharge[3][3].." of your cheque to us. Withdrawing cash costs you "..((fsrp.config.atmfeesurcharge[3][2])*100).."% of the amount.")
		
			self:addOption( "I would like to chose this account", function( )
				self:AccquireAccount( 3 )
			end )
			
			self:addOption( "I would like to know about another account" , function ( )
				self:MakeBankAccount( 1 )	
			end)
		
end
function NPC:AccquireAccount( int )

				timer.Simple(1,function()
					if !self then return end
	self:addText("We can set that up for you, just give me a second to get your information in our database")
	
	self:send("setbankaccountType", int )

				timer.Simple(1,function()
					if !self then return end
	self:addText("Ok we are done.", 1)
end)
	timer.Simple( 2, function()
		self:onStart( )
	end )
		
	end)
end
function NPC:SucceedTransfer( bool )
	local _t
	if bool then
		_t = "deposited"
	elseif !bool then
		_t = "withdrawn"
	end

				timer.Simple(1,function()
					if !self then return end
	self:addText( "Awesome! We have successfully " .. _t .. " your money. Is there anything else we can do for you?" )

	self:addOption( "I would like to do something else.", function( )
	
				timer.Simple(1,function()
					if !self then return end
		self:CheckBankProceed( 1 )
		end)
	end )
	
	self:addOption("Thank you, I have to go.", function()
				
				timer.Simple(1,function()
					if !self then return end		
		self:addText("Sure! Please check out what we can do for you!" )
		end)
		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("<Leave>")
					
	end )
	end)
end

function NPC:CheckBank( )
	self:addText("Okay please let me get your information.")
	
	self:addOption( "<Proceed>", function( )
	
		self:addText("Awesome! Thank you, I will be just a second.")

		timer.Simple(.1,function()
			if !self then return end
			self:CheckBankProceed( _i )
		_i = 0;
			end)
	end )


end

function NPC:CheckBankProceed( int )
	local _typeac = "";

	if int == 1 then
		timer.Simple(1,function()
			if !self then return end
			self:addText("Your current balance in your bank is $" ..math.Round( LocalPlayer():getBank( ) ,2).. ".")
			
			if LocalPlayer():getBankAccount() == 1 then
			
				_typeac = "You have a Smart Savings Account.";
				
			elseif LocalPlayer():getBankAccount() == 2 then			
				_typeac = "You have a Chequing Supreme Account.";
				
			elseif LocalPlayer():getBankAccount() == 3 then			
				_typeac = "You have a Buisiness Account.";
				
			end

			timer.Simple(3 , function()
					if !self then return end
				self:addText(_typeac );
		
				//self:addText("What would you like to do? (You have $" .. math.Round(LocalPlayer():getMoney(),2) .. ")")
				
				self:addOption( "I would like to deposit..", function( )
					local depTbl = { 
						{name = "$1,000", amt = 1000},
						{name = "$5,000", amt = 5000},
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
						
						self:CheckBankProceed( 1 )
					
					end )
				
				end)
				
				self:addOption("Thank you, I have to go.", function()
						
						self:addText("Sure! That's fine! We have plenty customers so we are ready to help you with your banking!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
				end )
			
			
			end )
			
		end)
		
		 
		else
			local _typeac = "You have a Smart Savings Account."
		timer.Simple(3,function()
			if !self then return end
			self:addText("Your current balance in your bank is $" ..math.Round( LocalPlayer():getBank( ) ,2).. ".")
			
			if LocalPlayer():getBankAccount() == 1 then
			
				_typeac = "You have a Smart Savings Account.";
				
			elseif LocalPlayer():getBankAccount() == 2 then			
				_typeac = "You have a Chequing Supreme Account.";
				
			elseif LocalPlayer():getBankAccount() == 3 then			
				_typeac = "You have a Buisiness Account.";
				
			end

			timer.Simple(1 , function()
				self:addText(_typeac );
			
			
				//self:addText("What would you like to do? (You have $" .. math.Round( LocalPlayer():getMoney(),2) .. ")")
				
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
						
						self:CheckBankProceed(1)

					end )
				
				end)
				
				self:addOption("Thank you, I have to go.", function()
						
						self:addText("Sure! That's fine! We have plenty customers so we are ready to help you with your banking!" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:addLeave("<Leave>")
					
				end )
			
			 
			end )
			
		end)
		
		end
	
end
