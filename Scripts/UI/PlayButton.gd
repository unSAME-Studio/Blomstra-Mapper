extends Button

signal toggle_play_audio


func reset():
	set_text("Play")


func _on_Play_button_down():
	if SongTracker.songPlaying == false:
		emit_signal("toggle_play_audio", true)
	else:
		emit_signal("toggle_play_audio", false)


func _process(delta):
	if SongTracker.songPlaying:
		set_text("Pause")
	else:
		set_text("Play")
