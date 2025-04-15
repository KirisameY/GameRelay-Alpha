extends Node2D

@onready var left = get_node("Left")
@onready var right = get_node("Right")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_Z:
				set_block(0,left,event.is_pressed())
			KEY_C:
				set_block(1,right,event.is_pressed())
			KEY_SPACE:
				set_separate(event.is_pressed())

func set_block(direction:int,block:StaticBody2D,rise:bool) -> void:
	
	var modifier = 1 if direction%2==1 else -1
	if(!rise):
		var tween = create_tween()
		tween.tween_property(block,"rotation",0,0.05)
		block.constant_angular_velocity = 0
	else:
		var tween = create_tween()
		tween.tween_property(block,"rotation_degrees",modifier*50,0.05)
		tween.tween_property(block,"constant_angular_velocity",modifier*30,0)
		tween.tween_property(block,"constant_angular_velocity",0,0.05)

func set_separate(separeted:bool) -> void:
	pass
