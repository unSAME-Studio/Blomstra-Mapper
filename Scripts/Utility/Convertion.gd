extends Node


func SamplesToCanvasPositionX(samples, screenSizeX):
	if SongTracker.songLoaded == false:
		return 0;
	
	return ((samples - SongTracker.songPosition * SongTracker.songFrequency) * screenSizeX / SongTracker.songSamples) + EditorDatas.offsetX
	
	# Old code
	# return ((samples - SongTracker.songSamples + SongTracker.firstBeatOffset) * screenSizeX / SongTracker.songSamples) + SongTracker.songPosition + EditorDatas.offsetX


func CanvasToScreenPosition(canvasX, screenSizeX):
	return canvasX
	
	# Old code
	# return (canvasX / EditorDatas.scaleFactor + screenSizeX)
