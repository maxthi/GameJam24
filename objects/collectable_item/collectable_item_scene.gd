@tool # https://docs.godotengine.org/en/latest/tutorials/plugins/running_code_in_the_editor.html#doc-running-code-in-the-editor
extends Area2D

#https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
signal entered_signal( effectName )

@export var SpriteTexture : Texture :
	set(new_texture): # called in editor
		SpriteTexture = new_texture # update property variable
		$Sprite2D.texture = new_texture # update tile node texture
		
@export var EffectName : String

func _ready():
	$Sprite2D.texture = SpriteTexture

func _on_body_entered(body):
	if body.name == "Player": # this requires player node to be called "Player"
		entered_signal.emit( EffectName ) # tell the world object was collided
		queue_free() # delete plant
