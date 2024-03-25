extends Area2D

@export var speed = 400.0

var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	print("screen_size: ", screen_size)

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
	
	# Block overlap speed for multiple keys pressed for same direction
	if direction.length() > 1:
		direction = direction.normalized()
	
	# moving_direction * character_speed * time
	position += direction * speed * delta
	# limit player to not go outside of the window of the game
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
