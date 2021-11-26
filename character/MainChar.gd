extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movement = Vector2.ZERO
var health
var sp
var sanity
var sp_refilled
var skill_ready
const SPEED = 100
const ACCELERATION=600
const FRICTION = 600
# Called when the node enters the scene tree for the first time.
func _ready():
	health=100
	sp=200
	skill_ready=true
	sanity=100

#func _process(delta):
#	pass
	
	#print(sp,sp_refilled)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(Input.is_action_pressed("attack") and skill_ready):
		_draw_artifact()
		sp-=5
		if(sp<=0):
			skill_ready=false
	else:
		if(sp<200):
			sp+=5
		elif(sp>=200):
			sp=200
			skill_ready=true
		print($Timer.time_left)	
		_stop()
		
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("Right")-Input.get_action_strength("Left")
	input_vector.y=Input.get_action_strength("Down")-Input.get_action_strength("Up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		movement = movement.move_toward(input_vector*SPEED,ACCELERATION*delta)
	else:
		movement = movement.move_toward(Vector2.ZERO,delta*FRICTION)
	##print(movement)
	movement = $KinematicBody2D.move_and_slide(movement)
func _draw_artifact():
	$KinematicBody2D/AnimatedSprite.animation="atk"
	$KinematicBody2D/AnimatedSprite.frame=1
	
func _walk():
	$KinematicBody2D/AnimatedSprite.animation="walk"
	$KinematicBody2D/AnimatedSprite.playing=true

func _stop():
	$KinematicBody2D/AnimatedSprite.stop()
	$KinematicBody2D/AnimatedSprite.frame=0


func _on_Timer_timeout():
	skill_ready=true # Replace with function body.
