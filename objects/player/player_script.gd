extends CharacterBody2D

const move_speed = 100;

func _physics_process(delta):


	
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	if Input.is_action_pressed("move_up"):
		velocity.y = -move_speed
	elif Input.is_action_pressed("move_down"):
		velocity.y = move_speed
	else:
		velocity.y = move_toward(velocity.y, 0, move_speed)

	move_and_slide()
