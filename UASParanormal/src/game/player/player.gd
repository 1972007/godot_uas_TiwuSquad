extends KinematicBody2D

var WALK_SPEED = 60
var SPRINT_SPEED = 100

export (NodePath) var joystickLeftPath
onready var joystickLeft : VirtualJoystick = get_node(joystickLeftPath)


var follow_mode = false # If pressed up/forward follow the mouse instead of just going up
onready var activate_artifact = $ActivateArtifact
onready var artifact_area = $ActivateArtifact/ArtifactArea

var artifact_signal = false
var artifact_ready = true
var artifact_total=2
var sprints = SPRINT_SPEED
var speed = WALK_SPEED
func ready():
	$FOV.enabled=true
func move():
	if Input.is_action_pressed("sprint"): # check if player is sprinting
		speed = sprints
	else:
		speed = WALK_SPEED
	var move = Vector2(0,-1)
	#movement basic

	if Input.is_action_pressed("ui_up") : # basic movement
		move_and_slide(move * speed)
	if Input.is_action_pressed("ui_down"):
		move_and_slide(move.rotated(PI) * speed)
	if Input.is_action_pressed("ui_left"):
		move_and_slide(move.rotated(-PI/2) * speed)
	if Input.is_action_pressed("ui_right"):
		move_and_slide(move.rotated(PI/2) * speed)
		
	rotation = joystickLeft.get_output().angle()
	rotate(rotation)
	if(Input.is_action_pressed("draw_artifact")):
		artifact_signal=true
	else:
		artifact_signal=false
func _process(delta):
	
	move()
	hold_artifact()
func hold_artifact():
	if(artifact_signal  and artifact_ready and artifact_total>0):

		artifact_area.get_node("CollisionShape2D").disabled=false
		$temp_artifact.visible=true
	else:
		artifact_area.get_node("CollisionShape2D").disabled=true
		$temp_artifact.visible=false


func _on_ArtifactArea_body_entered(body):
	if(body.is_in_group("Enemies")):
		body.stop()
	

func _on_ArtifactArea_body_exited(body):
	if(body.is_in_group("Enemies")):
		body.resume()

func _set_artifact_ready(boolean):
	artifact_ready=boolean

func _reduce_artifact(number=1):
	artifact_total-=1;
# Replace with function body.
