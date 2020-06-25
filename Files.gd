extends Node

func _ready():
	pass # Replace with function body.

func open(filename):
	var file = File.new()
	file.open("res://records/" + filename + ".txt", File.READ)
	
	var content = file.get_as_text()
	SearchEngine.terms = parse_json(content)
	file.close()

func save(filename):
	var file = File.new()
	file.open("res://records/" + filename + ".txt", File.WRITE)
	
	var content = to_json(SearchEngine.terms)
	file.store_string(content)
	file.close()
