extends VBoxContainer


func _on_AudioPlayer_update_song_meta(name, duration):
	$SongName.set_text(name)
	$HBoxContainer/SongTimes.set_text("%f" % [duration])
