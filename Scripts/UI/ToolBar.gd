extends Panel


func _on_TapNote_pressed():
	EditorDatas.currentType = EditorDatas.NOTE_TYPE.TAP


func _on_HoldNote_pressed():
	EditorDatas.currentType = EditorDatas.NOTE_TYPE.HOLD


func _on_SlideNote_pressed():
	EditorDatas.currentType = EditorDatas.NOTE_TYPE.SLIDE


func _on_Effects_pressed():
	EditorDatas.currentType = EditorDatas.NOTE_TYPE.EFFECT


func _on_Side_toggled(button_pressed):
	if button_pressed:
		EditorDatas.currentSide = EditorDatas.SIDE.RIGHT
	else:
		EditorDatas.currentSide = EditorDatas.SIDE.LEFT
