extends AudioStreamPlayer

# Signals
signal update_song_meta


# Nodes
onready var file_dialog = get_node("../Control/MusicLoader/FileDialog")

# Music Loading
var song_name:String
var song_duration:float


func _ready():
	pass


func load_audio_file(path):
	# Load audio file into the player from a path
	if path.get_extension() in ["ogg", "wav"]:
		
		var audio_file = load(path)
		#audio_file.set_loop(false)
		set_stream(audio_file)
		
		# Update Meta
		song_name = path.get_file()
		song_duration = get_stream().get_length()
		
		emit_signal("update_song_meta", song_name, song_duration)


func play_song():
	play()


func stop_song():
	stop()


func _on_Open_button_down():
	file_dialog.popup_centered()


func _on_FileDialog_file_selected(path):
	load_audio_file(path)
	pass


func _on_Play_toggle_play_audio(play):
	if play == true:
		play_song()
	elif play == false:
		stop_song()
