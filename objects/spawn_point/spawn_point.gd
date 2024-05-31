extends Node2D

@export var player_scene: PackedScene
@export var level_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var player = player_scene.instantiate()
	var player_root_node : CharacterBody2D = player.get_node("CharacterBody2D")
	player_root_node.property
	
	
	
	
