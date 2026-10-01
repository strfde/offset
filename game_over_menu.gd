extends Popup

@onready var reason_node = $VBoxContainer/Reason

@onready var reload_button = $VBoxContainer/HBoxContainer/ReloadButton
@onready var next_button = $VBoxContainer/HBoxContainer/NextButton

var reason = ["You are miserable to lose this !", 
				"You are not done yet ! \n To the next one !!"]
				
func load_popup(success_code) :
	reason_node.text = reason[success_code]
	reload_button.visible = true if success_code == 0 else false
	next_button.visible = false if success_code == 0 else true
	
	if Globals.level >= 13 and success_code == 1:
		reason_node.text = "We will be back with more !! \n Until then, Home !!"
		next_button.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
