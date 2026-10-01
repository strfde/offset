extends Button

func aux_fxn() :
	Globals.level += 1
	get_tree().call_deferred("change_scene_to_file", "res://level_" + str(Globals.level) +".tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(aux_fxn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
