extends Button

signal toggle_play_audio

var play = false

func _on_Play_button_down():
	if play == false:
		emit_signal("toggle_play_audio", true)
		play = true
	else:
		emit_signal("toggle_play_audio", false)
		play = false
