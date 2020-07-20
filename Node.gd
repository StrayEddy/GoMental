extends Node2D

signal is_selected(node)

var node_scene = load("res://Node.tscn")

var center = Vector2(0,0)
var width = 50
var radius = 50

var label = ""
var path = "/root"
var level = 1
var start_angle = 0
var end_angle = 2*PI
#var color_normal = Color( 0, 0, 0.33, 1 )
var color_normal = Color.darkblue
var color_selected = Color.black

var is_selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	var color = color_normal
	if is_selected:
		color = color_selected
	
	if level > 1:
		draw_arc(center, level*radius, start_angle, end_angle, 2048, color, width)
		draw_arc(center, level*radius + width/2, start_angle, end_angle, 2048, Color.white, 2.0)
		draw_arc(center, level*radius - width/2, start_angle, end_angle, 2048, Color.white, 2.0)
	else:
		draw_arc(center, level*radius - width/2, start_angle, end_angle, 2048, color, width*2)
		draw_arc(center, level*radius + width/2, start_angle, end_angle, 2048, Color.white, 2.0)
	
	if abs(end_angle-start_angle) < 2*PI:
		var p1 = center + Vector2(cos(start_angle), sin(start_angle)) * (level*radius-width/2)
		var p2 = center + Vector2(cos(start_angle), sin(start_angle)) * (level*radius+width/2)
		draw_line(p1, p2, Color.white, 2.0)
		var p3 = center + Vector2(cos(end_angle), sin(end_angle)) * (level*radius-width/2)
		var p4 = center + Vector2(cos(end_angle), sin(end_angle)) * (level*radius+width/2)
		draw_line(p3, p4, Color.white, 2.0)
		
		#Put label at center of arc
		var middle_angle = start_angle + (end_angle-start_angle)/2.0
		var label_pos = center + Vector2(cos(middle_angle), sin(middle_angle)) * (level*radius)
		label_pos -= Vector2($Label.rect_size.x/2, $Label.rect_size.y/2)
		$Label.rect_pivot_offset = $Label.rect_size/2
		$Label.set_position(label_pos, false)
		if middle_angle < PI:
			$Label.set_rotation(middle_angle-PI/2.0)
		else:
			$Label.set_rotation(middle_angle+PI/2.0)
	elif level > 1:
		#Put label at center of arc
		var label_pos = center + Vector2(cos(2*PI/4), sin(2*PI/4)) * (level*radius)
		label_pos -= Vector2($Label.rect_size.x/2, $Label.rect_size.y/2)
		$Label.rect_pivot_offset = $Label.rect_size/2
		$Label.set_position(label_pos, false)

func add_node(label):
	var node = node_scene.instance()
	node.label = label
	node.path = path + "/" + label
	node.get_node("Label").text = label
	node.level = level+1
	node.color_normal = color_normal.lightened(node.level/20.0)
	
	add_child(node)
	
	return node

func update():
	var children = []
	for child in get_children():
		if child.is_in_group("Node"):
			children.append(child)
	
	var nb_children = children.size()
	
	for i in range(0, nb_children):
		var child = children[i]
		child.start_angle = start_angle + i*(end_angle - start_angle) / nb_children
		child.end_angle = start_angle + (i+1)*(end_angle - start_angle) / nb_children
#		child.color.g = color.g + 0.25*i
#		child.color_unselected.g = color_unselected.g + 0.25*i
		child.update()
	
	.update()


func get_point_on_arc(radius, angle):
	return Vector2(radius*cos(angle), radius*sin(angle))
			

func select():
	unselect_all_nodes()
	is_selected = true
	return self

func unselect():
	is_selected = false
	return self

func unselect_all_nodes():
	for node in get_tree().get_nodes_in_group("Node"):
		node.unselect()

func set_label(text):
	$Label.text = text

func get_nodes():
	var nodes = []
	for child in get_children():
		if child.is_in_group("Node"):
			nodes.append(child)
	
	return nodes
