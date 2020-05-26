extends Node2D


onready var viewportRect = get_viewport_rect()

onready var sectionHeight = 0.5
onready var sectionLocation = viewportRect.size.y * 0.9
	

func _process(_delta):
	pass
	# update()


func _draw():
	var sampleSize: int = (len(SongTracker.AudioData) / viewportRect.size.x) * EditorDatas.scaleFactor
	
	# Temp check!!! Need REMOVE
	if len(SongTracker.AudioData) > 100:
		
		for i in range(0, viewportRect.size.x):
			
			# Check if index out of bound
			if int(i * sampleSize) > len(SongTracker.AudioData):
				break
				
			var barPos = SongTracker.AudioData[int(i * sampleSize)]
			
			# Convert Signed Byte to Correct Int rep
			if barPos > 127:
				barPos = (-1) * (256 - barPos)
		
			draw_line(
				Vector2(i, sectionLocation - barPos * sectionHeight), 
				Vector2(i, sectionLocation + barPos * sectionHeight), 
				Color("1cff9b"), 2)


# Testing Audio Data Drawing
func _on_Meta_pressed():
	print("Audio Datas Lenth: %d" % len(SongTracker.AudioData))
	
	update()
