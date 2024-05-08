
if SERVER then

	AddCSLuaFile()
	
	SWEP.Weight = 5;
	
	SWEP.AutoSwitchTo = false;
	SWEP.AutoSwitchFrom = false

end


SWEP.PrintName		= "Orange Sign Soapstone"
SWEP.Base			= "swep_cons_base"
SWEP.Author 		= "Mario S."
SWEP.Contact 		= "sk8tra@gmail.com"
SWEP.Purpose 		= "Emits a sound based on it's type when thrown."
SWEP.Instructions 	= "Reload to hold normally. Right Click to ready your throw, Left Click to throw on the ground."


if CLIENT then

	SWEP.Slot			= 2
	SWEP.SlotPos		= 4

	SWEP.DrawAmmo 		= false;
	SWEP.SwayScale 		= 2;
	SWEP.DrawCrosshair 	= false;

end

SWEP.Primary.ClipSize	 	= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Secondary.ClipSize	 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic		= false
SWEP.Secondary.Ammo			= "none"
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

//The category that you SWep will be shown in, in the Spawn (Q) Menu 
//(This can be anything, GMod will create the categories for you)
//SWEP.Category = "Orange Sign Soapstone"


SWEP.Spawnable = true
SWEP.AdminSpawnable = true;
SWEP.HoldType = "fist"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = ""
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true


    local _TEMPLATES = {
        '**** ahead',
        'No **** ahead',
        '**** required ahead',
        'be wary of ****',
        'try ****',
        'Could this be a ****?',
        'If only I had a ****...',
        'visions of ****...',
        'Time for ****',
        '****',
        '****!',
        '****?',
        '****...',
        'Huh. It\'s a ****...',
        'praise the ****!',
        'Let there be ****',
        'Ahh, ****...'
    };

    local _CONJUNCTIONS = {
        '',
		'but',
        'and then',
        'therefore',
        'in short',
        'or',
        'only',
        'by the way',
        'so to speak',
        'all the more',
        ','
    };
    
    local _CATEGORIES = {
        ['Creatures'] = {
            'enemy',
			'horse',
            'monster',
            'mob enemy',
            'tough enemy',
            'critical foe',
            'Hollow',
            'pilgrim',
            'prisoner',
            'monstrosity',
            'skeleton',
            'ghost',
            'beast',
            'lizard',
            'bug',
            'grub',
            'crab',
            'dwarf',
            'giant',
            'demon',
            'dragon',
            'knight',
            'sellword',
            'warrior',
            'herald',
            'bandit',
            'assassin',
            'sorcerer',
            'pyromancer',
            'cleric',
            'deprived',
            'sniper',
            'duo',
            'trio',
            'you',
            'you bastard',
            'good fellow',
            'saint',
            'wretch',
            'charmer',
            'poor soul',
            'oddball',
            'nimble one',
            'laggard',
            'moneybags',
            'beggar',
            'miscreant',
            'liar',
            'fatty',
            'beanpole',
            'youth',
            'elder',
            'old codger',
            'old dear',
            'merchant',
            'artisan',
            'master',
            'sage',
            'champion',
            'Lord of Cinder',
            'king',
            'queen',
            'prince',
            'princess',
            'angel',
            'god',
            'friend',
            'ally',
            'spouse',
            'covenantor',
            'Phantom',
            'Dark Spirit'
        },
        ['Objects'] = {
            'bonfire',
            'ember',
            'fog wall',
            'lever',
            'contraption',
            'key',
            'trap',
            'torch',
            'door',
            'treasure',
            'chest',
            'something',
            'quite something',
            'rubbish',
            'filth',
            'weapon',
            'shield',
            'projectile',
            'armor',
            'item',
            'ring',
            'ore',
            'coal',
            'transposing kiln',
            'scroll',
            'umbral ash',
            'throne',
            'rite',
            'coffin',
            'cinder',
            'ash',
            'moon',
            'eye',
            'brew',
            'soup',
            'message',
            'bloodstain',
            'illusion'
        },
        ['Techniques'] = {
            'close-ranged battle',
            'ranged battle',
            'eliminating one at a Time',
            'luring it out',
            'beating to a pulp',
            'ambush',
            'pincer attack',
            'hitting them in one swoop',
            'duel-wielding',
            'stealth',
            'mimicry',
            'fleeing',
            'charging',
            'jumping off',
            'dashing through',
            'circling around',
            'trapping inside',
            'rescue',
            'Skill',
            'sorcery',
            'pyromancy',
            'miracles',
            'pure luck',
            'prudence',
            'brief respite',
            'play dead'
        },
        ['Actions'] = {
            'jog',
            'dash',
            'rolling',
            'backstepping',
            'jumping',
            'attacking',
            'jump attack',
            'dash attack',
            'counter attack',
            'stabbing in the back',
            'guard stun & stab',
            'plunging attack',
            'shield breaking',
            'blocking',
            'parrying',
            'locking-on',
            'no lock-on',
            'two-handing',
            'gesture',
            'control',
            'destroy'
        },
        ['Geography'] = {
            'boulder',
            'lava',
            'poison gas',
            'enemy horde',
            'forest',
            'swamp',
            'cave',
            'shortcut',
            'detour',
            'hidden path',
            'secret passage',
            'dead end',
            'labyrinth',
            'hole',
            'bright spot',
            'dark spot',
            'open area',
            'tight spot',
            'safe zone',
            'danger zone',
            'sniper spot',
            'hiding place',
            'illusory wall',
            'ladder',
            'lift',
            'gorgeous view',
            'looking away',
            'overconfidence',
            'slip-up',
            'oversight',
            'fatigue',
            'bad luck',
            'inattention',
            'loss of stamina',
            'chance encounter',
            'planned encounter'
        },
        ['Orientation'] = {
            'front',
            'back',
            'left',
            'right',
            'up',
            'down',
            'below',
            'above',
            'behind'
        },
        ['Body parts'] = {
            'head',
            'neck',
            'stomach',
            'back',
            'armor',
            'finger',
            'leg',
            'rear',
            'tail',
            'wings',
            'anywhere',
            'tongue',
            'right arm',
            'left arm',
            'thumb',
            'indexfinger',
            'longfinger',
            'ringfinger',
            'smallfinger',
            'right leg',
            'left leg',
            'right side',
            'left side',
            'pincer',
            'wheel',
            'core',
            'mount'
        },
        ['Attribute'] = {
            'regular',
            'strike',
            'thrust',
            'slash',
            'magic',
            'crystal',
            'fire',
            'chaos',
            'lightning',
            'blessing',
            'dark',
            'critical hits',
            'bleeding',
            'poison',
            'toxic',
            'frost',
            'curse',
            'equipment breakage'
        },
        ['Concepts'] = {
            'chance',
            'quagmire',
            'hint',
            'secret',
            'sleeptalk',
            'happiness',
            'misfortune',
            'life',
            'death',
            'demise',
            'joy',
            'fury',
            'agony',
            'sadness',
            'tears',
            'loyalty',
            'betrayal',
            'hope',
            'despair',
            'fear',
            'losing sanity',
            'victory',
            'defeat',
            'sacrifice',
            'light',
            'dark',
            'bravery',
            'confidence',
            'vigor',
            'revenge',
            'resignation',
            'overwhelming',
            'regret',
            'pointless',
            'man',
            'woman',
            'friendship',
            'love',
            'recklessness',
            'composure',
            'guts',
            'comfort',
            'silence',
            'deep',
            'dregs',
        },
        ['Musings'] = {
            'good luck',
            'fine work',
            'I did it!',
            'I\'ve failed...',
            'here!',
            'not here!',
            'I can\'t take this...',
            'lonely...',
            'don\'t you dare!',
            'do it!',
            'look carefully',
            'listen carefully',
            'think carefully',
            'this place again?',
            'now the real fight begins',
            'you don\'t deserve this',
            'keep moving',
            'pull back',
            'give it up',
            'don\'t give up',
            'help me...',
            'impossible...',
            'bloody expensive...',
            'let me out of here...',
            'stay calm',
            'like a dream...',
            'seems familiar...',
            'are you ready?',
            'it\'ll happen to you too',
            'praise the Sun!',
            'may the flames guide thee',
        }
    };

SWEP.VElements = {
	["chunk"] = { type = "Model", model = "models/props_debris/concrete_column001a_chunk01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, -0.519), angle = Angle(90, 0, -78.312), size = Vector(2.637, 1.534, 1.858), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["soapstone_wmodel"] = { type = "Model", model = "models/props_debris/concrete_column001a_chunk01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, 2.596), angle = Angle(0, -180, 180), size = Vector(0.172, 0.172, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Initialize()

	self:SetHoldType("fist")
end

if SERVER then

	util.AddNetworkString("sendPlayerMessageBoard")
	util.AddNetworkString("sendServerSoap")

else

	net.Receive( "sendPlayerMessageBoard" , function ( _l , _p )

		DrawMessageCreator()

	end ) 

end


function SWEP:PrimaryAttack()
	
		
	self:SecondaryAttack()
	
end

function SWEP:SecondaryAttack()
		
	if CLIENT then return end
	
	for k , v in pairs(ents.FindInSphere(self.Owner:GetPos(),85)) do
		
		if v:GetClass() == "prop_door_rotating" or v:GetClass() == "func_door" then
			local _p = self.Owner;
			_p:Notify("Your sign has not been placed because you are near a door.")
			return
		end
		
	end
	net.Start("sendPlayerMessageBoard")
	net.Send( self.Owner ) 
		

end

function GetMessageFromTable( tb )


		local _SelectedTbl = tb;
		local _tmp1 , _wrd1 , _conj , _tmp2 , _wrd2 = "", "", "", "", "";
		
		if !_SelectedTbl then return end
		
		if _SelectedTbl.Template_1 > 0 then
		
			_tmp1 = _TEMPLATES[ _SelectedTbl.Template_1 ] || "";
		
		end
		
		if _SelectedTbl.Word_1_Cat != "" && _SelectedTbl.Word_1 > 0 then
			
			_wrd1 = _CATEGORIES[ _SelectedTbl.Word_1_Cat ][ _SelectedTbl.Word_1 ] || "";
		
		end
		
		if _SelectedTbl.Conjunction > 0 then
		
			_conj = _CONJUNCTIONS[ _SelectedTbl.Conjunction ] || "";
		
		end
		
		if _SelectedTbl.Template_2 > 0 then
		
			_tmp2 = _TEMPLATES[ _SelectedTbl.Template_2 ] || "";
	
		end
		
		if _SelectedTbl.Word_2_Cat != "" &&  _SelectedTbl.Word_2 > 0 then
		
			_wrd2 = _CATEGORIES[ _SelectedTbl.Word_2_Cat ][ _SelectedTbl.Word_2 ] || "";

		end
		
		local _Part_1, _Part_2 = "", "";
		
		if _wrd1 != "" then
		
			_Part_1 = string.Replace( _tmp1 , "****" , _wrd1 )
			
		end
		
		local _Sentence = _Part_1
		
		if _conj != "" then
			
			_Sentence = _Sentence .. " " .. _conj 
			
		end		
		
		if _wrd2 != "" then
		
			_Part_2 = string.Replace( _tmp2 , "****" , _wrd2 )
			
		end
		
		if _Part_2 != "" then
		
			_Sentence = _Sentence .. " " .. _Part_2;
		end
		
		
		return _Sentence
		
		//local _Sentence = _tmp1 .. _wrd1 .. _conj .. _tmp2 .. _wrd2;
		
		//_MessageCreatorFrame.Message = _Sentence
	
	
	
	
end

if SERVER then

	/* Table structure */
	/*_MessageCreatorFrame.Selected = {
		Template_1 	= -1,
		Word_1	   	= -1,
		Conjunction	= -1,
		Template_2  = -1,
		Word_2		= -1,
		Word_1_Cat  = "",
		Word_2_Cat  = "",
		Permanent = false,
		shouldAlwaysShow = false,
	}*/
	net.Receive( "sendServerSoap" , function( _l , _p )
		foundSigns = 0 
		local _SoapTable = net.ReadTable( )
		for k , v in pairs( ents.FindInSphere( _p:GetPos(), 150 ) ) do
			if v:GetClass() == "soapstonewriting" then
				foundSigns = foundSigns + 1;
			end
			
		end



		if foundSigns > 0 then return _p:ChatPrint("You are too close to another sign!") end
		
		if _SoapTable.Permanent == true && !_p:IsSuperAdmin() then
		
			return _p:ChatPrint("Oh no you didn't");
		
		end
		
		if _SoapTable.shouldAlwaysShow == true && !_p:IsSuperAdmin() then
		
			return _p:ChatPrint("Oh no you didn't");
		
		end
		
		DrawSoapstone( _p , _SoapTable, true )
		
	end ) 
	
end

function DrawSoapstone( caller, _tbL, save )

	local _sentenceWriting = util.TableToJSON(_tbL)
    local msgToSave = {};
	/*
        tabletomessage.Template_1   = jsonMsgToTable.T1,
        tabletomessage.Word_1       = jsonMsgToTable.W1,
        tabletomessage.Conjunction  = jsonMsgToTable.CNJ,
        tabletomessage.Template_2  =  jsonMsgToTable.T2,
        tabletomessage.Word_2       = jsonMsgToTable.W2,
        tabletomessage.Word_1_Cat  = jsonMsgToTable.W1C,
        tabletomessage.Word_2_Cat  = jsonMsgToTable.W2C,
        tabletomessage.Permanent = jsonMsgToTable.P,
        tabletomessage.shouldAlwaysShow = jsonMsgToTable.AS,
    */
    msgToSave.T1 =  _tbL.Template_1;
    msgToSave.W1 =  _tbL.Word_1;
    msgToSave.CNJ = _tbL.Conjunction;
    msgToSave.T2 = _tbL.Template_2
    msgToSave.W2 = _tbL.Word_2;
    msgToSave.W1C = _tbL.Word_1_Cat
    msgToSave.W2C = _tbL.Word_2_Cat;
    msgToSave.P = _tbL.Permanent;
    msgToSave.AS = _tbL.shouldAlwaysShow;
    
    local _sentenceWriting = util.TableToJSON(msgToSave)

	if save then
	
		insertnewSign( _sentenceWriting, caller:SteamID(), caller:getRPName(), game.GetMap(), caller:GetPos(), caller:GetAngles(), _tbL.Permanent, _tbL.shouldAlwaysShow )
	
	end
	
	local _signEnt = ents.Create( "soapstonewriting" ) 
	_signEnt:SetPos( caller:GetPos() + Vector( 0,0,2 ) )
	caller:SetPos( caller:GetPos() + Vector( 0,0,10 ) )
	local _angl = caller:GetAngles();
	//self.PublicInfo = { Sentence = "", upVotes = 0, downVotes = 0, userID = "" };
	
	_signEnt:Spawn()
	_signEnt:SetPublicInformation( { Sentence = GetMessageFromTable(_tbL), upVotes = 0, downVotes = 0, userName = caller:getRPName() } )
	_signEnt:DropToFloor()
	
	
end

function SWEP:Reload()

end