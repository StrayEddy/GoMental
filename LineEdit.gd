extends LineEdit

func _ready():
	theme.set_color("font_color", "LineEdit", Color(1,1,1))

func _on_LineEdit_focus_entered():
	theme.set_color("font_color", "LineEdit", Color(0,0,0))

func _on_LineEdit_focus_exited():
	theme.set_color("font_color", "LineEdit", Color(1,1,1))

func _on_LineEdit_text_entered(new_text):
	clear()
	Global.sunburst.add_node(new_text, Global.diagram.selected_node)
	get_parent().hide()
