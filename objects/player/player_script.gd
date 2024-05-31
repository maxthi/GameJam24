extends CharacterBody2D

const MOVE_SPEED = 100;

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.speed_scale = 2

func _physics_process(delta):
	
	var moveDirection = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		moveDirection.x = -1
		_animated_sprite.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		moveDirection.x = 1
		_animated_sprite.play("walk_right")
	
	if Input.is_action_pressed("move_up"):
		moveDirection.y = -1
		_animated_sprite.play("walk_up")
	elif Input.is_action_pressed("move_down"):
		moveDirection.y = 1
		_animated_sprite.play("walk_down")

	# calculate player velocity
	var vel = Vector2( moveDirection.x * MOVE_SPEED, moveDirection.y * MOVE_SPEED)
	
	# update node member
	velocity = vel;
	move_and_slide()
	
	# update animation
	if moveDirection.length() == 0:
		_animated_sprite.play("idle_front")
