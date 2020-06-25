extends Node

func _process(delta):
	if Input.is_action_pressed("ui_open"):
		$OpenFileDialog.popup()
	if Input.is_action_pressed("ui_save"):
		$SavePopupDialog.popup()

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
