extends Button

func aux_fxn() :
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(aux_fxn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
