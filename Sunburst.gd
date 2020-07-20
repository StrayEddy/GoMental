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
	root.set_label(tree.label)
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
	print(parent_node.path)
	var parent_leaf = find_leaf(parent_node.path)
	var new_leaf = {
		"label": label,
		"path": parent_node.path + "/" + label,
		"children": []
	}
	parent_leaf.children.append(new_leaf)
	parent_node.add_node(label)
	update_tree(tree)

func delete_node(node):
	if node.level > 1:
		var parent_node = node.get_parent()
		var parent_leaf = find_leaf(parent_node.path)
		var leaf_index = 0
		for i in range(0, parent_leaf.children.size()):
			if parent_leaf.children[i].path == node.path:
				leaf_index = i
				break
		parent_leaf.children.remove(leaf_index)
		parent_node.remove_child(node)
		node.queue_free()
		
		Global.diagram.selected_node = select_node(parent_node)
		update_tree(tree)

func relabel_node(node, new_label):
	# Change the label
	var old_label = node.label
	var leaf = find_leaf(node.path)
	leaf.label = new_label
	node.set_label(new_label)
	
	# Change current path and children paths
	var new_path = node.path.replace(old_label, new_label)
	change_path(node.path, new_path)

func change_path(path, new_path, branch = tree):
	if path in branch.path:
		branch.path.replace(path, new_path)
		for leaf in branch.children:
			change_path(path, new_path, leaf)

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
