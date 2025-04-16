@tool
class_name Ball
extends RigidBody2D

@export_range(0,32)
var Size: float = 8:
	set(value):
		Size = value
		call_deferred("set_size", value)

func _draw():
	draw_circle(Vector2.ZERO, Size+0.75, Color.BLACK, true, -1.0, true)
	draw_circle(Vector2.ZERO, Size, Color.WHITE, true, -1.0, true)

func set_size(size: float):
	($Shape.shape as CircleShape2D).radius = size
	queue_redraw()
