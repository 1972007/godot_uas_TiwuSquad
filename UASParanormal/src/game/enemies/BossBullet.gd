extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_direction=Vector2(0,0)
var bullet_speed=150

# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_direction=Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass
	
func _physics_process(delta):
	print(bullet_direction)
	bullet_direction.x+=bullet_speed
	bullet_direction.x = lerp(bullet_direction.x,0,0.1)
	
	move_and_collide(bullet_speed*bullet_direction)
	
	# if(collision):
	# 	queue_free()
func set_bullet_speed(speed):
	bullet_speed=speed
func set_x_y_speed(x,y,speed):
	bullet_direction.x=x
	bullet_direction.y=y
	bullet_speed=speed
func set_direction(vector):
	bullet_direction=vector
