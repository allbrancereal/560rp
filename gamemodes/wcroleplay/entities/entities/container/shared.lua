




ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName		= "Dynamic Container"
ENT.Author			= "Tibba"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.Spawnable = true
ENT.AdminSpawnable = true;


local i = 0;
for k , v in pairs(fsrp.config.VisibleContainers) do 
	local _c = {
		ID = 800+i;
		Category = "Craftable";
		Name = v.name;
		Quality = 1;
		Class = "container";
		Description = "A container with " .. v.slots .. " slots.";
		Model	= v.model;
		Weight = 0.5; 
		ContainerSize = i;
		MaxStack = 25;
		Scale = v.scale;
		Cost = v.cost;
		CamPos = Vector(0, 0, 37.837837837838);
		LookAt = Vector(0, 0, 0);
		OnPickedUp = function( _p )
 
		end;
		EntityOnUse = function( _p,_e )
			_e.container = _e.ContainerSize;
			_e:setFlag("container",_e.ContainerSize)
			_e:FigureContainer(_e.ContainerSize)
			return false
		end;

		CanUse = function( _p )
			return true
		end;
		OnDropped = function( _p )
			return true
		end ;
	}

	SetupItem ( _c ) 
	i=i+1;
end