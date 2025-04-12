@tool

class_name DisplayPolygon2D
extends CollisionPolygon2D

@export
var PolygonColor: Color = Color("#ffffff"):
	set(value):
		PolygonColor = value
		queue_redraw()

func _ready():
	if Engine.is_editor_hint():
		editor_state_changed.connect(queue_redraw)

func _draw():
	if polygon.size() > 2:
		draw_colored_polygon(polygon, PolygonColor)
