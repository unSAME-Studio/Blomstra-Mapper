extends AudioStreamPlayer

# Signals
signal update_song_meta
signal song_loaded

# For loading audio stream
var audio_importer = preload("res://Scripts/GDScriptAudioImport.gd")
# Nodes
onready var file_dialog = get_node("../Control/Popups/FileDialog")
onready var music_ui = get_node("../Control/MarginContainer/VBoxContainer/PlaybackControls/MarginContainer/HBoxContainer/MusicUI")

# Music Player
var currentPosition = 0.0


func load_audio_file(path):
	# Load audio file into the player from a path
	match path.get_extension():
		"ogg":
			var importer = audio_importer.new()
			var audio_stream = importer.loadfile(path)
			set_stream(audio_stream)
			
			# Update Audio Datas
			SongTracker.AudioData = get_stream().get_data()
			SongTracker.AudioType = SongTracker.TYPES.OGG
			
			# Update Meta
			SongTracker.songName = path.get_file()
			SongTracker.songDuration = get_stream().get_length()
			
			SongTracker.calculates()
			
			# print("Song Format:", get_stream().get_format())
			print("Song Length: ", SongTracker.songDuration)
			print("songFrequency: ", SongTracker.songFrequency)
			print("Total Datas: ", len(SongTracker.AudioData))
			
			emit_signal("update_song_meta")
			emit_signal("song_loaded")
			
			SongTracker.songLoaded = true
			
		"wav":
			pass
			
		"mp3":
			pass


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
