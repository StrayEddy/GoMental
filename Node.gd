extends Node2D

signal is_selected(node)

var node_scene = load("res://Node.tscn")

var center = Vector2(0,0)
var width = 20
var radius = 50

var label = ""
var level = 0
var start_angle = 0
var end_angle = 360
var color_selected = Color.lightblue
var color_unselected = Color.darkblue
var color = color_unselected


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	draw_arc(center, level*radius, start_angle, end_angle, 10, color, width)
	
	var points = []
	var inner_r = radius - width/2
	var outer_r = radius + width/2
	
	points.append(get_point_on_arc(outer_r, start_angle))
	points.append(get_point_on_arc(outer_r, start_angle + (end_angle-start_angle)/4))
	points.append(get_point_on_arc(outer_r, start_angle + (end_angle-start_angle)/2))
	points.append(get_point_on_arc(outer_r, end_angle - (end_angle-start_angle)/4))
	points.append(get_point_on_arc(outer_r, end_angle))
	
	points.append(get_point_on_arc(inner_r, end_angle))
	points.append(get_point_on_arc(inner_r, end_angle - (end_angle-start_angle)/4))
	points.append(get_point_on_arc(inner_r, start_angle + (end_angle-start_angle)/2))
	points.append(get_point_on_arc(inner_r, start_angle + (end_angle-start_angle)/4))
	points.append(get_point_on_arc(inner_r, start_angle))
	
	set_collision_shape(points)

func add_node(label):
	var node = node_scene.instance()
	node.label = label
	node.level = level+1
	node.color_unselected = color_unselected
	node.color_selected = color_selected
	node.color = color_unselected
	
	add_child(node)
	print("node '" + node.label + "' added")

func update_children_angles():
	var children = []
	for child in get_children():
		if child.is_in_group("Node"):
			children.append(child)
	
	var nb_children = children.size()
	for i in range(0, nb_children):
		var child = children[i]
		child.start_angle = start_angle + i*(end_angle - start_angle)/ nb_children
		child.end_angle = i * end_angle / nb_children
		child.update_children_angles()


func get_point_on_arc(radius, angle):
	return Vector2(radius*cos(angle), radius*sin(angle))

func set_collision_shape(points):
	for i in range(0, points.size()):
		$Area2D/CollisionShape2D.shape.segments.set(i, points[i])

func _on_Area2D_mouse_entered():
	color = color_selected
	update()
#	$CircleSprite/CenterContainer/Label.set("custom_colors/font_color", Color(0,0,0))

func _on_Area2D_mouse_exited():
	color = color_unselected
	update()
#	$CircleSprite/CenterContainer/Label.set("custom_colors/font_color", Color(1,1,1))

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed:
			emit_signal("is_selected", self)
