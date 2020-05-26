extends HSlider


func _on_ZoomSlider_value_changed(value):
	EditorDatas.scaleFactor = value
	# print("Scale Factor Changed: %f" % value)
	
	EditorDatas.width = 1280 * value
