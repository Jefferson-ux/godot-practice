extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 220.0
const JUMP_VELOCITY = -350.0
var is_jumping : bool = false

func _ready() -> void:
	floor_snap_length = 25.0

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("mover_izquierda", "mover_derecha")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	move_and_slide()		
		
	if is_on_floor():
		is_jumping = false
	

	
	# 1. Dirección del Sprite (Funciona tanto en el suelo como en el aire)
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	if is_jumping==true:
		sprite.play("jump")
	elif not is_on_floor():
		sprite.play("idle")
	else:
		sprite.play("move" if direction != 0 else "idle")

	
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
