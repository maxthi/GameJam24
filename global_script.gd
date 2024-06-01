extends Node


# Emitted whenever a pickup is picked up
signal on_collectible_pickup(effectName: String)


var player: Player = null
var spawnpoint: SpawnPoint = null

func reset_to_start():
	if player:
		player.resetEffects()
		if spawnpoint:
			spawnpoint.resetPlayer(player)
	var collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in collectibles:
		if collectible is CollectibleItem:
			collectible.reactivateIfWasUsed()

func _process(_delta: float):
	if Input.is_action_just_pressed("reset"):
		reset_to_start()
