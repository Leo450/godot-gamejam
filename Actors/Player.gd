extends CharacterBody2D

@export var ACCELERATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 700

enum {
	MOVE,
	ATTACK,
	CHANGE_MAP,
	NOP
}

var state = MOVE
var input_vector = Vector2.ZERO
var last_input_vector = Vector2.ZERO
var timer = null

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var hitbox_collision_shape = $HitboxPivot/Hitbox/CollisionShape2D

func _ready():
	Events.connect("translate_camera", _on_translate_camera)
	Events.connect("nop_camera", _on_nop_camera)
	hitbox_collision_shape.disabled = true

func _physics_process(delta):
	match state:
		MOVE: move_state(delta) 
		ATTACK: attack_state(delta)
		CHANGE_MAP: change_map_state(delta)
		NOP: nop_state(delta)

func move_state(delta):
	input_to_velocity(delta)
	animate(input_vector)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		state = ATTACK
	
	if Input.is_action_just_pressed("ui_focus_next"):
		Events.toggle_power()

func attack_state(delta):
	animation_state.travel("Attack")
	velocity = Vector2.ZERO

func _on_animation_tree_animation_finished(anim_name: String):
	if anim_name.begins_with("Attack"):
		state = MOVE

func _on_translate_camera(direction):
	state = CHANGE_MAP
	await create_tween().tween_property(self, "global_position", global_position + direction * 12, .5).finished
	state = MOVE

func _on_nop_camera(direction):
	state = CHANGE_MAP
	await create_tween().tween_property(self, "global_position", global_position + direction * -12, .5).finished
	state = MOVE

func change_map_state(delta):
	pass

func nop_state(delta):
	pass

func input_to_velocity(delta):
	input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	
	if input_vector != Vector2.ZERO:
		last_input_vector = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func animate(input_vector):
	if input_vector == Vector2.ZERO:
		animation_state.travel("Idle")
		return
		
	animation_tree.set("parameters/Idle/blend_position", input_vector)
	animation_tree.set("parameters/Run/blend_position", input_vector)
	animation_tree.set("parameters/Attack/blend_position", input_vector)
	animation_state.travel("Run")
