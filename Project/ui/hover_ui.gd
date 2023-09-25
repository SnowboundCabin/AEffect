extends Node3D
## Adjusts a control to follow its position.

@onready var hcon = get_children()[0]

func _ready():
	set_notify_transform(true)
	_notification(2000)

func _notification(what):
	if what == 2000:
		var acam = get_viewport().get_camera_3d()
		if acam.is_position_behind(get_global_transform().origin):
			hcon.set_position(-hcon.get_size()) #SHOULD put the hcon out of sight when it goes too far behind.
		else:
			hcon.set_position(
				acam.unproject_position(get_global_transform().origin)
			)
