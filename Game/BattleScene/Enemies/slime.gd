extends AnimatableBody2D

@export var MaxHealth: float
@onready var Health: float = MaxHealth

func _physics_process(delta):
	move_and_collide(Vector2.LEFT*24*delta)

func take_damage(damage: float):
	Health -= damage
	if Health <= 0: 
		die.emit()
		queue_free()

signal die()
