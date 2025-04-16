@tool
extends StaticBody2D

@export var source:CollisionShape2D

func get_shape() -> RectangleShape2D:
	return source.shape

func _ready() -> void:
	queue_redraw()
	
func _draw() -> void:
	draw_rect(Rect2(source.position-get_shape().size/2,get_shape().size),"#cccccc")
