extends Area2D

var player_in_area = false

func handle_entry(player) :
	# print("entered_area")
	# disable inputs
	if player.name.to_lower() != "player" : return
	player.disable_input()
	player.disable_collision_layer()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(handle_entry)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
