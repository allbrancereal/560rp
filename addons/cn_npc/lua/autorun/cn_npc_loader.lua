--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2
--]]

if (SERVER) then
	include("cn_npc_system/sv_cn_npc.lua")
	include("cn_npc_system/sh_cn_npc.lua")

	AddCSLuaFile("cn_npc_system/cl_cn_npc.lua")
	AddCSLuaFile("cn_npc_system/sh_cn_npc.lua")
else
	include("cn_npc_system/cl_cn_npc.lua")
	include("cn_npc_system/sh_cn_npc.lua")
end

MsgC(Color(0, 255, 0), "Loaded Chessnut's NPC system! rev. f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2\n")