extends Node

var path = "res://records/"
var current_name

func _ready():
	pass # Replace with function body.

func open(name):
	var file = File.new()
	file.open(path + name, File.READ)
	var content = file.get_as_text()
	
	Global.sunburst.root.set_label(name)
	Global.sunburst.tree = parse_json(content)
	Global.sunburst.reset()
#	SearchEngine.terms = []

	current_name = name
	file.close()

func save(name):
	var file = File.new()
	file.open(path + name, File.WRITE)
	
	var content = to_json(Global.sunburst.tree)
#	var content = to_json(SearchEngine.terms)
	
	file.store_string(content)
	file.close()

func get_file_name(path):
	var regex = RegEx.new()
	regex.compile("^(.*)\/\/(.*)(\/..*)$")
	var results = regex.search_all(path)
	return results[1].get_string()
