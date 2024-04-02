extends Node

# Import Mob.tscn to the Main
@export var mob_scene: PackedScene

func _on_ready():
	randomize()

func _on_mob_timer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	# Random mob spawn location
	# mob_spawn_location.unit_offset = randf() # Godot 3
	mob_spawn_location.progress_ratio = randf() # Godot 4

	# Instantite the mob scene
	var mob = mob_scene.instantiate()
	# Add mob
	add_child(mob)
	
	# Assign position to the mob
	mob.position = mob_spawn_location.position
	
	# Add the rotation to the mob after spawned
	var direction =  mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Move the mob
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)
