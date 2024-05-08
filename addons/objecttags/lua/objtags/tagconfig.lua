

if ObjectTags.ShowDebugPrints then

	print( "Including Object Tag Config.")

end

ObjectTags = ObjectTags || {};
ObjectTags.config = {};

ObjectTags.config.SaveMode = 1// 0 = SQL, 1 = MySQL, 2 = txt files;
ObjectTags.config.SaveLocation = "entitytags/" // Folder Relative to garrysmod/data/
ObjectTags.config.SQLTableName = "" // Relative to save method 0;