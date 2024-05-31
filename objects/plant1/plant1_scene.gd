extends Area2D

signal entered_signal

func _on_body_entered(body):
	entered_signal.emit() # tell the world it was collided
	queue_free() # delete plant
