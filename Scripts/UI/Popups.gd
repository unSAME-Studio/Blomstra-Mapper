extends CenterContainer

signal meta_edited


func _on_Open_button_down():
	$FileDialog.popup_centered()


func _on_Save_pressed():
	$FileDialogSave.set_current_file("%s.bstmap" % [SongTracker.songFile])
	
	$FileDialogSave.popup_centered()


func _on_Meta_pressed():
	$MetadataDialog/GridContainer/EditFile.set_text(SongTracker.songFile)
	$MetadataDialog/GridContainer/EditName.set_text(SongTracker.songName)
	$MetadataDialog/GridContainer/EditArtist.set_text(SongTracker.songArtist)
	$MetadataDialog/GridContainer/EditCreator.set_text(SongTracker.mapCreator)
	$MetadataDialog/GridContainer/EditDifficulty.set_text(SongTracker.mapDifficulty)
	
	$MetadataDialog.popup_centered()


func _on_MetadataDialog_confirmed():
	SongTracker.songFile = $MetadataDialog/GridContainer/EditFile.get_text()
	SongTracker.songName = $MetadataDialog/GridContainer/EditName.get_text()
	SongTracker.songArtist = $MetadataDialog/GridContainer/EditArtist.get_text()
	SongTracker.mapCreator = $MetadataDialog/GridContainer/EditCreator.get_text()
	SongTracker.mapDifficulty = $MetadataDialog/GridContainer/EditDifficulty.get_text()
	
	print(SongTracker.songName, SongTracker.songArtist)
	
	emit_signal("meta_edited")


func _on_FileDialogSave_file_selected(path):
	MapSaver.save_map_to_path(path)
	print(path)
