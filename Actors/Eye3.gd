extends Sprite2D

@export var MAX_SPEED = .1
@export var DELAY = 0
var initial_position = Vector2.ZERO
var direction = true

func _ready():
	if transform.get_scale().x < 0:
		direction = false
	initial_position = global_position

func _process(delta):
	await get_tree().create_timer(DELAY).timeout
	var target = null
	if direction:
		target = initial_position + Vector2(32, 0)
		if (global_position == target):
			direction = false
			target = initial_position
	else:
		target = initial_position
		if (global_position == target):
			direction = true
			target = initial_position + Vector2(32, 0)
	flip_h = !direction
	global_position = global_position.move_toward(target, MAX_SPEED)
