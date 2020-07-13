extends LineEdit

func _ready():
	theme.set_color("font_color", "LineEdit", Color(1,1,1))

func _on_LineEdit_focus_entered():
	theme.set_color("font_color", "LineEdit", Color(0,0,0))

func _on_LineEdit_focus_exited():
	Global.diagram.get_node("Status").text = ""
	theme.set_color("font_color", "LineEdit", Color(1,1,1))

func _on_LineEdit_text_entered(new_text):
	clear()
	get_parent().hide()
	if Global.diagram.is_saving:
		Global.diagram.save(new_text)
	elif Global.diagram.is_opening:
		Global.diagram.open(new_text)
	else:
		Global.diagram.add_node(new_text)
