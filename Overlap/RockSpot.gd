extends Marker2D

signal rock_status_changed

var rock_status = false : set = _set_rock_status

func _set_rock_status(value):
	rock_status = value
	emit_signal("rock_status_changed", value)

func _on_area_2d_area_entered(area):
	self.rock_status = true

func _on_area_2d_area_exited(area):
	self.rock_status = false
