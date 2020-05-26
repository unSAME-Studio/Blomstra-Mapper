extends SpinBox

signal lpb_updated

func _on_LPB_value_changed(value):
	EditorDatas.LPB = int(value)
	
	emit_signal("lpb_updated")
