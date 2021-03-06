extends VBoxContainer

var position_min = 0
var position_sec = 0

var duration_min = 0
var duration_sec = 0


func reset_ui():
	$SongName.set_text("No Music")
	$HBoxContainer/SongPosition.set_text("00:00 / 00:00")
	
	$HBoxContainer/TimeSlider.set_value(0.0)
	
	# Reset play button
	$"../Play".reset()
	
	# Reset Volume Slider
	$"../VBoxContainer/SliderControls/VolumeSlider".set_value(25)


func set_song_position(sec):
	# warning-ignore:integer_division
	position_min = int(sec) / 60 % 60
	position_sec = int(sec) % 60
	$HBoxContainer/SongPosition.set_text("%02d:%02d / %02d:%02d" % [position_min, position_sec, duration_min, duration_sec])
	
	if SongTracker.songPlaying == true:
		$HBoxContainer/TimeSlider.set_value(sec)


func _on_AudioPlayer_update_song_meta():
	reset_ui()
	
	$SongName.set_text(SongTracker.songName)
	
	# warning-ignore:integer_division
	duration_min = int(SongTracker.songDuration) / 60 % 60
	duration_sec = int(SongTracker.songDuration) % 60
	$HBoxContainer/SongPosition.set_text("%02d:%02d / %02d:%02d" % [position_min, position_sec, duration_min, duration_sec])
	
	# Update Slider Max Value to Duration Sec
	$HBoxContainer/TimeSlider.set_max(SongTracker.songDuration)


func _on_Popups_meta_edited():
	$SongName.set_text(SongTracker.songName)
