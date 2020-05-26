extends CenterContainer

signal meta_edited


func _on_Open_button_down():
	$FileDialog.popup_centered()


func _on_Meta_pressed():
	$MetadataDialog/GridContainer/EditName.set_text(SongTracker.songName)
	$MetadataDialog/GridContainer/EditArtist.set_text(SongTracker.songArtist)
	$MetadataDialog/GridContainer/EditCreator.set_text(SongTracker.mapCreator)
	$MetadataDialog/GridContainer/EditDifficulty.set_text(SongTracker.mapDifficulty)
	
	$MetadataDialog.popup_centered()


func _on_MetadataDialog_confirmed():
	SongTracker.songName = $MetadataDialog/GridContainer/EditName.get_text()
	SongTracker.songArtist = $MetadataDialog/GridContainer/EditArtist.get_text()
	SongTracker.mapCreator = $MetadataDialog/GridContainer/EditCreator.get_text()
	SongTracker.mapDifficulty = $MetadataDialog/GridContainer/EditDifficulty.get_text()
	
	print(SongTracker.songName, SongTracker.songArtist)
	
	emit_signal("meta_edited")
