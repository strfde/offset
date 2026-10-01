extends Node2D

@export var player : CharacterBody2D
@export var target : CharacterBody2D

@export var vanish_duration : float = 1.0

@onready var game_over_menu = $"Game Over Menu"
@onready var pause_menu = $"Pause Menu"
@onready var black_screen = $BlackScreen

var game_over : bool = false

func display_game_over(success_code) :
	# display Gave Over PopUp
	if game_over :
		return
	game_over = true
	game_over_menu.load_popup(success_code)
	black_screen.visible = true
	game_over_menu.visible = true

func handle_player_collision(collision) :
	var collider = collision.get_collider()
	
	if collider.name.to_lower().contains("target") :
		player.disable_input()
		if target : target.disable_input()
		await get_tree().create_timer(1).timeout
		# display_game_over_pop_up
		display_game_over(1)
		
	if collider.name.to_lower() == "pinsblock" :
		player.disable_input()
		if target : target.disable_input()
		player.play_death_animation()
		await get_tree().create_timer(1).timeout
		# display game_over_pop_up
		display_game_over(0)
		
	if collider.name.to_lower().contains("movingblock") :
		collider = collider.get_parent()
		if collider.stop_moving and not collider.is_oscillating:
			collider.is_oscillating = true
			await collider.start_oscillation()
			collider.is_oscillating = false
		
	if collider.name.to_lower() == "pole" :
		player.disable_input()
		if target : target.disable_input()
		player.play_death_animation()
		await get_tree().create_timer(1).timeout
		# disaply game_over_pop_up
		# display_game_over(0)
		
	if collider.name.to_lower().contains("hit") :
		await get_tree().create_timer(vanish_duration).timeout
		if collider : collider.queue_free()


func handle_target_collision(collision) :
	var collider = collision.get_collider()
	
	if collider.name.to_lower() == "pinsblock" :
		player.disable_input()
		if target : target.disable_input()
		target.play_death_animation()
		await get_tree().create_timer(1).timeout
		# display game_over_pop_up
		display_game_over(0)
		
	if collider.name.to_lower().contains("movingblock") :
		collider = collider.get_parent()
		if collider.stop_moving and not collider.is_oscillating:
			collider.is_oscillating = true
			await collider.start_oscillation()
			collider.is_oscillating = false
			

func open_pause_popup() :
	player.disable_input()
	black_screen.visible = true
	pause_menu.visible = true

func close_pause_popup() :
	black_screen.visible = false
	pause_menu.visible = false
	player.enable_input()
	
	if game_over :
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", ("res://main.tscn"))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not player :
		# Show Error PopUp
		pass
	
	game_over = false
	
	pause_menu.close_requested.connect(close_pause_popup)
	game_over_menu.popup_hide.connect(close_pause_popup)
	
	Globals.game_over.connect(display_game_over)
	player.player_collision.connect(handle_player_collision)
	if target :
		target.target_collision.connect(handle_target_collision)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		# disable player inputs
		# show pause menu
		# save game state
		open_pause_popup()
