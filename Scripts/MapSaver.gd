extends Node

const header = "Blomstra Map Format v1"

class NoteSorter:
	static func sort_ascending(a, b):
		if int(a.split(",")[0]) <= int(b.split(",")[0]):
			return true
		return false


func create_save_dict():
	var save = {
		"BPM": SongTracker.bpm,
		"AudioType": SongTracker.AudioType,
		"AudioFile": SongTracker.songFile,
		"SongName": SongTracker.songName,
		"SongArtist": SongTracker.songArtist,
		"MapCreator": SongTracker.mapCreator,
		"MapDifficulty": SongTracker.mapDifficulty
	}
	
	return save


func load_dict_to_tracker(dict):
	SongTracker.bpm = int(dict["BPM"])
	SongTracker.AudioType = int(dict["AudioType"])
	SongTracker.songFile = dict["AudioFile"]
	SongTracker.songName = dict["SongName"]
	SongTracker.songArtist = dict["SongArtist"]
	SongTracker.mapCreator = dict["MapCreator"]
	SongTracker.mapDifficulty = dict["MapDifficulty"]


func save_map_to_path(path):
	var file = File.new()
	file.open(path, File.WRITE)
	
	# header
	file.store_line(header)
	
	# meta savers
	var save_dict = create_save_dict()
	for key in save_dict.keys():
		file.store_line("%s:%s" % [key, String(save_dict[key])])
	
	# save notes by sorted
	file.store_line("[Notes]")
	var order_list = SongTracker.notesDatas.keys()
	order_list.sort_custom(NoteSorter, "sort_ascending")
	
	for key in order_list:
		var line = "%s,%d,%d,%d" % [
			key,
			SongTracker.notesDatas[key]["type"],
			SongTracker.notesDatas[key]["endTime"].x,
			SongTracker.notesDatas[key]["endTime"].y
		]
		file.store_line(line)
	
	Global.messager_ref.display_message("Map Saved | %s" % path)
	
	file.close()


func load_map(path):
	# Reload scene
	#get_tree().reload_current_scene()
	
	# File
	var file = File.new()
	file.open(path, File.READ)
	
	# check for header, desabled
	if not header in file.get_line():
		return
	
	# read attributes
	var line = file.get_line()
	var dict = {}
	
	while line != "[Notes]": 
		line = line.split(":")
		dict[line[0]] = line[1]
		
		line = file.get_line()
	
	load_dict_to_tracker(dict)
	
	# read notes and store to song trackers
	SongTracker.notesDatas = {}
	
	while not file.eof_reached():
		var note = file.get_line().split(",")
		
		if len(note) < 3:
			break
		
		var key = "%s,%s,%s" % [note[0], note[1], note[2]]
		SongTracker.notesDatas[key] = {}
		SongTracker.notesDatas[key]["type"] = int(note[3])
		SongTracker.notesDatas[key]["endTime"] = Vector2(note[4], note[5])
	
	# finally also load the music, if can't find then manually load
	var directory = Directory.new()
	var music_path = "%s/%s" % [path.get_base_dir(), SongTracker.songFile]
	
	if directory.file_exists(music_path):
		Global.music_control_ref.load_audio_file(music_path)
		Global.messager_ref.display_message("Map Loaded! | %s" % SongTracker.songFile)
	else:
		Global.messager_ref.display_message("Map loaded but can't find the audio file, please open it manually.")
	
	
	file.close()
