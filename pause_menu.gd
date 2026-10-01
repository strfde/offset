extends Window

func aux_fxn() :
	close_requested.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ContinueButton.close_popup.connect(aux_fxn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
