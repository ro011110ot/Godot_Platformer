extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_on_ladder: bool = false
var is_hit: bool = false

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_hit:
		_animated_sprite.play("hit")
		return # Block input while hit (optional logic)

	# Handle gravity
	if not is_on_floor() and not is_on_ladder:
		velocity.y += gravity * delta

	# Handle Jump and Jump Animation
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			_animated_sprite.play("jump")
	elif not is_on_ladder:
		_animated_sprite.play("jump")

	# Handle Ducking
	var is_ducking := Input.is_action_pressed("ui_down") and is_on_floor()

	# Horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if is_ducking:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("duck")
	elif direction:
		velocity.x = direction * SPEED
		_animated_sprite.flip_h = direction < 0
		if is_on_floor():
			_animated_sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			_animated_sprite.play("idle")

	# Ladder Logic (Climbing)
	if is_on_ladder:
		var climb_dir := Input.get_axis("ui_up", "ui_down")
		velocity.y = climb_dir * SPEED * 0.7
		_animated_sprite.play("climb")
		if velocity.y == 0:
			_animated_sprite.pause()

	move_and_slide()
