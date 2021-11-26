extends KinematicBody2D

var WALK_SPEED = 60
var SPRINT_SPEED = 100

var follow_mode = false # If pressed up/forward follow the mouse instead of just going up
onready var activate_artifact = $ActivateArtifact
onready var artifact_area = $ActivateArtifact/ArtifactArea


var sprints = SPRINT_SPEED

func move():
	var speed = WALK_SPEED
	if Input.is_action_pressed("sprint"): # check if player is sprinting
		speed = sprints
	
	var move = Vector2(0,-1)
	if follow_mode:
		move = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("game_up"): # basic movement
		move_and_slide(move * speed)
	if Input.is_action_pressed("game_down"):
		move_and_slide(move.rotated(PI) * speed)
	if Input.is_action_pressed("game_left"):
		move_and_slide(move.rotated(-PI/2) * speed)
	if Input.is_action_pressed("game_right"):
		move_and_slide(move.rotated(PI/2) * speed)
func _process(delta):
	look_at(get_global_mouse_position()) # rotate head to mouse position
	move() # movement control
	hold_artifact()

func hold_artifact():
	if(Input.is_action_pressed("draw_artifact")):
		activate_artifact.visible=true
		artifact_area.get_node("CollisionShape2D").disabled=false
	else:
		activate_artifact.visible=false
		artifact_area.get_node("CollisionShape2D").disabled=true


func _on_ArtifactArea_body_entered(body):
	if(body.is_in_group("Enemies")):
		body.stop()
	

func _on_ArtifactArea_body_exited(body):
	if(body.is_in_group("Enemies")):
		body.resume()
