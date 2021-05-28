extends KinematicBody

onready var camera = $Target/Camera
#var gravity = -9.8
var velocity = Vector3()


const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	var dir = Vector3()
	var camera_transform = camera.global_transform
	
	if(Input.is_action_pressed("move_fw")):
		dir += -camera_transform.basis[2]
	if(Input.is_action_pressed("move_bw")):
		dir += camera_transform.basis[2]
	if(Input.is_action_pressed("move_l")):
		dir += -camera_transform.basis[0]
	if(Input.is_action_pressed("move_r")):
		dir += camera_transform.basis[0]
		
	dir.y = 0
	dir = dir.normalized()
	
	#velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))	
	
	if dir.length() > 0 :
		#var angle = atan2(hv.x, hv.z)
		var current_rotation = get_rotation()
		current_rotation.y = atan2(hv.x, hv.z)
		set_rotation(current_rotation)
