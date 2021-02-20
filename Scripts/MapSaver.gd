extends Node


class NoteSorter:
	static func sort_ascending(a, b):
		if int(a.split(":")[0]) <= int(b.split(":")[0]):
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


func save_map_to_path(path):
	var file = File.new()
	file.open(path, File.WRITE)
	
	# header
	file.store_line("Blomstra Map Format v1")
	
	# meta savers
	var save_dict = create_save_dict()
	for key in save_dict.keys():
		file.store_line("%s:%s" % [key, String(save_dict[key])])
	
	# save notes by sorted
	var order_list = SongTracker.notesDatas.keys()
	order_list.sort_custom(NoteSorter, "sort_ascending")
	
	for key in order_list:
		file.store_line(key + to_json(SongTracker.notesDatas[key]))
	
	file.close()


func load_map(map_name):
	var file = File.new()
	file.open("user://%s" % map_name, File.READ)
	
	file.close()
