extends Node2D

@export var offset : Vector2 = Vector2(0, -320)
@export var duration : int = 5
@export var stop_loopping : bool = true

@export var stop_moving : bool = false
var is_oscillating = false

var tween : Tween

func start_oscillation() :
	tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops(10000 if not stop_loopping else 1).set_parallel(false)
	tween.tween_property($MovingBlock, "position", offset, duration/2.0)
	tween.tween_property($MovingBlock, "position", Vector2.ZERO, duration/2.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tween :
		tween.kill()
	if not stop_moving :
		start_oscillation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _exit_tree() -> void:
	if tween :
		tween.kill()
