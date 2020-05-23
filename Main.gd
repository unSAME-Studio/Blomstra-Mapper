extends Node


# Position Tracking
###################

# the current position of the song (in seconds)
var songPosition: float

# the current position of the song (in beats)
var songPosInBeats: float

# the duration of a beat
var secPerBeat: float

# how much time (in seconds) has passed since the song started
var dsptimesong: float


# Song Information
###################

# beats per minute of a song
var bpm: float

# keep all the position-in-beats of notes in the song
# note formar: (starting_time, type, end_time (Hold only, else 0), yloc (in screen percentage))



func _ready():
	# calculate how many seconds is one beat
	secPerBeat = 60.0 / bpm


