extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func _on_hurtbox_area_entered(area):
	queue_free()
	create_grass_effect()

func create_grass_effect():
	var grass_effect = GrassEffect.instantiate()
	get_parent().add_child(grass_effect)
	grass_effect.global_position = global_position
	pass
