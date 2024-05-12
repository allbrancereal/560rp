
fsrp.devprint( "[WC-RP] - Fetching Model Library" )

SEX_FEMALE = 'f' || 1;
SEX_MALE = 'm' || 2;


CAM_LOOK_AT = {};
CAM_LOOK_AT[2] = Vector(-48.64869, 0, 54.05405);
CAM_LOOK_AT_CAMMODEL_POS = {};
CAM_LOOK_AT_CAMMODEL_POS[2] = Vector(54.05405454, 0, 54.0540);
CAM_LOOK_AT_CAMMODEL_POS[1] = Vector(43.24324323, 0, 59.4594559);
CAM_LOOK_AT[1] = Vector(-100, 10.8110811, 37.8378);
CAM_LOOK_AT[1] = CAM_LOOK_AT[1];
CAM_LOOK_AT[2] = CAM_LOOK_AT[2];

Model = {}
Model.__index = Model

function Model:new(path, name)
    local model = {}
    setmetatable(model, Model)
    model.path = path
    model.name = name
	model.beginner = true
	model.desc = true
    return model
end
local mdltbl = {
    [1] = {
        [1] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_04_hoodiepulloverjeans_pm.mdl", "Pullover Jeans", "", true),
        [2] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_04_hoodiepulloversweats_pm.mdl", "Pullover Sweats", "", true),
        [3] = Model:new("models/smalls_civilians/pack1/zipper_female_04_pm.mdl", "Zipper", "", true),
        [4] = Model:new("models/smalls_civilians/pack2/female/parkasweats/female_04_parkasweats_pm.mdl", "Parka Sweats", "", true),
        [5] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_04_hoodiezippedjeans_pm.mdl", "Zipper Jeans", "", true),
        [6] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_04_hoodiezippedsweats_pm.mdl", "Zipper Sweats", "", true),
        [7] = Model:new("models/smalls_civilians/pack2/female/parkajeans/female_04_parkajeans_pm.mdl", "Parka Jeans", "", true),
        [8] = Model:new("models/smalls_civilians/pack1/zipper_female_02_pm.mdl", "Zipper", "", true),
        [9] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_02_hoodiepulloversweats_pm.mdl", "Pullover Sweats", "", true),
        [10] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_02_hoodiepulloverjeans_pm.mdl", "Pullover Jeans", "", true),
        [11] = Model:new("models/smalls_civilians/pack2/female/parkajeans/female_02_parkajeans_pm.mdl", "Parka Jeans", "", true),
        [12] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_02_hoodiezippedjeans_pm.mdl", "Zipper Jeans", "", true),
        [13] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_02_hoodiezippedsweats_pm.mdl", "Zipper Sweats", "", true),
        [14] = Model:new("models/smalls_civilians/pack2/female/parkasweats/female_02_parkasweats_pm.mdl", "Parka Sweats", "", true),
        [15] = Model:new("models/smalls_civilians/pack2/female/parkasweats/female_01_parkasweats_pm.mdl", "Parka Sweats", "", true),
        [16] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_01_hoodiepulloversweats_pm.mdl", "Pullover Sweats", "", true),
        [17] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_01_hoodiepulloverjeans_pm.mdl", "Pullover Jeans", "", true),
        [18] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_01_hoodiezippedsweats_pm.mdl", "Zipper Sweats", "", true),
        [19] = Model:new("models/smalls_civilians/pack1/zipper_female_01_pm.mdl", "Zipper", "", true),
        [20] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_01_hoodiezippedjeans_pm.mdl", "Zipper Jeans", "", true),
        [21] = Model:new("models/smalls_civilians/pack2/female/parkajeans/female_01_parkajeans_pm.mdl", "Parka Jeans", "", true),
        [22] = Model:new("models/smalls_civilians/pack2/female/parkajeans/female_06_parkajeans_pm.mdl", "Parka Jeans", "", true),
        [23] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_06_hoodiezippedsweats_pm.mdl", "Zipper Sweats", "", true),
        [24] = Model:new("models/smalls_civilians/pack1/zipper_female_06_pm.mdl", "Zipper", "", true),
        [25] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_06_hoodiepulloverjeans_pm.mdl", "Pullover Jeans", "", true),
        [26] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_06_hoodiepulloversweats_pm.mdl", "Pullover Sweats", "", true),
        [27] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_06_hoodiezippedjeans_pm.mdl", "Zipper Jeans", "", true),
        [28] = Model:new("models/smalls_civilians/pack2/female/parkasweats/female_06_parkasweats_pm.mdl", "Parka Sweats", "", true),
        [29] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_03_hoodiepulloverjeans_pm.mdl", "Pullover Jeans", "", true),
        [30] = Model:new("models/smalls_civilians/pack1/zipper_female_03_pm.mdl", "Zipper", "", true),
        [31] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_03_hoodiezippedsweats_pm.mdl", "Zipper Sweats", "", true),
        [32] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_03_hoodiepulloversweats_pm.mdl", "Pullover Sweats", "", true),
        [33] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_03_hoodiezippedjeans_pm.mdl", "Zipper Jeans", "", true),
        [34] = Model:new("models/smalls_civilians/pack2/female/parkajeans/female_03_parkajeans_pm.mdl", "Parka Jeans", "", true),
        [35] = Model:new("models/smalls_civilians/pack2/female/parkasweats/female_03_parkasweats_pm.mdl", "Parka Sweats", "", true),
        [36] = Model:new("models/sentry/gtav/iaa/senvfenagntpm.mdl", "", "", true),
        [37] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_07_hoodiezippedjeans_pm.mdl", "Zipper Jeans", "", true),
        [38] = Model:new("models/smalls_civilians/pack2/female/parkasweats/female_07_parkasweats_pm.mdl", "Parka Sweats", "", true),
        [39] = Model:new("models/smalls_civilians/pack1/zipper_female_07_pm.mdl", "Zipper", "", true),
        [40] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_07_hoodiepulloversweats_pm.mdl", "Pullover Sweats", "", true),
        [41] = Model:new("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_07_hoodiezippedsweats_pm.mdl", "Zipper Sweats", "", true),
        [42] = Model:new("models/smalls_civilians/pack2/female/parkajeans/female_07_parkajeans_pm.mdl", "Parka Jeans", "", true),
        [43] = Model:new("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_07_hoodiepulloverjeans_pm.mdl", "Pullover Jeans", "", true),
    },
    [2] = {
        [1] = Model:new("models/smalls_civilians/pack1/hoodie_male_09_pm.mdl", "Hoodie", "", true),
        [2] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_09_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [3] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_09_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [4] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_09_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [5] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_09_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [6] = Model:new("models/smalls_civilians/pack1/puffer_male_09_pm.mdl", "Puffer", "", true),
        [7] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_09_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [8] = Model:new("models/smalls_civilians/pack2/male/flannel/male_09_flannel_pm.mdl", "Flannel", "", true),
        [9] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_09_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [10] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_07_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [11] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_07_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [12] = Model:new("models/smalls_civilians/pack1/puffer_male_07_pm.mdl", "Puffer", "", true),
        [13] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_07_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [14] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_07_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [15] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_07_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [16] = Model:new("models/smalls_civilians/pack2/male/flannel/male_07_flannel_pm.mdl", "Flannel", "", true),
        [17] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_07_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [18] = Model:new("models/smalls_civilians/pack1/hoodie_male_07_pm.mdl", "Hoodie", "", true),
        [19] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_05_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [20] = Model:new("models/smalls_civilians/pack1/hoodie_male_05_pm.mdl", "Hoodie", "", true),
        [21] = Model:new("models/smalls_civilians/pack2/male/flannel/male_05_flannel_pm.mdl", "Flannel", "", true),
        [22] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_05_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [23] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_05_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [24] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_05_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [25] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_05_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [26] = Model:new("models/smalls_civilians/pack1/puffer_male_05_pm.mdl", "Puffer", "", true),
        [27] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_05_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [28] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_03_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [29] = Model:new("models/smalls_civilians/pack1/hoodie_male_03_pm.mdl", "Hoodie", "", true),
        [30] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_03_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [31] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_03_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [32] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_03_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [33] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_03_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [34] = Model:new("models/smalls_civilians/pack1/puffer_male_03_pm.mdl", "Puffer", "", true),
        [35] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_03_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [36] = Model:new("models/smalls_civilians/pack2/male/flannel/male_03_flannel_pm.mdl", "Flannel", "", true),
        [37] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_04_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [38] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_04_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [39] = Model:new("models/smalls_civilians/pack1/hoodie_male_04_pm.mdl", "Hoodie", "", true),
        [40] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_04_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [41] = Model:new("models/smalls_civilians/pack1/puffer_male_04_pm.mdl", "Puffer", "", true),
        [42] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_04_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [43] = Model:new("models/smalls_civilians/pack2/male/flannel/male_04_flannel_pm.mdl", "Flannel", "", true),
        [44] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_04_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [45] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_04_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [46] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_01_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [47] = Model:new("models/smalls_civilians/pack1/puffer_male_01_pm.mdl", "Puffer", "", true),
        [48] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_01_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [49] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_01_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [50] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_01_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [51] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_01_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [52] = Model:new("models/smalls_civilians/pack1/hoodie_male_01_pm.mdl", "Hoodie", "", true),
        [53] = Model:new("models/smalls_civilians/pack2/male/flannel/male_01_flannel_pm.mdl", "Flannel", "", true),
        [54] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_01_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [55] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_02_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [56] = Model:new("models/smalls_civilians/pack2/male/flannel/male_02_flannel_pm.mdl", "Flannel", "", true),
        [57] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_02_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [58] = Model:new("models/smalls_civilians/pack1/hoodie_male_02_pm.mdl", "Hoodie", "", true),
        [59] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_02_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [60] = Model:new("models/smalls_civilians/pack1/puffer_male_02_pm.mdl", "Puffer", "", true),
        [61] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_02_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [62] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_02_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [63] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_02_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [64] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_08_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [65] = Model:new("models/smalls_civilians/pack2/male/flannel/male_08_flannel_pm.mdl", "Flannel", "", true),
        [66] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_08_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [67] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_08_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [68] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_08_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [69] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_08_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [70] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_08_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
        [71] = Model:new("models/smalls_civilians/pack2/male/baseballtee/male_06_baseballtee_pm.mdl", "Baseball Tee", "", true),
        [72] = Model:new("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_06_jacketvneck_sweatpants_pm.mdl", "Jacket Sweats", "", true),
        [73] = Model:new("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_06_hoodiesweatpants_pm.mdl", "Hoodie Sweats", "", true),
        [74] = Model:new("models/smalls_civilians/pack2/male/leatherjacket/male_06_leather_jacket_pm.mdl", "Leather Jacket", "", true),
        [75] = Model:new("models/smalls_civilians/pack2/male/flannel/male_06_flannel_pm.mdl", "Flannel", "", true),
        [76] = Model:new("models/smalls_civilians/pack2/male/jacket_open/male_06_jacketopen_pm.mdl", "Jacket Jeans", "", true),
        [77] = Model:new("models/smalls_civilians/pack2/male/hoodie_jeans/male_06_hoodiejeans_pm.mdl", "Hoodie Jeans", "", true),
    },
}
local function GetModelTable()
	return mdltbl 
end 
mdlTable = GetModelTable();

function ExplodeModelInfo ( path )
	local split = string.Explode("_", path);
	
	local newTable = {};
	
	newTable.sex = 1;
	if (split[1] == "2") then newTable.sex = 2; end
	
	newTable.id = tonumber(split[2]);
	//fsrp.devprintTable( newTable );
	return newTable;
end

function iterateModelTable( gender, id )
	if !gender then return end
	if !id then return end
	local newTable = {};
			
	if gender == 1 then
	
	for k ,v in pairs( mdlTable ) do
		
		//fsrp.devprint( k )
		if k == gender then
			newTable.id = id;
			newTable.sex = 1;
			newTable.mdl = mdlTable[k][id].path ;
			newTable.name = mdlTable[k][id].name;
			newTable.desc = mdlTable[k][id].desc;
			if mdlTable[k][id].desc then
				newTable.beginner = mdlTable[k][id].beginner;
			end
		end
		
	end
	
	elseif gender == 2 then 
	
	for k ,v in pairs( mdlTable ) do
		
		//fsrp.devprint( k )
		if k == gender then
			newTable.id = id;
			newTable.sex = 2;
			newTable.mdl = mdlTable[k][id].path ;
			newTable.name = mdlTable[k][id].name;
			newTable.desc = mdlTable[k][id].desc;
			if mdlTable[k][id].beginner then
				newTable.beginner = mdlTable[k][id].beginner;
			end
		end
		
	end
	
	end
	//fsrp.devprintTable( newTable )
	return newTable;
end
local plyMeta = FindMetaTable('Player');
function plyMeta:GetModelPath( g ,id )

	return iterateModelTable( g, id );
		
end
function tryThis( )
local Models = {};

		local id = 1
		for k, v in pairs(mdlTable) do 
		if mdlTable[k] == "f" then
				
			local iterator = iterateModelTable( 1, id );
				
			if iterator.beginner then
				table.insert(Models, {1, id }); 
			end
			id = id + 1;
		end
		id = 0;
		if mdlTable[k] == "m" then
			local iterator = iterateModelTable( 1, id );
			if iterator.beginner then
				table.insert(Models, {2, id }); 
				
			end
			id = id + 1;
		end
	
	end
	//fsrp.devprintTable(Models)
end

function PreCacheAllCivillianModels()
	if !SERVER then return end
	for k , v in pairs( mdlTable[2] ) do
		util.PrecacheModel( v.path )
	end
	for k , v in pairs( mdlTable[1] ) do
		util.PrecacheModel( v.path )

	end
	/*
	for k , v in pairs( jobMdlTable[TEAM_PARAMEDIC][1] ) do
		util.PrecacheModel( v.model )

	end
	for k , v in pairs( jobMdlTable[TEAM_PARAMEDIC][2] ) do
		util.PrecacheModel( v.model )

	end

	for k , v in pairs( jobMdlTable[TEAM_POLICE][2] ) do
		util.PrecacheModel( v.model )

	end
	*/
	local _vList = list.Get( "Vehicles" )
	for k , v in pairs (ITEMLIST) do
		
		if v.Model then
			util.PrecacheModel(v.Model)
		end
	end
	
end
fsrp.devprint( "[WC-RP] - Accquired Model Library" )
