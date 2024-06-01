class_name SpawnPoint
extends Node2D

@export var player_scene: PackedScene
@export var level_scene: PackedScene
var _playerUpdatePosition: Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var player: Player = get_tree().root.find_child("Player") as Player
	_playerUpdatePosition = player
	#get_tree().create_timer()
	#defer
	call_deferred("resetPlayer", player)
	#resetPlayer(player)

	var global = get_tree().root.get_child(0) as GlobalScript
	global.spawnpoint = self
	
	$Sprite2D.hide()

func _process(_delta: float):
	if _playerUpdatePosition:
		resetPlayer(_playerUpdatePosition)
		_playerUpdatePosition = null

func resetPlayer(player: Player):
	if player:
		player.move_and_slide()
		player.global_transform = global_transform
		#player.set_po
		#player.global_position = global_position
