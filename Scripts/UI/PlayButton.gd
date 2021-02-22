extends Button

signal toggle_play_audio


var play_icon = preload("res://Graphics/Icons/Play.png")
var pause_icon = preload("res://Graphics/Icons/Pause.png")


func reset():
	#set_text("Play")
	set_button_icon(play_icon)


func _on_Play_button_down():
	if SongTracker.songLoaded == true:
		if SongTracker.songPlaying == false:
			emit_signal("toggle_play_audio", true)
		else:
			emit_signal("toggle_play_audio", false)


func _process(_delta):
	if SongTracker.songPlaying:
		#set_text("Pause")
		set_button_icon(pause_icon)
	else:
		#set_text("Play")
		set_button_icon(play_icon)
