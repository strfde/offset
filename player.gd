extends CharacterBody2D

signal player_collision(collision)

const SPEED = 350.0
const JUMP_VELOCITY = -600.0

var jump_count = 0
var allow_input = true

func disable_input() :
	allow_input = false
	
func enable_input() :
	allow_input = true
	
func disable_collision_layer() :
	$CollisionShape2D.set_deferred("disabled", true)

func enable_collision_layer() :
	$CollisionShape2D.set_deferred("disabled", false)

func play_death_animation() :
	var tween = get_tree().create_tween()
	# tween.tween_interval(0.2)
	tween.tween_property(self, "position", Vector2(position.x, position.y - 50), 0.2)
	await get_tree().create_timer(0.25).timeout
	disable_collision_layer()


func _ready() -> void:
	enable_collision_layer()
	enable_input()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		# var gravity = 1250
		velocity += get_gravity() * delta
	else :
		jump_count = 0
		# velocity += get_gravity() * delta

	# Handle jump.
	if allow_input and Input.is_action_just_pressed("jump") and jump_count < 2:
		jump_count += 1
		velocity.y = JUMP_VELOCITY if is_on_floor() else JUMP_VELOCITY*5/6

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if allow_input and direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_v = -1 + direction
		$AnimatedSprite2D.play("rolling")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.pause()
		# $AnimatedSprite2D.play("default")

	move_and_slide()
	
	for i in range(get_slide_collision_count()) :
		var collision = get_slide_collision(i)
		if allow_input :
			player_collision.emit(collision)
			
	if position.y > 2000 :
		Globals.game_over.emit(0)
