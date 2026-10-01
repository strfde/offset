extends Node2D

@export var duration:float = 0.5
@export var initial_delay = 0
var vanishing_tween: Tween

func hide_van() -> void:
	$AnimatableBody2D.visible = false
	$AnimatableBody2D/CollisionShape2D.disabled = true


func show_van() -> void:
	$AnimatableBody2D.visible = true
	$AnimatableBody2D/CollisionShape2D.disabled = false


func start_vanishing() -> void:
	vanishing_tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	vanishing_tween.set_loops(10000)

	if initial_delay:
		vanishing_tween.tween_interval(initial_delay)
		initial_delay = 0

	vanishing_tween.tween_callback(hide_van)
	vanishing_tween.tween_interval(2 * duration)
	vanishing_tween.tween_callback(show_van)
	vanishing_tween.tween_interval(duration)

func _ready() -> void:
	if vanishing_tween:
		vanishing_tween.kill()
	start_vanishing()


func _exit_tree() -> void:
	if vanishing_tween:
		vanishing_tween.kill()
