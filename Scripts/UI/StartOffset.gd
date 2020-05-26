extends SpinBox


func _on_StartOffset_value_changed(value):
	SongTracker.firstBeatOffset = value / 1000


func _on_Button_pressed():
	set_value(SongTracker.songPosition * 1000) 
	
