
if SERVER then
	function OverrideDeathSound()
		return true
	end
	
	hook.Add("PlayerDeathSound", "OverrideDeathSound", OverrideDeathSound)
end

function TestAnimation(ply,cmd,args)

	--ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_GMOD_TAUNT_CHEER, true)
   -- ply:AnimSetGestureWeight(GESTURE_SLOT_CUSTOM, 1)
		
	ply:SetSequence(ply:LookupSequence("death_01"))
		
		
	print("GESTURING")

end

concommand.Add( "sendanimation", TestAnimation)

require( "mysqloo" )

util.AddNetworkString("sendDownvoteRequest")
util.AddNetworkString("sendUpvoteRequest")
util.AddNetworkString("sendClientSignCooldown")

local _pMeta =FindMetaTable( "Player" )

function _pMeta:SetSignCooldownTimer( x )

	self.__LastVote = x + CurTime();
	
	net.Start("sendClientSignCooldown")
		net.WriteInt( self.__LastVote ,32 )
	net.Send( self )
	
end

local db = mysqloo.connect( "", "", "", "", 3306 )
function getMsgDB()
	return db
end
function db:onConnected()

    local q = self:query( "SELECT 5+5" )
    function q:onSuccess( data )

        print( "DB Has connected!" )
        //PrintTable( data )

    end

    function q:onError( err, sql )

        print( "Query errored!" )
        print( "Query:", sql )
        print( "Error:", err )

    end

    q:start()

end

function db:onConnectionFailed( err )

    print( "Connection to database failed!" )
    print( "Error:", err )

end

db:connect()


function retrievePermSigns()
	
	local _query = db:query( "SELECT * FROM `fsdb_messenger` WHERE `permanent` = true AND `map` = '".. game.GetMap() .."';" );

    function _query:onSuccess( data )

		for k , v in pairs( ents.GetAll() ) do
		
			if v:GetClass() == "soapstonewriting" then
				
				if v.Permanent == true then
					
					v:Remove();

				end
		
			end
			
		end
		
		// ID
		// alwaysshow (1/0)
		// ang str
		// downvotes
		// map
		// name
		// permanent
		// pos
		// steamid
		// upvotes
		//PrintTable( data ) 
		for k , v in pairs( data ) do
		
			local _posExplode = string.Explode( ",", v.pos )
			local _truPos = Vector( _posExplode[1],_posExplode[2],_posExplode[3] ) + Vector( 0,0,1.75) 
					
			local _angExplode = string.Explode( ",", v.ang )
			local _truAng = Angle( _angExplode[1],_angExplode[2],_angExplode[3] )
					
			local _signEnt = ents.Create( "soapstonewriting" ) 
			_signEnt:SetPos( _truPos )
			_signEnt:SetAngles( _truAng )
			//self.PublicInfo = { Sentence = "", upVotes = 0, downVotes = 0, userID = "" };
			
			_signEnt:Spawn()
			_signEnt:SetPublicInformation( { ID = tonumber(v.ID) ,Sentence = GetMessageFromTable( v.msg ), upVotes = v.upvotes, downVotes = v.downvotes, userName = v.name } )
			_signEnt.PrivateOwner = v.steamid;
			_signEnt.Permanent = true;
			
			_signEnt:DropToFloor()
			
		end

    end

    function _query:onError( err, sql )

        print( "Query:", sql )
        print( "Error:", err )

    end
	
	_query:start();
	
end

function retrieveSigns( x )
	
	for k , v in pairs( ents.FindByClass( "soapstonewriting" ) ) do

		v:Remove()

	end

	local _query = db:query( "SELECT * FROM `fsdb_messenger` WHERE `permanent` = false AND `map` = '".. game.GetMap() .."' ORDER BY RAND() LIMIT " .. x .. ";" );

    function _query:onSuccess( data )

		for k , v in pairs( ents.GetAll() ) do
		
			if v:GetClass() == "soapstonewriting" then
				
				if v.Permanent != true then
					
					v:Remove();

				end
		
			end
			
		end
		
		// ID
		// alwaysshow (1/0)
		// ang str
		// downvotes
		// map
		// name
		// permanent
		// pos
		// steamid
		// upvotes
		//PrintTable( data ) 

		for k , v in pairs( data ) do
			
			local tabletomessage = {};
			local jsonMsgToTable = util.JSONToTable(  v.msg );

			tabletomessage.Template_1 	= jsonMsgToTable.T1;
			tabletomessage.Word_1	   	= jsonMsgToTable.W1; 
			tabletomessage.Conjunction	= jsonMsgToTable.CNJ;
			tabletomessage.Template_2  =  jsonMsgToTable.T2;
			tabletomessage.Word_2		= jsonMsgToTable.W2;
			tabletomessage.Word_1_Cat  = jsonMsgToTable.W1C;
			tabletomessage.Word_2_Cat  = jsonMsgToTable.W2C;
			tabletomessage.Permanent = jsonMsgToTable.P;
			tabletomessage.shouldAlwaysShow = jsonMsgToTable.AS;
			local _posExplode = string.Explode( ",", v.pos )
			local _truPos = Vector( _posExplode[1],_posExplode[2],_posExplode[3] ) + Vector( 0,0,1.75) 
					
			local _angExplode = string.Explode( ",", v.ang )
			local _truAng = Angle( _angExplode[1],_angExplode[2],_angExplode[3] )
					
			local _signEnt = ents.Create( "soapstonewriting" ) 
			_signEnt:SetPos( _truPos )
			_signEnt:SetAngles( _truAng )
			//self.PublicInfo = { Sentence = "", upVotes = 0, downVotes = 0, userID = "" };
			
			_signEnt:Spawn()
			_signEnt:SetPublicInformation( { ID = tonumber(v.ID) ,Sentence = GetMessageFromTable( tabletomessage ), upVotes = v.upvotes, downVotes = v.downvotes, userName = v.name } )
			_signEnt.PrivateOwner = v.steamid;
			_signEnt.Permanent = false;
			
			_signEnt:DropToFloor()
			
		end
		

    end

    function _query:onError( err, sql )

        print( "Query:", sql )
        print( "Error:", err )

    end
	
	_query:start();
	
end

function insertnewSign( sentence ,steamid, name, map, pos, ang, permanent, alwaysshow )

	for k , v in pairs(ents.FindInSphere(pos,85)) do
		
		if v:GetClass() == "prop_door_rotating" or v:GetClass() == "func_door" then
			local _p = player.GetBySteamID(steamid);
			_p:Notify("Your sign has not been placed because you are near a door.")
			return
		end
		
	end
	local _steamID = steamid || "";
	local _name = name || "";
	local _map = map || game.GetMap()
	local _pos = pos || Vector( 0,0,0 )
	local _ang = ang || Angle( 0,0,0 ) // yaw only (p,y,r)
	local _permanent = permanent || false;
	local _alwaysshow = alwaysshow || false;
	local _sentence = sentence || "";
	local _posString = math.Round(_pos.x,4) .. "," .. math.Round(_pos.y,4) .. "," .. math.Round(_pos.z,4);
	local _angString = math.Round(_ang.p,4) .. "," .. math.Round(_ang.y,4) .. "," .. math.Round(_ang.r,4);
	
	if _steamID == "" then return end
	if _name == "" then return end
	if _sentence == "" then return end
	if _pos == Vector( 0,0,0 ) then return end
	
	local _query = db:prepare( "INSERT INTO `fsdb_messenger` (`steamid`, `name`, `map`, `pos`, `ang`, `upvotes`, `downvotes`, `permanent`, `alwaysshow`, `msg`) VALUES ( ?,?,?,?,?,?,?,?,?,? );" );

	function _query:onSuccess(data)
		//print("Rows inserted successfully!")
	end

	function _query:onError(err)
		print("An error occured while executing the query: " .. err)
	end


	_query:setString(1, _steamID )
	_query:setString(2, _name)
	_query:setString(3, _map )
	_query:setString(4, _posString )
	_query:setString(5, _angString )
	_query:setNumber(6, 0)
	_query:setNumber(7, 0)
	_query:setBoolean(8, _permanent)
	_query:setBoolean(9, _alwaysshow)
	_query:setString(10, _sentence )
	
	_query:start()
	
end

net.Receive("sendUpvoteRequest", function(_l, _p )

	local _index = net.ReadInt( 32 )
	local _ent = ents.GetByIndex(_index);
	
	if !_ent.PublicInfo then return end
	
	_ent:IncrementUpVote( _p )
	if !_p:IsSuperAdmin() then
	
		_p:SetSignCooldownTimer( 300 )
	
	end
	
end )

net.Receive("sendDownvoteRequest", function(_l, _p )

	local _index = net.ReadInt( 32 )
	local _ent = ents.GetByIndex(_index);
	
	if !_ent.PublicInfo then return end
	
	_ent:IncrementDownVote( _p )
	if !_p:IsSuperAdmin() then
	
		_p:SetSignCooldownTimer( 300 )

	end
	
end )

function updateSignByID( id , upvotes, downvotes)

	local transaction = db:createTransaction()
	if !id then return end
	local query1 = db:query("UPDATE `fsdb_messenger` SET upvotes =  ".. upvotes .. "  WHERE ID =" .. id .. ";" )
	local query2 = db:query("UPDATE `fsdb_messenger` SET downvotes = " .. downvotes .." WHERE ID = " .. id .. ";")

	transaction:addQuery(query1) -- This also works with PreparedQueries
	transaction:addQuery(query2)

	-- Executed if and only if all of the queries in the transaction were executed successfully
	function transaction:onSuccess()
		//local allQueries = transaction:getQueries()
		//local query1Duplicate = allQueries[1] -- You can either use this function or save a reference to the query
		//print("Transaction completed successfully")
		//print("Affected rows: " .. query1:affectedRows())
	end

	-- Executed if any of the queries in the transaction fail
	function transaction:onError(err)
		print("Transaction failed: " .. err)
	end

	transaction:start()

end