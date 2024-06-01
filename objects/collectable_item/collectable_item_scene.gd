@tool # https://docs.godotengine.org/en/latest/tutorials/plugins/running_code_in_the_editor.html#doc-running-code-in-the-editor

class_name CollectibleItem
extends Area2D


@export var SpriteTexture: Texture:
	set(new_texture): # called in editor
		SpriteTexture = new_texture # update property variable
		$Sprite2D.texture = new_texture # update tile node texture


@export var EffectName: String
var _hasBeenPickedUp: bool = false


func _ready():
	$Sprite2D.texture = SpriteTexture


func reactivateIfWasUsed():
	_hasBeenPickedUp = false;
	$Sprite2D.show()


func _on_body_entered(body: Node2D):
	if !_hasBeenPickedUp && body.name == "Player": # this requires player node to be called "Player"
		var global = get_tree().root.get_child(0) as GlobalScript
		global.on_collectible_pickup.emit(EffectName)
		_hasBeenPickedUp = true
		$Sprite2D.hide()
