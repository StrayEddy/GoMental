extends GridContainer

var suggestions = []

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
		filter_suggestions()

func autocomplete():
	$LineEdit.text = $Button.text
	$LineEdit.caret_position = $LineEdit.text.length()+1

func set_suggestions(new_suggestions):
	if new_suggestions.size() > 0 and new_suggestions[0] == "":
		suggestions = new_suggestions.slice(1, new_suggestions.size()-1)
	else:
		suggestions = new_suggestions
	
	filter_suggestions()

func filter_suggestions():
	var filter = $LineEdit.text
	
	var filtered_suggestions = []
	if filter != "":
		for suggestion in suggestions:
			if filter in suggestion:
				filtered_suggestions.append(suggestion)
	else:
		filtered_suggestions = suggestions
	
	
	$Button.text = ""
	$Button2.text = ""
	$Button3.text = ""
	$Button4.text = ""
	$Button5.text = ""
	
	if filtered_suggestions.size() > 4:
		$Button5.text = filtered_suggestions[4]
	if filtered_suggestions.size() > 3:
		$Button4.text = filtered_suggestions[3]
	if filtered_suggestions.size() > 2:
		$Button3.text = filtered_suggestions[2]
	if filtered_suggestions.size() > 1:
		$Button2.text = filtered_suggestions[1]
	if filtered_suggestions.size() > 0:
		$Button.text = filtered_suggestions[0]

func clear():
	$LineEdit.clear()
	$Button.release_focus()
	$Button2.release_focus()
	$Button3.release_focus()
	$Button4.release_focus()
	$Button5.release_focus()
