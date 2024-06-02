@tool # https://docs.godotengine.org/en/latest/tutorials/plugins/running_code_in_the_editor.html#doc-running-code-in-the-editor

class_name CollectibleItem
extends Area2D


@export_enum("berries", "frog", "herb0", "honey", "honey_spoiled", "mushroom0", "mushroom1", "mushroom2", "mushroom3", "mushroom4", "rhubarb") var SpriteTexture: String:
	set(new_texture): # called in editor
		SpriteTexture = new_texture # update property variable
		if is_node_ready():
			$AnimatedSprite2D.play(new_texture) # update tile node texture


@export_enum("color_shift", "evil_colors", "vignette", "shift") var EffectName: String
var _hasBeenPickedUp: bool = false


@export_range(-1, 1) var Strength: float = 0.34

func _ready():
	var rng = RandomNumberGenerator.new()
	$AnimatedSprite2D.play(SpriteTexture)
	$AnimatedSprite2D.set_frame_and_progress(rng.randi(), rng.randf())


func reactivateIfWasUsed():
	_hasBeenPickedUp = false;
	$AnimatedSprite2D.show()


func _on_body_entered(body: Node2D):
	if !_hasBeenPickedUp && body.name == "Player": # this requires player node to be called "Player"
		var global = get_tree().root.get_child(0) as GlobalScript
		global.on_collectible_pickup.emit(EffectName, Strength)
		_hasBeenPickedUp = true
		$AnimatedSprite2D.hide()
