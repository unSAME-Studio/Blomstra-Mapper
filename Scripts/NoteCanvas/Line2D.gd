extends Line2D


var array_ref: Array
var index: int


func _process(_delta):
	set_width(array_ref[index][3])
	set_default_color(array_ref[index][2])
	set_point_position(0, Vector2(0, array_ref[index][1]))
	set_point_position(1, Vector2(array_ref[index][0], array_ref[index][1]))
	
