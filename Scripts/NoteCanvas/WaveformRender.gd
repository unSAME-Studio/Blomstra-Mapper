extends Node2D


onready var viewportRect = get_viewport_rect()

var AudioData: PoolByteArray


func _process(_delta):
	update()


func _draw():
	# Testing Audio Data Drawing
	var sampleSize: int = (len(AudioData) / viewportRect.size.x) * EditorDatas.scaleFactor
	if len(AudioData) > 100:
		for i in range(0, viewportRect.size.x - 1):
			# Convert Signed Byte to Correct Int rep
			var barPos = AudioData[int(i * sampleSize)]
			if barPos > 127:
				barPos = (256 - barPos) * (-1)
			
			draw_line(Vector2(i, 200 + barPos), Vector2(i+1, 200 + barPos + 2), Color("1cff9b"), 2)


# Testing Audio Data Drawing
func _on_Meta_pressed():
	print("Audio Datas Lenth: %d" % len(AudioData))
	AudioData = get_node("../../../../../../AudioStreamPlayer").get_stream().get_data()
	#print(get_node("../../../../../../AudioStreamPlayer").get_stream().get_format())
