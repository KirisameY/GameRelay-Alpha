extends RigidBody2D

@export_range(0,32)
var Size: float = 8:
	set(value):
		Size = value
		call_deferred("set_size", value)

func set_size(size: float):
	($CollisionShape2D.shape as CircleShape2D).radius = size
	queue_redraw()

func _ready():
	contact_monitor = true
	max_contacts_reported = 1

func _draw():
	draw_circle(Vector2.ZERO, Size, Color.WHITE, true, -1.0, true)


@export var DamageRate: float

func _on_body_entered(body: Node):
	if body.has_method("take_damage"):
		body.take_damage(linear_velocity.length() * DamageRate)
	var particles : GPUParticles2D = $GPUParticles2D
	particles.finished.connect(particles.queue_free)
	particles.emitting = false
	particles.reparent(get_parent())
	queue_free()
