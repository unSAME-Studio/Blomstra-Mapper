extends Node2D


var viewportRect: Rect2

var mouseEntered = false

var blockLines = []
var beatLines = []


func _ready():
	viewportRect = get_viewport_rect()
	
	# Calculate Block Lines
	for i in range(1, 10):
		var blockYPos: float = viewportRect.size.y * 0.8 * (float(i) / 10.0)
		blockLines.append([Vector2(0, blockYPos), Vector2(viewportRect.size.x, blockYPos), Color("2e3840"), 2])


func _process(_delta):
	#update()
	pass


func _draw():
	# Draw Block Lines
	for line in blockLines:
		draw_line(line[0], line[1], line[2], line[3])
	
	if (mouseEntered):
		var mousePos = get_viewport().get_mouse_position()
		print(mousePos)


# Capture mouse when entered
func _on_ViewportContainer_mouse_entered():
	mouseEntered = true

func _on_ViewportContainer_mouse_exited():
	mouseEntered = false
