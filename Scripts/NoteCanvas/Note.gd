extends Node2D


var beatArray: Array
var blockArray: Array

var xIndex = 0
var yIndex = 0


func _process(_delta):
	set_position(Vector2(beatArray[xIndex][0], blockArray[yIndex][1]))
