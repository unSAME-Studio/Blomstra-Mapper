extends SpinBox


func _on_BPM_value_changed(value):
	SongTracker.bpm = value
	SongTracker.calculates()
