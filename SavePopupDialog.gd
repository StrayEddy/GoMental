extends PopupDialog

func _on_LineEdit_text_entered(path):
	Files.save(path)
	$VBoxContainer/LineEdit.clear()
	hide()

func _on_LineEdit_gui_input(event):
	get_tree().set_input_as_handled()
	if Input.is_action_pressed("ui_cancel"):
		$VBoxContainer/LineEdit.clear()
		hide()
