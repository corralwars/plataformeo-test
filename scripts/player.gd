extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -390.0

@onready var anim=$AnimatedSprite2d

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h=direction<0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if not is_on_floor():
		if velocity.y<0:
			anim.play("Jump")
		else:
			anim.play("Fall")
	else:
		if direction!=0:
			anim.play("Walk")
		else:
			anim.play("Idle")
