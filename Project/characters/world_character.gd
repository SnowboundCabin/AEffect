extends CharacterBody3D

const SPEED = 5.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var sprite_node = $CharacterSprite


func _ready():
	$ShadowArm.add_excluded_object(get_rid())


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("game_left", "game_right", "game_up", "game_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if velocity.x < 0:
			sprite_node.flip_h = true
		if velocity.x > 0:
			sprite_node.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
