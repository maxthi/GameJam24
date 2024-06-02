class_name Teleporter
extends Area2D


@export var enabled: bool = true
@export var scene: PackedScene = null 


# Called when the node enters the scene tree for the first time.
func _ready():
	if !body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body: Node2D):
	if enabled && scene:
		get_tree().change_scene_to_packed(scene)
