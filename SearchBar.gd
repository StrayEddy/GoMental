extends GridContainer

func _ready():
	pass

func _on_LineEdit_gui_input(event):
	get_tree().set_input_as_handled()
	if Input.is_key_pressed(KEY_TAB):
		autocomplete()
	elif Input.is_key_pressed(KEY_RIGHT):
		if $LineEdit.caret_position == $LineEdit.text.length():
			$Button.grab_focus()
	elif Input.is_key_pressed(KEY_ESCAPE):
		hide()
	else:
		var suggestions = []
		if Global.diagram.is_saving or Global.diagram.is_opening:
			suggestions = SearchEngine.search_files_starting_with($LineEdit.text)
		else:
			var terms = SearchEngine.search_terms_containing_label($LineEdit.text)
			for term in terms:
				suggestions.append(term.label)
		
		set_suggestions(suggestions)

func autocomplete():
	$LineEdit.text = $Button.text
	$LineEdit.caret_position = $LineEdit.text.length()+1

func set_suggestions(suggestions):
	if suggestions.size() > 0 and suggestions[0] == "":
		suggestions = suggestions.slice(1, suggestions.size()-1)
	
	$Button.text = ""
	$Button2.text = ""
	$Button3.text = ""
	$Button4.text = ""
	$Button5.text = ""
	
	if suggestions.size() > 4:
		$Button5.text = suggestions[4]
	if suggestions.size() > 3:
		$Button4.text = suggestions[3]
	if suggestions.size() > 2:
		$Button3.text = suggestions[2]
	if suggestions.size() > 1:
		$Button2.text = suggestions[1]
	if suggestions.size() > 0:
		$Button.text = suggestions[0]

func clear():
	$LineEdit.clear()
	$Button.release_focus()
	$Button2.release_focus()
	$Button3.release_focus()
	$Button4.release_focus()
	$Button5.release_focus()
