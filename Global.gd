extends Node

var diagram

func _ready():
	diagram = get_tree().get_nodes_in_group("Diagram")[0]
