extends Node2D

signal is_selected(node)

var node_scene = load("res://Node.tscn")

var center = Vector2(0,0)
var width = 50
var radius = 50

var label = ""
var level = 1
var start_angle = 0
var end_angle = 2*PI
var color_selected = Color.lightblue
var color_unselected = Color.darkblue
var color = color_unselected


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	draw_arc(center, level*radius, start_angle, end_angle, 2048, color, width)
	draw_arc(center, level*radius + width/2, start_angle, end_angle, 2048, Color.white, 2.0)
	draw_arc(center, level*radius - width/2, start_angle, end_angle, 2048, Color.white, 2.0)
	
	if abs(end_angle-start_angle) < 2*PI:
		var p1 = center + Vector2(cos(start_angle), sin(start_angle)) * (level*radius-width/2)
		var p2 = center + Vector2(cos(start_angle), sin(start_angle)) * (level*radius+width/2)
		draw_line(p1, p2, Color.white, 2.0)
		var p3 = center + Vector2(cos(end_angle), sin(end_angle)) * (level*radius-width/2)
		var p4 = center + Vector2(cos(end_angle), sin(end_angle)) * (level*radius+width/2)
		draw_line(p3, p4, Color.white, 2.0)
	
#	build_collision_shape()

func add_node(label):
	var node = node_scene.instance()
	node.label = label
	node.level = level+1
	node.color_unselected = color_unselected.lightened(node.level/10.0)
	node.color_selected = color_selected.lightened(node.level/10.0)
	node.color = node.color_unselected
	
	add_child(node)
	
	return node

func update_children_angles():
	var children = []
	for child in get_children():
		if child.is_in_group("Node"):
			children.append(child)
	
	var nb_children = children.size()
	
	for i in range(0, nb_children):
		var child = children[i]
		child.start_angle = start_angle + i*(end_angle - start_angle) / nb_children
		child.end_angle = (i+1) * end_angle / nb_children
		child.color.g += 0.25*i
		child.update_children_angles()


func get_point_on_arc(radius, angle):
	return Vector2(radius*cos(angle), radius*sin(angle))

func build_collision_shape():
	var points = PoolVector2Array()
	var inner_r = radius - width/2
	var outer_r = radius + width/2
	
	points.append(get_point_on_arc(outer_r, start_angle))
	points.append(get_point_on_arc(outer_r, start_angle + (end_angle-start_angle)/4.0))
	points.append(get_point_on_arc(outer_r, start_angle + (end_angle-start_angle)/2.0))
	points.append(get_point_on_arc(outer_r, end_angle - (end_angle-start_angle)/4.0))
	points.append(get_point_on_arc(outer_r, end_angle))
	
	points.append(get_point_on_arc(inner_r, end_angle))
	points.append(get_point_on_arc(inner_r, end_angle - (end_angle-start_angle)/4.0))
	points.append(get_point_on_arc(inner_r, start_angle + (end_angle-start_angle)/2.0))
	points.append(get_point_on_arc(inner_r, start_angle + (end_angle-start_angle)/4.0))
	points.append(get_point_on_arc(inner_r, start_angle))
	
	for i in range(0, points.size()):
		$Area2D/CollisionShape2D.shape.segments[i] = points[i]

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
