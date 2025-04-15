@tool
class_name Effector
extends Area2D

var Size: Vector2 = Vector2(64, 64):
	set(value):
		Size = value
		call_deferred("set_size", value)

@export_range(32, 512) var SizeX: float = 64:
	get: return Size.x
	set(value): Size.x = value

@export_range(32,512) var SizeY: float = 64:
	get: return Size.y
	set(value): Size.y = value

@export var Icon: Texture2D = PlaceholderTexture2D.new():
	set(value):
		Icon = value
		queue_redraw()

@export_color_no_alpha
var BgColor: Color = Color("#ffffff"):
	set(value):
		BgColor = value
		queue_redraw()


func _ready():
	if not has_node("CollisionShape2D"):
		var shape = CollisionShape2D.new()
		shape.name = "CollisionShape2D"
		shape.visible = false
		shape.shape = RectangleShape2D.new()
		shape.shape.size = Size
		add_child(shape)
	else:
		(func():
			$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
			$CollisionShape2D.shape.size = Size
		).call_deferred()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	collision_layer = 0
	collision_mask = 2

func _draw():
	var rect := Rect2(-Size/2,Size)
	draw_rect(rect, BgColor * Color("#ffffffaa"), true, -1.0, true)
	draw_rect(rect, BgColor * Color("#ffffffcc"), false, 1.5, true)
	if Icon != null: draw_texture_rect(Icon, Rect2(-16, -16, 32, 32), false)


func set_size(size: Vector2):
	if $CollisionShape2D.shape != null:
		($CollisionShape2D.shape as RectangleShape2D).size = size
	queue_redraw()


#################### Function ####################

var AffectingBalls: Array[Ball]

#virtual method for apply an effect on ball, override this
func _effect_ball(_ball: Ball): pass

func _on_body_entered(body):
	var ball := body as Ball
	if ball == null or AffectingBalls.has(ball): return
	
	AffectingBalls.append(ball)
	ball.tree_exiting.connect(func():AffectingBalls.erase(ball),\
							  ConnectFlags.CONNECT_ONE_SHOT)
	_effect_ball(ball)


func _on_body_exited(body):
	if body is not Ball: return
	AffectingBalls.erase(body)
