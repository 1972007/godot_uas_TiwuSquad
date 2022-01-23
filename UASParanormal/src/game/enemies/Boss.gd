extends "res://src/game/enemies/enemy_generic.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stam =100
var speed=300
var exhaust_rate=0.5
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = hash("Godot")
	health = 55
	max_health = 55
	sprite = $TempSprite
	$HealthBar._set_max_val(max_health)
	$HealthBar._set_val(health)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(stam<100):
		stam+=delta
	rng.randomize()
	var res = rng.randf()
	if(res>0.3 and stam>0 and not stunned):
		speed_up()
	elif(res<=0.3 and not stunned):
		SPEED=80
	elif(stunned):
		SPEED=0
func speed_up():
	SPEED=speed
	stam-=exhaust_rate
func stun(dmg=5):
	health-=dmg
	stunned=true
	speed=0
	$HealthBar._set_val(health)
	print("Boss Stunned")
	animationPlayer.play("stun")
	$StunTime.start()
	
	#(-256,256),(1286,256),(1286,1632),(-256,1632)

func _on_StunTime_timeout():
	rng.randomize()
	speed=SPEED
	animationPlayer.play("walk")
	stunned=false # Replace with function body.
