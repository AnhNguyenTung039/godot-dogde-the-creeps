extends Area2D

signal hit

@export var speed = 400.0

var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var direction = Vector2.ZERO	
	# Or it can be declare like this
	# var direction = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	# If length > 0 there is at least 1 key is being pressed,
	if direction.length() > 0:
		direction = direction.normalized()
		# We add animation if the key is being pressed
		$AnimatedSprite2D.play()
	else :
		# We stop animation if there is no key being pressed		
		$AnimatedSprite2D.stop()
	
	# Moving_direction * character_speed * time
	position += direction * speed * delta
	# Limit player to not go outside of the window of the game
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if direction.x != 0:
		# Handle logic if the player pressing left or right
		$AnimatedSprite2D.animation = "Right"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = direction.x < 0
	elif direction.y != 0:
		# Handle logic if the player pressing up or down		
		$AnimatedSprite2D.animation = "Up"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_v = direction.y > 0

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	# hide the Player
	hide()
	# deactivate colision
	# set_deferred is a safe way for physics interaction run first then after that we disabled the colision
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
