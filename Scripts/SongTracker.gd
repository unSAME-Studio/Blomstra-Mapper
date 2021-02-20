extends Node


# Position Tracking
###################

# Check if song is loaded
var songLoaded = false

# the current state of song playing
var songPlaying = false

# the current position of the song (in seconds)
var songPosition = 0.0

# the current position of the song (in samples)
var songPosInSample = 0

# the duration of a beat
var secPerBeat = 0.0

# how much time (in seconds) has passed since the song started
var dspSongTime = 0.0

# The offset to the first beat of the song in seconds
var firstBeatOffset = 0.0


# Song Information
###################

# beats per minute of a song
var bpm = 120.0

# sample rate for the song
var songFrequency = 44100.0

# total length of the song in seconds
var songDuration = 0.0

# total length of the song in samples
var songSamples = 0.0

# contain all the amplitude of the audio files
var AudioData: PoolByteArray

# set what type of audio for decoding
enum TYPES {OGG, WAV, MP3}
var AudioType = TYPES.OGG

# keep all the position-in-beats of notes in the song
# old note formar: (starting_time, type, end_time (Hold only, else 0), yloc (in screen percentage))
# new format: "position index": {type, endTime, yIndex}
var notesDatas = {}

# NEW FEATURE
# added time markers for live mapping helper
var markersDatas = {}


# Meta Information
###################

var songFile = "No File"

var songName = "No Name"

var songArtist = "No Artist"

var mapCreator = "Blomstra Mapper"

var mapDifficulty = "Normal"



# Methods
###################

func calculates() -> void:
	# calculate how many seconds is one beat
	secPerBeat = 60.0 / bpm
	
	# calculate total length in samples
	songSamples = AudioData.size()
	
	# calculate frequency from durations and AudioData
	songFrequency = AudioData.size() / songDuration


func update_positions(audio_position) -> void:
	# determine how many seconds since the song started
	songPosition = audio_position - dspSongTime - firstBeatOffset
	
	# determine how many samples since the song started
	songPosInSample = int(SongTracker.songPosition * SongTracker.songFrequency)


func add_note(selectedPos: Vector2, endTime: Vector2 = Vector2.ZERO) -> void:
	if selectedPos != Vector2(-1, -1):
		var key = "%d:%d:%d" % [selectedPos.x, selectedPos.y, EditorDatas.currentSide]
		
		# init nested dict
		notesDatas[key] = {}
		
		notesDatas[key]["type"] = EditorDatas.currentType
		notesDatas[key]["endTime"] = endTime
		
		#print(notesDatas[key])
		get_tree().get_nodes_in_group("Message")[0].display_message("Note Added | " + key + to_json(notesDatas[key]))
			


func remove_note(selectedPos: Vector2) -> bool:
	if selectedPos != Vector2(-1, -1):
		var key = "%d:%d:%d" % [selectedPos.x, selectedPos.y, EditorDatas.currentSide]
		
		if notesDatas.has(key):
			notesDatas.erase(key)
			return true
			
	return false


func add_markers(side: int) -> void:
	markersDatas[songPosInSample] = side


func remove_markers() -> void:
	markersDatas.clear()
