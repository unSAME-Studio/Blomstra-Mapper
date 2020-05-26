extends SpinBox


func _on_StartOffset_value_changed(value):
	SongTracker.firstBeatOffset = value
