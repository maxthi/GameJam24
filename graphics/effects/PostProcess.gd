extends CanvasLayer

class_name PostProcessing

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func enable_effect_EvilColors():
	$EvilColorsLayer/Effect.show()


func enable_effect_ColorShift():
	$ColorShiftLayer/Effect.show()


func enable_effect_Vignette():
	$VignetteLayer/Effect.show()


func enable_effect_Shift():
	$ShiftLayer/Effect.show()
