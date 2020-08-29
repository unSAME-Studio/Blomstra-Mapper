extends Node2D


var viewportRect: Rect2

var mouseEntered = false

var unitBeatSamples = 0
var beatNum = 0

var beatSamples = []
var blockLines = []
var beatLines = []

var cachedZeroSamplePosX = -1.0
var cachedCanvasWidth = 0.0
var snappingThreshold = 25.0

var ClosestNotePosition = Vector2(-1, -1)

var beatFont = preload("res://Graphics/Font/BeatLineFont.tres")

var line2d = preload("res://Scenes/Line2D.tscn")

var note = preload("res://Scenes/Note.tscn")


func _ready():
	viewportRect = get_viewport_rect()
	
	EditorDatas.height = viewportRect.size.y * 0.75
	EditorDatas.width = viewportRect.size.x
	
	# Set judgement line offset X
	EditorDatas.offsetX = viewportRect.size.x * 0.1 + 100


func reset_canvas():
	remove_all_lines()
	
	calculate_beat_num()
	calculate_block_lines()
	
	add_all_lines()


func calculate_beat_num():
	unitBeatSamples = floor(SongTracker.songFrequency * 60.0 / SongTracker.bpm)
	beatNum = EditorDatas.LPB * ceil(SongTracker.songSamples / float(unitBeatSamples))


func calculate_block_lines():
	# calculate all the block lines into an array
	for i in range(1, EditorDatas.maxBlock + 1):
		var blockYPos: float = EditorDatas.height * (float(i) / float(EditorDatas.maxBlock + 1))
		blockLines.append([viewportRect.size.x, blockYPos, Color("2e3840"), 2])


func add_all_lines():
	# add Block Lines
	for i in range(blockLines.size()):
		var l = line2d.instance()
		l.array_ref = blockLines
		l.index = i
		$BlockLines.add_child(l)
	
	# update judge line
	$JudgeLine.set_point_position(0, Vector2(EditorDatas.offsetX, 0))
	$JudgeLine.set_point_position(1, Vector2(EditorDatas.offsetX, viewportRect.size.y))


func remove_all_lines():
	for i in $BlockLines.get_children():
		i.queue_free()


func _process(_delta):
	if SongTracker.songLoaded == true:
		
		# Generate Beat Lines Array
		if len(beatSamples) != beatNum or cachedCanvasWidth != EditorDatas.width:
			
			# Refresh and recalculate the array
			beatSamples = []
			for i in range(0, beatNum):
				beatSamples.append((i * unitBeatSamples) / EditorDatas.LPB)
				
			
			beatLines = []
			for i in range(beatSamples.size()):
				var x = Convertion.SamplesToCanvasPositionX(beatSamples[i], EditorDatas.width)
				var beatInfo = BeatLineCalculations(i)
				
				# Array Format:
				# [xpos, ypos, color, line_thickness, display_number]
				beatLines.append([
					Convertion.CanvasToScreenPosition(x, EditorDatas.width), 
					EditorDatas.height * beatInfo[1], 
					beatInfo[0], 
					2 * beatInfo[1], 
					beatInfo[2]])
			
			cachedZeroSamplePosX = beatLines[0][0]
			cachedCanvasWidth = EditorDatas.width
				
		else:
			
			# Change the x location and colors of each line in array
			var currentX = Convertion.CanvasToScreenPosition(Vector2(1, 0) * Convertion.SamplesToCanvasPositionX(0, EditorDatas.width), viewportRect.size).x
			var diffX = currentX - cachedZeroSamplePosX;
			
			for i in range(beatNum):
				beatLines[i][0] += diffX
				beatLines[i][2] = BeatLineColor(i)
				
			cachedZeroSamplePosX = currentX
		
		
		
		# Reset the block line color
		for line in blockLines:
			line[2] = Color("2e3840")
		
		# Highlight the selected blocks
		if mouseEntered:
			
			var mousePos = get_viewport().get_mouse_position()
			
			var closestLineIndex = GetClosestLineIndex(beatLines, mousePos.x, 0)
			var closestBlockLindex = GetClosestLineIndex(blockLines, mousePos.y, 1)
			
			var distance = (Vector2(beatLines[closestLineIndex][0], blockLines[closestBlockLindex][1]) - mousePos).abs()
			
			if  distance.x < snappingThreshold and distance.y < snappingThreshold:
				
				beatLines[closestLineIndex][2] = Color("1cff9b")
				blockLines[closestBlockLindex][2] = Color("1cff9b")
				ClosestNotePosition = Vector2(closestLineIndex, closestBlockLindex)
				
			else:
				
				ClosestNotePosition = Vector2(-1, -1)
				
		
		update()


func _draw():
	
	if SongTracker.songLoaded == true:
		
		# Draw Beat Lines
		for line in beatLines:
			draw_line(
				Vector2(line[0], 0), 
				Vector2(line[0], line[1]), 
				line[2], line[3])
			
			# Draw the number for beat lines
			if line[4] > -1:
				draw_string(beatFont, Vector2(line[0], line[1] + 20), str(line[4]))


func add_notes(selectedPos: Vector2):
	var n = note.instance()
	n.beatArray = beatLines
	n.blockArray = blockLines
	n.xIndex = selectedPos.x
	n.yIndex = selectedPos.y
	$Notes.add_child(n)
	
	pass
	"""
	# Draw Notes
	match type:
		EditorDatas.NOTE_TYPE.TAP:
			pass
		EditorDatas.NOTE_TYPE.HOLD:
			pass
		EditorDatas.NOTE_TYPE.SLIDE:
			pass
		EditorDatas.NOTE_TYPE.EFFECT:
			pass
	"""


func GetClosestLineIndex(lines: Array, mouse_pos: float, index: int) -> Vector2:
	# find the cloest distance line's index in array
	var best_match = null
	var least_diff = 1000
	
	for i in range(lines.size()):
		var diff = abs(lines[i][index] - mouse_pos)
		
		if diff <= least_diff:
			best_match = i
			least_diff = diff
	
	return best_match


func BeatLineCalculations(beat: int):
	# Calculate the color, beatline length, and display numbers
	if beat % (EditorDatas.LPB * 4) == 0:
		return [Color("7790a3"), 1.025, floor(beat / (EditorDatas.LPB * 4))]
	elif beat % EditorDatas.LPB == 0:
		return [Color("475662"), 1.05, -1]
	else:
		return [Color("2e3840"), 1, -1]


func BeatLineColor(beat: int):
	# Calculate the color from beat
	if beat % (EditorDatas.LPB * 4) == 0:
		return Color("7790a3")
	elif beat % EditorDatas.LPB == 0:
		return Color("475662")
	else:
		return Color("2e3840")


# Capture mouse when entered
func _on_ViewportContainer_mouse_entered():
	mouseEntered = true

func _on_ViewportContainer_mouse_exited():
	mouseEntered = false


# Detect click events and add notes
func _on_ViewportContainer_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.get_button_index() == BUTTON_LEFT:
				SongTracker.add_note(ClosestNotePosition)
				add_notes(ClosestNotePosition)
			elif event.get_button_index() == BUTTON_RIGHT:
				SongTracker.remove_note(ClosestNotePosition)


# Recalculate Canvas when song loaded
func _on_AudioStreamPlayer_song_loaded():
	reset_canvas()


func _on_BPM_bpm_updated():
	calculate_beat_num()


func _on_LPB_lpb_updated():
	calculate_beat_num()
