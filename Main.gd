extends Node

func _process(delta):
	if Input.is_action_just_pressed("ui_new"):
		Global.sunburst.restart()
	if Input.is_action_just_pressed("ui_del"):
		if not $Diagram.is_typing:
			$Diagram.delete()
	if Input.is_action_just_pressed("ui_relabel"):
		if not $Diagram.is_typing:
			$Diagram.is_relabeling = true
			$Diagram/Status.text = "renaming..."
			$Diagram.start_typing()
	if Input.is_action_just_pressed("ui_open"):
		if not $Diagram.is_typing:
			$Diagram.is_opening = true
			$Diagram/Status.text = "opening..."
			$Diagram.start_typing()
	if Input.is_action_just_pressed("ui_save"):
		if not $Diagram.is_typing:
			$Diagram.is_saving = true
			$Diagram/Status.text = "saving..."
			$Diagram.start_typing()
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
			$Diagram/Status.text = "adding..."
			$Diagram.start_typing()
		else:
			$Diagram.accept()

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
