extends LineEdit

func _ready():
	theme.set_color("font_color", "LineEdit", Color(1,1,1))

func _on_LineEdit_focus_entered():
	theme.set_color("font_color", "LineEdit", Color(0,0,0))

func _on_LineEdit_focus_exited():
	theme.set_color("font_color", "LineEdit", Color(1,1,1))

func _on_LineEdit_text_entered(new_text):
	clear()
	Global.diagram.add_neuron(new_text)
	get_parent().hide()
