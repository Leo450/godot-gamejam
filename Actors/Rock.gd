extends CharacterBody2D

@onready var audio_stream_player = $AudioStreamPlayer

var tween = null

func _on_area_2d_body_entered(body):
	var direction = body.last_input_vector
	if direction.x != 0 && direction.y != 0:
		direction.x = sign(direction.x)
		direction.y = 0
	
	var can_move = !test_move(transform, direction * 16)
	
	if can_move && (tween == null || !tween.is_running()):
		tween = create_tween()
		tween.tween_property(self, "global_position", global_position + direction * 16, .5)
		audio_stream_player.play()

