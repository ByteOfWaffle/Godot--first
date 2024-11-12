extends CharacterBody2D


const SPEED = 230.0
const JUMP_VELOCITY = -300.0
var MAX_JUMPS = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and MAX_JUMPS >1: #If spacebar is pressed and max jumps is more than 1 then jump, since max jumps starts at two, this allows for double jump.
		velocity.y = JUMP_VELOCITY
		MAX_JUMPS -=1



	# Get the input direction and handle the movement/deceleration.
	#Get input direction -1, 0 or 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play animation
	if is_on_floor():
		MAX_JUMPS = 2
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
#Handle hiding, can make the player have the same laye ras floor, but different layer from enemy, or actually i can maybe get away with temporarely removing the collision layer of the enemy raycast or player.
	if Input.is_action_just_pressed("hide"):
		hidecharacter()
	move_and_slide()
var is_hidden = false
func hidecharacter():
	if is_hidden == false:
		is_hidden = true
		set_collision_layer_value(2, false)
		set_collision_layer_value(9, false)
		set_collision_mask_value(2, false)
		set_collision_mask_value(1, false)
		set_collision_mask_value(9, false)
		print("enabled")
	else:
		set_collision_layer_value(2, true)
		set_collision_layer_value(9, true)
		set_collision_mask_value(2, true)
		set_collision_mask_value(1, true)
		set_collision_mask_value(9, true)
		print("disabled")
		is_hidden = false
