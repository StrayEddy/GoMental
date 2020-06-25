extends FileDialog

func _on_OpenFileDialog_confirmed():
	Files.open(current_file)
	_draw()
	hide()


func _on_OpenFileDialog_gui_input(event):
	get_tree().set_input_as_handled()
	if Input.is_action_pressed("ui_cancel"):
		_draw()
		hide()

func _draw():
	set_current_dir("res://records/")
