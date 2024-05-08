
local _plyMeta=FindMetaTable("Player");

fsrp.OrganizationBoost = fsrp.OrganizationBoost || {}

function _plyMeta:HasOrgBoost()
	local _orgtofind = self:getFlag("organization",0);
	if fsrp.OrganizationBoost[_orgtofind] then
		if fsrp.OrganizationBoost[_orgtofind][1] > os.time() then
			return true,fsrp.OrganizationBoost[_orgtofind]
		end
	end
	return false,{os.time()-1,false};
end

local _boostText = {
	[1] = "30 Minute" ,
	[2] = "60 Minute",
	[3] = "90 Minute",
} 
if CLIENT then
	
	net.Receive("RequestOrgBoost", function(_l,_p)

		fsrp.OrganizationBoost = util.JSONToTable(net.ReadString())

	end)

elseif SERVER then
	
	util.AddNetworkString("RequestOrgBoost")
	function fsrp.UpdateOrganizationBoost()
		for k ,v in pairs (fsrp.OrganizationBoost) do
			if v[1] < os.time() then
				table.remove(fsrp.OrganizationBoost,k)
			end
		end

		for k , v in pairs ( player.GetAll() ) do
			net.Start("RequestOrgBoost")
				net.WriteString(util.TableToJSON(fsrp.OrganizationBoost))
			net.Send(v)
		end
	
	end

	hook.Add("PaydayDistribution","UpdateOrgBoost",function()
		fsrp.UpdateOrganizationBoost()
	end)
	
	function fsrp.BoostOrg(org,time,_pl)

	//_p:addBank(_boostcost*-1)
		if !fsrp.OrganizationBoost[org] then
			fsrp.OrganizationBoost[org] = {os.time()+time,true};
		else
			local _org = fsrp.OrganizationBoost[org]
			if _org[1] > os.time() then
				_org[1]=_org[1]+time
			else
				_org[1]=time
			end
			fsrp.OrganizationBoost[org][1] = _org[1];
		end
		
		for k , v in pairs ( player.GetAll() ) do

			net.Start("RequestOrgBoost")
				net.WriteString(util.TableToJSON(fsrp.OrganizationBoost))
			net.Send(v)
		
			if v:getFlag("organization",0) == org then
				if _pl && IsValid(_pl) then
					v:ChatMessage ("[ORG] ".._pl:getRPName() .. " has initiated a " .. time .. "s boost for all organization members. [TOTAL:" .. fsrp.OrganizationBoost[org][1]-os.time() .. "s]", 10 )
				elseif !_pl then
					v:ChatMessage ("A " .. time .. "s boost for all organization members.", 10 )
				end
			end	
		end

	end
	
	net.Receive("RequestOrgBoost", function(_l,_p)

		local _orgtofind = _p:getFlag("organization",0);
		local _boost = net.ReadInt(3);
		local _boostText = {
			[1] = "30 Minute" ,
			[2] = "60 Minute",
			[3] = "90 Minute",
		} 
		local _boostcost = fsrp.config.OrgBoostCost;
		local _lv = 1;
		if _p:GetRotoLevel(19) then
			_lv = _p:GetRotoLevel(19)[1]
		end
		_boostcost = math.max(10000,_boostcost - (1000*_lv));
		
		if _p:canAffordBank(_boost*_boostcost) then
			_p:Notify("You have spent $" .. _boost*_boostcost .. " on a organization boost.");
			
			_p:addBank(_boostcost*-1)
			if !fsrp.OrganizationBoost[_orgtofind] then
				fsrp.OrganizationBoost[_orgtofind] = {os.time()+(_boost*3600),true};
			else
				local _org = fsrp.OrganizationBoost[_orgtofind]
				if _org[1] > os.time() then
					_org[1]=_org[1]+(_boost*3600)
				else
					_org[1]=(_boost*3600)
				end
				fsrp.OrganizationBoost[_orgtofind][1] = _org[1];
			end
			
			for k , v in pairs ( player.GetAll() ) do
				net.Start("RequestOrgBoost")
					net.WriteString(util.TableToJSON(fsrp.OrganizationBoost))
				net.Send(v)
			
				if v:getFlag("organization",0) == _orgtofind then
					v:ChatMessage (_p:getRPName() .. " has initiated a " .. _boostText[_boost] .. "s boost for all organization members.", 10 )
				end	

			end

		else

			_p:Notify("You can not afford a organization growth boost.")

		end
		
	end)


end
