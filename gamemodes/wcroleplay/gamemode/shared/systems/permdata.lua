

local _pMeta = FindMetaTable( "Player" ) 

function _pMeta:GetPermanentDataTable()

	return self:getFlag("PermanentData" , {} );

end

function _pMeta:GetPermanentData( category )

	local permdata = self:GetPermanentDataTable();

	return permdata[category];

end

if SERVER then
	
	util.AddNetworkString("sendItemSlots")
	net.Receive("sendItemSlots", function(_l,_p)
		local _tb = net.ReadTable();
		if !istable(_tb) then return end
		_p:SavePermanentData(util.TableToJSON(_tb),"actionbarslots")
	end)
end
function _pMeta:SavePermanentData( var , category )

	local permdata = self:GetPermanentDataTable();

	permdata[category] = var;

	self:setFlag("PermanentData", permdata);
 
  	fsrp.SavePermanentData( self ) 

end


function _pMeta:RemovePermanentData( category )

	local permdata = self:GetPermanentDataTable();

	permdata[category] = nil;

	self:setFlag("PermanentData", permdata);

  	fsrp.SavePermanentData( self ) 

end

function _pMeta:GetJSONPermdata()
	local _data = self:GetPermanentDataTable( ) ;

	local _toStr = "";

	for k , v in pairs( _data ) do
		
		_toStr = _toStr .. k .. ">" .. tostring(v) .. ";";	

	end

	return _toStr
	//return util.TableToJSON( self:GetPermanentDataTable( ) );

end

fsrp = fsrp || {}

fsrp.PermDataTbl = fsrp.PermDataTbl || {};


function fsrp.GetPermanentData( )

	return fsrp.PermDataTbl;

end

function UpdatePermanentDataForClients()
	
	if SERVER then

 		fsrp.SavePermanentData( ) 

		net.Start("SendPermData")
			net.WriteString( util.TableToJSON( fsrp.GetPermanentData( ) ) );
		
		if #player.GetAll() > 0 then
			net.Broadcast()
		end
 		
	end

end

if CLIENT then

	net.Receive( "SendPermData" , function( _l , _p )

		local _data = net.ReadString();

		fsrp.PermDataTbl = util.JSONToTable(_data);

	end)

else

	util.AddNetworkString( "SendPermData" )

end

function fsrp.GetPermanentDataByCategory( category )

	local permdata = fsrp.GetPermanentData( )

	return permdata[category];

end

function fsrp.WritePermanentData( var , category )

	local permdata = fsrp.GetPermanentData( )

	permdata[category] = var;

	fsrp.PermDataTbl = permdata;

	UpdatePermanentDataForClients();

end

function fsrp.RemovePermanentData( category )

	local permdata = fsrp.GetPermanentData( )

	fsrp.PermDataTbl[category] = nil;

	//fsrp.PermDataTbl = permdata;
	
	UpdatePermanentDataForClients();

end

function fsrp.PermanentDataExists( category )

	return (fsrp.GetPermanentData()[category]) && true || false;

end
