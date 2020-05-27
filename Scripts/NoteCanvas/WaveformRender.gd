extends Node2D


onready var viewportRect = get_viewport_rect()

onready var sectionHeight = 0.3
onready var sectionLocation = viewportRect.size.y * 0.9


var samples = []

var cachedCanvasWidth = 0.0
var cachedTimeSamples = 0.0

func _process(_delta):
	
	if SongTracker.songLoaded == true:
		
		if cachedCanvasWidth != EditorDatas.width or cachedTimeSamples != SongTracker.songPosInSample:
			
			# Update Cache
			cachedCanvasWidth = EditorDatas.width
			cachedTimeSamples = SongTracker.songPosInSample
			
			var skipSamples = int(1 / (EditorDatas.width / SongTracker.songSamples))
			
			samples = []
			
			for i in range(viewportRect.size.x):
				
				var index = int(SongTracker.songPosInSample + i * skipSamples)
				
				if index % 2 == 0:
					index += 1
				
				if index < (SongTracker.AudioData.size() - 1):
					samples.append(SongTracker.AudioData[index])
			
			
			update()


func _draw():
	
	if SongTracker.songLoaded == true:
		
		for i in range(samples.size()):
				
			var barPos = samples[i]
			
			# Convert Signed Byte to Correct Int rep
			if barPos > 127:
				barPos = (-1) * (256 - barPos)
		
			draw_line(
				Vector2(i, sectionLocation - barPos * sectionHeight), 
				Vector2(i, sectionLocation + barPos * sectionHeight), 
				Color("1cff9b"), 1)


func _on_Waveform_toggled(button_pressed):
	if button_pressed == true:
		show()
		
		print("Audio Datas Lenth: %d" % len(SongTracker.AudioData))
		update()
		
	else:
		hide()
