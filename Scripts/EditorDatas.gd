extends Node


# Note Canvas Infos
###################

# current selected note type
enum NOTE_TYPE {TAP, HOLD, SLIDE, EFFECT}
var currentType = NOTE_TYPE.TAP

# current selected note side
enum SIDE {LEFT, RIGHT}
var currentSide = SIDE.LEFT

# controls the zooming of the note canvas interface
var scaleFactor = 25

# controls the size of the note editor area
var height = 0.0

var width = 32000.0

# control how many line in a beat
var LPB = 4

# control how many block
var maxBlock = 9

# The offset for the judgement line on canvas
var offsetX = 0.0


# Misc
###################

var showWaveform = true

var playClapSound = true
