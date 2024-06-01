@tool
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var rng = RandomNumberGenerator.new()
var timePassed = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timePassed += delta
	if timePassed > 1:
		timePassed = 0
		var my_random_number = rng.randf_range(0, 100)
		if my_random_number < 30:
			$AnimatedSprite2D.play("smile")
		else:
			$AnimatedSprite2D.play("default")
