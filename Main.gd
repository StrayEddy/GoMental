extends Node

func _process(delta):
	if Input.is_action_just_pressed("ui_new"):
		Global.sunburst.restart()
	if Input.is_action_just_pressed("ui_open"):
		$OpenFileDialog.popup()
		var mouse_pos = $OpenFileDialog.get_global_mouse_position()
		$OpenFileDialog.rect_position = mouse_pos
	if Input.is_action_just_pressed("ui_save"):
		$SavePopupDialog.popup()
		$SavePopupDialog/VBoxContainer/LineEdit.text = Files.current_path
		$SavePopupDialog/VBoxContainer/LineEdit.caret_position = Files.current_path.length()
		var mouse_pos = $SavePopupDialog.get_global_mouse_position()
		$SavePopupDialog.rect_position = mouse_pos
	if Input.is_action_just_pressed("ui_up"):
		if not $Diagram.is_typing:
			$Diagram.move_selection_up()
	if Input.is_action_just_pressed("ui_down"):
		if not $Diagram.is_typing:
			$Diagram.move_selection_down()
	if Input.is_action_just_pressed("ui_left"):
		if not $Diagram.is_typing:
			$Diagram.move_selection_left()
	if Input.is_action_just_pressed("ui_right"):
		if not $Diagram.is_typing:
			$Diagram.move_selection_right()
	if Input.is_action_just_pressed("ui_accept"):
		if not $Diagram.is_typing:
			$Diagram.start_typing()
		else:
			$Diagram.accept()

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
