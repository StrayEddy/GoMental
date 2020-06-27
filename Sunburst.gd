extends Node2D

var node_scene = load("res://Node.tscn")

var tree = {
	"label": "",
	"children": [
		{
			"label":"depression",
			"children":[]
		},
		{
			"label":"anxiete",
			"children":[]
		}
	]
}

func _ready():
	var root = node_scene.instance()
	add_child(root)
	build_tree(root, tree.label, tree.children)
	root.update_children_angles()
	root.update()

func build_tree(node, label, children):
	var nb_children = children.size()
	if nb_children == 0:
		return
	for i in range(0, nb_children):
		var child = children[i]
		var subnode = node.add_node(child.label)
		build_tree(subnode, child.label, child.children)

func reset():
	_ready()
