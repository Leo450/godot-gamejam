extends Area2D

var player_inside = false
var current_player_id = 1

func _process(delta):
	if Input.is_action_just_pressed("easter"):
		if current_player_id == 1:
			current_player_id = 2
		else:
			current_player_id = 1
		Events.emit_signal("easter_egg", current_player_id)

func _on_body_entered(body):
	player_inside = true

func _on_body_exited(body):
	player_inside = false
