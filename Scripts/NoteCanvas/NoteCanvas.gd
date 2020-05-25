extends Node2D


var viewportRect: Rect2

var mouseEntered = false

var blockLines = []
var beatLines = []

var snappingThreshold = 23.0

var selectedBlock = 0
var selectedBeat = 0


func _ready():
	viewportRect = get_viewport_rect()
	
	# Calculate Block Lines
	for i in range(1, 10):
		var blockYPos: float = viewportRect.size.y * 0.8 * (float(i) / 10.0)
		blockLines.append([viewportRect.size.x, blockYPos, Color("2e3840"), 2])


func _process(_delta):
	
	if (mouseEntered):
		
		var mousePos = get_viewport().get_mouse_position()
		
		for i in range(blockLines.size()):
			if abs(blockLines[i][1] - mousePos.y) < snappingThreshold:
				blockLines[i][2] = Color("1cff9b")
				selectedBlock = i + 1
			else:
				blockLines[i][2] = Color("2e3840")
			
			
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


# Capture mouse when entered
func _on_ViewportContainer_mouse_entered():
	mouseEntered = true

func _on_ViewportContainer_mouse_exited():
	mouseEntered = false


# Detect click events
func _on_ViewportContainer_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print(selectedBlock, selectedBeat)
		
