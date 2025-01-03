extends CharacterBody2D


const SPEED = 15.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 20.0
const MAX_VELOCITY_MAX = 300.0
const MAX_VELOCITY_MIN = -300.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("p3_up") and is_on_floor():
		velocity.y += JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("p3_left", "p3_right")
	if direction:
		if velocity.x >= 0 and velocity.x < MAX_VELOCITY_MAX:
			velocity.x += direction * SPEED
			print(velocity,">=")
		if velocity.x < 0 and velocity.x > MAX_VELOCITY_MIN:
			velocity.x += direction * SPEED
			print(velocity,"<")
		else:
			velocity.x += direction* -1 
			print("im skibidi rizzing rn1")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
