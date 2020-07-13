extends Node2D

var node_scene = load("res://Node.tscn")

var root

var tree = {
	"label":"",
	"path":"/root",
	"children": []
}

func _ready():
	root = node_scene.instance()
	add_child(root)
	build_tree(root, tree.label, tree.children)
	update_tree(tree)

func build_tree(node, label, children):
	var nb_children = children.size()
	if nb_children == 0:
		return
	for i in range(0, nb_children):
		var child = children[i]
		var subnode = node.add_node(child.label)
		build_tree(subnode, child.label, child.children)

func add_node(label, parent_node):
	var parent_leaf = find_leaf(parent_node.path)
	var new_leaf = {
		"label": label,
		"path": parent_node.path + "/" + label,
		"children": []
	}
	parent_leaf.children.append(new_leaf)
	parent_node.add_node(label)
	update_tree(tree)

func update_tree(tree):
	self.tree = tree
#	print_the_tree(tree)
	root.update()

func find_leaf(path, branch = tree):
	if branch.path == path:
		return branch
	for leaf in branch.children:
		var l = find_leaf(path, leaf)
		if l != null:
			return l
	return null

func print_the_tree(tree):
	for branch in tree.children:
		print(branch.path)
		if not branch.children.empty():
			print_the_tree(branch)

func select_node(node):
	node.select()
	update_tree(tree)
	return node

func select_node_with_path(path):
	for node in get_tree().get_nodes_in_group("Node"):
		if node.path == path:
			select_node(node)


func reset():
	root.queue_free()
	_ready()

func restart():
	tree = {
		"label":"",
		"path":"/root",
		"children": []
	}
	reset()
	Global.diagram.selected_node = select_node(root)
