

-- This sets the model for the NPC.
NPC.model = "models/captainbigbutt/vocaloid/tda_kenzie.mdl"
NPC.name = "Bank Secretary Elizabeth"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.reputation =3;

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.
--function NPC:onIgnite(client, seconds)
	--client:Ignite(tonumber(seconds) or 5)
--end

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:onEntityCreated(entity)
    --print(entity)
    --entity:Ignite(5)
end

function NPC:ontransferMoney( client , amt, bool )
		
		
	if bool then
		
		client:MoneyToBank( amt )
		client:Notify("You have transferred $" .. amt .. " to your bank account.")
		
	elseif !bool then
	
		client:BankToMoney( amt )
		
	end
	
end

function NPC:ontransferallMoney( client, bool )

	if bool then
	
		client:Notify("You have transferred $" .. client:getMoney() .. " to your bank account.")
		client:MoneyToBank( client:getMoney() )
		
	elseif !bool then
	
		
		client:BankToMoney( client:getBank() )
	else

		return client:Notify("You can not make a transfer less than $100")
	end
	
end

function NPC:onsetbankaccountType( client , int )
	local toHit = client;
	
	for k , v in pairs( player.GetAll() ) do
	
		if v == client then
		
			toHit = v;
			
		end
		
	end
	
	if !toHit then return end
	
	if !toHit:IsOnQuest( 1 ) then
	
		toHit:RewardQuest( 1 , toHit:getFlag("questTable", nil ) );
	
		toHit:setBankAccount( int );
	
	else	
	

	
	if toHit:getBankAccount() != 0 && toHit:canAffordBank( fsrp.config.BankAccountChangeCost ) then
	
		toHit:setBankAccount( int );
		toHit:addBank( -fsrp.config.BankAccountChangeCost )
		toHit:Notify("You have been charged $" .. fsrp.config.BankAccountChangeCost .." for changing your bank account type")
		
	end
	
		fsdb_saveClient( toHit )
	end
end
function NPC:onquestTut_1_step_2( client ) 

	client:AdvanceQuestStep( 1)

end
function NPC:onquestTut_1( client )

	if !client:getFlag("questTable",{})[1] then
	
		client:StartQuest( 1 )
		
	end

end