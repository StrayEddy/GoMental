extends Node

var path = "user://"
var current_name

func _ready():
	open_terms()

func open(name):
	var file = File.new()
	file.open(path + name, File.READ)
	var content = file.get_as_text()
	
	Global.sunburst.root.set_label(name)
	Global.sunburst.tree = parse_json(content)
	Global.sunburst.reset()

	current_name = name
	file.close()

func save(name):
	var file = File.new()
	file.open(path + name, File.WRITE)
	
	var content = to_json(Global.sunburst.tree)
	
	file.store_string(content)
	file.close()

func get_file_name(path):
	var regex = RegEx.new()
	regex.compile("^(.*)\/\/(.*)(\/..*)$")
	var results = regex.search_all(path)
	return results[1].get_string()

func get_file_names():
	var filenames = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name != "." and file_name != ".." and file_name != "terms.txt":
				filenames.append(file_name)
			file_name = dir.get_next()
	return filenames

func open_terms():
	var file = File.new()
	file.open(path + "terms.txt", File.READ)
	var content = file.get_as_text()
	if content != "":
		SearchEngine.terms = parse_json(content)
	file.close()

func save_terms():
	var file = File.new()
	file.open(path + "terms.txt", File.WRITE)
	var content = to_json(SearchEngine.terms)
	file.store_string(content)
	file.close()
