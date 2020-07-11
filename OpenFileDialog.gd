extends FileDialog

func _draw():
	set_current_dir("res://records/")

func _on_OpenFileDialog_file_selected(path):
	Files.open(path)
	_draw()
	hide()
