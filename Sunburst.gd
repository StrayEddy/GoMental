extends Node2D

var node_scene = load("res://Node.tscn")

var root

var tree = {
	"label":"",
	"path":"/root",
	"children": [
		{
			"label":"depression",
			"path":"/root/depression",
			"children":[
				{
					"label":"exercice",
					"path":"/root/depression/exercice",
					"children":[]
				},
				{
					"label":"journal_humeur",
					"path":"/root/depression/journal_humeur",
					"children":[]
				}
			]
		},
		{
			"label":"anxiete",
			"path":"/root/anxiete",
			"children":[
				{
					"label":"respiration",
					"path":"/root/anxiete/respiration",
					"children":[]
				},
				{
					"label":"meditation",
					"path":"/root/anxiete/meditation",
					"children":[]
				}
			]
		}
	]
}

func _ready():
	root = node_scene.instance()
	add_child(root)
	build_tree(root, tree.label, tree.children)
	update_tree()

func build_tree(node, label, children):
	var nb_children = children.size()
	if nb_children == 0:
		return
	for i in range(0, nb_children):
		var child = children[i]
		var subnode = node.add_node(child.label)
		build_tree(subnode, child.label, child.children)

func add_node(label, parent_node):
	var parent_leaf = find_leaf(tree, parent_node.path)
	var new_leaf = {
		"label": label,
		"path": parent_node.path + "/" + label,
		"children": []
	}
	parent_leaf.children.append(new_leaf)
	parent_node.add_node(label)
	update_tree()

func update_tree():
	print_the_tree(tree)
	root.update()

func find_leaf(branch, path):
	if branch.path == path:
		return branch
	for leaf in branch.children:
		var l = find_leaf(leaf, path)
		if l != null:
			return l
	return null

func print_the_tree(tree):
	for branch in tree.children:
		print(branch.path)
		if not branch.children.empty():
			print_the_tree(branch)

func reset():
	root.queue_free()
	_ready()
