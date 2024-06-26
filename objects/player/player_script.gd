class_name Player
extends CharacterBody2D

const DEFAULT_MOVE_SPEED = 100 * 60;
#const PostProcess = preload("res://graphics/effects/PostProcess.tscn")
var _postProcessEffect : PostProcessing = null
var _moveSpeed: float = DEFAULT_MOVE_SPEED
var _lastMoveVec: Vector2

# plants
const MAX_PLANTS = 9
var _plantCount = 0

var _rng = RandomNumberGenerator.new()

# speech bubble timer
var _speechBubbleTimer = 0

func showSpeechBubble( icon, time ):
	_speechBubbleTimer = time
	$SpeechBubble.show()
	$SpeechBubble.play(icon)

func hideSpeechBubble():
	$SpeechBubble.hide()

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.speed_scale = 2
	var global = get_tree().root.get_child(0) as GlobalScript
	global.on_collectible_pickup.connect(_on_collectible_interact)
	global.player = self
	_postProcessEffect = get_tree().root.get_node("/root/PostProcess") as PostProcessing
	
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
		if abs(moveDirection.y) > abs(moveDirection.x):
			if moveDirection.y > 0:
				spriteName = "walk_down"
			elif moveDirection.y <= 0:
				spriteName = "walk_up"
		else:
			if moveDirection.x > 0:
				spriteName = "walk_right"
			elif moveDirection.x <= 0:
				spriteName = "walk_left"
	elif _lastMoveVec.length_squared() > 0:
		if abs(_lastMoveVec.y) > abs(_lastMoveVec.x):
			if _lastMoveVec.y > 0:
				spriteName = "idle_front"
			elif _lastMoveVec.y <= 0:
				spriteName = "idle_back"
		else:
			if _lastMoveVec.x > 0:
				spriteName = "idle_right"
			elif _lastMoveVec.x <= 0:
				spriteName = "idle_left"
	
	if spriteName.length() > 0:
		_animated_sprite.play(spriteName)
	if !_animated_sprite.is_playing():
		_animated_sprite.play("idle_front")

	# calculate player velocity and move
	_lastMoveVec = velocity
	velocity = moveDirection * delta * _moveSpeed;
	move_and_slide()
	
	# audio feedback
	if moveDirection.length_squared() > 0:
		if not $audio/steps.playing:
				$audio/steps.play()
	else:
		if $audio/steps.playing:
				$audio/steps.stop()
				
	# speech bubble timer
	if _speechBubbleTimer > 0:
		_speechBubbleTimer -= delta
	else:
		hideSpeechBubble()


func _on_collectible_interact( effectName : String, strength: float): 

	if strength < 0:
		$audio/frogsound.play()
	else:
		showSpeechBubble("heart", 2)
		var array = [$audio/bite, $audio/bite2, $audio/bite3]
		var rnd = _rng.randi_range(0,array.size()-1)
		array[rnd].play()

	if strength > 0:
		if effectName == "speed":
			_effect_speed()
		elif effectName == "invert_view":
			_invert_view()
		elif effectName == "color_shift":
			_postProcessEffect.enable_effect_ColorShift(strength)
		elif effectName == "evil_colors":
			_postProcessEffect.enable_effect_EvilColors()
		elif effectName == "vignette":
			_postProcessEffect.enable_effect_Vignette(strength)
		elif effectName == "shift":
			_postProcessEffect.enable_effect_Shift(strength)	
		print( "Run over effect " + effectName )
		_plantCount += 1
		if _plantCount >= MAX_PLANTS:
			get_tree().change_scene_to_file("res://levels/level2/level2.tscn")
	
	else:
		var allEffectsCleared = _postProcessEffect.reduceRandomIntensity(abs(strength))
		if allEffectsCleared:
			get_tree().change_scene_to_file("res://levels/world/world.tscn")


func _effect_speed():
	_moveSpeed += DEFAULT_MOVE_SPEED;
	_animated_sprite.speed_scale = _moveSpeed / DEFAULT_MOVE_SPEED

func _invert_view():
	$Camera2D.zoom.y *= -1;

func resetEffects():
	# color_shift
	if _postProcessEffect:
		_postProcessEffect.queue_free()
		_postProcessEffect = null

	#speed
	_moveSpeed = DEFAULT_MOVE_SPEED
	_animated_sprite.speed_scale = 1

	# invert_view
	if $Camera2D.zoom.y < 0:
		$Camera2D.zoom.y *= -1
