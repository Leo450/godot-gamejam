extends CharacterBody2D

@export var ACCELERATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 700

enum {
	MOVE,
	ATTACK
}

var state = MOVE

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _physics_process(delta):
	match state:
		MOVE: move_state(delta)
		ATTACK: attack_state(delta)

func move_state(delta):
	var input_vector = input_to_velocity(delta)
	animate(input_vector)
	move_and_slide()

func attack_state(delta):
	pass

func input_to_velocity(delta):
	var input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	return input_vector

func animate(input_vector):
	if input_vector == Vector2.ZERO:
		animation_state.travel("Idle")
		return
		
	animation_tree.set("parameters/Idle/blend_position", input_vector)
	animation_tree.set("parameters/Run/blend_position", input_vector)
	animation_state.travel("Run")
