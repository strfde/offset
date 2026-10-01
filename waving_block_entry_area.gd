extends Area2D

var exited_area = false

signal trigger_wave(body)

func handle_entry(body) :
	if body.name.to_lower() != "player" : return 
	if exited_area :
		exited_area = false
		# print("Player entered area")
		trigger_wave.emit(body)
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exited_area = true
	body_entered.connect(handle_entry)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
