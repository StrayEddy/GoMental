extends Node2D

const ZOOM_SENSITIVITY = Vector2(.05, .05)

var selected_node

func _ready():
	pass

func node_is_selected(node):
	selected_node = node
	$CanvasLayer/SearchBar.show()
	put_focus_on_line_edit()

func put_focus_on_line_edit():
	$CanvasLayer/SearchBar/LineEdit.clear()
	$CanvasLayer/SearchBar/LineEdit.grab_focus()
	var suggestions = SearchEngine.get_suggestions(selected_node.label)
	$CanvasLayer/SearchBar.set_suggestions(suggestions)

func add_node(text):
	selected_node.add_node(text)
	$Sunburst.reset()
	
	# Add new term
	SearchEngine.add_term(text)
	SearchEngine.add_suggestion(selected_node.label, text)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			$Background/Camera2D.zoom += ZOOM_SENSITIVITY
		elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			$Background/Camera2D.zoom -= ZOOM_SENSITIVITY 
