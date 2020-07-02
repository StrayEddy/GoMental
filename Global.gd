extends Node

var diagram
var sunburst

func _ready():
	diagram = get_tree().get_nodes_in_group("Diagram")[0]
	sunburst = get_tree().get_nodes_in_group("Sunburst")[0]
