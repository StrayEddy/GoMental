extends Button

func _ready():
	self.connect("focus_entered", self, "_on_focus_entered")
	self.connect("focus_exited", self, "_on_focus_exited")
	
	theme.set_color("font_color", "Button", Color(1,1,1))

func _on_focus_entered(event):
	theme.set_color("font_color", "Button", Color(0,0,0))

func _on_focus_exited(event):
	theme.set_color("font_color", "Button", Color(1,1,1))

func _on_Button_gui_input(event):
	get_tree().set_input_as_handled()
	if not Input.is_action_just_pressed("ui_accept"):
		return
	get_parent().get_node("LineEdit").clear()
	get_parent().hide()
	if Global.diagram.is_saving:
		Global.diagram.save(text)
	elif Global.diagram.is_opening:
		Global.diagram.open(text)
	elif Global.diagram.is_relabeling:
		Global.diagram.relabel(text)
	else:
		Global.diagram.add_node(text)
