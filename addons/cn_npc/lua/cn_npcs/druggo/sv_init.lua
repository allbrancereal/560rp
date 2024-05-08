
-- This sets the model for the NPC.
NPC.model = "models/virtual_youtuber/sister_cleaire/sister_cleaire_npc.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Drug Dealer"

NPC.reputation =4;
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.
function NPC:onIgnite(client, seconds)
	client:Ignite(tonumber(seconds) or 5)
end


function NPC:onstartquest8(  _p )
	local _finished, _lfinished = _p:FinishedQuest(8);

	local _ActiveQuests = _p:getFlag("questTable", nil )

	if _finished == false then
		_p:StartQuest(8)

	
	else
		_p:Notify("You did this quest!")
	end

end 

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:ondeliveryinc(entity)
	local _npc = nil;
	for k , v in pairs( ents.FindByClass("cn_npc") ) do
		if v:GetQuest() == self.uniqueID then _npc = v end 
	end 
	
	local _data = entity:GetBusiness();
	local _found = false;
	for k , v in pairs(_data) do
		if v[8] and v[8][1] then
			fsrp.config.DeliveryMissions[v[8][1]].supplyStep[game.GetMap()].AdvanceCriteria(entity,_npc)
			_found = true;
		end
	end

	if _found == true then
		local _chance = math.random(10000);

		if _chance <=8500 then
			fsrp.blackmarket.help.Randomize();
		end
	end

end


util.AddNetworkString("changeDealerNotify")

net.Receive("changeDealerNotify", function( _l, client )
	local _oldFlag = client:getFlag("notifyDealerChange", false );
	
	client:setFlag("notifyDealerChange", !_oldFlag );	

end )