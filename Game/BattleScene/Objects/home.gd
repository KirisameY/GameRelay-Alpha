@tool
class_name Home
extends Area2D

func _draw():
	draw_rect(Rect2(-16,-256,32,512), Color("#ff3300aa"), true, -1, true)
	draw_rect(Rect2(-16,-256,32,512), Color("#ff3300cc"), false, 2, true)


signal enemy_entered(enemy: Node2D)

func _on_body_entered(body: Node2D):
	body.queue_free()
	enemy_entered.emit(body)
