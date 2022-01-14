extends KinematicBody2D

var WALK_SPEED = 200
var SPRINT_SPEED = 300

export (NodePath) var joystickLeftPath
onready var joystickLeft : VirtualJoystick = get_node(joystickLeftPath)

var artifact 
var follow_mode = false # If pressed up/forward follow the mouse instead of just going up
onready var activate_artifact = $ActivateArtifact
onready var artifact_area = $ActivateArtifact/ArtifactArea
onready var animation = $AnimationPlayer
onready var start_move=true
onready var artifact_active=false
var artifact_ready = true

#not the actual signal, but checks one from TouchScreenButton
var artifact_signal = false
var run_signal=false

var sprints = SPRINT_SPEED
var speed = WALK_SPEED
var exhausted = false #flag to check player exhaustion
var max_stam = 100
var stamina = 100
var STAMINA_REGEN = .5 #stamina regeneration rate
var EXH_RATE = 1 #stamina exhaustion rate
func ready():
	$FOV.enabled=true
	start_move=true
	animation.play("idle")
func move():
	var move = Vector2(0,-1)
	
	if(stamina<max_stam):
		stamina+=STAMINA_REGEN
	#movement basic
	if(joystickLeft and joystickLeft.is_pressed() and start_move):
		if(stamina<=0):
			exhausted=true
		if(stamina>=max_stam):
			exhausted=false
		if (Input.is_action_pressed("sprint") or run_signal) and not exhausted: # check if player is sprinting
			if(stamina>0):
				stamina-=EXH_RATE
			speed = SPRINT_SPEED
		else:
			speed = WALK_SPEED
			
		var move_curr = Vector2.ZERO
		if Input.is_action_pressed("ui_up") : # basic movement
			move_curr= move_and_slide(move * speed)
		if Input.is_action_pressed("ui_down"):
			move_curr= move_and_slide(move.rotated(PI) * speed)
		if Input.is_action_pressed("ui_left"):
			move_curr= move_and_slide(move.rotated(-PI/2) * speed)
		if Input.is_action_pressed("ui_right"):
			move_curr= move_and_slide(move.rotated(PI/2) * speed)
		if(move_curr.x>0):
			$PlayerModel.flip_h=true
			animation.play("walk")
		elif(move_curr.x<0):
			$PlayerModel.flip_h=false
			animation.play("walk")
		else:
			animation.play("idle")
#		rotation = joystickLeft.get_output().angle()
#		rotate(rotation)
	if(artifact!=null):
		if((Input.is_action_just_pressed("draw_artifact") or artifact_signal) and artifact.ready_to_use and artifact_active==false):
			if(artifact.durability >0):
				artifact_area.get_node("CollisionShape2D").disabled=false
				$temp_artifact.texture = artifact.texture
				$temp_artifact.visible=true
				artifact_active=true
				artifact_area.get_node("AreaTimer").start(6)
				artifact.durability-=artifact.timer
		else:
			if(artifact.durability<0):
				artifact.durability=0
				artifact.ready_to_use=false
			if(artifact.durability<artifact.max_durability):
				artifact.durability+=(0.016)
				print(artifact.durability)
			if(artifact.durability>artifact.max_durability):
				artifact.durability=artifact.max_durability
				artifact.ready_to_use=true
func _process(delta):
	move()


func _on_ArtifactArea_body_entered(body):
	if(artifact!=null):
		if(body.is_in_group("Enemies")):
			body.stop(artifact.dmg)
		if(body.is_in_group("Boss")):
			body.stun(artifact.dmg)

func _on_ArtifactArea_body_exited(body):
	if(body.is_in_group("Enemies")):
		body.resume()

func _set_artifact_ready(boolean):
	artifact_ready=boolean
func _paused_camera():
	$Camera/ColorRect.modulate.a=0.5
func _resumed_camera():
	$Camera/ColorRect.modulate.a=0

# Replace with function body.




func _on_AreaTimer_timeout():
	artifact_area.get_node("CollisionShape2D").disabled=true
	$temp_artifact.visible=false
	artifact_active=false
func set_artifact(artifact):
	self.artifact = artifact

func _on_CooldownTimer_timeout():
	pass # Replace with function body.
