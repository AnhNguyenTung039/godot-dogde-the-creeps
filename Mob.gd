extends RigidBody2D

# Random spawn enemies
@export var min_speed = 150.0
@export var max_speed = 150.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite2D.play() = true # Version 3
	$AnimatedSprite2D.play()
	
	#var mob_types = $AnimatedSprite2D.frames.get_animation_names() # Version 3
	var mob_types : Array = $AnimatedSprite2D.sprite_frames.get_animation_names()
	
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Destroy an node function at the end of the frame
	# There is another function called free but that more dangerous
	queue_free()
