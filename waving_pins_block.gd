extends Node2D

@export var duration = 0.1
@export var show_pins = true

var tween : Tween

func enable_wave(player) :
	# print("enabling wave ... ")
	if player.name.to_lower() != "player" :
		return
	tween = get_tree().create_tween()
	tween.tween_property($WavingBlock, "position", Vector2($WavingBlock.position.x, 0), duration)
	tween.tween_property($WavingBlock, "rotation_degrees", -90, duration*(2))
	tween.set_loops(1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not show_pins :
		$"Pins Block".disable_pins()
	$"Waving Block Entry Area".trigger_wave.connect(enable_wave)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _exit_tree() -> void:
	if tween :
		tween.kill()
