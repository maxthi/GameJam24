extends CanvasLayer

class_name PostProcessing

var _effectMix = [0.0, 0.0, 0.0, 0.0]
var _targetEffectMix = [0.0, 0.0, 0.0, 0.0]
@onready var _effectShaders: Array[ShaderMaterial] = [
	$EvilColorsLayer/Effect.material as ShaderMaterial,
	$ColorShiftLayer/Effect.material as ShaderMaterial,
	$VignetteLayer/Effect.material as ShaderMaterial,
	$ShiftLayer/Effect.material as ShaderMaterial,
]

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass


const EFFECT_INCREASE = 0.1
const EFFECT_DECREASE = 0.5


func _applyIntensity(intensity: float, material: ShaderMaterial):
	material.set_shader_parameter("intensity_mix", intensity)


func applyAllIntensities():
	for i: int in _effectMix.size():
		_applyIntensity(_effectMix[i], _effectShaders[i])


func reduceRandomIntensity(strength: float) -> bool:
	var indices = []
	for i: int in _targetEffectMix.size():
		if _targetEffectMix[i] > 0:
			indices.push_back(i)

	if indices.size() > 0:
		var rng = RandomNumberGenerator.new()
		var index = indices[rng.randi() % indices.size()]
		_targetEffectMix[index] = clamp(_targetEffectMix[index] - strength, 0, 1)
		return indices.size() == 1 && _targetEffectMix[index] == 0
	else:
		return true
	

func _processIntensity(delta: float, intensity: float, target: float, material: ShaderMaterial) -> float:
	if intensity == target:
		return target
	if abs(intensity - target) < 0.01:
		target = target
	elif intensity > target:
		intensity = clampf(intensity - delta * EFFECT_DECREASE, target, 1)
	else:
		intensity = clampf(intensity + delta * EFFECT_INCREASE, 0, target)
	_applyIntensity(intensity, material)
	return intensity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	for i: int in _effectMix.size():
		_effectMix[i] = _processIntensity(delta, _effectMix[i], _targetEffectMix[i], _effectShaders[i])

func enable_effect_EvilColors():
	_targetEffectMix[0] = clampf(_targetEffectMix[0] + 1.0, 0, 1)


func enable_effect_ColorShift(strength: float):
	_targetEffectMix[1] = clampf(_targetEffectMix[1] + strength, 0, 1)


func enable_effect_Vignette(strength: float):
	_targetEffectMix[2] = clampf(_targetEffectMix[2] + strength, 0, 1)


func enable_effect_Shift(strength: float):
	_targetEffectMix[3] = clampf(_targetEffectMix[3] + strength, 0, 1)


func _soft_reset_effects():
	for i: int in _targetEffectMix.size():
		_targetEffectMix[i] = 0.0
