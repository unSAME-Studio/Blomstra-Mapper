extends AudioStreamPlayer

# Signals
signal update_song_meta
signal song_loaded

# Nodes
onready var file_dialog = get_node("../Control/Popups/FileDialog")
onready var music_ui = get_node("../Control/MarginContainer/VBoxContainer/PlaybackControls/MarginContainer/HBoxContainer/MusicUI")
onready var tween = get_node("../Tween")

# Music Player
var currentPosition = 0.0


func load_audio_file(path):
	# Load audio file into the player from a path
	if path.get_extension() in ["ogg", "wav"]:
		
		var audio_file = ResourceLoader.load(path)
		# audio_file.set_loop(false)
		set_stream(audio_file)
		
		SongTracker.AudioData = get_stream().get_data()
		
		# Update Meta
		SongTracker.songName = path.get_file()
		SongTracker.songDuration = get_stream().get_length()
		
		print("Song Length: ", SongTracker.songDuration)
		print("songFrequency: ", SongTracker.songFrequency)
		
		SongTracker.calculates()
		
		emit_signal("update_song_meta", SongTracker.songName, SongTracker.songDuration)
		emit_signal("song_loaded")
		
		SongTracker.songLoaded = true



func play_song():
	play(currentPosition)
	SongTracker.songPlaying = true


func stop_song():
	stop()
	SongTracker.songPlaying = false


func _process(_delta):
	
	if SongTracker.songLoaded == true:
		
		currentPosition = get_playback_position()
		
		# Update the song tracker positions
		SongTracker.update_positions(currentPosition)
		
		# Set Display Position
		# Set Slider Position if playing
		music_ui.set_song_position(currentPosition)



func _on_FileDialog_file_selected(path):
	load_audio_file(path)


func _on_Play_toggle_play_audio(play):
	if play == true:
		play_song()
	elif play == false:
		stop_song()


# Slider Control
var resume_play = false

func _on_TimeSlider_gui_input(event):
		if event is InputEventMouseButton:
			if event.is_pressed():
				if SongTracker.songPlaying:
					resume_play = true
					stop_song()
			else:
				if resume_play == true:
					resume_play = false
					play_song()

func _on_TimeSlider_value_changed(value):
	if SongTracker.songPlaying == false:
		currentPosition = value
		seek(currentPosition)


# Mouse Wheels Control
var scroll_delta = 0.6

func _input(event):
	if event.is_action_pressed("timeline_left"):
		currentPosition -= scroll_delta
		seek(currentPosition)
	elif event.is_action_pressed("timeline_right"):
		currentPosition += scroll_delta
		seek(currentPosition)


# Volume Slider
func _on_VolumeSlider_value_changed(value):
	set_volume_db(value - 50)
