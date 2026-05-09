extends CharacterBody2D

@onready var coyote_timer = $CoyoteTimer

const SPEED = 400.0
const JUMP_VELOCITY = -350.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() || !coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY
	elif velocity.y < 0.0:
		if Input.is_action_just_released("jump"):
			velocity.y *= 0.4

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction:
		# We use move_toward for basic acceleration/deceleration
		velocity.x = direction * SPEED
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) # Decelerate to a stop
		animated_sprite.play("idle")
	# checking before vs after mov n slide when jumoed to start coyote timer
	var was_on_floor = is_on_floor()

	move_and_slide()

	if was_on_floor && !is_on_floor():
		coyote_timer.start()
