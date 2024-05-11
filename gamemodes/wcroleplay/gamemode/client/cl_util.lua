local NEXT_WEAPONS_UPDATE = CurTime();
 
local weaponsinfos={}

weaponsinfos["cw_ak74"]={}
weaponsinfos["cw_ak74"].Model=ClientsideModel("models/weapons/w_rif_ak47.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_ak74"].Model:SetNoDraw(true)
weaponsinfos["cw_ak74"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["cw_ak74"].BoneOffset={Vector(5, 7.5, -7.5),Angle(0,10,0)}

weaponsinfos["cw_ar15"]={}
weaponsinfos["cw_ar15"].Model=ClientsideModel("models/weapons/w_rif_m4a1.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_ar15"].Model:SetNoDraw(true)
weaponsinfos["cw_ar15"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["cw_ar15"].BoneOffset={Vector(2.5, 12.5, -4),Angle(0,10,0)}

weaponsinfos["cw_g3a3"]={}
weaponsinfos["cw_g3a3"].Model=ClientsideModel("models/weapons/w_snip_g3sg1.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_g3a3"].Model:SetNoDraw(true)
weaponsinfos["cw_g3a3"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["cw_g3a3"].BoneOffset={Vector(2.5, 12.5, -4),Angle(0,10,0)}

weaponsinfos["cw_l115"]={}
weaponsinfos["cw_l115"].Model=ClientsideModel("models/weapons/w_cstm_l96.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_l115"].Model:SetNoDraw(true)
weaponsinfos["cw_l115"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["cw_l115"].BoneOffset={Vector(5, -5, -5),Angle(0,5,15)}

weaponsinfos["cw_mp5"]={}
weaponsinfos["cw_mp5"].Model=ClientsideModel("models/weapons/w_smg_mp5.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_mp5"].Model:SetNoDraw(true)
weaponsinfos["cw_mp5"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["cw_mp5"].BoneOffset={Vector(4, 7.5,-7.5),Angle(0,10,15)}

weaponsinfos["god_stick"]={}
weaponsinfos["god_stick"].Model=ClientsideModel("models/weapons/w_stunbaton.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["god_stick"].Model:SetNoDraw(true)
weaponsinfos["god_stick"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["god_stick"].BoneOffset={Vector(5, -8, -2.5),Angle(100, 0, -90)}

weaponsinfos["cw_mr96"]={}
weaponsinfos["cw_mr96"].Model=ClientsideModel("models/weapons/w_357.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_mr96"].Model:SetNoDraw(true)
weaponsinfos["cw_mr96"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["cw_mr96"].BoneOffset={Vector(-2.5, 7.5, 0),Angle(90, -90, 90)}

weaponsinfos["cw_deagle"]={}
weaponsinfos["cw_deagle"].Model=ClientsideModel("models/weapons/w_pist_deagle.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["cw_deagle"].Model:SetNoDraw(true)
weaponsinfos["cw_deagle"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["cw_deagle"].BoneOffset={Vector(0, 7.5, -3.5),Angle(90, -90, 90)}

weaponsinfos["god_stick_moderator"]={}
weaponsinfos["god_stick_moderator"].Model=ClientsideModel("models/weapons/w_stunbaton.mdl", RENDERGROUP_OPAQUE)
weaponsinfos["god_stick_moderator"].Model:SetNoDraw(true)
weaponsinfos["god_stick_moderator"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["god_stick_moderator"].BoneOffset={Vector(2, 4.25, -8),Angle(90, 0, 90)}

 


local PlayerLegs = {}
PlayerLegs.LegEntity = nil

function PlayerLegs:ShouldDraw()
    local localPlayer = LocalPlayer()
    local thirdPerson = GetConVar("wc_thirdperson"):GetBool()

    return IsValid(self.LegEntity) and
            (localPlayer:Alive() or (localPlayer.IsGhosted and localPlayer:IsGhosted())) and
            self:CheckDrawVehicle() and
            GetViewEntity() == localPlayer and
            not localPlayer:ShouldDrawLocalPlayer() and
            not localPlayer:GetObserverTarget() and
            not thirdPerson
end


function PlayerLegs:GetLegs(ply)
    return ply and ply ~= LocalPlayer() and ply or (self:ShouldDraw() and self.LegEntity or LocalPlayer())
end

PlayerLegs.VehicleDrawVar = 0
PlayerLegs.LeanMode = 1

function PlayerLegs:FixModelName(mdl)
    mdl = mdl:lower()
    return mdl
end
local playerLegs = {}

function PlayerLegs:CreateLegs()
    self.LegEntity = ClientsideModel(self:FixModelName(LocalPlayer():GetModel()), RENDER_GROUP_OPAQUE_ENTITY)
    self.LegEntity:SetNoDraw(true)
    self.LegEntity:SetSkin(LocalPlayer():GetSkin())
    self.LegEntity:SetMaterial(LocalPlayer():GetMaterial())
    self.LegEntity.LastTick = 0

    -- Store the LegEntity in the playerLegs table
    playerLegs[LocalPlayer()] = self.LegEntity
end

PlayerLegs.PlaybackRate = 1
PlayerLegs.Sequence = nil
PlayerLegs.Velocity = 0
PlayerLegs.PreviousWeapon = nil
PlayerLegs.HoldType = nil

PlayerLegs.BoneHoldTypes = {
    ["none"] = {
        "ValveBiped.Bip01_Head1",
        "ValveBiped.Bip01_Neck1",
        "ValveBiped.Bip01_Spine4",
        "ValveBiped.Bip01_Spine2",
    },
    ["default"] = {
        "ValveBiped.Bip01_Head1",
        "ValveBiped.Bip01_Neck1",
        "ValveBiped.Bip01_Spine4",
        "ValveBiped.Bip01_Spine2",
        "ValveBiped.Bip01_L_Hand",
        "ValveBiped.Bip01_L_Forearm",
        "ValveBiped.Bip01_L_Upperarm",
        "ValveBiped.Bip01_L_Clavicle",
        "ValveBiped.Bip01_R_Hand",
        "ValveBiped.Bip01_R_Forearm",
        "ValveBiped.Bip01_R_Upperarm",
        "ValveBiped.Bip01_R_Clavicle"
    },
    ["vehicle"] = {
        "ValveBiped.Bip01_Head1",
        "ValveBiped.Bip01_Neck1",
        "ValveBiped.Bip01_Spine4",
        "ValveBiped.Bip01_Spine2",
    }
}

PlayerLegs.BonesToRemove = {}
PlayerLegs.BoneMatrix = nil

function PlayerLegs:ChangeWeapon(weap)
    if IsValid(self.LegEntity) then
        if IsValid(weap) then
            self.HoldType = weap:GetHoldType()
        else
            self.HoldType = "none"
        end
        function self.LegEntity:BuildBonePositions(numbones, numphysbones)
            PlayerLegs.BonesToRemove = {
                "ValveBiped.Bip01_Head1"
            }
            if not LocalPlayer():InVehicle() then
                PlayerLegs.BonesToRemove = PlayerLegs.BoneHoldTypes[PlayerLegs.HoldType] or PlayerLegs.BoneHoldTypes["default"]
            else
                PlayerLegs.BonesToRemove = PlayerLegs.BoneHoldTypes["vehicle"]
            end
            for k, v in ipairs(PlayerLegs.BonesToRemove) do
                PlayerLegs.BoneMatrix = self:GetBoneMatrix(self:LookupBone(v))
                if PlayerLegs.BoneMatrix then
                    PlayerLegs.BoneMatrix:Scale(vector_origin)
                    self:SetBoneMatrix(self:LookupBone(v), PlayerLegs.BoneMatrix)
                end
            end
        end
    end
end

PlayerLegs.BreathScale = 0.5
PlayerLegs.NextBreath = 0

function PlayerLegs:Update(maxseqgroundspeed)
    if IsValid(self.LegEntity) then
        local localPlayer = LocalPlayer()
        if localPlayer:GetActiveWeapon() ~= self.PreviousWeapon then
            self.PreviousWeapon = localPlayer:GetActiveWeapon()
            self:ChangeWeapon(self.PreviousWeapon)
        end

        if self.LegEntity:GetModel() ~= self:FixModelName(localPlayer:GetModel()) then
            self.LegEntity:SetModel(self:FixModelName(localPlayer:GetModel()))
        end

        self.LegEntity:SetMaterial(localPlayer:GetMaterial())
        self.LegEntity:SetSkin(localPlayer:GetSkin())

        self.Velocity = localPlayer:GetVelocity():Length2D()

        self.PlaybackRate = 1

        if self.Velocity > 0.5 then
            if maxseqgroundspeed < 0.001 then
                self.PlaybackRate = 0.01
            else
                self.PlaybackRate = self.Velocity / maxseqgroundspeed
                self.PlaybackRate = math.Clamp(self.PlaybackRate, 0.01, 10)
            end
        end

        self.LegEntity:SetPlaybackRate(self.PlaybackRate)

        self.Sequence = localPlayer:GetSequence()

        if (self.LegEntity.Anim ~= self.Sequence) then
            self.LegEntity.Anim = self.Sequence
            self.LegEntity:ResetSequence(self.Sequence)
        end

        self.LegEntity:FrameAdvance(CurTime() - self.LegEntity.LastTick)
        self.LegEntity.LastTick = CurTime()
    end
end

function PlayerLegs:Initialize()
    self.LegEntity = nil
    self.VehicleDrawVar = 0
    self.LeanMode = 1
    self.PlaybackRate = 1
    self.Sequence = nil
    self.Velocity = 0
    self.PreviousWeapon = nil
    self.HoldType = nil
    self.BonesToRemove = {}
    self.BoneMatrix = nil
    self.BreathScale = 0.5
    self.NextBreath = 0
end

function LPGB(dotrace)
    if !dotrace then
    for i=0,LocalPlayer():GetBoneCount()-1 do
        print(LocalPlayer():GetBoneName(i))
    end
    else
    local entity=LocalPlayer():GetEyeTrace().Entity
    if !IsValid(entity) then return end
    for i=0,entity:GetBoneCount()-1 do
        print(entity:GetBoneName(i))
    end
    end
end
 
local function CalcOffset(pos,ang,off)
        return pos + ang:Right() * off.x + ang:Forward() * off.y + ang:Up() * off.z;
end
     
local function clhasweapon(pl,weaponclass)
    for i,v in pairs(pl:GetWeapons()) do
        if string.lower(v:GetClass())==string.lower(weaponclass) then return true end
    end
     
    return false;
end
 
local function clgetweapon(pl,weaponclass)
    for i,v in pairs(pl:GetWeapons()) do
        if string.lower(v:GetClass())==string.lower(weaponclass) then return v end
    end
     
    return nil;
end
 
local function playergettf2class(ply)
    return ply:GetPlayerClass()
end
 
local function IsTf2Class(ply)
    return LocalPlayer().IsHL2 && !LocalPlayer():IsHL2()
end
 
local function GetHolsteredWeaponTable(ply,indx)
    local class=IsTf2Class(ply) and playergettf2class(ply) or nil
    if !class then  return weaponsinfos[indx]
    else return (weaponsinfos[indx] && weaponsinfos[indx][class]) and weaponsinfos[indx][class] or nil
    end
end


local function playerdrawdamnit(pl,legs)
    if !IsValid(pl) then return end
    if !pl:GetWeapons() then return end
    local plLegs = playerLegs[pl]
    if !plLegs then return end
    for i,v in pairs(pl:GetWeapons()) do
        if GetHolsteredWeaponTable(pl, v:GetClass()) && (pl:GetActiveWeapon()==NULL || pl:GetActiveWeapon():GetClass()~=v:GetClass()) && clhasweapon(pl,v:GetClass()) then
            //if v:GetClass() != "god_stick" && pl:IsDisguised()  then return end
            if GetHolsteredWeaponTable(pl, v:GetClass()).Priority then
                local priority=GetHolsteredWeaponTable(pl,v:GetClass()).Priority
                local bol=GetHolsteredWeaponTable(pl,priority) && (pl:GetActiveWeapon()==NULL || pl:GetActiveWeapon():GetClass()!=priority) && clhasweapon(pl,priority)
                if bol then continue; end
            end
            local PlayerWeapon = GetHolsteredWeaponTable(pl, v:GetClass()).Model;
        if not isentity(PlayerWeapon) then return end  -- Add this line
            local oldpl=pl;
            local wep=clgetweapon(oldpl, v:GetClass())
       
            if legs && IsValid(legs) then
                pl=legs;
            end
            if legs && IsValid(legs) && (string.find(string.lower(GetHolsteredWeaponTable(oldpl, v:GetClass()).Bone),"spine") or string.find(string.lower(GetHolsteredWeaponTable(oldpl,v:GetClass()).Bone),"clavi") ) then
                pl=oldpl;
                continue;
            end
             
            local bone=plLegs:LookupBone(GetHolsteredWeaponTable(oldpl, v:GetClass()).Bone or "")
            if !bone then pl=oldpl;continue; end
 
             
            local matrix = plLegs:GetBoneMatrix(bone)
            if !matrix then pl=oldpl;continue; end
            local pos = matrix:GetTranslation()
            local ang = matrix:GetAngles()
            local pos=CalcOffset(pos,ang,GetHolsteredWeaponTable(oldpl, v:GetClass()).BoneOffset[1])
            if GetHolsteredWeaponTable(oldpl, v:GetClass()).Skin then PlayerWeapon:SetSkin(GetHolsteredWeaponTable(oldpl, v:GetClass()).Skin) end
             
            PlayerWeapon:SetRenderOrigin(pos)
             
            ang:RotateAroundAxis(ang:Forward(),GetHolsteredWeaponTable(oldpl, v:GetClass()).BoneOffset[2].p)
            ang:RotateAroundAxis(ang:Up(),GetHolsteredWeaponTable(oldpl, v:GetClass()).BoneOffset[2].y)
            ang:RotateAroundAxis(ang:Right(),GetHolsteredWeaponTable(oldpl, v:GetClass()).BoneOffset[2].r)
            PlayerWeapon:SetRenderAngles(ang)
            if PlayerWeapon.WorldModelVisible==nil || (PlayerWeapon.WorldModelVisible!=false) then
                PlayerWeapon:SetupBones()
                PlayerWeapon:DrawModel();
            end
            PlayerWeapon:SetRenderOrigin()
            PlayerWeapon:SetRenderAngles()
            if IsValid(PlayerWeapon.AttachedModel) then
                PlayerWeapon.AttachedModel:DrawModel();
            end
            if PlayerWeapon.WModelAttachment && multimodel then
                multimodel.Draw(PlayerWeapon.WModelAttachment, wep, {origin=pos, angles=ang})
                multimodel.DoFrameAdvance(PlayerWeapon.WModelAttachment, CurTime(),wep)
            end
             
            if GetHolsteredWeaponTable(oldpl, v:GetClass()).DrawFunction then
                GetHolsteredWeaponTable(oldpl, v:GetClass()).DrawFunction(PlayerWeapon,oldpl)
            end
            pl=oldpl;
        end
    end
end
local function drawlegsdamnit(legs)
    playerdrawdamnit(LocalPlayer(),legs)
end
 
hook.Add("PostLegsDraw","DrawOnLegs",drawlegsdamnit)
hook.Add("PostPlayerDraw","Draw",playerdrawdamnit)
-- Hook into the Initialize event of the game mode
hook.Add("Initialize", "PlayerLegsInitialize", function()
    PlayerLegs:Initialize()
end)
