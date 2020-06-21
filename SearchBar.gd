extends GridContainer

func _ready():
	pass

func autocomplete():
	$LineEdit.text = $Button.text

func _on_LineEdit_gui_input(event):
	if Input.is_key_pressed(KEY_TAB):
		autocomplete()
	elif Input.is_key_pressed(KEY_RIGHT):
		$Button.grab_focus()
	else:
		var suggestions = SearchEngine.search_terms_containing_label($LineEdit.text)
		set_suggestions(suggestions)

func set_suggestions(suggestions):
	$Button.text = ""
	$Button2.text = ""
	$Button3.text = ""
	$Button4.text = ""
	$Button5.text = ""
	
	if suggestions.size() > 4:
		$Button5.text = suggestions[4].label
	if suggestions.size() > 3:
		$Button4.text = suggestions[3].label
	if suggestions.size() > 2:
		$Button3.text = suggestions[2].label
	if suggestions.size() > 1:
		$Button2.text = suggestions[1].label
	if suggestions.size() > 0:
		$Button.text = suggestions[0].label
