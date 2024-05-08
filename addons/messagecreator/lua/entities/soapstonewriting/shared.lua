-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT! 
ENT.Type                = "anim"
ENT.Base                = "base_anim"
ENT.PrintName           = "SoapStone Carving"
ENT.Category            = "Dark Souls"
ENT.Author              = "Mario S."
ENT.Purpose             = "Used for the soapstone weapon."
ENT.Instructions        = "Use the soapstone to use this."
ENT.Spawnable 			= true  
ENT.AdminOnly 			= false
   
function ENT:Think()

end	   
 
function ENT:Initialize()
	if SERVER then
		self:SetUseType( SIMPLE_USE )
		self:SetModel( "models/hunter/plates/plate1x2.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
	else
	 //self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER ); // COLLISION_GROUP_WEAPON ) // COLLISION_GROUP_DEBRIS

		
		self:SetRenderClipPlaneEnabled( false )
	end
      
	self.PublicInfo = { ID = 0, Sentence = "", upVotes = 0, downVotes = 0, userName = "" };
	
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
end
if SERVER then
	util.AddNetworkString("updateClientPublicInfo")
	util.AddNetworkString("receiveSignUpdate")
end

function ENT:SetPublicInformation( tbl )

	self.PublicInfo = tbl;
	
	if SERVER then
		
		net.Start("updateClientPublicInfo")
			net.WriteInt( self:EntIndex() , 20 )
			net.WriteTable( tbl )
		net.Broadcast() 

	end
	
end

function ENT:IncrementDownVote( _p )

	if tonumber(os.time())-30<_p:getFlag("lastMessageVote",0)then
		return _p:Notify("You cannot vote for another few moments") end
	_p:setFlag("lastMessageVote" , tonumber(os.time()) )

	self.PublicInfo.downVotes = self.PublicInfo.downVotes + 1
	updateSignByID( self.PublicInfo.ID , self.PublicInfo.upVotes, self.PublicInfo.downVotes ) 
	self:SendClientSigns( _p )

end

function ENT:SendClientSigns( client )
	if SERVER then
		
		net.Start("receiveSignUpdate")
			net.WriteInt( self.PublicInfo.upVotes,20)
			net.WriteInt( self.PublicInfo.downVotes,20)
		net.Broadcast( client ) 
		
	end
end

function ENT:IncrementUpVote( _p )

	if tonumber(os.time())-30<_p:getFlag("lastMessageVote",0)then
		return _p:Notify("You cannot vote for another few moments") end
	_p:setFlag("lastMessageVote" , tonumber(os.time()) )


	self.PublicInfo.upVotes = self.PublicInfo.upVotes +1
	updateSignByID( self.PublicInfo.ID , self.PublicInfo.upVotes, self.PublicInfo.downVotes ) 
	self:SendClientSigns( _p )
	
end

if CLIENT then

net.Receive("updateClientPublicInfo", function( _l , _p )

	local _index = net.ReadInt( 20 );
	local _tbl = net.ReadTable();
	
	ents.GetByIndex( _index ).PublicInfo = _tbl

end )


end