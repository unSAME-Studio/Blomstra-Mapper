extends Node2D


onready var viewportRect = get_viewport_rect()

onready var sectionHeight = 0.5
onready var sectionLocation = viewportRect.size.y * 0.9

var AudioData: PoolByteArray
	

func _process(_delta):
	update()


func _draw():
	var sampleSize: int = (len(AudioData) / viewportRect.size.x) * EditorDatas.scaleFactor
	
	# Temp check!!! Need REMOVE
	if len(AudioData) > 100:
		
		for i in range(0, viewportRect.size.x):
			
			# Check if index out of bound
			if int(i * sampleSize) > len(AudioData):
				break
				
			var barPos = AudioData[int(i * sampleSize)]
			
			# Convert Signed Byte to Correct Int rep
			if barPos > 127:
				barPos = (-1) * (256 - barPos)
		
			draw_line(
				Vector2(i, sectionLocation - barPos * sectionHeight), 
				Vector2(i, sectionLocation + barPos * sectionHeight), 
				Color("1cff9b"), 2)


# Testing Audio Data Drawing
func _on_Meta_pressed():
	print("Audio Datas Lenth: %d" % len(AudioData))
	AudioData = get_node("../../../../../../AudioStreamPlayer").get_stream().get_data()
	#print(get_node("../../../../../../AudioStreamPlayer").get_stream().get_format())
