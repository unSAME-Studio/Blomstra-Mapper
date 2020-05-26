extends SpinBox

signal bpm_updated

func _on_BPM_value_changed(value):
	SongTracker.bpm = value
	SongTracker.calculates()
	
	emit_signal("bpm_updated")
