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
var timerPath = Timer.new()
onready var path = []
func _ready():
	timerPath.connect("timeout",self,"_on_timerPath_timeout")
	add_child(timerPath)
	timerPath.start(1)
	healthBar._set_max_val(max_health)
	
func _physics_process(delta): #real short movement code. seems to work, nice :)
	pass
func _path_find():
	if(health>0 and not stunned):
		path = nav.get_simple_path(position, player.position)
func _process(delta):
	if(health<=0 and not dead):
		animationPlayer.play("death")
		dead=true
	if(path.size()>0):
		
		var distance = path[1] - position
		if distance.length() <= 0:
			path.remove(1)
			return

		var direction = distance.normalized()
		var _v = move_and_slide(direction * SPEED)
		if(not stunned):
			animationPlayer.play("walk")
		if(_v== Vector2.ZERO and not stunned):
			animationPlayer.play("idle")
		if((distance.x<0 and  not sprite.flip_h)):
			sprite.flip_h = true
			leftFacing = true
		elif(distance.x>0 and sprite.flip_h):
			sprite.flip_h=false
			leftFacing = false
			
		# DEBUG STUFF
		if game.debug_mode: #if in debug mode then show the pathfinding vectors
			var debug_path = PoolVector2Array()
			for i in path:
				debug_path.append(to_local(i))
			pathfinding.points = debug_path
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
	
func _on_AnimationPlayer_animation_finished(anim_name:String):
	if(anim_name=="death"):
		emit_signal("died")
		queue_free()

func _on_timerPath_timeout():
	_path_find()
	timerPath.start()
