@tool
extends Area2D


func _ready():
	(func(): 
		$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	).call_deferred()

######################## Display ########################

@export_category("Display")

var Size: Vector2 = Vector2(128,24):
	set(value):
		Size = value
		call_deferred("set_size", value)

@export_range(0, 512) var SizeX: float = 128:
	get: return Size.x
	set(value): Size.x = value

@export_range(0,64) var SizeY: float = 24:
	get: return Size.y
	set(value): Size.y = value


func _draw():
	var rect := Rect2(-Size/2,Size)
	draw_rect(rect, Color("#ffffffaa"), true, -1.0, true)
	draw_rect(rect, Color("#ffffffcc"), false, 1.5, true)

func set_size(size: Vector2):
	($CollisionShape2D.shape as RectangleShape2D).size = size
	queue_redraw()

func set_text():
	const SYMBOLS : Array[String] = ["+", "-", "×", "÷"]
	var symbol:= SYMBOLS[Mode]
	$Label.text = symbol + str(Value)

######################## Crease ########################

enum CreaseMode{Add, Sub, Mul, Div}

@export_category("Function")

@export var Mode: CreaseMode:
	set(value):
		Mode = value
		call_deferred("set_text")

@export var Value: int = 1:
	set(value):
		Value = value
		call_deferred("set_text")

var InRangeObjects: Array[Ball]
@onready var Counter: int = Value


func _on_body_entered(body: Node2D):
	if InRangeObjects.has(body): return
	var ball = body as Ball
	if ball == null: return
	InRangeObjects.append(ball)
	
	match Mode:
		CreaseMode.Add:
			if Value <= 0: return
			Value -= 1
			add_ball(ball)
		CreaseMode.Sub:
			if Value <= 0: return
			Value -= 1
			remove_ball(ball)
		CreaseMode.Mul:
			if Value == 0: remove_ball(ball)
			elif Value > 1: 
				for i in range(Value-1): add_ball(ball)
		CreaseMode.Div:
			Counter -= 1
			if Counter == 0: Counter = Value
			else: remove_ball(ball)

func _on_body_exited(body: Node2D):
	if to_local(body.global_position).dot(Vector2.DOWN) > 0:
		InRangeObjects.erase(body)


func add_ball(ball: Ball):
	var new_body = ball.duplicate()
	new_body.position += Vector2(randf_range(-1,1), randf_range(-1,1))
	InRangeObjects.append(new_body)
	ball.get_parent().call_deferred("add_child", new_body)

func remove_ball(ball: Ball):
	InRangeObjects.erase(ball)
	ball.queue_free()
