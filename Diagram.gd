extends Node2D

const ZOOM_SENSITIVITY = Vector2(.05, .05)

var selected_node
var is_typing = false
var is_opening = false
var is_saving = false
var is_relabeling = false

func _ready():
	selected_node = $Sunburst.root.select()

func put_focus_on_line_edit():
	$CanvasLayer/SearchBar/LineEdit.clear()
	$CanvasLayer/SearchBar/LineEdit.grab_focus()
	var suggestions = SearchEngine.get_suggestions(selected_node.label)
	$CanvasLayer/SearchBar.set_suggestions(suggestions)

func add_node(text):
	$Sunburst.add_node(text, selected_node)
	
	# Add new term
#	SearchEngine.add_term(text)
#	SearchEngine.add_suggestion(selected_node.label, text)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			$Background/Camera2D.zoom += ZOOM_SENSITIVITY
		elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			$Background/Camera2D.zoom -= ZOOM_SENSITIVITY 

func move_selection_up():
	if selected_node.level > 1:
		selected_node = $Sunburst.select_node(selected_node.get_parent())
#		reset()

func move_selection_down():
	var children = selected_node.get_nodes()
	if children != []:
		selected_node = $Sunburst.select_node(children[0])
	else:
		for node in get_tree().get_nodes_in_group("Node"):
			if node.level == selected_node.level + 1:
				selected_node = $Sunburst.select_node(node)
				return

func move_selection_left():
	var siblings = []
	for node in get_tree().get_nodes_in_group("Node"):
		if node.level == selected_node.level:
			siblings.append(node)
	
	var selected_node_index = siblings.find(selected_node)
	var sibling_index = (selected_node_index + 1) % siblings.size()
	selected_node = $Sunburst.select_node(siblings[sibling_index])

func move_selection_right():
	var siblings = []
	for node in get_tree().get_nodes_in_group("Node"):
		if node.level == selected_node.level:
			siblings.append(node)
	
	var selected_node_index = siblings.find(selected_node)
	var sibling_index = (selected_node_index - 1) % siblings.size()
	selected_node = $Sunburst.select_node(siblings[sibling_index])

func accept():
	is_typing = false
	$CanvasLayer/SearchBar.clear()
	$CanvasLayer/SearchBar.hide()

func start_typing():
	is_typing = true
	$CanvasLayer/SearchBar.show()
	put_focus_on_line_edit()
	
func stop_typing():
	accept()

func reset():
	print("resetting...")
	print("path = " + selected_node.path)
	var path = selected_node.path
	$Sunburst.reset()
	selected_node = $Sunburst.select_node_with_path(path)
	print("reset done")
	print("path = " + selected_node.path)

func open(name):
	Files.open(name)
	selected_node = $Sunburst.root.select()
	is_opening = false
	$Status.text = "opened"

func save(name):
	Files.save(name)
	is_saving = false
	$Status.text = "saved"

func delete():
	$Sunburst.delete_node(selected_node)

func relabel(label):
	is_relabeling = false
	$Sunburst.relabel_node(selected_node, label)
	$Status.text = "renamed"
