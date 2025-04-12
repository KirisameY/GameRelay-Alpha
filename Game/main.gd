extends Node

# 临时代码
func _ready():
	(func(): get_tree().change_scene_to_file("res://Gui/StageSelect.tscn")).call_deferred()
