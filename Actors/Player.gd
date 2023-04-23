extends CharacterBody2D

@export var ACCELERATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 700

enum {
	MOVE,
	ATTACK,
	CHANGE_MAP,
	NOP,
	CINEMATIK
}

var state = MOVE
var input_vector = Vector2.ZERO
var last_input_vector = Vector2.ZERO
var timer = null

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var animation_player = $AnimationPlayer
@onready var hitbox_collision_shape = $HitboxPivot/Hitbox/CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var shadow = $Shadow

func _ready():
	Events.connect("translate_camera", _on_translate_camera)
	Events.connect("nop_camera", _on_nop_camera)
	Events.connect("cinematik", _on_cinematik)
	hitbox_collision_shape.disabled = true

func _physics_process(delta):
	match state:
		MOVE: move_state(delta) 
		ATTACK: attack_state(delta)
		CHANGE_MAP: change_map_state(delta)
		NOP: nop_state(delta)
		CINEMATIK: cinematik_state(delta)

func move_state(delta):
	input_to_velocity(delta)
	animate(input_vector)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		state = ATTACK

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

func _on_cinematik():
	state = CINEMATIK
	
	await create_tween().tween_property(self, "global_position", Vector2(160, -960), 2).finished
	
	animation_tree.active = false
	await get_tree().create_timer(3).timeout
	
	animation_player.play("Fall")
	await get_tree().create_timer(8).timeout
	
	shadow.visible = true
	shadow.play("default")
	await create_tween().tween_property(sprite_2d, "offset", Vector2(0, -60), 6).finished
	shadow.stop()
	shadow.frame = 2
	
	await get_tree().create_timer(2).timeout
	
	Events.toggle_power()
	await get_tree().create_timer(1).timeout
	Events.toggle_power()
	await get_tree().create_timer(1).timeout
	Events.toggle_power()
	await get_tree().create_timer(.75).timeout
	Events.toggle_power()
	await get_tree().create_timer(.5).timeout
	Events.toggle_power()
	await get_tree().create_timer(.2).timeout
	Events.toggle_power()
	await get_tree().create_timer(.2).timeout
	Events.toggle_power()
	await get_tree().create_timer(.1).timeout
	Events.toggle_power()
	await get_tree().create_timer(.1).timeout
	Events.toggle_power()
	await get_tree().create_timer(.1).timeout
	Events.toggle_power()
	await get_tree().create_timer(.1).timeout
	Events.toggle_power()
	await get_tree().create_timer(.1).timeout
	
	await get_tree().create_timer(3).timeout
	
	shadow.play("reverse")
	await create_tween().tween_property(sprite_2d, "offset", Vector2(0, 0), 6).finished
	shadow.stop()
	shadow.visible = false
	
	Events.toggle_power()
	
	await get_tree().create_timer(3).timeout
	
	animation_tree.active = true
	state = MOVE
	
	Events.emit_signal("cinematik_done")

func cinematik_state(delta):
	pass
	
