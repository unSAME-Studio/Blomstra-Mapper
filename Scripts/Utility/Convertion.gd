extends Node


func SamplesToCanvasPositionX(samples, screenSizeX):
	# Get a samples number and calculate the x position for that samples
	if SongTracker.songLoaded == false:
		return 0.0;
	
	return ((samples - SongTracker.songPosInSample) * screenSizeX / (SongTracker.songSamples)) + EditorDatas.offsetX
	
	# Old code
	# return ((samples - SongTracker.songSamples + SongTracker.firstBeatOffset) * screenSizeX / SongTracker.songSamples) + SongTracker.songPosition + EditorDatas.offsetX


func CanvasToScreenPosition(canvasX, screenSizeX):
	# Placeholder?
	return canvasX
	
	# Old code
	# return (canvasX / EditorDatas.scaleFactor + screenSizeX)
