extends Node

@export
var InputKey: StringName = "space"

@onready var player: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event):
	if event.is_echo(): return
	if event.is_action(InputKey):
		player.play("control", -1, 1 if event.is_pressed() else -1, !event.is_pressed())
