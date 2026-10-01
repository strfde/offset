extends Button

@onready var title_node = $"../Title"
@onready var levels_node = $"../LevelMenu"
@onready var credits_node = $"../Credits"

func aux_fxn() :
	if text.to_lower() == "details" :
		text = "Levels"
		title_node.text = "DETAILS"
		credits_node.visible = true
		levels_node.visible = false
		
	else :
		text = "Details"
		title_node.text = "LEVELS"
		credits_node.visible = false
		levels_node.visible = true
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(aux_fxn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
