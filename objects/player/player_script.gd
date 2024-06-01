extends CharacterBody2D

var MOVE_SPEED = 100 * 60;

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.speed_scale = 2
	var global = get_tree().root.get_child(0) as GlobalScript
	global.on_collectible_pickup.connect(_on_collectible_interact)


func _physics_process(delta):
	
	# Process player input
	var moveDirection = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		moveDirection.x += -1
	if Input.is_action_pressed("move_right"):
		moveDirection.x += 1

	if Input.is_action_pressed("move_up"):
		moveDirection.y += -1
	if Input.is_action_pressed("move_down"):
		moveDirection.y += 1

	moveDirection = moveDirection.normalized() # Normalizing a zero vector is fine, returns another zero vector

	# Update walking sprite
	var spriteName = ""
	if moveDirection.length_squared() > 0:
		if abs(moveDirection.y) >= abs(moveDirection.x):
			if moveDirection.y > 0:
				spriteName = "walk_down"
			elif moveDirection.y <= 0:
				spriteName = "walk_up"
		else:
			if moveDirection.x > 0:
				spriteName = "walk_right"
			elif moveDirection.x <= 0:
				spriteName = "walk_left"
	else:
		spriteName = "idle_front"
	_animated_sprite.play(spriteName)

	# calculate player velocity and move
	velocity = moveDirection * delta * MOVE_SPEED;
	move_and_slide()


func _on_collectible_interact( effectName : String ):
	print( "Run over effect " + effectName )
	MOVE_SPEED *= 2
