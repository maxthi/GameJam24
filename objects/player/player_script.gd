extends CharacterBody2D

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * 30
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
