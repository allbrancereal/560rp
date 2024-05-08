
-- This sets the model for the NPC.
NPC.model = "models/kemono_friends/oinari_sama/oinari_sama_npc.mdl"
NPC.name = "City Council Ward"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.reputation =6;

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.
function NPC:onShowNameChangeMenu(client)

	client:ShowNameChangeMenu( true )
	
end

function NPC:onBuyOrganization( client )

	if !client:canAfford( fsrp.config.OrganizationCost ) then
		
		return client:Notify( "You must have $" .. ( fsrp.config.OrganizationCost - client:getMoney() ) .. " to purchase an organization.")

	end

	client:addMoney( -fsrp.config.OrganizationCost );
	client:Notify( "Creating Organization: " .. client:getFirstName() .. "s Cool Organization!" )

	client:MakeOrganization( client:getFirstName() .. "s Cool Organization!" )
end
function NPC:onLeaveOrganization( client )

	client:LeaveOrganization( )

end
function NPC:onmayoralBallot( client )

	client:SignUpForMayor( )

end
function NPC:onDisbandOrganization( client )

	client:DisbandOrganization( )

end

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:onEntityCreated(entity)
    --print(entity)
    --entity:Ignite(5)
end
function NPC:onfinishquest9(_p)
	local _finished, _lfinished = _p:FinishedQuest(9);
	if (_p:IsVIP() and !_p:IsDev()) or (_p:IsDev() and _finished == true) then return _p:Notify("You are a VIP already!") end
	local _ActiveQuests = _p:getFlag("questTable", nil )
	local _canfinish = QUEST_TABLE[9].Condition(_p);
	print(_canfinish)
	print(_finished)
	if _finished == false and _canfinish==true then
		_p:addMoney(-5000000)
		_p:RewardQuest( 9, _ActiveQuests )

	else 
		_p:Notify("You do not meet the requirements for this quest.")
	end


end


function NPC:onstartquest9(  _p )
	local _finished, _lfinished = _p:FinishedQuest(9);

	local _ActiveQuests = _p:getFlag("questTable", nil )

	if  (_p:IsVIP() and !_p:IsDev()) or (_p:IsDev() and _finished == true) then return _p:Notify("You are already a vip!") end

	if _finished == false then
		_p:StartQuest(9)

	
	else
		_p:Notify("You already are a VIP!")
	end

end 