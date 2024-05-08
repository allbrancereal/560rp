
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
	
	// Template
	// Words -> Categories -> Selected Category
	// Conjunctions
	// Templates 2
	// Words 2 -> Categories - Selected Category
	
	
function DrawMessageCreator( )
	
	local _MessageCreatorFrame = vgui.Create( "DFrame" )
	
	_MessageCreatorFrame:ShowCloseButton( true )
	_MessageCreatorFrame:SetSize( 300, 300 )
	_MessageCreatorFrame:SetTitle( "Message Creator" )
	
	_MessageCreatorFrame:Center()
	_MessageCreatorFrame:MakePopup()
	
	_MessageCreatorFrame.Selected = {
		Template_1 	= -1,
		Word_1	   	= -1,
		Conjunction	= -1,
		Template_2  = -1,
		Word_2		= -1,
		Word_1_Cat  = "",
		Word_2_Cat  = "",
		Permanent = false,
		shouldAlwaysShow = false,
	}
	_MessageCreatorFrame.Message = ""
	
	function _MessageCreatorFrame:Paint( w , h )
	
		draw.RoundedBoxEx( 0, 0, 0, w, h , Color( 56, 56, 56 , 128 ) );
		draw.RoundedBoxEx( 0, 0, 0, w, 25 , Color( 56, 56, 56 , 128 ) );
		
		draw.SimpleText( _MessageCreatorFrame.Message , "DermaDefault", 5, h * 0.85 )
	end
	
	
	function _MessageCreatorFrame:UpdateMessage()
		local _SelectedTbl = _MessageCreatorFrame.Selected;
		local _tmp1 , _wrd1 , _conj , _tmp2 , _wrd2 = "", "", "", "", "";
		
		if _SelectedTbl.Template_1 > 0 then
		
			_tmp1 = _TEMPLATES[ _SelectedTbl.Template_1 ] || "";
		
		else
		
			_MessageCreatorFrame.Accept:SetEnabled( false )
				
				
		end
		
		if _SelectedTbl.Word_1_Cat != "" && _SelectedTbl.Word_1 > 0 then
			
			_wrd1 = _CATEGORIES[ _SelectedTbl.Word_1_Cat ][ _SelectedTbl.Word_1 ] || "";
		
		else
		
			_MessageCreatorFrame.Accept:SetEnabled( false )
				
		end
		
		if _SelectedTbl.Conjunction > 0 then
		
			_conj = _CONJUNCTIONS[ _SelectedTbl.Conjunction ] || "";
		
		else
		
			_MessageCreatorFrame.Accept:SetEnabled( false )
				
		end
		
		if _SelectedTbl.Template_2 > 0 then
		
			_tmp2 = _TEMPLATES[ _SelectedTbl.Template_2 ] || "";
	
		else
		
			_MessageCreatorFrame.Accept:SetEnabled( false )
				
		end
		
		if _SelectedTbl.Word_2_Cat != "" &&  _SelectedTbl.Word_2 > 0 then
		
			_wrd2 = _CATEGORIES[ _SelectedTbl.Word_2_Cat ][ _SelectedTbl.Word_2 ] || "";

		else
		
			_MessageCreatorFrame.Accept:SetEnabled( false )
				
		end
		
		local _Part_1, _Part_2 = "", "";
		
		if _wrd1 != "" then
		
			_Part_1 = string.Replace( _tmp1 , "****" , _wrd1 )
			
			if !_MessageCreatorFrame.Accept:IsEnabled( ) then
			
				_MessageCreatorFrame.Accept:SetEnabled( true )
				
			end
			
		end
		
		local _Sentence = _Part_1
		
		if _conj != "" then
			
			_Sentence = _Sentence .. " " .. _conj 
			
			_MessageCreatorFrame.Accept:SetEnabled( false )
			
		end		
		
		if _wrd2 != "" then
			
			if !_MessageCreatorFrame.Accept:IsEnabled( ) then
			
				_MessageCreatorFrame.Accept:SetEnabled( true )
				
			end
			
			_Part_2 = string.Replace( _tmp2 , "****" , _wrd2 )
			
		end
		
		if _Part_2 != "" then
		
			_Sentence = _Sentence .. " " .. _Part_2;
		end
		
		
		_MessageCreatorFrame.Message = _Sentence
		
		//local _Sentence = _tmp1 .. _wrd1 .. _conj .. _tmp2 .. _wrd2;
		
		//_MessageCreatorFrame.Message = _Sentence
	
	
	end
	
	_MessageCreatorFrame.ActionPanel = vgui.Create( "DPanel" , _MessageCreatorFrame )
	_MessageCreatorFrame.ActionPanel:SetSize( _MessageCreatorFrame:GetWide()  -10, 225 )
	_MessageCreatorFrame.ActionPanel:SetPos( 5, 25 )
	
	function _MessageCreatorFrame.ActionPanel:Paint( w, h )
	
		draw.RoundedBoxEx( 0, 0, 0 , w, h , Color( 128 , 128 ,128 , 128 ) )
	
	end
	
	_MessageCreatorFrame.ActionPanel.ActionBox = vgui.Create( "DScrollPanel" , _MessageCreatorFrame.ActionPanel )
	_MessageCreatorFrame.ActionPanel.ActionBox:SetSize( _MessageCreatorFrame.ActionPanel:GetWide() , _MessageCreatorFrame.ActionPanel:GetTall() )
	
	_MessageCreatorFrame.Template_1 = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Template_1:GetPos();
	
	_tempX = _tempX + 60;
	
	_MessageCreatorFrame.Template_1:SetPos( _tempX + 40 , _tempY + 8.5)
	_MessageCreatorFrame.Template_1:SetValue( "Templates " )
	_MessageCreatorFrame.Template_1:SetSize( 150 , 30 )
	
	for k , v in pairs( _TEMPLATES ) do
	
		_MessageCreatorFrame.Template_1:AddChoice( v )
		
	end
		
	function _MessageCreatorFrame.Template_1:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Template_1 = index;
		_MessageCreatorFrame:UpdateMessage()
		
		if !_MessageCreatorFrame.Category_01:IsVisible() || value != "" then
		
			_MessageCreatorFrame.Category_01:SetEnabled( true )
			_MessageCreatorFrame.Category_01:RefreshChoices()
			
		end
		
	end
	
	// Category for word 1
	_MessageCreatorFrame.Category_01 = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Category_01:GetPos();
	
	_MessageCreatorFrame.Category_01:SetPos( _tempX + 5 , _tempY + 42.5)
	_MessageCreatorFrame.Category_01:SetValue( "Categories " )
	_MessageCreatorFrame.Category_01:SetEnabled( false )
	_MessageCreatorFrame.Category_01:SetSize( 75 , 30 )
	
		
	function _MessageCreatorFrame.Category_01:RefreshChoices()
		
		table.Empty( _MessageCreatorFrame.Category_01.Choices )
		
	
		for k , v in pairs( _CATEGORIES ) do
		
			_MessageCreatorFrame.Category_01:AddChoice( k )
			
		end
		
	end
	function _MessageCreatorFrame.Category_01:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Word_1_Cat = value;
		
		table.Empty( _MessageCreatorFrame.Word_01.Choices )
			
		for k , v in pairs( _CATEGORIES[value] ) do
			
			_MessageCreatorFrame.Word_01:AddChoice( v )
			
		end
			
		_MessageCreatorFrame:UpdateMessage()
		
		if !_MessageCreatorFrame.Word_01:IsVisible() || value != "" then
		
				
				
			_MessageCreatorFrame.Word_01:SetEnabled( true )
			
		end
		
	end
	
	
	// Word 1 Selection
	_MessageCreatorFrame.Word_01 = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Word_01:GetPos();
	
	_MessageCreatorFrame.Word_01:SetPos( _tempX + 100 , _tempY + 42.5)
	_MessageCreatorFrame.Word_01:SetEnabled( false )
	_MessageCreatorFrame.Word_01:SetSize( 150 , 30 )
	
		
	function _MessageCreatorFrame.Word_01:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Word_1 = index;
		_MessageCreatorFrame:UpdateMessage()
		
		if !_MessageCreatorFrame.Conjunction:IsVisible() || value != "" then
		
				
				
			_MessageCreatorFrame.Conjunction:SetEnabled( true )
			
		end
		
	end
	
	_MessageCreatorFrame.Conjunction = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Conjunction:GetPos();
	
	_MessageCreatorFrame.Conjunction:SetPos( _tempX + 100 , _tempY + 76.5)
	_MessageCreatorFrame.Conjunction:SetValue( "Conjunctions " )
	_MessageCreatorFrame.Conjunction:SetEnabled( false )
	_MessageCreatorFrame.Conjunction:SetSize( 150 , 30 )
	
	
	for k , v in pairs( _CONJUNCTIONS ) do
	
		_MessageCreatorFrame.Conjunction:AddChoice( v )
		
	end
		
	function _MessageCreatorFrame.Conjunction:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Conjunction = index;
		_MessageCreatorFrame:UpdateMessage()
		
			
		if !_MessageCreatorFrame.Template_2:IsVisible() || value != "" then
		
			_MessageCreatorFrame.Template_2:SetEnabled( true )
			_MessageCreatorFrame.Template_2:RefreshChoices()
			
		end
		
	end
	
	
	// PART 2
	
		
	_MessageCreatorFrame.Template_2 = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Template_2:GetPos();
	
	_MessageCreatorFrame.Template_2:SetPos( _tempX + 100 , _tempY + 110.5)
	_MessageCreatorFrame.Template_2:SetValue( "Templates " )
	_MessageCreatorFrame.Template_2:SetEnabled( false )
	_MessageCreatorFrame.Template_2:SetSize( 150 , 30 )
	
	function _MessageCreatorFrame.Template_2:RefreshChoices()
	
		
		table.Empty( _MessageCreatorFrame.Template_2.Choices )
		
		for k , v in pairs( _TEMPLATES ) do
		
			_MessageCreatorFrame.Template_2:AddChoice( v )
			
		end

	end
	
	function _MessageCreatorFrame.Template_2:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Template_2 = index;
		_MessageCreatorFrame:UpdateMessage()
		
		if !_MessageCreatorFrame.Category_02:IsVisible() || value != "" then
		
			_MessageCreatorFrame.Category_02:SetEnabled( true )
			_MessageCreatorFrame.Category_02:RefreshChoices()
			
		end
		
	end
	
	// Category for word 1
	_MessageCreatorFrame.Category_02 = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Category_02:GetPos();
	
	_MessageCreatorFrame.Category_02:SetPos( _tempX + 5 , _tempY + 144.5)
	_MessageCreatorFrame.Category_02:SetValue( "Categories " )
	_MessageCreatorFrame.Category_02:SetEnabled( false )
	_MessageCreatorFrame.Category_02:SetSize( 75 , 30 )
	
		
	function _MessageCreatorFrame.Category_02:RefreshChoices()
		
		table.Empty( _MessageCreatorFrame.Category_02.Choices )
		
	
		for k , v in pairs( _CATEGORIES ) do
		
			_MessageCreatorFrame.Category_02:AddChoice( k )
			
		end
		
	end
	function _MessageCreatorFrame.Category_02:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Word_2_Cat = value;
		
		table.Empty( _MessageCreatorFrame.Word_02.Choices )
			
		for k , v in pairs( _CATEGORIES[value] ) do
			
			_MessageCreatorFrame.Word_02:AddChoice( v )
			
		end
			
		_MessageCreatorFrame:UpdateMessage()
		
		if !_MessageCreatorFrame.Word_02:IsVisible() || value != "" then
		
				
				
			_MessageCreatorFrame.Word_02:SetEnabled( true )
			
		end
		
	end
	
	
	// Word 1 Selection
	_MessageCreatorFrame.Word_02 = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DComboBox" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Word_02:GetPos();
	
	_MessageCreatorFrame.Word_02:SetPos( _tempX + 100 , _tempY + 144.5)
	_MessageCreatorFrame.Word_02:SetEnabled( false )
	_MessageCreatorFrame.Word_02:SetSize( 150 , 30 )	
		
	function _MessageCreatorFrame.Word_02:OnSelect( index, value, data )

		_MessageCreatorFrame.Selected.Word_2 = index;
		_MessageCreatorFrame:UpdateMessage()
		
		if !_MessageCreatorFrame.Conjunction:IsVisible() || value != "" then
		
				
				
			_MessageCreatorFrame.Conjunction:SetEnabled( true )
			
		end
		
	end
	
	_MessageCreatorFrame.Accept = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DButton" )
	
	local _tempX , _tempY = _MessageCreatorFrame.Accept:GetPos();
	
	_MessageCreatorFrame.Accept:SetPos( _tempX  + 5, _tempY + 144.5+34 )
	_MessageCreatorFrame.Accept:SetVisible( true )
	_MessageCreatorFrame.Accept:SetEnabled( false )
	_MessageCreatorFrame.Accept:SetText( "Accept" )
	_MessageCreatorFrame.Accept:SetSize( 75 , 30 )	
	function _MessageCreatorFrame.Accept:DoClick( )
		foundSigns = 0 
		for k , v in pairs( ents.FindInSphere( LocalPlayer():GetPos(), 150 ) ) do
			if v:GetClass() == "soapstonewriting" then
				foundSigns = foundSigns + 1;
			end
			
		end



		if foundSigns > 0 then return LocalPlayer():ChatPrint("You are too close to another sign!") end
		
		net.Start("sendServerSoap")
			net.WriteTable( _MessageCreatorFrame.Selected )
		net.SendToServer()
	
	end
	
	if LocalPlayer():IsSuperAdmin() then
	
	_MessageCreatorFrame.PermanentBool = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DCheckBoxLabel" )
	
	local _tempX , _tempY = _MessageCreatorFrame.PermanentBool:GetPos();
	
	_MessageCreatorFrame.PermanentBool:SetPos( _tempX + 100 , _tempY + 144.5 + 34)
	_MessageCreatorFrame.PermanentBool:SetVisible( true )
	_MessageCreatorFrame.PermanentBool:SetText( "(Administrator) Permanent?" )
	_MessageCreatorFrame.PermanentBool:SetEnabled( LocalPlayer():IsSuperAdmin() )
	function _MessageCreatorFrame.PermanentBool:OnChange( bool )
	
		_MessageCreatorFrame.Selected.Permanent = bool;
		
	end
	//_MessageCreatorFrame.Accept:SetSize( 75 , 30 )	
	_MessageCreatorFrame.AlwaysShow = _MessageCreatorFrame.ActionPanel.ActionBox:Add( "DCheckBoxLabel" )
	
	local _tempX , _tempY = _MessageCreatorFrame.AlwaysShow:GetPos();
	
	_MessageCreatorFrame.AlwaysShow:SetPos( _tempX + 100 , _tempY + 144.5 + 25 * 2)
	_MessageCreatorFrame.AlwaysShow:SetVisible( true )
	_MessageCreatorFrame.AlwaysShow:SetText( "(Administrator) Always show?" )
	_MessageCreatorFrame.AlwaysShow:SetEnabled( LocalPlayer():IsSuperAdmin() )
	function _MessageCreatorFrame.AlwaysShow:OnChange( bool )
	
		_MessageCreatorFrame.Selected.shouldAlwaysShow = bool;
		
	end
	
	end
	
end


	/* 
	
	
            var words = _.chain(CATEGORIES).values().flatten().value();
            
            var templateOneCode = parseInt($scope.templateIndexOne).toString(17);
            var wordOneCode = _.indexOf(words, $scope.wordOne).toString(36);
            if (wordOneCode.length === 1) {
                wordOneCode = '0' + wordOneCode;
            }
            $scope.code = templateOneCode + wordOneCode;
            
            var conjunctionIndex = parseInt($scope.conjunctionIndex);
            if (conjunctionIndex && conjunctionIndex !== 0 && $scope.wordTwo) {
                var conjunctionCode = (conjunctionIndex - 1).toString(10);
                var templateTwoCode = parseInt($scope.templateIndexTwo).toString(17);
                var wordTwoCode = _.indexOf(words, $scope.wordTwo).toString(36);
                if (wordTwoCode.length === 1) {
                    wordTwoCode = '0' + wordTwoCode;
                }
                $scope.code = $scope.code + conjunctionCode + templateTwoCode + wordTwoCode; */