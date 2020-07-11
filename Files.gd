extends Node

var current_path = "res://records/"

func _ready():
	pass # Replace with function body.

func open(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	
	Global.sunburst.root.set_label(get_file_name(path))
	Global.sunburst.tree = parse_json(content)
	Global.sunburst.reset()
#	SearchEngine.terms = []

	current_path = path
	file.close()

func save(path):
	var file = File.new()
	file.open(path, File.WRITE)
	
	var content = to_json(Global.sunburst.tree)
#	var content = to_json(SearchEngine.terms)

	
	file.store_string(content)
	file.close()

func get_file_name(path):
	var regex = RegEx.new()
	regex.compile("^(.*)\/\/(.*)(\/..*)$")
	var results = regex.search_all(path)
	print(results.size())
	return results[1].get_string()
