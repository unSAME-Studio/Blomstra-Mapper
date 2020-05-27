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


# keep all the position-in-beats of notes in the song
# note formar: (starting_time, type, end_time (Hold only, else 0), yloc (in screen percentage))


# Meta Information
###################

var songName = "No Name"

var songArtist = "No Artist"

var mapCreator = "Blomstra Mapper"

var mapDifficulty = "Normal"



# Methods
###################

func calculates():
	# calculate how many seconds is one beat
	secPerBeat = 60.0 / bpm
	
	# calculate total length in samples
	songSamples = len(AudioData)


func update_positions(audio_position):
	# determine how many seconds since the song started
	songPosition = audio_position - dspSongTime - firstBeatOffset
	
	# determine how many samples since the song started
	songPosInSample = int(SongTracker.songPosition * SongTracker.songFrequency)
	
