extends AnimatedSprite2D

func _ready():
	connect("animation_finished", _on_animation_finished)
	play("Default")

func _on_animation_finished():
	queue_free()
