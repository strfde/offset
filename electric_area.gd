extends Area2D

func trigger_shock(player) :
	if player.name.to_lower() != "player" :
		return
	player.disable_input()
	await player.play_death_animation()
	# make shock sprite appear
	# player.game_over.emit("Shocked to Death!")
	player.disable_collision_layer()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(trigger_shock)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
