extends Button

func _ready():
	self.connect("focus_entered", self, "_on_focus_entered")
	self.connect("focus_exited", self, "_on_focus_exited")
	self.connect("gui_input", self, "_on_gui_input")
	
	theme.set_color("font_color", "Button", Color(1,1,1))

func _on_focus_entered(event):
	theme.set_color("font_color", "Button", Color(0,0,0))

func _on_focus_exited(event):
	theme.set_color("font_color", "Button", Color(1,1,1))

func _on_gui_input(event):
	if Input.is_key_pressed(KEY_ENTER):
		Global.diagram.add_neuron(text)
