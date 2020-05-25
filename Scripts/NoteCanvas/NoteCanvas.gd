extends Node2D


var viewportRect: Rect2

var mouseEntered = false

var blockLines = []
var beatLines = []

var snappingThreshold = 25.0

var ClosestNotePosition = Vector2(0, 0)


func _ready():
	viewportRect = get_viewport_rect()
	
	# Calculate Block Lines
	for i in range(1, EditorDatas.maxBlock + 1):
		var blockYPos: float = viewportRect.size.y * 0.8 * (float(i) / float(EditorDatas.maxBlock + 1))
		blockLines.append([viewportRect.size.x, blockYPos, Color("2e3840"), 2])


func _process(_delta):
	# Reset the block line color
	for line in blockLines:
		line[2] = Color("2e3840")
	
	if (mouseEntered):
		
		var mousePos = get_viewport().get_mouse_position()
		
		var closestLineIndex = 0
		var closestBlockLindex = GetClosestLineIndex(blockLines, mousePos.y)
		
		var distance = Vector2(mousePos.x, blockLines[closestBlockLindex][1]) - mousePos
		
		if  distance.x < snappingThreshold and distance.y < snappingThreshold:
			
			blockLines[closestBlockLindex][2] = Color("1cff9b")
			ClosestNotePosition = Vector2(0, closestBlockLindex + 1)
			
		else:
			
			ClosestNotePosition = Vector2(0, 0)
			
			
		update()


func _draw():
	
	# Draw Block Lines
	for line in blockLines:
		draw_line(
			Vector2(0, line[1]), 
			Vector2(line[0], line[1]), 
			line[2], line[3])
	
	# Draw Judgement Line
	draw_line(
		Vector2(viewportRect.size.x * 0.1, 0), 
		Vector2(viewportRect.size.x * 0.1, viewportRect.size.y),
		Color("ffffff"), 2)


func GetClosestLineIndex(lines: Array, mouse_pos: float):
	var best_match = null
	var least_diff = 1000
	
	for i in range(lines.size()):
		var diff = abs(lines[i][1] - mouse_pos)
		
		if diff <= least_diff:
			best_match = i
			least_diff = diff
	
	return best_match


# Capture mouse when entered
func _on_ViewportContainer_mouse_entered():
	mouseEntered = true

func _on_ViewportContainer_mouse_exited():
	mouseEntered = false


# Detect click events
func _on_ViewportContainer_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print(ClosestNotePosition)
		
