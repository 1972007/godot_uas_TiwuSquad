extends KinematicBody2D

onready var nav = get_node("../Navigation")
onready var player = get_node("../Player")
onready var pathfinding = get_node("DebugPathfinding")
onready var animationPlayer = $AnimationPlayer
onready var healthBar=$HealthBar

var SPEED = 80
onready var max_health = 50
var health = 50

onready var leftFacing = false
onready var stunned=false
onready var dead=false
onready var sprite = $Hallowen0001
var scale_x = 1
signal died
func _ready():
	
	healthBar._set_max_val(max_health)
	
func _physics_process(delta): #real short movement code. seems to work, nice :)
	if(health>0 and not stunned):
		var path = nav.get_simple_path(position, player.position)
		if(path.size()>0):
			var distance = path[1] - position

			if distance.length() <= 0:
				path.remove(1)
				return

			var direction = distance.normalized()
			var v = move_and_slide(direction * SPEED)
			animationPlayer.play("walk")
			if(v== Vector2.ZERO):
				animationPlayer.play("idle")
			if((position.x<player.position.x )):
				scale.x=-scale_x
				leftFacing = true
			else:
				scale.x=scale_x
				leftFacing = false
			# DEBUG STUFF
			if game.debug_mode: #if in debug mode then show the pathfinding vectors
				var debug_path = PoolVector2Array()
				for i in path:
					debug_path.append(to_local(i))
				pathfinding.points = debug_path
		
func _process(delta):
	if(health<=0 and not dead):
		animationPlayer.play("death")
		dead=true

func stop(dmg=5):
	if((not dead)):
			
		SPEED=0
		health-=dmg
		healthBar._set_val(health)
		stunned = true
		animationPlayer.play("stun")

func resume(cooldown=2):
	$Stun.start(cooldown)
	
func _on_Stun_timeout():
	stunned = false
	SPEED=80
	if(dead):
		health=max_health
		healthBar._set_val(health)
		animationPlayer.play("revive")
		dead=false
	
func _on_AnimationPlayer_animation_finished(anim_name:String):
	if(anim_name=="death"):
		emit_signal("died")
		queue_free()
