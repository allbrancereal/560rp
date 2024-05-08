

if SERVER then

resource.AddSingleFile( "materials/icon16/funny2.png" )

AddCSLuaFile( "computerhardware/cl_computerui.lua")
AddCSLuaFile( "computerhardware/cl_compselection.lua")
AddCSLuaFile( "computerhardware/sh_computerconfig.lua")
include( "computerhardware/sh_computerconfig.lua")
include( "computerhardware/sv_computernw.lua")
  
elseif CLIENT then

include( "computerhardware/cl_computerui.lua")
include( "computerhardware/sh_computerconfig.lua")
include( "computerhardware/cl_compselection.lua")


end

