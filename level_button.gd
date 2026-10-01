extends Button

var level = 0

func trigger_level() :
	Globals.level = level
	get_tree().change_scene_to_file("res://level_"+ str(level) +".tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if text.is_valid_int() :
		level = int(text)
		
	name = text
	pressed.connect(trigger_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
