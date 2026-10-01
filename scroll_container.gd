extends ScrollContainer

func _ready() -> void:
	var scroll_bar = get_v_scroll_bar()
	
	scroll_bar.custom_minimum_size.x = 10
