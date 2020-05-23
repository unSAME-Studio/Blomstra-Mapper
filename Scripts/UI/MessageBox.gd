extends Label


func _ready():
	display_message("Blomstra Map Editor v 0.0.1", 2)


func display_message(string, sec):
	set_text(string)
	yield(get_tree().create_timer(sec), "timeout")
	set_text(" ")


func _on_AudioPlayer_update_song_meta(name, _duration):
	display_message("Song Loaded! %s" % name, 2)
